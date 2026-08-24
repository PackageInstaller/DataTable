from __future__ import annotations

import argparse
import json
import re
import struct
import sys
import traceback
import warnings
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from threading import Lock
from typing import Any

import requests
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from rich.console import Console
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
)
from rich.table import Table

# ---------------------------------------------------------------------------
# 客户端常量
# ---------------------------------------------------------------------------
# GDefine.cctor → CDN_FALLBACK_URL
CDN = "https://assets.orisries.playhorny.com"
# ProtocolConst.HEADER_CDN_AUTH / HEADER_CDN_VALUE
HTTP_HEADERS = {
    "horny-truedau": "ZFF3NHc5V2dYY1E=",
    "User-Agent": "UnityPlayer/2021.3.33f1 (UnityWebRequest/1.0, libcurl/8.5.0-DEV)",
    "Accept": "*/*",
}

# GDefine: PROJECT_NAME / BUILD_NUMBER / VERSION
# eRegion.android = 1, eChannel.cela = 1 → String.Format 用枚举名
PROJECT = "Orisries"
REGION = "android"
CHANNEL = "cela"
CLIENT_BUILD = "30002"

# DecryptionUtil.DecryptAES: RuntimeHelpers.InitializeArray(
#   FC3F14D0… Field, base64 d2lraSBpcyB0cmFuc2Zlcg==)
AES_KEY = b"wiki is transfer"

# DecryptionUtil.ShouldEncrypt == false（明文下发）
PLAINTEXT_MARKERS = (
    "defaultlocalgroup_assets_all",
    "unitybuiltinshaders",
    "localbundle",
)

# DecryptionUtil.IsRuntimeDecryptiion: 客户端磁盘保持密文、加载时再解。脚本一律解开。
RUNTIME_DECRYPT_MARKERS = (
    "spinechar_",
    "avgcg_",
    "avgfg_",
    "stpics_",
    "avgbg",
    "charpics",
    "avgsp",
)

console = Console()
SESSION = requests.Session()
SESSION.headers.update(HTTP_HEADERS)
EXTRACT_LOCK = Lock()
warnings.filterwarnings("ignore", message="No valid Unity version found")

ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
STATE_PATH = ROOT / "version.json"


def format_size(n: int) -> str:
    size = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{n} B"


def http_get(url: str, timeout: int = 60) -> requests.Response:
    resp = SESSION.get(url, timeout=timeout)
    resp.raise_for_status()
    return resp


def config_url(build: str) -> str:
    # GDefine.ConfigDomain: "{0}/{1}/{2}-{3}-{4}-{5}-{6}{7}.json"
    return f"{CDN}/config/{PROJECT}-config-{REGION}-{CHANNEL}-{build}.json"


def version_url() -> str:
    # GDefine.VersionDomain: "{0}/{1}/{2}-{3}-{4}-{5}{6}.json"
    return f"{CDN}/version/{PROJECT}-version-{REGION}-{CHANNEL}.json"


def art_catalog_stem(catalog_url: str, art_version: str, art_catalog: str) -> str:
    # GDefine.AssetCatalogRemotePath 去掉 ".json"
    # CDN + "/" + catalog_url + "/" + art_version + "/" + art_catalog
    return f"{CDN}/{catalog_url.strip('/')}/{art_version}/{art_catalog}"


def versioned_catalog_stem(catalog_url: str, ver_id: str) -> str:
    # GDefine.GetCommonCatalogRemotePath / GetSeasonCatalogRemotePath 去掉 ".json"
    # CDN + "/" + catalog_url + "/" + verId + "/" + verId
    return f"{CDN}/{catalog_url.strip('/')}/{ver_id}/{ver_id}"


def art_asset_dir(asset_url: str) -> str:
    # GDefine.GetArtAssetRemoteDirectory + String.Format("{0}/")
    # CDN + "/" + asset_url + "/art/"
    return f"{CDN}/{asset_url.strip('/')}/art/"


def versioned_asset_dir(asset_url: str, ver_id: str) -> str:
    # GDefine.GetCommonAssetRemoteDirectory / GetSeasonAssetRemoteDirectory + "{0}/"
    return f"{CDN}/{asset_url.strip('/')}/{ver_id}/"


def version_table_url(kind: str, version_id: str) -> str:
    # CommonCatalogVersionTablePath / SeasonCatalogVersionTablePath
    return f"{CDN}/config/version_table/{kind}_{version_id}.txt"


def resolve_catalog_id(kind: str, version_id: str) -> str:
    """GetFileNameFromVersion: GET version_table txt，正文即 catalog 目录名。"""
    vid = version_id.strip()
    if kind == "season" and vid.upper().startswith("S"):
        vid = vid.split("_", 1)[0]
    url = version_table_url(kind, vid)
    try:
        body = http_get(url).text.strip()
        if body:
            resolved = body.splitlines()[0].strip()
            console.print(f"[cyan]{kind} version_table[/] {vid} → {resolved}")
            return resolved
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]version_table 拉取失败，使用原值 {vid}:[/] {exc}")
    return vid


def is_encrypted_name(name: str) -> bool:
    lower = name.lower()
    return not any(m in lower for m in PLAINTEXT_MARKERS)


def is_data_bundle(name: str) -> bool:
    return "data_assets" in name.lower()


def looks_like_unityfs(data: bytes) -> bool:
    return data[:7] == b"UnityFS"


def looks_like_unityfs_file(path: Path) -> bool:
    with path.open("rb") as fh:
        return fh.read(7) == b"UnityFS"


def decrypt_aes_bundle(data: bytes) -> bytes:
    """AssetBundleResource._LoadBundle: [ciphertext][IV][IV_len int32 LE]，AES-128-CBC + PKCS7。"""
    if len(data) < 8:
        raise ValueError("bundle too small")
    if looks_like_unityfs(data):
        return data
    iv_len = int.from_bytes(data[-4:], "little", signed=True)
    if iv_len <= 0 or iv_len > len(data) - 4:
        raise ValueError(f"invalid IV length: {iv_len}")
    iv_start = len(data) - 4 - iv_len
    iv = data[iv_start : iv_start + iv_len]
    ciphertext = data[:iv_start]
    cipher = AES.new(AES_KEY, AES.MODE_CBC, iv)
    return unpad(cipher.decrypt(ciphertext), AES.block_size)


def parse_catalog_info(text: str) -> list[tuple[str, int]]:
    """UpdateCatalogAndCollectLatestFileList: 每行 fileName|fileSize。"""
    items: list[tuple[str, int]] = []
    for line in text.splitlines():
        line = line.strip()
        if not line or "|" not in line:
            continue
        name, size_s = line.split("|", 1)
        name = name.strip()
        try:
            size = int(size_s.strip())
        except ValueError:
            size = 0
        if name:
            items.append((name, size))
    return items


def load_state() -> dict[str, Any]:
    if STATE_PATH.exists():
        return json.loads(STATE_PATH.read_text(encoding="utf-8"))
    return {}


def save_state(state: dict[str, Any]) -> None:
    STATE_PATH.write_text(json.dumps(state, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def fetch_json(url: str) -> Any:
    return http_get(url).json()


def download_bytes(url: str, retries: int = 3) -> bytes:
    last_err: Exception | None = None
    for attempt in range(1, retries + 1):
        try:
            return http_get(url, timeout=120).content
        except Exception as exc:  # noqa: BLE001
            last_err = exc
            console.print(f"[yellow]重试 {attempt}/{retries}[/] {url}: {exc}")
    assert last_err is not None
    raise last_err


def process_bundle(raw: bytes, filename: str) -> bytes:
    if not is_encrypted_name(filename) or looks_like_unityfs(raw):
        return raw
    return decrypt_aes_bundle(raw)


def textasset_payload(script: object) -> bytes:
    if isinstance(script, (bytes, bytearray, memoryview)):
        return bytes(script)
    if isinstance(script, str):
        # UnityPy 把二进制 TextAsset 解成带 surrogateescape 的 str
        return script.encode("utf-8", "surrogateescape")
    return bytes(script)


# ---------------------------------------------------------------------------
# PacketData 反序列化（libil2cpp PacketData / GData.Load*）
# TextAsset 经 LoadTextAstData → PushBytes 原样进缓冲，不 XOR。
# 整数小端；字符串 ushort 长度，isUTF8=true 时为字节数。
# ---------------------------------------------------------------------------
class PacketError(Exception):
    pass


class PacketReader:
    """对应 PacketData.GetByte/GetUShort/GetInt/GetUTF8String/GetBool。"""

    def __init__(self, data: bytes):
        self.data = data
        self.i = 0

    def __len__(self) -> int:
        return len(self.data)

    @property
    def remaining(self) -> int:
        return len(self.data) - self.i

    @property
    def is_end(self) -> bool:
        return self.i >= len(self.data)

    def _need(self, n: int) -> None:
        if self.i + n > len(self.data):
            raise PacketError(f"需要 {n} 字节，剩余 {self.remaining} @ {self.i}")

    def u8(self) -> int:
        self._need(1)
        v = self.data[self.i]
        self.i += 1
        return v

    def i8(self) -> int:
        v = self.u8()
        return v - 256 if v >= 128 else v

    def get_bool(self) -> bool:
        return self.u8() == 1

    def u16(self) -> int:
        self._need(2)
        v = struct.unpack_from("<H", self.data, self.i)[0]
        self.i += 2
        return v

    def i16(self) -> int:
        self._need(2)
        v = struct.unpack_from("<h", self.data, self.i)[0]
        self.i += 2
        return v

    def u32(self) -> int:
        self._need(4)
        v = struct.unpack_from("<I", self.data, self.i)[0]
        self.i += 4
        return v

    def i32(self) -> int:
        self._need(4)
        v = struct.unpack_from("<i", self.data, self.i)[0]
        self.i += 4
        return v

    def i64(self) -> int:
        self._need(8)
        v = struct.unpack_from("<q", self.data, self.i)[0]
        self.i += 8
        return v

    def utf8(self) -> str:
        # PacketData.GetUTF8String：ushort 字节数；0 或越界返回 ""
        n = self.u16()
        if n == 0 or self.i + n > len(self.data):
            return ""
        s = self.data[self.i : self.i + n].decode("utf-8", "replace")
        self.i += n
        return s

    def utf16(self) -> str:
        n = self.u16()
        nbytes = n * 2
        if n == 0 or self.i + nbytes > len(self.data):
            return ""
        s = self.data[self.i : self.i + nbytes].decode("utf-16-le", "replace")
        self.i += nbytes
        return s


def _read_count_tables(r: PacketReader, read_row) -> list[Any]:
    """LoadStructData：可连续多段 int count + N 条记录。多数文件只有一段。"""
    tables: list[list[Any]] = []
    while r.remaining >= 4:
        n = r.i32()
        if n < 0:
            raise PacketError(f"非法 count={n}")
        tables.append([read_row(r) for _ in range(n)])
    if len(tables) == 1:
        return tables[0]
    return tables


def parse_int_text(r: PacketReader) -> Any:
    return _read_count_tables(r, lambda p: {"textID": p.i32(), "textStr": p.utf8()})


def parse_uint_text(r: PacketReader) -> Any:
    return _read_count_tables(r, lambda p: {"textID": p.u32(), "textStr": p.utf8()})


def parse_name_list_str(r: PacketReader) -> Any:
    def row(p: PacketReader) -> dict[str, Any]:
        return {
            "PlatformMark": p.u8(),
            "Season": p.u8(),
            "Serial": p.u32(),
            "Name": p.utf8(),
        }

    return _read_count_tables(r, row)


def parse_transitions_cg(r: PacketReader) -> Any:
    # LoadTransitionsCgData：struct 里 is_r18 是 uint，loader 读 ushort
    def row(p: PacketReader) -> dict[str, Any]:
        return {"cg_id": p.u32(), "str_id": p.u32(), "is_r18": p.u16()}

    return _read_count_tables(r, row)


def parse_title_voice(r: PacketReader) -> Any:
    return _read_count_tables(r, lambda p: p.i32())


def _parse_avg_body(r: PacketReader, avg_id: int) -> dict[str, Any]:
    # GData.LoadAvgData：无顶层 count。actorNum≤0x14，evtNum≤0x7D0。
    init_bg = r.u16()
    init_bgm = r.u16()
    actor_num = r.u16()
    if actor_num > 0x14:
        raise PacketError(f"actorNum={actor_num} > 0x14")
    actors = [r.u16() for _ in range(actor_num)]
    evt_num = r.u16()
    if evt_num > 0x7D0:
        raise PacketError(f"evtNum={evt_num} > 0x7D0")
    events = []
    for _ in range(evt_num):
        event_id = r.u16()
        eff_id = r.u16()
        pra_num = r.u16()
        pra = [r.i32() for _ in range(pra_num)]
        events.append({"eventID": event_id, "effID": eff_id, "praAy": pra})
    data_ver = 0
    particles: list[int] = []
    actor_cloth: list[int] = []
    actor_name_clr: list[int] = []
    if not r.is_end:
        data_ver = r.i32()
        if data_ver >= 1:
            particle_num = r.u16()
            if particle_num > 0x64:
                raise PacketError(f"particleNum={particle_num} > 0x64")
            particles = [r.i32() for _ in range(particle_num)]
            actor_cloth = [r.u8() for _ in range(actor_num)]
        if data_ver > 1:
            actor_name_clr = [r.i32() for _ in range(actor_num)]
    return {
        "dataVer": data_ver,
        "avgID": avg_id,
        "initBgPicID": init_bg,
        "initBgmID": init_bgm,
        "actorAy": actors,
        "actorClothAy": actor_cloth,
        "actorNameClrAy": actor_name_clr,
        "particleAy": particles,
        "avgEventAy": events,
    }


def parse_avg(r: PacketReader) -> dict[str, Any]:
    # 现行 LoadAvgData 用 int avgID；savg11001 等旧文件是 ushort。
    start = r.i
    try:
        return _parse_avg_body(r, r.i32())
    except PacketError:
        r.i = start
        return _parse_avg_body(r, r.u16())


def _femdom_sub(r: PacketReader) -> dict[str, Any]:
    # LoadFemdomActGrpSubData：talkAry 构造长度 3
    return {
        "isLoop": r.get_bool(),
        "seID1": r.u16(),
        "seID2": r.u16(),
        "talkAry": [r.u16() for _ in range(3)],
    }


def _femdom_talk(r: PacketReader) -> dict[str, Any]:
    # LoadFemdomActGrpTalkData：talkAry[3]，再 int n 个 ushort[3]
    val = r.u16()
    talk_ary = [r.u16() for _ in range(3)]
    n = r.i32()
    act_talks = [[r.u16() for _ in range(3)] for _ in range(n)]
    return {"val": val, "talkAry": talk_ary, "actTalks": act_talks}


def _femdom_act_grp(r: PacketReader, pack_ver: int) -> dict[str, Any]:
    grp: dict[str, Any] = {"grpID": r.u16()}
    if pack_ver >= 3:
        grp["notCutTalk"] = r.get_bool()
    grp["touch"] = r.u8()
    grp["clothToy"] = r.u8()
    grp["idle"] = _femdom_sub(r)
    n_acts = r.i32()
    grp["acts"] = [_femdom_sub(r) for _ in range(n_acts)]
    grp["finish"] = [_femdom_sub(r) for _ in range(2)]
    grp["finEffect"] = [_femdom_sub(r) for _ in range(2)]
    grp["diff"] = r.u8()
    grp["triggerSound"] = r.i32()
    grp["effectId"] = r.i32()
    grp["effectTriggerKind"] = r.u8()
    grp["effectPosKind"] = r.u8()
    grp["effectPosSetting"] = r.u8()
    n_talks = r.i32()
    grp["actTalks"] = [_femdom_talk(r) for _ in range(n_talks)]
    return grp


def parse_femdom_char(r: PacketReader) -> dict[str, Any]:
    # LoadFemdomCharData：首字节是格式版本，不进 TFemdomData。
    # actGrp[4]、grpCnt[3]、cloths[3]、toys[2] 来自 TFemdomData 构造函数。
    pack_ver = r.u8()
    out: dict[str, Any] = {
        "packVer": pack_ver,
        "charID": r.u16(),
        "bgmID": r.u16(),
    }
    if pack_ver >= 2:
        out["grpCnt"] = [r.u8() for _ in range(3)]
    else:
        out["grpCnt"] = []
    out["actGrp"] = [_femdom_act_grp(r, pack_ver) for _ in range(4)]
    if pack_ver >= 3:
        out["cloths"] = [r.u8() for _ in range(3)]
    else:
        out["cloths"] = []
    out["toys"] = []
    for _ in range(2):
        n = r.i32()
        out["toys"].append([_femdom_sub(r) for _ in range(n)])
    n_events = r.i32()
    events = []
    for _ in range(n_events):
        ev = {
            "minVal": r.u16(),
            "maxVal": r.u16(),
            "kind": r.u8(),
            "pra1": r.u16(),
            "pra2": r.u16(),
            "pra3": r.u16(),
            "pra4": r.u16(),
            "pra5": r.i32(),
            "praStr1": r.utf8(),
            "praBool": r.get_bool(),
        }
        n_list = r.i32()
        ev["praList1"] = [r.u16() for _ in range(n_list)]
        events.append(ev)
    out["events"] = events
    n_counts = r.i32()
    counts = []
    for _ in range(n_counts):
        item = {
            "objID": r.u16(),
            "kind": r.u8(),
            "grpID": r.u8(),
            "objKeep": r.get_bool(),
        }
        n_vals = r.i32()
        item["Datas"] = [{"count": r.i32(), "objVal": r.i32()} for _ in range(n_vals)]
        counts.append(item)
    out["counts"] = counts
    drags: list[dict[str, Any]] = []
    if pack_ver >= 3:
        n_drags = r.i32()
        for _ in range(n_drags):
            drags.append(
                {
                    "grpID": r.u16(),
                    "actID": r.i32(),
                    "vector": r.u8(),
                    "length": r.i32(),
                    "objID": r.u16(),
                    "objVal": [r.i32() for _ in range(2)],
                    "objKeep": r.u8(),
                    "objTime": r.i32(),
                    "objAdd": [r.i32() for _ in range(2)],
                    "objReset": [r.i32() for _ in range(2)],
                }
            )
    out["drags"] = drags
    out["otherSettings"] = {
        "actIcon": [r.u16() for _ in range(4)],
        "clothIcon": [r.u16() for _ in range(3)],
        "toyIcon": [r.u16() for _ in range(2)],
        "takeOffIcon": [r.u16() for _ in range(1)],
        "actAddValue": [r.u16() for _ in range(4)],
        "toyAddValue": [r.u16() for _ in range(2)],
    }
    return out


UINT_TEXT_PREFIXES = (
    "TransitionsCgStr",
    "LocalTransitionsCgStr",
    "season_str",
    "tutorial_str",
    "novice_str",
    "equipment_forging_str",
)
INT_TEXT_PREFIXES = (
    "CommonStr",
    "CommonLocalStr",
    "block_info_str",
    "character_str",
    "soldier_str",
    "textdata_str",
    "memories_cha_str",
    "memories_story_str",
    "memories_achieve_avg_str",
    "item_str",
    "item_resource_str",
    "building_str",
    "buildingeffect_str",
    "femdom_str",
    "femdomr15_str",
    "equipment_str",
    "equipment_quality_data_str",
    "skill_str",
    "area_str",
    "interactive_str",
    "avatar_str",
    "patrol_str",
    "mail_str",
    "quest_list_str",
    "lucky_bag_str",
    "paybag_str",
    "step_paybag_str",
    "gacha_str",
    "course_str",
    "event_str",
    "dungeon_level_str",
    "reconstruction_str",
    "achievement_str",
    "DirtyStr",
    "season_report_str",
    "artifact_str",
    "ranking_event_str",
    "skill_guild_str",
    "eventScore_str",
    "wheel_probability_str",
    "point_event_help_str",
)
FEMDOM_CHAR_RE = re.compile(r"^femdom\d{4}$", re.I)
AVG_RE = re.compile(r"^savg", re.I)


def _name_matches(name: str, prefixes: tuple[str, ...]) -> bool:
    return any(name == p or name.startswith(p + "_") or name.startswith(p) for p in prefixes)


def decode_packet(name: str, payload: bytes) -> tuple[Any, int]:
    """按资源名走对应 GData.Load*。返回 (对象, 未读字节数)。"""
    r = PacketReader(payload)
    if AVG_RE.match(name):
        obj = parse_avg(r)
    elif FEMDOM_CHAR_RE.match(name):
        obj = parse_femdom_char(r)
    elif name.startswith("name_list_str"):
        obj = parse_name_list_str(r)
    elif name == "TransitionsCg_C" or name.startswith("TransitionsCg_C"):
        obj = parse_transitions_cg(r)
    elif name == "title_voice_C" or name.startswith("title_voice_C"):
        obj = parse_title_voice(r)
    elif _name_matches(name, UINT_TEXT_PREFIXES):
        obj = parse_uint_text(r)
    elif _name_matches(name, INT_TEXT_PREFIXES) or name.endswith("_str") or "_str_" in name:
        obj = parse_int_text(r)
    else:
        raise PacketError(f"未知表类型: {name}")
    return obj, r.remaining


def unique_json_stem(name: str, container: str, used: set[str]) -> str:
    if name not in used:
        used.add(name)
        return name
    parent = Path(container).parent.name if container else "dup"
    cand = f"{name}__{parent}"
    n = 2
    while cand in used:
        cand = f"{name}__{parent}_{n}"
        n += 1
    used.add(cand)
    return cand


def write_master_json(stem: str, obj: Any) -> None:
    path = MASTER_DIR / f"{stem}.json"
    path.write_text(
        json.dumps(obj, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def extract_master_data(bundle_path: Path, used_stems: set[str] | None = None) -> int:
    """从 data bundle 抽出 TextAsset，按 PacketData 反序列化为 indent=2 JSON。"""
    try:
        import UnityPy
    except ImportError:
        console.print("[yellow]未安装 UnityPy，跳过数据表提取。pip install UnityPy[/]")
        return 0

    used = used_stems if used_stems is not None else set()
    with EXTRACT_LOCK:
        UnityPy.config.FALLBACK_UNITY_VERSION = "2021.3.33f1"
        env = UnityPy.load(str(bundle_path))
        written = 0
        MASTER_DIR.mkdir(parents=True, exist_ok=True)
        for obj in env.objects:
            if getattr(obj.type, "name", None) != "TextAsset":
                continue
            data = obj.read()
            name = getattr(data, "m_Name", None) or getattr(data, "name", None) or f"unnamed_{obj.path_id}"
            container = getattr(obj, "container", None) or ""
            payload = textasset_payload(data.m_Script)
            stem = unique_json_stem(name, container, used)
            try:
                decoded, unread = decode_packet(name, payload)
                if unread:
                    decoded = {"data": decoded, "_unread": unread}
                write_master_json(stem, decoded)
            except Exception as exc:  # noqa: BLE001
                write_master_json(
                    stem,
                    {
                        "_error": str(exc),
                        "_name": name,
                        "_container": container,
                        "_size": len(payload),
                    },
                )
                console.print(f"[yellow]解码失败[/] {stem}: {exc}")
            written += 1
        return written


def download_one(
    filename: str,
    remote_size: int,
    remote_dir: str,
    dest_dir: Path,
    retries: int,
    force: bool,
) -> dict[str, Any]:
    dest = dest_dir / filename
    result: dict[str, Any]

    if dest.exists() and not force and looks_like_unityfs_file(dest):
        result = {"file": filename, "status": "skip", "bytes": dest.stat().st_size}
    else:
        url = f"{remote_dir}{filename}"
        raw = download_bytes(url, retries=retries)
        try:
            data = process_bundle(raw, filename)
        except Exception as exc:  # noqa: BLE001
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_bytes(raw)
            return {
                "file": filename,
                "status": "decrypt_fail",
                "error": str(exc),
                "bytes": len(raw),
                "remote_size": remote_size,
            }
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data)
        result = {
            "file": filename,
            "status": "ok" if looks_like_unityfs(data) else "not_unityfs",
            "bytes": len(data),
            "remote_size": remote_size,
            "encrypted": is_encrypted_name(filename) and not looks_like_unityfs(raw),
        }

    if is_data_bundle(filename) and dest.exists() and looks_like_unityfs_file(dest):
        try:
            result["tables"] = extract_master_data(dest)
        except Exception as exc:  # noqa: BLE001
            result["tables_error"] = str(exc)
    return result


def print_summary(cfg: dict[str, Any], ver: dict[str, Any] | None, items: list[tuple[str, int]]) -> None:
    table = Table(title="Orisries CDN")
    table.add_column("项")
    table.add_column("值")
    table.add_row("CDN", CDN)
    table.add_row("config.latest_build_number", str(cfg.get("latest_build_number")))
    table.add_row("art_version", str(cfg.get("art_version")))
    table.add_row("art_catalog", str(cfg.get("art_catalog")))
    table.add_row("catalog_url", str(cfg.get("catalog_url")))
    table.add_row("asset_url", str(cfg.get("asset_url")))
    if ver:
        table.add_row("version.latest_build_number", str(ver.get("latest_build_number")))
        table.add_row("version.target_build_number", str(ver.get("target_build_number")))
        table.add_row("force_update", str(ver.get("force_update")))
    total = sum(sz for _, sz in items)
    table.add_row("catalog 文件数", str(len(items)))
    table.add_row("远端合计(加密体积)", format_size(total))
    console.print(table)


def save_catalog_meta(version_id: str, stem: str) -> tuple[list[tuple[str, int]], str]:
    info_text = http_get(f"{stem}.info").text
    cat_hash = http_get(f"{stem}.hash").text.strip()
    meta_dir = ASSETS_DIR / "_catalog" / version_id
    meta_dir.mkdir(parents=True, exist_ok=True)
    (meta_dir / f"{version_id}.info").write_text(info_text, encoding="utf-8")
    (meta_dir / f"{version_id}.hash").write_text(cat_hash + "\n", encoding="utf-8")
    try:
        (meta_dir / f"{version_id}.json").write_bytes(http_get(f"{stem}.json").content)
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]catalog.json 下载失败:[/] {exc}")
    return parse_catalog_info(info_text), cat_hash


def cmd_status() -> int:
    state = load_state()
    cfg = fetch_json(config_url(CLIENT_BUILD))
    try:
        ver = fetch_json(version_url())
    except Exception as exc:  # noqa: BLE001
        ver = None
        console.print(f"[yellow]version.json 拉取失败:[/] {exc}")

    art_version = cfg.get("art_version")
    art_catalog = cfg.get("art_catalog") or art_version
    stem = art_catalog_stem(cfg["catalog_url"], art_version, art_catalog)
    info_text = http_get(f"{stem}.info").text
    items = parse_catalog_info(info_text)
    remote_hash = http_get(f"{stem}.hash").text.strip()
    print_summary(cfg, ver, items)

    local_files = [p for p in ASSETS_DIR.rglob("*") if p.is_file()] if ASSETS_DIR.exists() else []
    console.print(f"本地 Assets: {len(local_files)} 个文件")
    console.print(f"本地 catalog.hash: {state.get('catalog_hash', '(无)')}")
    console.print(f"远端 catalog.hash: {remote_hash}")
    console.print(f"art catalog: {stem}.json")
    console.print(f"art assets:  {art_asset_dir(cfg['asset_url'])}")
    if state.get("catalog_hash") == remote_hash:
        console.print("[green]catalog 未变化[/]")
    else:
        console.print("[cyan]catalog 已更新，建议运行同步[/]")
    return 0


def run(
    build: str,
    workers: int,
    retries: int,
    force: bool,
    common: str | None,
    season: str | None,
    extract_only: bool,
    data_only: bool,
    limit: int | None,
) -> int:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    MASTER_DIR.mkdir(parents=True, exist_ok=True)

    if extract_only:
        count = 0
        used_stems: set[str] = set()
        for path in ASSETS_DIR.rglob("*.bundle"):
            if not is_data_bundle(path.name):
                continue
            n = extract_master_data(path, used_stems)
            count += n
            console.print(f"[green]{path.name}[/] → {n} TextAsset")
        console.print(f"共提取 {count} 个 JSON 到 {MASTER_DIR}")
        return 0

    console.print(f"拉取配置 build={build} …")
    cfg = fetch_json(config_url(build))
    try:
        ver = fetch_json(version_url())
    except Exception as exc:  # noqa: BLE001
        ver = None
        console.print(f"[yellow]version.json 拉取失败（可忽略）:[/] {exc}")

    # jobs: (label, remote_dir, items, catalog_hash, version_id)
    jobs: list[tuple[str, str, list[tuple[str, int]], str, str]] = []

    def add_art() -> None:
        art_version = cfg.get("art_version")
        art_catalog = cfg.get("art_catalog") or art_version
        if not art_version or not art_catalog:
            raise RuntimeError("配置里没有 art_version / art_catalog")
        stem = art_catalog_stem(cfg["catalog_url"], art_version, art_catalog)
        remote_dir = art_asset_dir(cfg["asset_url"])
        console.print(f"[cyan]art[/] catalog {stem}.json")
        items, cat_hash = save_catalog_meta(art_version, stem)
        jobs.append(("art", remote_dir, items, cat_hash, art_version))

    def add_versioned(label: str, version_id: str) -> None:
        resolved = resolve_catalog_id(label, version_id)
        stem = versioned_catalog_stem(cfg["catalog_url"], resolved)
        remote_dir = versioned_asset_dir(cfg["asset_url"], resolved)
        console.print(f"[cyan]{label}[/] catalog {stem}.json")
        items, cat_hash = save_catalog_meta(resolved, stem)
        jobs.append((label, remote_dir, items, cat_hash, resolved))

    add_art()
    if common:
        add_versioned("common", common)
    if season:
        add_versioned("season", season)

    print_summary(cfg, ver, jobs[0][2])
    for label, remote_dir, items, cat_hash, ver_id in jobs:
        console.print(f"  {label} ({ver_id}): {len(items)} files, hash={cat_hash}")
        console.print(f"    → {remote_dir}")

    state = load_state()
    art_hash = jobs[0][3]
    if state.get("catalog_hash") == art_hash and not force and not common and not season:
        console.print("[green]art catalog.hash 未变化。[/] 仍会补下缺失文件；已有 UnityFS 跳过。")

    work: list[tuple[str, int, str, Path]] = []
    for label, remote_dir, items, _hash, _ver in jobs:
        dest_dir = ASSETS_DIR / label
        dest_dir.mkdir(parents=True, exist_ok=True)
        for name, size in items:
            if data_only and not is_data_bundle(name):
                continue
            work.append((name, size, remote_dir, dest_dir))
    if limit is not None:
        work = work[:limit]
        console.print(f"[yellow]--limit {limit}，本次只处理 {len(work)} 个文件[/]")

    stats = {"ok": 0, "skip": 0, "fail": 0, "decrypt_fail": 0, "tables": 0}
    errors: list[str] = []

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("下载资源", total=len(work))
        with ThreadPoolExecutor(max_workers=workers) as pool:
            futures = {
                pool.submit(download_one, name, size, remote_dir, dest_dir, retries, force): name
                for name, size, remote_dir, dest_dir in work
            }
            for fut in as_completed(futures):
                name = futures[fut]
                progress.advance(task)
                try:
                    result = fut.result()
                except Exception as exc:  # noqa: BLE001
                    stats["fail"] += 1
                    errors.append(f"{name}: {exc}")
                    console.print(f"[red]FAIL[/] {name}: {exc}")
                    continue
                status = result.get("status")
                if status == "ok":
                    stats["ok"] += 1
                elif status == "skip":
                    stats["skip"] += 1
                elif status == "decrypt_fail":
                    stats["decrypt_fail"] += 1
                    errors.append(f"{name}: decrypt {result.get('error')}")
                else:
                    stats["fail"] += 1
                    errors.append(f"{name}: {status} {result.get('error', '')}")
                stats["tables"] += int(result.get("tables") or 0)

    state.update(
        {
            "project": PROJECT,
            "build": build,
            "art_version": cfg.get("art_version"),
            "art_catalog": cfg.get("art_catalog"),
            "catalog_hash": art_hash,
            "catalog_url": cfg.get("catalog_url"),
            "asset_url": cfg.get("asset_url"),
            "common": common,
            "season": season,
            "latest_build_number": cfg.get("latest_build_number"),
        }
    )
    save_state(state)

    console.print()
    console.print(
        f"[bold]完成[/] 下载 {stats['ok']}  跳过 {stats['skip']}  "
        f"失败 {stats['fail']}  解密失败 {stats['decrypt_fail']}  "
        f"数据表 {stats['tables']}"
    )
    if errors:
        err_log = ROOT / "download_errors.log"
        err_log.write_text("\n".join(errors) + "\n", encoding="utf-8")
        console.print(f"[yellow]错误写入 {err_log} ({len(errors)})[/]")
        return 1
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description="Orisries 全资产下载 / 解密 / 数据表提取")
    parser.add_argument("--build", default=CLIENT_BUILD, help=f"配置 build 号 (默认 {CLIENT_BUILD})")
    parser.add_argument("--workers", type=int, default=8, help="并发数")
    parser.add_argument("--retries", type=int, default=3, help="单文件重试次数")
    parser.add_argument("--force", action="store_true", help="强制重新下载已有文件")
    parser.add_argument("--status", action="store_true", help="只查看远端版本，不下载")
    parser.add_argument("--extract-only", action="store_true", help="只从本地 Assets 提取并解码数据表为 JSON")
    parser.add_argument("--data-only", action="store_true", help="只下载 *data_assets* 数据包")
    parser.add_argument("--limit", type=int, default=None, help="最多处理 N 个文件（调试用）")
    parser.add_argument(
        "--common",
        default=None,
        help="额外下载 common catalog（登录路线后才有版本号，会先查 version_table）",
    )
    parser.add_argument(
        "--season",
        default=None,
        help="额外下载 season catalog（Sxxx_yyy 会先取 Sxxx，再查 version_table）",
    )
    args = parser.parse_args()

    try:
        if args.status:
            return cmd_status()
        return run(
            build=args.build,
            workers=args.workers,
            retries=args.retries,
            force=args.force,
            common=args.common,
            season=args.season,
            extract_only=args.extract_only,
            data_only=args.data_only,
            limit=args.limit,
        )
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/]")
        return 130
    except Exception:  # noqa: BLE001
        console.print("[red]未处理异常[/]")
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    sys.exit(main())
