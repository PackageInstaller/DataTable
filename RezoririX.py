from __future__ import annotations

import hashlib
import io
import json
import re
import struct
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, field
from datetime import datetime
from io import BytesIO
from pathlib import Path
from threading import Lock
from typing import Any, Dict, List, Optional, Tuple, Union
from urllib.parse import quote
from urllib.request import Request, urlopen

import lz4.block
import requests
import UnityPy
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    TextColumn,
    TransferSpeedColumn,
)

PROJECT = Path(__file__).resolve().parent
MASTER = PROJECT / "MasterData"
MASTER.mkdir(exist_ok=True)

MASTER_BASE_URL = "https://rezoriri.funyoursjapan.pink/prod/res"
HASH_URL = f"{MASTER_BASE_URL}/game-settings.bytes.hash"
BYTES_URL = f"{MASTER_BASE_URL}/game-settings.bytes"

HASH_FILE = PROJECT / "game-settings.bytes.hash"
BYTES_FILE = PROJECT / "game-settings.bytes"
OUTPUT_JSON = MASTER / "game-settings.json"
IL2CPP_CS = PROJECT / "cs" / "il2cpp.cs"
SCHEMA_JSON = PROJECT / "settings_schema.json"

AB_BASE_URL = "https://rezoriri.funyoursjapan.pink/prod/res/android"
AB_MANIFEST_URL = f"{AB_BASE_URL}/android.bin"
AB_CATALOG_JSON = PROJECT / "assets.json"
AB_OUTPUT_DIR = PROJECT / "Assets"
AB_WORKERS = 8
AB_RETRIES = 3
AB_TIMEOUT = 60

AB_PATH_PREFIXES: Tuple[Tuple[str, Tuple[str, ...]], ...] = (
    ("assets-bundles-", ("assets", "bundles")),
    ("assets-dialog-", ("assets", "dialog")),
    ("assets-", ("assets",)),
)

console = Console()

CHUNK_COMPRESSED = 0x01

ELEMENT_TYPECODE: Dict[str, int] = {
    "GameCore.Accessories.AccessoryMainSetting": 0x989DB37C,
    "GameCore.Accessories.AccessorySecondarySetting": 0x79A24CB8,
    "GameCore.Accessories.AccessorySetting": 0x2D912F64,
    "GameCore.Accessories.AccessorySetSetting": 0x6038DCA4,
    "GameCore.Achieves.AttrGrowAchieveSetting": 0x8EAC30D4,
    "GameCore.Activities.ActivityBingoRewardSetting": 0x004A4B48,
    "GameCore.Activities.ActivityAccumulateIapSetting": 0x5CF08BB4,
    "GameCore.Activities.ActivitySetting": 0xA7B5CE80,
    "GameCore.Activities.ActivityCostSetting": 0x81FDD194,
    "GameCore.Activities.ActivitySelectGrowSpSetting": 0x29CCC788,
    "GameCore.Activities.ActivitySignSetting": 0xEF4560E8,
    "GameCore.Activities.ActivityBingoSetting": 0x8591F9F4,
    "GameCore.Activities.ActivityBpSetting": 0xB4CC9BD8,
    "GameCore.Activities.ActivityLimitBossSetting": 0x72D347E8,
    "GameCore.Activities.ActivityLimitMainSetting": 0x3A3F045C,
    "GameCore.Activities.ActivityLimitTalentSlotSetting": 0x94747F8C,
    "GameCore.Activities.ActivityLotterySetting": 0x321C53F4,
    "GameCore.StringSetting": 0xB0E57150,
}

ELEMENT_TYPECODE_TO_NAME: Dict[int, str] = {
    code: name for name, code in ELEMENT_TYPECODE.items()
}


PRIMITIVE_MAP = {
    "bool": "System.Boolean",
    "byte": "System.Byte",
    "sbyte": "System.SByte",
    "char": "System.Char",
    "short": "System.Int16",
    "ushort": "System.UInt16",
    "int": "System.Int32",
    "uint": "System.UInt32",
    "long": "System.Int64",
    "ulong": "System.UInt64",
    "float": "System.Single",
    "double": "System.Double",
    "string": "System.String",
    "decimal": "System.Decimal",
}

ALLOW_BASE_SYSTEM_TYPES = frozenset(
    {
        "System.Boolean",
        "System.SByte",
        "System.Byte",
        "System.Int16",
        "System.UInt16",
        "System.Int32",
        "System.UInt32",
        "System.Int64",
        "System.UInt64",
        "System.Char",
        "System.Single",
        "System.Double",
        "System.Decimal",
        "System.String",
        "System.Guid",
        "System.TimeSpan",
        "System.DateTime",
    }
)

NON_SERIALIZABLE_TYPE_ROOTS = frozenset({"System.Attribute", "System.Exception"})

WIRE_FIELD_TYPECODE: Dict[str, int] = {
    "System.UInt32": 0x22F20A7C,
    "System.Int32": 0x4441CDFC,
    "System.UInt16": 0x235B2340,
    "System.Int64": 0xF951D74C,
    "System.UInt64": 0x6CCCC6A4,
    "System.Single": 0x8C0E9040,
    "System.Byte": 0x788C5544,
    "System.Boolean": 0x96D03930,
    "System.String": 0x2DD45A30,
    "GameCore.StatisticType": 0x0EBABED4,
    "GameCore.RewardType": 0x2DE7A0C0,
    "GameCore.HeroRareLimit": 0xEC7FE5B4,
    "GameCore.Activities.ActivityCostType": 0x0A11B554,
    "GameCore.Activities.ActivitySelectGrowSpConditionType": 0xDF832018,
    "GameCore.Activities.ActivityType": 0xC7DF1C40,
}


WIRE_TC_TYPE_ALIASES: Dict[int, Any] = {
    0x9C10C28C: ("GameCore.RewardType", True),
    0x5C432A58: ("System.UInt16", False),
}


def normalize_type_name(type_name: str) -> str:
    t = type_name.rstrip("?")
    nullable = type_name.endswith("?")
    base = PRIMITIVE_MAP.get(t, t)
    return base + ("?" if nullable else "")



def is_serializable_field(field: dict) -> bool:
    """Reflections.IsSerializable(FieldInfo): public, instance, not init-only."""
    if not field.get("is_public", True):
        return False
    if field.get("is_static"):
        return False
    if field.get("is_initonly"):
        return False
    return True


def get_serializable_fields(cls: dict) -> List[dict]:
    """Fields included in GetSerializableFields + HashTypeCode signature."""
    return [f for f in cls.get("fields", []) if is_serializable_field(f)]


def _type_assignable_from(root: str, type_name: str) -> bool:
    tn = normalize_type_name(type_name).rstrip("?")
    if tn == root:
        return True
    if root == "System.Attribute":
        return tn.endswith("Attribute") or tn.endswith(".Attribute")
    if root == "System.Exception":
        return tn.endswith("Exception") or ".Exceptions." in tn
    return False


def is_serializable_type(
    type_name: str, *, is_enum: bool = False, is_value_type: bool = False
) -> bool:
    tn = normalize_type_name(type_name).rstrip("?")
    if tn in NON_SERIALIZABLE_TYPE_ROOTS:
        return False
    for root in NON_SERIALIZABLE_TYPE_ROOTS:
        if _type_assignable_from(root, tn):
            return False
    return True


def build_type_signature(type_name: str, fields: List[Tuple[str, str]]) -> str:
    tn = normalize_type_name(type_name)
    parts = [f"{name}:{normalize_type_name(ft)}" for name, ft in fields]
    return f"{tn}{{{','.join(parts)}}}"


def md5_u32(text: str) -> int:
    return struct.unpack("<I", hashlib.md5(text.encode("utf-8")).digest()[:4])[0]


def hash_type_code_without_array(type_name: str, fields: List[Tuple[str, str]]) -> int:
    return md5_u32(build_type_signature(type_name, fields)) & 0xFFFFFFFF


def hash_type_code(
    type_name: str, fields: List[Tuple[str, str]], array_rank: int = 0
) -> int:
    base = hash_type_code_without_array(type_name, fields)
    return (array_rank | (4 * base)) & 0xFFFFFFFF


def wire_element_type_code(type_code_without_array: int) -> int:
    """On-wire array element typeCode = HashTypeCode(T) with array rank 0."""
    return (4 * (type_code_without_array & 0xFFFFFFFF)) & 0xFFFFFFFF


@dataclass
class FieldSpec:
    name: str
    type_name: str
    is_enum: bool = False
    is_class: bool = False
    is_nullable: bool = False


WIRE_TC_TO_FIELD: Dict[int, FieldSpec] = {
    code: FieldSpec(
        f"Field_{code:08X}",
        type_name,
        is_enum=type_name.startswith("GameCore."),
    )
    for type_name, code in WIRE_FIELD_TYPECODE.items()
}


@dataclass
class TypeSpec:
    name: str
    full_name: str
    fields: List[FieldSpec]


@dataclass
class TableChunk:
    property_name: str
    setting_full_name: str
    count: int
    element_type_code: int
    record_size: int
    offset: int
    size: int
    items: List[Dict[str, Any]] = field(default_factory=list)


class BinaryReader:
    def __init__(self, data: bytes, offset: int = 0):
        self._data = data
        self._stream = BytesIO(data)
        self._stream.seek(offset)
        self.pos = offset

    def tell(self) -> int:
        return self._stream.tell()

    def remaining(self) -> int:
        return len(self._data) - self.tell()

    def read(self, n: int) -> bytes:
        b = self._stream.read(n)
        if len(b) != n:
            raise EOFError(f"expected {n} bytes at {self.tell()}")
        self.pos = self._stream.tell()
        return b

    def read_byte(self) -> int:
        return self.read(1)[0]

    def read_int32(self) -> int:
        return struct.unpack("<i", self.read(4))[0]

    def read_uint32(self) -> int:
        return struct.unpack("<I", self.read(4))[0]

    def seek(self, offset: int) -> None:
        self._stream.seek(offset)
        self.pos = offset


def _read_7bit_int(buf: bytes, offset: int) -> Tuple[int, int]:
    result = 0
    shift = 0
    while offset < len(buf):
        byte = buf[offset]
        offset += 1
        result |= (byte & 0x7F) << shift
        if byte & 0x80 == 0:
            return result, offset
        shift += 7
    raise EOFError("truncated 7-bit length")


def _read_string_payload(buf: bytes, offset: int) -> Tuple[Optional[str], int]:
    if offset >= len(buf):
        raise EOFError("truncated string marker")
    marker = buf[offset]
    offset += 1
    if marker == 0xFF:
        return None, offset
    length, offset = _read_7bit_int(buf, offset)
    if offset + length > len(buf):
        raise EOFError("truncated string body")
    text = buf[offset : offset + length].decode("utf-8", "replace")
    return text, offset + length


def _normalize_array_elem_type(elem_type: str) -> str:
    t = elem_type.rstrip("[]")
    return normalize_type_name(t)


def read_typed_primitive_array(
    buf: bytes, offset: int, elem_type: str, *, is_enum: bool = False
) -> Tuple[Any, int]:
    if offset + 4 > len(buf):
        raise EOFError("truncated array length")
    count = struct.unpack_from("<I", buf, offset)[0]
    offset += 4
    if count == -1:
        return None, offset
    if count < 0:
        raise ValueError(f"negative array length {count}")
    if count == 0:
        return [], offset

    base = _normalize_array_elem_type(elem_type)
    if (
        is_enum
        or base.endswith("Type")
        or "RewardType" in base
        or "StatisticType" in base
    ):
        if offset + count > len(buf):
            raise EOFError("truncated enum array body")
        return [buf[offset + i] for i in range(count)], offset + count

    if base in ("System.UInt32", "uint"):
        if offset + 4 * count > len(buf):
            raise EOFError("truncated uint array body")
        return [
            struct.unpack_from("<I", buf, offset + 4 * i)[0] for i in range(count)
        ], offset + 4 * count

    if base in ("System.Int32", "int"):
        if offset + 4 * count > len(buf):
            raise EOFError("truncated int array body")
        return [
            struct.unpack_from("<i", buf, offset + 4 * i)[0] for i in range(count)
        ], offset + 4 * count

    if base in ("System.Byte", "byte"):
        if offset + count > len(buf):
            raise EOFError("truncated byte array body")
        return [buf[offset + i] for i in range(count)], offset + count

    raise NotImplementedError(f"typed primitive array element {elem_type}")


def read_array_field(
    buf: bytes, offset: int, elem_type: str, *, is_enum: bool = False
) -> Tuple[Any, int, int]:
    if is_enum:
        if offset + 4 > len(buf):
            raise EOFError("truncated array length")
        count = struct.unpack_from("<I", buf, offset)[0]
        offset += 4
        if count == -1:
            return None, 0, offset
        if count < 0:
            raise ValueError(f"negative array length {count}")
        items: List[Any] = []
        last_tc = 0
        for _ in range(count):
            if offset + 4 > len(buf):
                raise EOFError("truncated enum array element typeCode")
            tc = struct.unpack_from("<I", buf, offset)[0]
            offset += 4
            last_tc = tc
            if tc == 0xFFFFFFFF:
                items.append(None)
                continue
            if offset >= len(buf):
                raise EOFError("truncated enum array element value")
            items.append(buf[offset])
            offset += 1
        return items, last_tc, offset

    items, offset = read_typed_primitive_array(buf, offset, elem_type, is_enum=False)
    return items, 0, offset


def _read_field_value_from_buffer(
    buf: bytes, offset: int, spec: FieldSpec, tc: int
) -> Tuple[Any, int]:
    if tc == 0xFFFFFFFF:
        return None, offset

    t = spec.type_name
    if t.endswith("[]"):
        value, _, new_offset = read_array_field(buf, offset, t, is_enum=spec.is_enum)
        return value, new_offset

    if t in ("string", "System.String"):
        value, new_offset = _read_string_payload(buf, offset)
        return value, new_offset

    if spec.is_class:
        raise NotImplementedError(f"class field {spec.name} typeCode={tc:#x}")

    if spec.is_enum or t in ("byte", "System.Byte"):
        if offset >= len(buf):
            raise EOFError("truncated enum/byte")
        return buf[offset], offset + 1

    if t in ("uint", "System.UInt32"):
        return struct.unpack_from("<I", buf, offset)[0], offset + 4

    if t in ("int", "System.Int32"):
        return struct.unpack_from("<i", buf, offset)[0], offset + 4

    if t in ("long", "System.Int64"):
        return struct.unpack_from("<q", buf, offset)[0], offset + 8

    if t in ("ushort", "System.UInt16"):
        return struct.unpack_from("<H", buf, offset)[0], offset + 2

    if t in ("ulong", "System.UInt64"):
        return struct.unpack_from("<Q", buf, offset)[0], offset + 8

    if t in ("float", "System.Single"):
        return struct.unpack_from("<f", buf, offset)[0], offset + 4

    if t in ("bool", "System.Boolean"):
        return buf[offset] != 0, offset + 1

    if t in ("System.DateTime", "DateTime"):
        ticks = struct.unpack_from("<q", buf, offset + 1)[0]
        return ticks, offset + 9

    if t in ("System.TimeSpan", "TimeSpan"):
        return struct.unpack_from("<q", buf, offset)[0], offset + 8

    if t in ("System.Guid", "Guid"):
        import uuid

        guid_bytes = buf[offset : offset + 16]
        return str(uuid.UUID(bytes_le=guid_bytes)), offset + 16

    if t in ("System.Decimal", "decimal"):
        return buf[offset : offset + 16].hex(), offset + 16

    raise NotImplementedError(f"unsupported field type {t} for {spec.name}")



def detect_record_stride(
    data: bytes, table_start: int, element_type_code: int, count: int
) -> int:
    pat = struct.pack("<I", element_type_code)
    first = data.find(pat, table_start)
    if first < 0:
        raise ValueError(
            f"element typeCode {element_type_code:#x} not found at {table_start}"
        )

    max_stride = min(4096, max(8, (len(data) - table_start) // max(count, 1) + 4))
    for stride in range(8, max_stride + 1):
        if count > 0 and table_start + (count - 1) * stride + 4 > len(data):
            continue
        if all(
            data[table_start + i * stride : table_start + i * stride + 4] == pat
            for i in range(count)
        ):
            return stride

    raise ValueError(
        f"cannot detect fixed record stride for element {element_type_code:#x} "
        f"(count={count}); table may use variable-length records"
    )


def _field_dict_to_spec(f: dict) -> FieldSpec:
    return FieldSpec(
        name=f["name"],
        type_name=f["type"],
        is_enum=f.get("is_enum", False),
        is_class=f.get("is_class", False),
        is_nullable=f.get("is_nullable", False),
    )


def enrich_field_specs_from_schema(cls: dict) -> TypeSpec:
    fields = cls.get("serializable_fields") or get_serializable_fields(cls)
    return TypeSpec(
        name=cls["name"],
        full_name=cls["full_name"],
        fields=[_field_dict_to_spec(f) for f in fields],
    )


ACCESSORY_MAIN_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("Group", "System.Byte"),
    FieldSpec("MainStatisticValue", "System.UInt32"),
    FieldSpec("InitSecondaryNum", "System.UInt32"),
    FieldSpec("InitSecondaryGroup", "System.UInt32"),
    FieldSpec(
        "MainStatisticGrow", "System.UInt32"
    ),
]

ACCESSORY_SETTING_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("InitMainGroup", "System.UInt32"),
    FieldSpec("Type", "GameCore.StatisticType", is_enum=True),
    FieldSpec("ReinExp", "System.Int32"),
]

ACCESSORY_SET_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("Name", "System.String"),
    FieldSpec("FilterShow", "System.Boolean"),
    FieldSpec("PartTitleA", "System.String"),
    FieldSpec("PartNumA", "System.Int32"),
    FieldSpec("SkillIdA1", "System.UInt32"),
    FieldSpec("SkillIdA2", "System.UInt32"),
    FieldSpec("PartTitleB", "System.String"),
    FieldSpec("PartNumB", "System.Int32"),
    FieldSpec("SkillIdB1", "System.UInt32"),
    FieldSpec("SkillIdB2", "System.UInt32"),
]

ATTR_GROW_ACHIEVE_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("Stage", "System.Int32"),
    FieldSpec("Attr", "System.Byte", is_enum=True),
    FieldSpec("PreId", "System.UInt32"),
    FieldSpec("Target", "System.UInt32"),
    FieldSpec("Tag", "System.Byte", is_enum=True),
    FieldSpec("FinTarA", "System.UInt32"),
    FieldSpec("FinTarB", "System.UInt32"),
]

ACTIVITY_BINGO_REWARD_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("SerialNo", "System.Int32"),
    FieldSpec("RewardType", "GameCore.RewardType", is_enum=True),
    FieldSpec("RewardTarget", "System.UInt32"),
    FieldSpec("RewardNum", "System.UInt32"),
    FieldSpec("LineIndex", "System.Int32"),
]

ACTIVITY_ACCUMULATE_IAP_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("SerialNo", "System.Int32"),
    FieldSpec("RewardType", "GameCore.RewardType", is_enum=True),
    FieldSpec("Target", "System.UInt32"),
    FieldSpec("RewardIndex", "System.UInt32"),
    FieldSpec("ItemRewardType", "GameCore.RewardType", is_enum=True),
    FieldSpec("RewardTarget", "System.UInt32"),
    FieldSpec("RewardNum", "System.UInt32"),
]

ACTIVITY_COST_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("SerialNo", "System.Int32"),
    FieldSpec("CostNum", "System.UInt32"),
    FieldSpec("Icon", "System.String"),
    FieldSpec("HeroPic", "System.String"),
    FieldSpec("RewardTypes", "GameCore.RewardType[]", is_enum=True),
    FieldSpec("RewardTargets", "uint[]"),
    FieldSpec("RewardNums", "uint[]"),
]

ACTIVITY_SELECT_GROW_SP_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("SerialNo", "System.Int32"),
    FieldSpec(
        "ConditionType",
        "GameCore.Activities.ActivitySelectGrowSpConditionType",
        is_enum=True,
    ),
    FieldSpec("ConditionTarget", "System.UInt32"),
    FieldSpec("ConditionNum", "System.UInt32"),
]

ACTIVITY_SIGN_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("RewardTargets", "uint[]"),
]

ACTIVITY_BINGO_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("SerialNo", "System.Int32"),
    FieldSpec("QuestPoint", "System.Int64"),
    FieldSpec("RewardType", "GameCore.RewardType", is_enum=True),
    FieldSpec("RewardTarget", "System.UInt32"),
    FieldSpec("RewardNum", "System.UInt32"),
]

ACTIVITY_BP_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("Name", "System.String"),
    FieldSpec("TargetBattlePower", "System.UInt32"),
    FieldSpec("BossIds", "uint[]"),
]

ACTIVITY_LIMIT_MAIN_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("SerialNo", "System.Int32"),
    FieldSpec("Name", "System.String"),
    FieldSpec("HeroGroupId", "System.UInt32"),
]

ACTIVITY_LIMIT_TALENT_SLOT_WIRE_FIELDS = [
    FieldSpec("Lv", "System.Int32"),
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("SkillId", "System.UInt16"),
    FieldSpec("CostTp", "System.UInt32"),
    FieldSpec("SlotIndex", "System.UInt32"),
    FieldSpec("RowFlag", "System.UInt32"),
]

ACTIVITY_LIMIT_BOSS_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("RecommendLv", "System.UInt16"),
    FieldSpec("MonsterId", "System.UInt32"),
    FieldSpec("Enabled", "System.UInt32"),
]

ACTIVITY_LOTTERY_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("Name", "System.String"),
    FieldSpec("ItemGroupId", "System.UInt32"),
    FieldSpec("SerialNo", "System.Int32"),
    FieldSpec("DrawGroupId", "System.UInt32"),
    # StageId5/6, TerminalId are computed in OnLoadFinished, not serialized
]

ACTIVITY_SETTING_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("Name", "System.String"),
    FieldSpec("Show", "System.Boolean"),
    FieldSpec("MenuShow", "System.Boolean"),
    FieldSpec("Sort", "System.UInt32"),
    FieldSpec("Icon", "System.String"),
    FieldSpec("IconNormal", "System.String"),
    FieldSpec("Bg", "System.String"),
    FieldSpec("BgNormal", "System.String"),
    FieldSpec("TipContent", "System.String"),
    FieldSpec("HeroInfo", "uint[]"),
    FieldSpec("PreStageSite", "System.UInt32"),
    FieldSpec("StartTime", "System.String"),
    FieldSpec("EndTime", "System.String"),
    FieldSpec("StartCreateRole", "System.String"),
    FieldSpec("EndCreateRole", "System.String"),
    FieldSpec("DurDay", "System.UInt32"),
    FieldSpec("ActivityType", "GameCore.Activities.ActivityType", is_enum=True),
    FieldSpec("ActivityVal1", "System.String"),
    FieldSpec("ActivityVal2", "System.String"),
    FieldSpec("ActivityVal3", "System.String"),
    FieldSpec("ActivityVal4", "System.String"),
    FieldSpec("ActivityVal5", "System.String"),
    FieldSpec("ActivityVal6", "System.String"),
    FieldSpec("NeedTarget", "uint[]"),
    FieldSpec("RewardType", "GameCore.RewardType[]", is_enum=True),
    FieldSpec("RewardTarget", "uint[]"),
    FieldSpec("RewardNum", "uint[]"),
]

ACCESSORY_SECONDARY_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("Group", "System.UInt32"),
    FieldSpec("SecondaryStatistic", "GameCore.StatisticType", is_enum=True),
    FieldSpec("SecondaryStatisticValue", "System.Int32"),
    FieldSpec("Grow", "System.Single"),
    FieldSpec("GrowTarget", "System.UInt32"),
    FieldSpec("GrowFlag", "System.Int32"),
]

WIRE_SPECS: Dict[str, TypeSpec] = {
    "GameCore.Accessories.AccessoryMainSetting": TypeSpec(
        "AccessoryMainSetting",
        "GameCore.Accessories.AccessoryMainSetting",
        ACCESSORY_MAIN_WIRE_FIELDS,
    ),
    "GameCore.Accessories.AccessorySecondarySetting": TypeSpec(
        "AccessorySecondarySetting",
        "GameCore.Accessories.AccessorySecondarySetting",
        ACCESSORY_SECONDARY_WIRE_FIELDS,
    ),
    "GameCore.Accessories.AccessorySetting": TypeSpec(
        "AccessorySetting",
        "GameCore.Accessories.AccessorySetting",
        ACCESSORY_SETTING_WIRE_FIELDS,
    ),
    "GameCore.Accessories.AccessorySetSetting": TypeSpec(
        "AccessorySetSetting",
        "GameCore.Accessories.AccessorySetSetting",
        ACCESSORY_SET_WIRE_FIELDS,
    ),
    "GameCore.Achieves.AttrGrowAchieveSetting": TypeSpec(
        "AttrGrowAchieveSetting",
        "GameCore.Achieves.AttrGrowAchieveSetting",
        ATTR_GROW_ACHIEVE_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityBingoRewardSetting": TypeSpec(
        "ActivityBingoRewardSetting",
        "GameCore.Activities.ActivityBingoRewardSetting",
        ACTIVITY_BINGO_REWARD_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityAccumulateIapSetting": TypeSpec(
        "ActivityAccumulateIapSetting",
        "GameCore.Activities.ActivityAccumulateIapSetting",
        ACTIVITY_ACCUMULATE_IAP_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivitySetting": TypeSpec(
        "ActivitySetting",
        "GameCore.Activities.ActivitySetting",
        ACTIVITY_SETTING_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityCostSetting": TypeSpec(
        "ActivityCostSetting",
        "GameCore.Activities.ActivityCostSetting",
        ACTIVITY_COST_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivitySelectGrowSpSetting": TypeSpec(
        "ActivitySelectGrowSpSetting",
        "GameCore.Activities.ActivitySelectGrowSpSetting",
        ACTIVITY_SELECT_GROW_SP_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivitySignSetting": TypeSpec(
        "ActivitySignSetting",
        "GameCore.Activities.ActivitySignSetting",
        ACTIVITY_SIGN_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityBingoSetting": TypeSpec(
        "ActivityBingoSetting",
        "GameCore.Activities.ActivityBingoSetting",
        ACTIVITY_BINGO_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityBpSetting": TypeSpec(
        "ActivityBpSetting",
        "GameCore.Activities.ActivityBpSetting",
        ACTIVITY_BP_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityLimitMainSetting": TypeSpec(
        "ActivityLimitMainSetting",
        "GameCore.Activities.ActivityLimitMainSetting",
        ACTIVITY_LIMIT_MAIN_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityLimitTalentSlotSetting": TypeSpec(
        "ActivityLimitTalentSlotSetting",
        "GameCore.Activities.ActivityLimitTalentSlotSetting",
        ACTIVITY_LIMIT_TALENT_SLOT_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityLimitBossSetting": TypeSpec(
        "ActivityLimitBossSetting",
        "GameCore.Activities.ActivityLimitBossSetting",
        ACTIVITY_LIMIT_BOSS_WIRE_FIELDS,
    ),
    "GameCore.Activities.ActivityLotterySetting": TypeSpec(
        "ActivityLotterySetting",
        "GameCore.Activities.ActivityLotterySetting",
        ACTIVITY_LOTTERY_WIRE_FIELDS,
    ),
    "GameCore.StringSetting": TypeSpec(
        "StringSetting",
        "GameCore.StringSetting",
        [
            FieldSpec("Id", "System.UInt32"),
            FieldSpec("Text", "System.String"),
        ],
    ),
}


STRING_SETTING_WIRE_FIELDS = [
    FieldSpec("Id", "System.UInt32"),
    FieldSpec("Text", "System.String"),
]


def spec_for_table(setting_full_name: str, classes: Dict[str, dict]) -> TypeSpec:
    if setting_full_name in WIRE_SPECS:
        return WIRE_SPECS[setting_full_name]
    if setting_full_name == "GameCore.Activities.ActivityLotterySetting":
        return TypeSpec(
            "ActivityLotterySetting",
            setting_full_name,
            ACTIVITY_LOTTERY_WIRE_FIELDS,
        )
    if setting_full_name == "GameCore.StringSetting":
        return TypeSpec(
            "StringSetting",
            setting_full_name,
            STRING_SETTING_WIRE_FIELDS,
        )
    if setting_full_name in classes:
        return enrich_field_specs_from_schema(classes[setting_full_name])
    raise KeyError(setting_full_name)


def resolve_setting_for_elem_tc(
    elem_tc: int,
    typecode_map: Dict[int, str],
    classes: Dict[str, dict],
) -> Tuple[str, Optional[TypeSpec]]:
    full = typecode_map.get(elem_tc) or ELEMENT_TYPECODE_TO_NAME.get(elem_tc, "")
    if not full:
        for cls_full, cls in classes.items():
            base = cls.get("type_code")
            if base is None:
                continue
            candidate = wire_element_type_code(int(base))
            if candidate == elem_tc:
                full = cls_full
                break
    if not full:
        return f"Unknown_{elem_tc:08X}", TypeSpec(
            f"Unknown_{elem_tc:08X}",
            f"Unknown_{elem_tc:08X}",
            [],
        )
    try:
        return full, spec_for_table(full, classes)
    except KeyError:
        return full, TypeSpec(
            full.rsplit(".", 1)[-1],
            full,
            [],
        )


def build_typecode_map(classes: Dict[str, dict]) -> Dict[int, str]:
    mapping: Dict[int, str] = {}
    for name, tc in ELEMENT_TYPECODE.items():
        mapping[tc] = name
    for full, cls in classes.items():
        base = cls.get("type_code")
        if base is None:
            continue
        tc = wire_element_type_code(int(base))
        mapping.setdefault(tc, full)
    return mapping


def build_metas_order(
    tables: List[dict],
    *,
    load_priority: Optional[Dict[str, int]] = None,
) -> List[dict]:
    load_priority = load_priority or {}
    dict_tables = [t for t in tables if t.get("container") == "SettingDictionary"]
    return sorted(
        dict_tables,
        key=lambda t: (
            load_priority.get(t.get("setting_full_name", ""), 254),
            t.get("property", ""),
        ),
    )



SETTING_LOAD_PRIORITY: Dict[str, int] = {
    "GameCore.Accessories.AccessoryMainSetting": 0,
    "GameCore.Accessories.AccessorySecondarySetting": 1,
    "GameCore.Accessories.AccessorySetting": 2,
    "GameCore.Accessories.AccessorySetSetting": 3,
    "GameCore.Achieves.AttrGrowAchieveSetting": 4,
    "GameCore.Activities.ActivityBingoRewardSetting": 5,
    "GameCore.Activities.ActivityAccumulateIapSetting": 6,
    "GameCore.Activities.ActivitySetting": 7,
    "GameCore.Activities.ActivityCostSetting": 8,
    "GameCore.Activities.ActivitySelectGrowSpSetting": 9,
    "GameCore.Activities.ActivitySignSetting": 10,
    "GameCore.Activities.ActivityBingoSetting": 11,
    "GameCore.Activities.ActivityBpSetting": 12,
    "GameCore.Activities.ActivityLimitBossSetting": 13,
    "GameCore.Activities.ActivityLimitMainSetting": 14,
    "GameCore.Activities.ActivityLotterySetting": 16,
    "GameCore.StringSetting": 17,
}


def _looks_like_next_element(data: bytes, offset: int, element_type_code: int) -> bool:
    if element_type_code == 0 or offset + 5 > len(data):
        return False
    if struct.unpack_from("<I", data, offset)[0] != element_type_code:
        return False
    return data[offset + 4] == 0x00


def find_next_element_offset(
    data: bytes, search_from: int, element_type_code: int
) -> int:
    pat = struct.pack("<I", element_type_code)
    pos = max(search_from, 0)
    while pos + 5 <= len(data):
        nxt = data.find(pat, pos)
        if nxt < 0:
            return -1
        if data[nxt + 4] == 0x00:
            return nxt
        pos = nxt + 1
    return -1


def read_field_from_reader(reader: BinaryReader, spec: FieldSpec) -> Any:
    tc = reader.read_uint32()
    if tc == 0xFFFFFFFF:
        return None
    value, new_offset = _read_field_value_from_buffer(
        reader._data, reader.tell(), spec, tc
    )
    reader.seek(new_offset)
    return value


def _resolve_wire_alias(field_tc: int) -> Optional[Tuple[str, bool]]:
    base_tc = field_tc & 0xFFFFFFFC
    raw = WIRE_TC_TYPE_ALIASES.get(field_tc) or WIRE_TC_TYPE_ALIASES.get(base_tc)
    if raw is None:
        return None
    if isinstance(raw, tuple):
        return raw[0], bool(raw[1])
    return str(raw), str(raw).startswith("GameCore.")


def _field_spec_for_wire_tc(field_tc: int) -> FieldSpec:
    base_tc = field_tc & 0xFFFFFFFC
    rank = field_tc & 3
    alias = _resolve_wire_alias(field_tc) or _resolve_wire_alias(base_tc)
    if alias:
        type_name, is_enum = alias
        if rank:
            type_name = f"{type_name}[]" if not type_name.endswith("[]") else type_name
        return FieldSpec(
            f"Field_{field_tc:08X}",
            type_name,
            is_enum=is_enum,
        )
    for type_name, code in WIRE_FIELD_TYPECODE.items():
        if code == base_tc:
            if rank:
                return FieldSpec(
                    f"Field_{field_tc:08X}",
                    f"{type_name}[]" if not type_name.endswith("[]") else type_name,
                    is_enum=type_name.startswith("GameCore."),
                )
            return FieldSpec(
                f"Field_{field_tc:08X}",
                type_name,
                is_enum=type_name.startswith("GameCore."),
            )
    raise NotImplementedError(f"unknown field typeCode {field_tc:#010x}")


def read_field_by_wire_tc(reader: BinaryReader, field_tc: int) -> Any:
    fspec = _field_spec_for_wire_tc(field_tc)
    return read_field_from_reader(reader, fspec)


def known_field_wire_typecodes() -> frozenset:
    """Field-level typeCodes that must not be treated as array element headers."""
    codes = set(WIRE_FIELD_TYPECODE.values())
    codes.update(WIRE_TC_TYPE_ALIASES.keys())
    expanded: set = set()
    for tc in codes:
        base = tc & 0xFFFFFFFC
        for rank in range(4):
            expanded.add(base | rank)
    return frozenset(expanded)


def find_table_header_with_elem_tc(data: bytes, search_from: int, elem_tc: int) -> int:
    """Locate the next ArrayFormatter table header with a specific element typeCode."""
    if not elem_tc:
        return -1
    pat = struct.pack("<I", elem_tc)
    pos = max(search_from, 0)
    while True:
        idx = data.find(pat, pos)
        if idx < 4:
            return -1
        hdr = idx - 4
        count = struct.unpack_from("<I", data, hdr)[0]
        if count in (0, 0xFFFFFFFF):
            pos = idx + 1
            continue
        if not (1 <= count <= 500_000):
            pos = idx + 1
            continue
        if data[hdr + 8] not in (0x00, 0xFF):
            pos = idx + 1
            continue
        return hdr


def find_next_array_header(
    data: bytes,
    search_from: int,
    typecode_map: Dict[int, str],
    *,
    exclude_tc: int = 0,
) -> int:
    pos = max(search_from, 0)
    while pos + 13 <= len(data):
        if not is_nonempty_table_header(data, pos):
            pos += 1
            continue
        count = struct.unpack_from("<I", data, pos)[0]
        elem_tc = struct.unpack_from("<I", data, pos + 4)[0]
        if elem_tc == exclude_tc:
            pos += 1
            continue
        if elem_tc in typecode_map:
            return pos
        if is_plausible_table_header(data, pos):
            return pos
        pos += 1
    return len(data)


def find_next_nonempty_table_header(
    data: bytes,
    search_from: int,
    *,
    exclude_tc: int = 0,
    max_search: int = 2_000_000,
) -> int:
    pos = max(search_from, 0)
    end = min(len(data), pos + max(max_search, 4096))
    while pos + 9 <= end:
        count = struct.unpack_from("<I", data, pos)[0]
        if count in (0, 0xFFFFFFFF):
            pos += 4
            continue
        if is_plausible_table_header(data, pos):
            elem_tc = struct.unpack_from("<I", data, pos + 4)[0]
            if exclude_tc and elem_tc == exclude_tc:
                pos += 4
                continue
            return pos
        pos += 4
    return len(data)


def deserialize_object_generic_from_reader(
    reader: BinaryReader,
    *,
    element_type_code: int = 0,
    type_name: str = "",
    record_end: Optional[int] = None,
    field_specs: Optional[List[FieldSpec]] = None,
) -> Dict[str, Any]:
    table_start = reader.tell()
    if reader.remaining() < 1:
        raise EOFError(f"truncated object prefix at {table_start}")
    marker = reader.read_byte()
    if marker == 0xFF:
        return {"_type": type_name, "_null": True}
    if marker != 0x00:
        raise ValueError(
            f"unexpected object prefix 0x{marker:02x} at {table_start} for {type_name}"
        )

    obj: Dict[str, Any] = {"_type": type_name}
    field_idx = 0
    while reader.remaining() >= 4:
        if record_end is not None and reader.tell() >= record_end:
            break
        if _looks_like_next_element(reader._data, reader.tell(), element_type_code):
            break
        pos = reader.tell()
        field_tc = struct.unpack_from("<I", reader._data, pos)[0]
        field_name = (
            field_specs[field_idx].name
            if field_specs and field_idx < len(field_specs)
            else f"Field{field_idx}"
        )
        if field_tc == 0xFFFFFFFF:
            reader.read_uint32()
            obj[field_name] = None
            field_idx += 1
            continue
        reader.seek(pos)
        try:
            wire_fspec = _field_spec_for_wire_tc(field_tc)
            if field_specs and field_idx < len(field_specs):
                wire_fspec = FieldSpec(
                    field_specs[field_idx].name,
                    field_specs[field_idx].type_name,
                    is_enum=field_specs[field_idx].is_enum,
                    is_class=field_specs[field_idx].is_class,
                    is_nullable=field_specs[field_idx].is_nullable,
                )
            obj[field_name] = read_field_from_reader(reader, wire_fspec)
            field_idx += 1
        except (EOFError, NotImplementedError, ValueError):
            next_pos = pos + 4
            limit = record_end if record_end is not None else pos + 512
            resynced = False
            while next_pos + 4 <= limit:
                scan_tc = struct.unpack_from("<I", reader._data, next_pos)[0]
                if _looks_like_next_element(reader._data, next_pos, element_type_code):
                    reader.seek(next_pos)
                    resynced = True
                    break
                try:
                    _field_spec_for_wire_tc(scan_tc)
                    reader.seek(next_pos)
                    resynced = True
                    break
                except NotImplementedError:
                    next_pos += 1
            if not resynced:
                if record_end is not None:
                    reader.seek(record_end)
                break
    return obj


def deserialize_object_from_reader(
    reader: BinaryReader,
    spec: TypeSpec,
    *,
    element_type_code: int = 0,
    use_generic: bool = False,
    record_end: Optional[int] = None,
) -> Dict[str, Any]:
    if use_generic or spec.full_name not in WIRE_SPECS:
        return deserialize_object_generic_from_reader(
            reader,
            element_type_code=element_type_code,
            type_name=spec.full_name,
            record_end=record_end,
            field_specs=spec.fields or None,
        )

    table_start = reader.tell()
    if reader.remaining() < 1:
        raise EOFError(f"truncated object prefix at {table_start}")
    marker = reader.read_byte()
    if marker == 0xFF:
        return {"_type": spec.full_name, "_null": True}
    if marker != 0x00:
        raise ValueError(
            f"unexpected object prefix 0x{marker:02x} at {table_start} for {spec.full_name}"
        )

    obj: Dict[str, Any] = {"_type": spec.full_name}
    is_known_spec = spec.full_name in WIRE_SPECS
    for fspec in spec.fields:
        if not is_known_spec and record_end is not None and reader.tell() >= record_end:
            break

        if not is_known_spec:
            if _looks_like_next_element(reader._data, reader.tell(), element_type_code):
                break
        try:
            obj[fspec.name] = read_field_from_reader(reader, fspec)
        except (EOFError, NotImplementedError, ValueError) as exc:
            obj["_error"] = str(exc)
            obj["_tail"] = reader._data[reader.tell() : record_end].hex()
            break

    extra_idx = 0
    if not is_known_spec:
        while (
            reader.remaining() >= 4
            and (record_end is None or reader.tell() < record_end)
            and (
                not element_type_code
                or not _looks_like_next_element(
                    reader._data, reader.tell(), element_type_code
                )
            )
        ):
            pos = reader.tell()
            field_tc = struct.unpack_from("<I", reader._data, pos)[0]
            try:
                reader.seek(pos)
                value = read_field_by_wire_tc(reader, field_tc)
                obj[f"_extra_{extra_idx}_{field_tc:08X}"] = value
                extra_idx += 1
            except (EOFError, NotImplementedError, ValueError):
                break


    if not is_known_spec:
        if record_end is not None and reader.tell() < record_end:
            reader.seek(record_end)

    if (
        "_error" not in obj
        and reader.remaining()
        and not element_type_code
        and record_end is None
        and not is_known_spec
    ):
        tail = reader._data[reader.tell() :]
        if tail:
            obj["_tail"] = tail.hex()
    return obj


def read_array_formatter_table_stream(
    reader: BinaryReader,
    spec: Optional[TypeSpec] = None,
    *,
    property_name: str = "",
    element_type_code: Optional[int] = None,
    next_element_type_code: Optional[int] = None,
    typecode_map: Optional[Dict[int, str]] = None,
    classes: Optional[Dict[str, dict]] = None,
    table_end: Optional[int] = None,
) -> TableChunk:
    classes = classes or {}
    table_start = reader.tell()
    count_raw = reader.read_uint32()
    if count_raw == 0xFFFFFFFF:
        return TableChunk(
            property_name=property_name,
            setting_full_name=spec.full_name if spec else "",
            count=-1,
            element_type_code=0,
            record_size=0,
            offset=table_start,
            size=4,
            items=[],
        )
    if count_raw == 0:

        reader.seek(table_start)
        return TableChunk(
            property_name=property_name,
            setting_full_name=spec.full_name if spec else "",
            count=0,
            element_type_code=element_type_code or 0,
            record_size=0,
            offset=table_start,
            size=0,
            items=[],
        )
    if count_raw > 10_000_000:
        raise ValueError(f"implausible table count {count_raw} at {table_start}")

    count = int(count_raw)
    elem_tc = element_type_code or 0
    active_spec = spec
    items: List[Dict[str, Any]] = []
    tc_map = typecode_map or {}
    stride = 0
    first_elem_pos = 0
    for idx in range(count):
        pos = reader.tell()
        wire_tc = reader.read_uint32()
        if wire_tc == 0xFFFFFFFF:
            items.append(
                {"_type": active_spec.full_name if active_spec else "", "_null": True}
            )
            continue
        if elem_tc and wire_tc != elem_tc:
            if idx == 0:
                elem_tc = wire_tc
            else:
                raise ValueError(
                    f"element typeCode mismatch at {pos}: {wire_tc:#010x} != {elem_tc:#010x}"
                )
        else:
            elem_tc = wire_tc
        tc_map.setdefault(elem_tc, active_spec.full_name if active_spec else "")
        if idx == 0:
            first_elem_pos = pos
        elif idx == 1 and first_elem_pos:
            stride = pos - first_elem_pos
        if active_spec is None:
            full, active_spec = resolve_setting_for_elem_tc(wire_tc, tc_map, classes)
            tc_map[wire_tc] = full
        record_end = None
        if idx + 1 < count:
            if active_spec is None or active_spec.full_name not in WIRE_SPECS:
                nxt = find_next_element_offset(reader._data, pos + 8, elem_tc)
                if nxt > 0:
                    record_end = nxt
                elif stride > 0:
                    record_end = pos + stride
            elif stride > 0:
                record_end = pos + stride
        else:
            if table_end is not None and table_end > pos:
                record_end = table_end
            elif next_element_type_code:
                hdr = find_table_header_with_elem_tc(
                    reader._data, pos + 8, next_element_type_code
                )
                if hdr > pos:
                    record_end = hdr
            if record_end is None:
                header_end = find_next_array_header(
                    reader._data, pos + 8, tc_map, exclude_tc=elem_tc
                )
                if header_end > pos:
                    record_end = header_end
            if record_end is None and stride > 0:
                record_end = pos + stride
        try:
            items.append(
                deserialize_object_from_reader(
                    reader,
                    active_spec,
                    element_type_code=elem_tc if elem_tc else (element_type_code or 0),
                    record_end=record_end,
                )
            )
        except (EOFError, NotImplementedError, ValueError) as exc:
            items.append(
                {
                    "_type": active_spec.full_name if active_spec else "",
                    "_error": str(exc),
                    "_offset": pos,
                }
            )
            break

    chunk_end = reader.tell()
    if table_end is not None and table_end > chunk_end:
        reader.seek(table_end)
        chunk_end = table_end
    return TableChunk(
        property_name=property_name,
        setting_full_name=(
            active_spec.full_name
            if active_spec
            else (typecode_map or {}).get(elem_tc, "")
        ),
        count=count,
        element_type_code=elem_tc,
        record_size=-1,
        offset=table_start,
        size=chunk_end - table_start,
        items=items,
    )


def assign_property_names(
    chunks: List[TableChunk],
    metas: List[dict],
    typecode_map: Dict[int, str],
) -> None:
    prop_by_type: Dict[str, str] = {}
    for meta in metas:
        full = meta.get("setting_full_name")
        prop = meta.get("property")
        if full and prop and full not in prop_by_type:
            prop_by_type[full] = prop

    if len(chunks) != len(metas):
        for i, chunk in enumerate(chunks):
            if chunk.property_name:
                continue
            if chunk.count > 0 and chunk.element_type_code:
                full = typecode_map.get(
                    chunk.element_type_code, chunk.setting_full_name
                )
                chunk.setting_full_name = full or chunk.setting_full_name
                chunk.property_name = prop_by_type.get(full, f"table_{i}")
            elif i < len(metas):
                chunk.property_name = metas[i].get("property", f"table_{i}")
                chunk.setting_full_name = metas[i].get("setting_full_name", "")
        return

    for chunk, meta in zip(chunks, metas):
        chunk.property_name = meta.get("property", "")
        expected_full = meta.get("setting_full_name", "")
        if chunk.count > 0 and chunk.element_type_code:
            actual_full = typecode_map.get(
                chunk.element_type_code, chunk.setting_full_name
            )
            chunk.setting_full_name = actual_full or expected_full
            if expected_full and actual_full and actual_full != expected_full:
                chunk.items.insert(
                    0,
                    {
                        "_warn": (
                            f"metas expected {expected_full} but wire elem_tc "
                            f"maps to {actual_full}"
                        )
                    },
                )
        else:
            chunk.setting_full_name = expected_full


BLOCKLIST_ELEMENT_TCS = {
    0x22F20A7C,
    0x4441CDFC,
    0x788C5544,
    0x8C0E9040,
    0x96D03930,
    0x2DD45A30,
    0x0EBABED4,
    0xFFFFFFFF,
    0x00000000,
    0xFFFFFF00,
    0x00FFFFFF,
    0xFFFF00FF,
}



def is_nonempty_table_header(
    data: bytes, pos: int, *, known_elem_tcs: Optional[set] = None
) -> bool:
    if pos + 9 > len(data):
        return False
    count = struct.unpack_from("<I", data, pos)[0]
    if not (1 <= count <= 500_000):
        return False
    elem_tc = struct.unpack_from("<I", data, pos + 4)[0]
    if elem_tc in BLOCKLIST_ELEMENT_TCS or elem_tc in known_field_wire_typecodes():
        return False
    if elem_tc < 0x0040_0000 and not (known_elem_tcs and elem_tc in known_elem_tcs):
        return False
    return data[pos + 8] in (0x00, 0xFF)


def is_array_formatter_table_header(data: bytes, pos: int) -> bool:
    if pos + 4 > len(data):
        return False
    count = struct.unpack_from("<I", data, pos)[0]
    if count in (0, 0xFFFFFFFF):
        return True
    return is_nonempty_table_header(data, pos)


def is_plausible_table_header(data: bytes, pos: int) -> bool:
    if not is_array_formatter_table_header(data, pos):
        return False
    count = struct.unpack_from("<I", data, pos)[0]
    if count in (0, 0xFFFFFFFF):
        return True
    elem_tc = struct.unpack_from("<I", data, pos + 4)[0]
    if elem_tc in BLOCKLIST_ELEMENT_TCS or elem_tc < 0x0010_0000:
        return False
    if elem_tc in known_field_wire_typecodes():
        return False
    if not (1 <= count <= 500_000):
        return False
    if pos + 8 + 1 > len(data):
        return False
    if data[pos + 8] not in (0x00, 0xFF):
        return False

    try:
        stride = detect_record_stride(data, pos + 4, elem_tc, count)
        if 8 <= stride <= 4096 and stride * count <= 20_000_000:
            return True
    except ValueError:
        pass
    try:
        offsets = find_variable_record_offsets(data, pos + 4, count, elem_tc)
    except ValueError:
        return 1 <= count <= 500_000
    if count > 500:
        return False
    if len(offsets) < 2:
        return True
    span = offsets[-1] - offsets[0]
    avg = span / (len(offsets) - 1)
    return 8 <= avg <= 4096


def find_variable_record_offsets(
    data: bytes, table_start: int, count: int, element_type_code: int
) -> List[int]:
    pat = struct.pack("<I", element_type_code)
    pos = table_start
    if data[pos : pos + 4] != pat:
        raise ValueError(
            f"element typeCode mismatch at {pos}: "
            f"{struct.unpack_from('<I', data, pos)[0]:#010x} != {element_type_code:#010x}"
        )

    offsets = [pos]
    for _ in range(count - 1):
        nxt = data.find(pat, pos + 8)
        if nxt < 0:
            raise ValueError(
                f"only found {len(offsets)} variable records for element {element_type_code:#x}"
            )
        offsets.append(nxt)
        pos = nxt
    return offsets


def find_table_stream_end(data: bytes, search_from: int) -> int:
    pos = max(search_from, 0)
    while pos + 8 <= len(data):
        if is_plausible_table_header(data, pos):
            return pos
        elem_tc = struct.unpack_from("<I", data, pos + 4)[0]
        if elem_tc in (0xFFFFFF00, 0xFFFFFFFF) or elem_tc < 0x0010_0000:
            return pos
        if pos + 16 <= len(data) and data[pos + 8 : pos + 16] == b"\xff" * 8:
            return pos
        pos += 4
    return len(data)


def find_next_table_offset(data: bytes, search_from: int) -> int:
    pos = max(search_from, 0)
    while pos < len(data) - 8:
        if is_plausible_table_header(data, pos):
            return pos
        pos += 4
    return find_table_stream_end(data, search_from)


def property_name_for_setting(tables: List[dict], setting_full_name: str) -> str:
    for meta in tables:
        if meta.get("setting_full_name") == setting_full_name:
            return meta.get("property", "")
    return ""


def game_helper_datetime_parse(text: Optional[str]) -> Optional[str]:
    if not text or not str(text).strip():
        return None
    s = str(text).strip()
    for fmt in (
        "%Y/%m/%d %H:%M:%S",
        "%Y-%m-%d %H:%M:%S",
        "%Y/%m/%d %H:%M",
        "%Y/%m/%d",
        "%Y-%m-%d",
    ):
        try:
            return datetime.strptime(s, fmt).strftime("%Y-%m-%d %H:%M:%S")
        except ValueError:
            continue
    return s


def build_group_index(
    items: List[Dict[str, Any]],
    key_field: str,
    *,
    skip_zero: bool = True,
) -> Dict[Any, List[Dict[str, Any]]]:
    groups: Dict[Any, List[Dict[str, Any]]] = {}
    for item in items:
        key = item.get(key_field)
        if skip_zero and not key:
            continue
        groups.setdefault(key, []).append(item)
    return groups


SET_GROUP_INDEX: Dict[str, Dict[str, Any]] = {
    "GameCore.Accessories.AccessoryMainSetting": {"key": "Group", "skip_zero": True},
    "GameCore.Accessories.AccessorySecondarySetting": {
        "key": "Group",
        "skip_zero": True,
    },
    "GameCore.Accessories.AccessorySetting": {"key": "Type", "skip_zero": False},
    "GameCore.Achieves.AttrGrowAchieveSetting": {"key": "Attr", "skip_zero": False},
}


def build_need_and_rewards(entry: Dict[str, Any]) -> List[Dict[str, Any]]:
    """ActivitySetting.OnLoadFinished: zip parallel arrays (length 8)."""
    need = entry.get("NeedTarget") or []
    rtype = entry.get("RewardType") or []
    rtarget = entry.get("RewardTarget") or []
    rnum = entry.get("RewardNum") or []
    rows: List[Dict[str, Any]] = []
    for i in range(8):
        need_target = need[i] if i < len(need) else 0
        reward_num = rnum[i] if i < len(rnum) else 0
        if need_target and reward_num:
            rows.append(
                {
                    "index": i,
                    "needTarget": need_target,
                    "rewardType": rtype[i] if i < len(rtype) else 0,
                    "rewardTarget": rtarget[i] if i < len(rtarget) else 0,
                    "rewardNum": reward_num,
                }
            )
    return rows


def postprocess_activity_setting(entry: Dict[str, Any]) -> Dict[str, Any]:
    """Mirror ActivitySetting.OnLoadFinished derived fields."""
    out = dict(entry)
    if not out.get("Id"):
        return out
    out["NeedAndRewards"] = build_need_and_rewards(out)
    for src, dst in (
        ("StartTime", "StartDT"),
        ("EndTime", "EndDT"),
        ("StartCreateRole", "StartCreateRoleDT"),
        ("EndCreateRole", "EndCreateRoleDT"),
    ):
        out[dst] = game_helper_datetime_parse(out.get(src))
    return out


def postprocess_expedition_skill_setting(entry: Dict[str, Any]) -> Dict[str, Any]:
    """Mirror ExpeditionSkillSetting.OnLoadFinished"""
    out = dict(entry)
    if not out.get("Id"):
        return out

    exp_type = out.get("ExpeditionSkillType", 0)
    effect_val1_str = out.get("EffectValue1", "")

    val1 = 0
    if effect_val1_str:
        try:
            val1 = int(effect_val1_str)
        except ValueError:
            val1 = 0

    if exp_type <= 11:
        if (1 << exp_type) & 0xFED:
            out["IntEffectValue1"] = val1
        else:
            out["IntEffectValue1"] = val1
            out["IntEffectValue2"] = val1

    return out


def postprocess_skill_setting(entry: Dict[str, Any]) -> Dict[str, Any]:
    out = dict(entry)
    if not out.get("Id"):
        return out

    buff_sort_str = out.get("BuffSortOrder", "")
    buff_order_list = []
    if buff_sort_str:
        parts = buff_sort_str.split("#")
        for p in parts:
            if p.strip():
                try:
                    val = int(p)
                    if val not in buff_order_list:
                        buff_order_list.append(val)
                except ValueError:
                    pass

    buff_order_list.append(0)
    out["ParsedBuffSortOrder"] = buff_order_list

    self_hp_str = out.get("SelfHpPercentGrow", "")
    if self_hp_str:
        out["ParsedTargetHpPercent"] = [tag for tag in self_hp_str.split("/") if tag]

    self_max_hp_str = out.get("SelfMaxHpPercent", "")
    if self_max_hp_str:
        if "/" in self_max_hp_str or "," in self_max_hp_str:
            combo_add_grow = []
            hp_percent_grow = []
            for part in self_max_hp_str.split("/"):
                if "," in part:
                    sub_parts = part.split(",")
                    if len(sub_parts) == 2:
                        try:
                            combo_add_grow.append(
                                {"Item1": int(sub_parts[0]), "Item2": int(sub_parts[1])}
                            )
                        except ValueError:
                            pass
                else:
                    try:
                        hp_percent_grow.append(int(part))
                    except ValueError:
                        pass
            out["ParsedTargetHpComboAddGrow"] = combo_add_grow
            out["ParsedTargetHpPercentGrow"] = hp_percent_grow
        else:
            try:
                out["TargetHpPercentLo"] = int(self_max_hp_str)
            except ValueError:
                pass

    return out


def passes_on_load_finished(entry: Dict[str, Any], setting_full_name: str) -> bool:
    """ISettingEntry.OnLoadFinished filter used by LoadFromSerializeStream."""
    if entry.get("_error") is not None:
        return True
    entry_id = entry.get("Id")

    if setting_full_name in (
        "GameCore.Activities.ActivitySetting",
        "GameCore.Expeditions.ExpeditionSkillSetting",
        "GameCore.Heros.SkillSetting",
    ):
        return bool(entry_id)

    if setting_full_name in (
        "GameCore.ActivityLotteryItemSetting",
        "GameCore.SpecialValueSetting",
    ):
        return bool(entry_id) and bool(entry.get("GroupId"))

    if entry_id is not None:
        return bool(entry_id)
    return True


_POSTPROCESS_BY_TYPE: Dict[str, Any] = {
    "GameCore.Activities.ActivitySetting": postprocess_activity_setting,
    "GameCore.Expeditions.ExpeditionSkillSetting": postprocess_expedition_skill_setting,
    "GameCore.Heros.SkillSetting": postprocess_skill_setting,
}


def apply_on_load_finished_to_chunk(
    chunk: TableChunk, *, filter_entries: bool = True
) -> TableChunk:
    post = _POSTPROCESS_BY_TYPE.get(chunk.setting_full_name)
    items: List[Dict[str, Any]] = []
    for entry in chunk.items:
        row = post(entry) if post else dict(entry)
        if not filter_entries or passes_on_load_finished(row, chunk.setting_full_name):
            items.append(row)
    return TableChunk(
        property_name=chunk.property_name,
        setting_full_name=chunk.setting_full_name,
        count=len(items) if filter_entries else chunk.count,
        element_type_code=chunk.element_type_code,
        record_size=chunk.record_size,
        offset=chunk.offset,
        size=chunk.size,
        items=items,
    )


def apply_on_load_finished(
    chunks: List[TableChunk], *, filter_entries: bool = True
) -> List[TableChunk]:
    return [
        apply_on_load_finished_to_chunk(c, filter_entries=filter_entries)
        for c in chunks
    ]


def compute_table_end(
    data: bytes,
    pos: int,
    count: int,
    elem_tc: int,
    *,
    known_elem_tcs: Optional[set] = None,
) -> int:
    if count <= 0:
        return pos + 4
    record_start = pos + 4
    try:
        offsets = find_variable_record_offsets(data, record_start, count, elem_tc)
        if len(offsets) == count:
            last_start = offsets[-1]
            nxt = find_next_nonempty_table_header(
                data,
                last_start + 64,
                max_search=262144,
                known_elem_tcs=known_elem_tcs,
            )
            if nxt > pos:
                return nxt
    except ValueError:
        pass
    try:
        stride = detect_record_stride(data, record_start, elem_tc, count)
        end = record_start + stride * count
        if pos < end <= len(data) and is_plausible_table_header(data, end):
            return end
    except ValueError:
        pass
    return find_next_nonempty_table_header(
        data, pos + 9, max_search=500_000, known_elem_tcs=known_elem_tcs
    )


def parse_all_tables(
    data: bytes,
    tables: List[dict],
    classes: Dict[str, dict],
    max_tables: Optional[int] = None,
    mode: str = "sequential",
    on_load_finished: bool = False,
) -> List[TableChunk]:
    chunks = parse_all_tables_sequential(data, tables, classes, max_tables=max_tables)
    if on_load_finished:
        chunks = apply_on_load_finished(chunks)
    return chunks


def parse_all_tables_sequential(
    data: bytes,
    tables: List[dict],
    classes: Dict[str, dict],
    max_tables: Optional[int] = None,
) -> List[TableChunk]:
    reader = BinaryReader(data)
    typecode_map = build_typecode_map(classes)
    metas = build_metas_order(tables, load_priority=SETTING_LOAD_PRIORITY)
    chunks: List[TableChunk] = []
    limit = max_tables if max_tables is not None else len(metas)

    consecutive_warnings = 0
    MAX_CONSECUTIVE_WARNINGS = 8
    i = 0
    while i < len(metas[:limit]):
        meta = metas[i]
        if reader.remaining() < 4:
            break
        if reader.tell() > 500_000 and consecutive_warnings > 3:
            break
        full = meta.get("setting_full_name", "")
        next_full = metas[i + 1].get("setting_full_name", "") if i + 1 < limit else ""
        try:
            spec = spec_for_table(full, classes) if full else None
            elem_tc = ELEMENT_TYPECODE.get(full) if full else None
            if elem_tc is None and full in classes:
                base = classes[full].get("type_code")
                if base is not None:
                    elem_tc = wire_element_type_code(int(base))
            next_elem_tc = ELEMENT_TYPECODE.get(next_full) if next_full else None
            if next_elem_tc is None and next_full:
                base = classes.get(next_full, {}).get("type_code")
                if base is not None:
                    next_elem_tc = wire_element_type_code(int(base))

            pos_before = reader.tell()
            if pos_before + 12 <= len(data):
                peek_cnt = struct.unpack_from("<I", data, pos_before)[0]
                peek_nxt_cnt = struct.unpack_from("<I", data, pos_before + 4)[0]
                peek_nxt_tc = struct.unpack_from("<I", data, pos_before + 8)[0]
                if (
                    peek_cnt == 0
                    and 1 <= peek_nxt_cnt <= 500_000
                    and peek_nxt_tc >= 0x00400000
                    and data[pos_before + 12] in (0x00, 0xFF)
                ):
                    reader.seek(pos_before + 4)
                    continue

            chunk = read_array_formatter_table_stream(
                reader,
                spec,
                property_name=meta.get("property", ""),
                element_type_code=elem_tc,
                next_element_type_code=next_elem_tc,
                typecode_map=typecode_map,
                classes=classes,
            )
            chunks.append(chunk)
            consecutive_warnings = 0
            i += 1
        except (EOFError, ValueError, NotImplementedError, KeyError) as exc:
            consecutive_warnings += 1
            if consecutive_warnings > MAX_CONSECUTIVE_WARNINGS:
                break
            pos_now = reader.tell()
            if pos_now + 12 <= len(data):
                cnt_here = struct.unpack_from("<I", data, pos_now)[0]
                cnt_next = struct.unpack_from("<I", data, pos_now + 4)[0]
                tc_next = struct.unpack_from("<I", data, pos_now + 8)[0]
                if (
                    cnt_here == 0
                    and 1 <= cnt_next <= 500_000
                    and tc_next >= 0x00400000
                    and data[pos_now + 12] in (0x00, 0xFF)
                ):
                    reader.seek(pos_now + 4)
                    consecutive_warnings = 0
                    continue

            wire_end = find_next_nonempty_table_header(
                reader._data, reader.tell(), max_search=500_000
            )
            if wire_end > reader.tell() and wire_end < len(data):
                reader.seek(wire_end)
                chunks.append(
                    TableChunk(
                        property_name=meta.get("property", ""),
                        setting_full_name=full,
                        count=-1,
                        element_type_code=0,
                        record_size=0,
                        offset=reader.tell(),
                        size=wire_end - reader.tell(),
                        items=[{"_warning": str(exc), "_next_offset": wire_end}],
                    )
                )
                i += 1
                continue
            else:
                chunks.append(
                    TableChunk(
                        property_name=meta.get("property", ""),
                        setting_full_name=full,
                        count=-1,
                        element_type_code=0,
                        record_size=0,
                        offset=reader.tell(),
                        size=0,
                        items=[{"_error": str(exc)}],
                    )
                )
                break

    assign_property_names(chunks, metas[:limit], typecode_map)
    return chunks



def _fetch(url: str) -> bytes:
    req = Request(
        url,
        headers={
            "User-Agent": "Mozilla/5.0 (Linux; x86_64) AppleWebKit/537.36 "
            "(KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36",
            "Accept": "*/*",
            "Accept-Language": "en-US,en;q=0.9",
        },
    )
    with urlopen(req, timeout=30) as resp:
        return resp.read()




# --- settings schema extraction ---

CLASS_START = re.compile(
    r"^\s*(?:public|internal)\s+(?:sealed\s+|abstract\s+)?class\s+(\w+)\s*(?::\s*([^/{]+?))?\s*(?://|$)"
)
FIELD_LINE = re.compile(
    r"^\s*public\s+(?!static)((?:readonly\s+)?)([\w<>\?\,\.\[\]]+)\s+(\w+)\s*;\s*//"
)
NAMESPACE = re.compile(r"^namespace\s+([\w\.]+)")
SETTING_DICT_PROP = re.compile(
    r"^\s*public\s+SettingDictionary<[^,]+,\s*(\w+)>\s+(\w+)\s*\{"
)
SETTING_GROUP_PROP = re.compile(
    r"^\s*public\s+SettingGroup<[^,]+,\s*(\w+)>\s+(\w+)\s*\{"
)
ENUM_LINE = re.compile(r"^\s*public enum (\w+)")


def resolve_type_name(
    type_name: str,
    namespace: str,
    classes: Dict[str, dict],
    short_to_full: Dict[str, List[str]],
) -> str:
    name = type_name.strip()
    if not name:
        return name
    if "." in name or "<" in name:
        return normalize_type_name(name)
    qualified = f"{namespace}.{name}" if namespace else name
    if qualified in classes:
        return qualified
    if name in short_to_full:
        same_ns = [
            full for full in short_to_full[name] if full.startswith(f"{namespace}.")
        ]
        if len(same_ns) == 1:
            return same_ns[0]
        if len(short_to_full[name]) == 1:
            return short_to_full[name][0]
    return normalize_type_name(name)


def get_serializable_fields_with_bases(
    cls: dict, classes: Dict[str, dict], visited: Optional[set[str]] = None
) -> List[dict]:
    visited = visited or set()
    full_name = cls.get("full_name")
    if not full_name or full_name in visited:
        return []
    visited.add(full_name)

    fields: List[dict] = []
    for base_full in cls.get("base_full_names", []):
        if base_full in classes:
            fields.extend(
                get_serializable_fields_with_bases(classes[base_full], classes, visited)
            )

    own_fields = [f for f in get_serializable_fields(cls)]
    combined = fields + own_fields

    seen: set[str] = set()
    unique: List[dict] = []
    for field in reversed(combined):
        if field["name"] in seen:
            continue
        seen.add(field["name"])
        unique.append(field)
    return list(reversed(unique))


def serializable_field_tuples_with_bases(
    cls: dict, classes: Dict[str, dict]
) -> List[Tuple[str, str]]:
    return [
        (f["name"], f["type"]) for f in get_serializable_fields_with_bases(cls, classes)
    ]


def parse_il2cpp(path: Path) -> Tuple[Dict[str, dict], List[dict], Dict[str, int]]:
    text = path.read_text(encoding="utf-8", errors="replace").splitlines()

    namespace = ""
    enums: set[str] = set()
    classes: Dict[str, dict] = {}
    tables: List[dict] = []

    current_class: Optional[str] = None
    current_full: Optional[str] = None
    current_fields: List[Tuple[str, str, bool]] = []
    current_base_types: List[str] = []
    current_brace_depth = 0
    in_game_context = False

    for line in text:
        ns_m = NAMESPACE.match(line)
        if ns_m:
            namespace = ns_m.group(1)
            continue

        if ENUM_LINE.match(line):
            em = ENUM_LINE.match(line)
            if em and namespace:
                enums.add(f"{namespace}.{em.group(1)}")

        if "public sealed class GameSettingContext" in line:
            in_game_context = True
        elif in_game_context and line.startswith("}") and not line.startswith("\t"):
            in_game_context = False

        if in_game_context:
            dm = SETTING_DICT_PROP.match(line)
            if dm:
                tables.append(
                    {
                        "property": dm.group(2),
                        "setting_type": dm.group(1),
                        "container": "SettingDictionary",
                    }
                )
                continue
            gm = SETTING_GROUP_PROP.match(line)
            if gm:
                tables.append(
                    {
                        "property": gm.group(2),
                        "setting_type": gm.group(1),
                        "container": "SettingGroup",
                    }
                )

        cm = CLASS_START.match(line)
        if cm:
            if current_class is not None:
                classes[current_full] = {
                    "name": current_class,
                    "namespace": namespace,
                    "full_name": current_full,
                    "fields": [
                        {
                            "name": n,
                            "type": normalize_type_name(t),
                            "is_public": True,
                            "is_static": False,
                            "is_initonly": initonly,
                        }
                        for n, t, initonly in current_fields
                    ],
                    "base_types": current_base_types,
                }
            current_class = cm.group(1)
            current_full = (
                f"{namespace}.{current_class}" if namespace else current_class
            )
            base_part = cm.group(2) or ""
            current_base_types = [
                b.strip() for b in re.split(r"\s*,\s*", base_part) if b.strip()
            ]
            current_fields = []
            current_brace_depth = 0
            continue

        if current_class:
            current_brace_depth += line.count("{") - line.count("}")
            if current_brace_depth <= 0 and line.strip() == "}":
                classes[current_full] = {
                    "name": current_class,
                    "namespace": namespace,
                    "full_name": current_full,
                    "fields": [
                        {
                            "name": n,
                            "type": normalize_type_name(t),
                            "is_public": True,
                            "is_static": False,
                            "is_initonly": initonly,
                        }
                        for n, t, initonly in current_fields
                    ],
                    "base_types": current_base_types,
                }
                current_class = None
                current_full = None
                current_fields = []
                current_base_types = []
                current_brace_depth = 0
                continue

            fm = FIELD_LINE.match(line)
            if fm:
                initonly = bool(fm.group(1).strip())
                raw_type, fname = fm.group(2), fm.group(3)
                if "<" in fname:
                    continue
                current_fields.append((fname, raw_type, initonly))

    if current_class is not None:
        classes[current_full] = {
            "name": current_class,
            "namespace": namespace,
            "full_name": current_full,
            "fields": [
                {
                    "name": n,
                    "type": normalize_type_name(t),
                    "is_public": True,
                    "is_static": False,
                    "is_initonly": initonly,
                }
                for n, t, initonly in current_fields
            ],
            "base_types": current_base_types,
        }

    enum_short = {e.split(".")[-1]: e for e in enums}
    short_to_full: Dict[str, List[str]] = {}
    for full in classes:
        short_name = full.split(".")[-1]
        short_to_full.setdefault(short_name, []).append(full)

    for cls in classes.values():
        cls["base_full_names"] = [
            resolve_type_name(base, cls.get("namespace", ""), classes, short_to_full)
            for base in cls.get("base_types", [])
        ]

    for cls in classes.values():
        for f in cls["fields"]:
            t = f["type"]
            if t in enums:
                f["type"] = t
                f["is_enum"] = True
            elif t in enum_short:
                f["type"] = enum_short[t]
                f["is_enum"] = True
            elif "." in t:
                f["is_enum"] = t in enums
            else:
                f["is_enum"] = t in enum_short
                if f["is_enum"]:
                    f["type"] = enum_short[t]
            if "is_enum" not in f:
                f["is_enum"] = False
            f["is_class"] = (
                f["type"] not in PRIMITIVE_MAP
                and f["type"] not in PRIMITIVE_MAP.values()
                and not f["type"].endswith("[]")
                and not f["is_enum"]
                and not f["type"].endswith("?")
            )
            f["is_nullable"] = t.endswith("?")
            if f["is_nullable"]:
                f["type"] = t[:-1]
            f["is_value_type"] = (
                not f["is_class"]
                and not f["is_enum"]
                and f["type"] not in PRIMITIVE_MAP.values()
                and not f["type"].endswith("[]")
            )
            f["is_serializable_type"] = is_serializable_type(
                f["type"],
                is_enum=f.get("is_enum", False),
                is_value_type=f.get("is_value_type", False),
            )

        serializable = get_serializable_fields_with_bases(cls, classes)
        cls["serializable_fields"] = [
            {"name": f["name"], "type": f["type"]} for f in serializable
        ]

    type_codes: Dict[str, int] = {}
    for full, cls in classes.items():
        flds = serializable_field_tuples_with_bases(cls, classes)
        if not flds:
            continue
        cls["type_code"] = hash_type_code_without_array(full, flds)
        cls["array_type_code"] = hash_type_code(full, flds, array_rank=1)
        type_codes[f"{full}[]"] = cls["array_type_code"]

    for t in tables:
        st = t["setting_type"]
        matches = [k for k in classes if k.endswith("." + st) or k == st]
        if len(matches) == 1:
            t["setting_full_name"] = matches[0]
            t["array_type_code"] = classes[matches[0]].get("array_type_code")
            t["type_code"] = classes[matches[0]].get("type_code")
        elif matches:
            pref = [m for m in matches if m.startswith("GameCore.")]
            t["setting_full_name"] = pref[0] if pref else matches[0]
            t["array_type_code"] = classes[t["setting_full_name"]].get(
                "array_type_code"
            )
            t["type_code"] = classes[t["setting_full_name"]].get("type_code")
        else:
            t["setting_full_name"] = None

    setting_classes = {
        k: v
        for k, v in classes.items()
        if k.endswith("Setting") or "Setting" in k.split(".")[-1]
    }

    return setting_classes, tables, type_codes


def ensure_settings_schema(force: bool = False) -> dict:
    if SCHEMA_JSON.exists() and not force:
        return json.loads(SCHEMA_JSON.read_text(encoding="utf-8"))

    if not IL2CPP_CS.exists():
        raise FileNotFoundError(f"缺少 il2cpp 源码: {IL2CPP_CS}")

    print("生成 settings_schema.json …")
    classes, tables, type_codes = parse_il2cpp(IL2CPP_CS)
    out = {
        "classes": classes,
        "tables": tables,
        "type_codes": {
            k: f"0x{v:08x}" for k, v in sorted(type_codes.items(), key=lambda x: x[1])
        },
    }
    SCHEMA_JSON.write_text(
        json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print(
        f"已提取 {len(classes)} 个 Setting 类, {len(tables)} 张表 -> {SCHEMA_JSON}"
    )
    return out


def load_manifest(source: Union[Path, bytes, str]) -> Dict[str, Any]:
    if isinstance(source, bytes):
        env = UnityPy.load(BytesIO(source))
    else:
        env = UnityPy.load(str(source))
    for obj in env.objects:
        if obj.type.name == "AssetBundleManifest":
            return obj.read_typetree()
    return {}


def parse_manifest(tree: Dict[str, Any]) -> List[Dict[str, Any]]:
    index_to_name = {int(idx): name for idx, name in tree.get("AssetBundleNames", [])}

    results: List[Dict[str, Any]] = []
    for entry in tree.get("AssetBundleInfos", []):
        idx: int = int(entry[0])
        raw_info: Dict[str, Any] = entry[1]
        name = index_to_name.get(idx)

        h_bytes = raw_info["AssetBundleHash"]
        hash_hex = "".join(f"{h_bytes[f'bytes[{i}]']:02x}" for i in range(16))

        deps_idx = raw_info.get("AssetBundleDependencies", [])
        deps_names = [index_to_name.get(d) for d in deps_idx]

        results.append(
            {
                "Index": idx,
                "AssetBundleName": name,
                "AssetBundleHash": hash_hex,
                "DepsIndex": deps_idx,
                "AssetBundleDependencies": deps_names,
            }
        )
    return results


def normalize_bundle_name(name: str) -> str:
    return name.replace(" ", "-")


def bundle_name_to_asset_path(name: str) -> str:
    n = normalize_bundle_name(name)
    for prefix, parts in AB_PATH_PREFIXES:
        if n.startswith(prefix):
            rest = n[len(prefix) :]
            head = "/".join(p.capitalize() if p != "assets" else "Assets" for p in parts)
            return f"{head}/{rest.replace('-', '/')}"
    return n.replace("-", "/")


def bundle_name_to_rel_path(name: str) -> Path:
    n = normalize_bundle_name(name)
    for prefix, parts in AB_PATH_PREFIXES:
        if n.startswith(prefix):
            rest = n[len(prefix) :]
            return Path(*parts) / f"{rest}.bin"
    return Path(f"{n}.bin")


def build_asset_catalog(parsed: List[Dict[str, Any]], base_url: str) -> Dict[str, Any]:
    bundles: List[Dict[str, Any]] = []
    for item in parsed:
        name = item.get("AssetBundleName")
        if not name:
            continue
        rel = bundle_name_to_rel_path(name)
        bundles.append(
            {
                "name": name,
                "hash": item.get("AssetBundleHash"),
                "dependencies": item.get("AssetBundleDependencies") or [],
                "asset_path": bundle_name_to_asset_path(name),
                "local_path": str(rel),
                "url": f"{base_url.rstrip('/')}/{quote(name)}.bin",
            }
        )
    return {
        "manifest_url": AB_MANIFEST_URL,
        "base_url": base_url,
        "count": len(bundles),
        "bundles": bundles,
    }


def fetch_ab_manifest(url: str, timeout: int = 60) -> bytes:
    resp = requests.get(url, timeout=timeout)
    resp.raise_for_status()
    return resp.content


def parse_manifest_stream(data: bytes) -> Tuple[List[Dict[str, Any]], Dict[str, Any]]:
    tree = load_manifest(data)
    if not tree:
        raise ValueError("manifest 字节流中未找到 AssetBundleManifest")
    parsed = parse_manifest(tree)
    catalog = build_asset_catalog(parsed, AB_BASE_URL)
    return parsed, catalog


def write_asset_catalog(catalog: Dict[str, Any]) -> None:
    AB_CATALOG_JSON.write_text(
        json.dumps(catalog, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    console.print(f"[green]Asset catalog[/green] -> {AB_CATALOG_JSON} ({catalog['count']} bundles)")


def bundle_url(base: str, name: str) -> str:
    return f"{base.rstrip('/')}/{quote(name)}.bin"


def local_ab_path(out_dir: Path, name: str) -> Path:
    return out_dir / bundle_name_to_rel_path(name)


def collect_ab_entries() -> List[Tuple[str, Path]]:
    console.print(f"[cyan]Fetching manifest[/cyan] {AB_MANIFEST_URL}")
    manifest_bytes = fetch_ab_manifest(AB_MANIFEST_URL, timeout=AB_TIMEOUT)
    parsed, catalog = parse_manifest_stream(manifest_bytes)
    console.print(f"[green]Parsed {len(parsed)} bundles from manifest stream[/green]")

    entries: List[Tuple[str, Path]] = []
    for item in parsed:
        name = item.get("AssetBundleName")
        if not name:
            continue
        entries.append((bundle_url(AB_BASE_URL, name), local_ab_path(AB_OUTPUT_DIR, name)))

    return entries


def download_one_ab(
    url: str,
    dest: Path,
    progress: Progress,
    task_id: int,
    lock: Lock,
    retries: int,
    timeout: int,
) -> Tuple[str, bool, str]:
    dest.parent.mkdir(parents=True, exist_ok=True)
    name = dest.name

    for attempt in range(1, retries + 1):
        session = requests.Session()
        session.headers.update({"User-Agent": "AssetBundleDownloader/1.0"})
        try:
            existing = dest.stat().st_size if dest.exists() else 0
            headers: Dict[str, str] = {}
            if existing:
                headers["Range"] = f"bytes={existing}-"

            with session.get(url, headers=headers, stream=True, timeout=timeout) as resp:
                if resp.status_code == 416:
                    return name, True, "already complete"
                if resp.status_code == 200:
                    existing = 0
                    mode = "wb"
                elif resp.status_code == 206:
                    mode = "ab"
                else:
                    resp.raise_for_status()
                    mode = "wb"

                with open(dest, mode) as f:
                    for chunk in resp.iter_content(chunk_size=256 * 1024):
                        if not chunk:
                            continue
                        f.write(chunk)
                        with lock:
                            progress.update(task_id, advance=len(chunk))

            return name, True, "ok"
        except requests.RequestException as exc:
            if attempt >= retries:
                return name, False, str(exc)
            time.sleep(min(2**attempt, 10))
        finally:
            session.close()

    return name, False, "unknown error"


def run_ab_downloads(entries: List[Tuple[str, Path]]) -> Tuple[int, int]:
    lock = Lock()
    ok_count = 0
    fail_count = 0
    done_count = 0
    total = len(entries)

    progress_columns = [
        TextColumn("[bold blue]{task.description}"),
        BarColumn(bar_width=40),
        DownloadColumn(),
        TransferSpeedColumn(),
    ]

    with Progress(*progress_columns, console=console) as progress:
        task_id = progress.add_task(f"0/{total}", total=None)

        with ThreadPoolExecutor(max_workers=AB_WORKERS) as pool:
            futures = {
                pool.submit(
                    download_one_ab,
                    url,
                    dest,
                    progress,
                    task_id,
                    lock,
                    AB_RETRIES,
                    AB_TIMEOUT,
                ): (url, dest)
                for url, dest in entries
            }

            for future in as_completed(futures):
                name, ok, msg = future.result()
                done_count += 1
                progress.update(task_id, description=f"{done_count}/{total}")
                if ok:
                    ok_count += 1
                else:
                    fail_count += 1
                    console.print(f"[red]Failed[/red] {name}: {msg}")

    return ok_count, fail_count


def download_asset_bundles() -> None:
    AB_OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    entries = collect_ab_entries()
    console.print(f"[cyan]Downloading[/cyan] -> {AB_OUTPUT_DIR.resolve()}")
    ok, failed = run_ab_downloads(entries)
    console.print(f"AssetBundle: [green]{ok} ok[/green], [red]{failed} failed[/red]")


def _read_varint(stream: io.BytesIO) -> int | None:
    result = 0
    shift = 0
    while True:
        b = stream.read(1)
        if not b:
            return (
                None
                if shift == 0
                else (_ for _ in ()).throw(EOFError("truncated varint"))
            )
        byte = b[0]
        result += (byte & 0x7F) << shift
        shift += 7
        if (byte & 0x80) == 0 or shift >= 64:
            break
    return result


def decompress_lz4net_stream(data: bytes) -> bytes:
    

    stream = io.BytesIO(data)
    out = bytearray()
    while True:
        flags = _read_varint(stream)
        if flags is None:
            break
        original_length = _read_varint(stream)
        if original_length is None:
            raise EOFError("unexpected EOF reading original length")
        is_compressed = flags & CHUNK_COMPRESSED
        compressed_length = _read_varint(stream) if is_compressed else original_length
        if compressed_length is None:
            raise EOFError("unexpected EOF reading compressed length")
        if compressed_length > original_length:
            raise ValueError(
                f"corrupt chunk: clen={compressed_length} > olen={original_length}"
            )
        chunk = stream.read(compressed_length)
        if len(chunk) != compressed_length:
            raise EOFError(
                f"truncated chunk: wanted {compressed_length}, got {len(chunk)}"
            )
        if original_length == 0:
            continue
        if is_compressed:
            out.extend(lz4.block.decompress(chunk, uncompressed_size=original_length))
        else:
            out.extend(chunk)
    return bytes(out)



def download_master_data(force: bool = False) -> None:
    remote_hash = _fetch(HASH_URL).decode("ascii").strip().lower()
    cached_hash = HASH_FILE.read_text().strip().lower() if HASH_FILE.exists() else ""
    if cached_hash == remote_hash and not force:
        print("MasterData 不需要重新下载")
    else:
        print(f"下载 {BYTES_URL} …")
        compressed = _fetch(BYTES_URL)
        BYTES_FILE.write_bytes(compressed)
        HASH_FILE.write_text(remote_hash)

        decompressed = decompress_lz4net_stream(compressed)
        (PROJECT / "game-settings.decompressed.bin").write_bytes(decompressed)

    print("反序列化 MasterData …")
    decomp_bin = PROJECT / "game-settings.decompressed.bin"
    if decomp_bin.exists():
        decompressed = decomp_bin.read_bytes()
    else:
        compressed = BYTES_FILE.read_bytes()
        decompressed = decompress_lz4net_stream(compressed)
        decomp_bin.write_bytes(decompressed)

    schema_data = ensure_settings_schema(force=force)
    classes = schema_data["classes"]
    tables = schema_data["tables"]

    chunks = parse_all_tables(
        decompressed,
        tables,
        classes,
        max_tables=None,
        mode="sequential",
        on_load_finished=True,
    )

    export: dict = {"file_size": len(decompressed), "tables": []}
    for c in chunks:
        items = c.items
        has_err = items and "_error" in items[0]
        has_warn = items and "_warning" in items[0]
        if has_err or has_warn:
            continue
        export["tables"].append(
            {
                "property": c.property_name,
                "type": c.setting_full_name,
                "count": c.count,
                "offset": c.offset,
                "size": c.size,
                "items": items,
            }
        )

    OUTPUT_JSON.write_text(
        json.dumps(export, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    ok = sum(1 for t in export["tables"] if t["count"] > 0 and not t.get("error"))
    print(f"{OUTPUT_JSON}  ({len(export['tables'])} tables, {ok} with data)")


def main() -> None:
    force = "--force" in sys.argv
    skip_ab = "--skip-ab" in sys.argv

    print("下载并转换 MasterData")
    download_master_data(force=force)

    if skip_ab:
        print("跳过 AssetBundle 下载 (--skip-ab)")
    else:
        print("\n下载 AssetBundle")
        download_asset_bundles()

    print("\n全部完成")


if __name__ == "__main__":
    main()
