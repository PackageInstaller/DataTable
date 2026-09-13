from __future__ import annotations

import json
import struct
from pathlib import Path
from typing import Any

TYPE_UINT32 = 0
TYPE_UINT64 = 1
TYPE_STRING = 2

PROPERTY_NAMES: dict[int, str] = {
    4092729604: "id",
    2072370017: "localized_name",
    3013568853: "romanized_name",
    2314468669: "model_path_hash",
    999008199: "text",
    1924308541: "voice_file",
    3411751622: "still_path_hash",
    397529648: "speech_balloon_type_id",
}

DIALOGUE_PREFIXES = (
    "Atelier_Talk",
    "CityTalkEvent",
    "Date",
    "LegendEvent",
    "SeasonalTalkEvent",
    "TalkEvent",
    "CharacterEvent",
    "SeasonalEvent",
    "SideStoryEvent",
)


def unpack_text_asset(data: bytes) -> list[dict[str, Any]]:
    offset = 0
    property_count, entry_count = struct.unpack_from("<II", data, offset)
    offset += 8
    props: list[tuple[int, str]] = []
    for _ in range(property_count):
        ptype, prop_id = struct.unpack_from("<II", data, offset)
        offset += 8
        name = PROPERTY_NAMES.get(prop_id, f"unknown_{prop_id}")
        props.append((ptype, name))

    entries: list[dict[str, Any]] = []
    for _ in range(entry_count):
        entry: dict[str, Any] = {}
        for ptype, name in props:
            if ptype == TYPE_UINT32:
                entry[name] = struct.unpack_from("<I", data, offset)[0]
                offset += 4
            elif ptype == TYPE_UINT64:
                entry[name] = struct.unpack_from("<Q", data, offset)[0]
                offset += 8
            elif ptype == TYPE_STRING:
                length = struct.unpack_from("<I", data, offset)[0]
                offset += 4
                entry[name] = data[offset:offset + length].decode("utf-8", "replace")
                offset += length
            else:
                raise ValueError(f"未处理的属性类型 {ptype}（字段 {name}）")
        entries.append(entry)
    return entries


def classify(name: str, entries: list[dict[str, Any]]) -> str:
    """按文件名/内容归类，方便输出到不同子目录。"""
    if "SystemText" in name or "ErrorText" in name:
        return "SystemText"
    if entries and isinstance(entries[0], dict) and "text" in entries[0]:
        for prefix in DIALOGUE_PREFIXES:
            if name.startswith(prefix):
                return f"Dialogue/{prefix}"
        return "Dialogue"
    return "Misc"


def dump_text_assets(
    blobs: dict[str, bytes],
    out_dir: Path,
    *,
    indent: int = 2,
    sort_folders: bool = True,
    on_asset: Any | None = None,
) -> tuple[int, int]:
    """把 {名字: TextAsset 字节} 写成 JSON，返回 (成功, 失败)。"""
    ok = fail = 0
    for name, blob in blobs.items():
        try:
            entries = unpack_text_asset(blob)
        except Exception:  # noqa: BLE001
            fail += 1
            continue
        folder = classify(name, entries) if sort_folders else ""
        dest = out_dir / folder / f"{name}.json" if folder else out_dir / f"{name}.json"
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(
            json.dumps(entries, ensure_ascii=False, indent=indent),
            encoding="utf-8",
        )
        ok += 1
        if on_asset is not None:
            on_asset(name, dest, len(entries))
    return ok, fail
