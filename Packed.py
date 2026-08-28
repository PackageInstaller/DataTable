from __future__ import annotations

import json
import struct
from io import BytesIO
from pathlib import Path


def _read_utf(stream: BytesIO, data: bytes) -> str:
    raw = stream.read(2)
    if len(raw) < 2:
        raise ValueError("UTF 长度截断")
    length = struct.unpack(">H", raw)[0]
    pos = stream.tell()
    if pos + length > len(data):
        raise ValueError("UTF 内容截断")
    return stream.read(length).decode("utf-8")


def parse_factory_pack(data: bytes) -> list[dict]:
    """all.bin 解压后：dataOffset + count + (name, relOffset)*，数据从 dataOffset 起。"""
    if len(data) < 8:
        raise ValueError("工厂包过短")
    stream = BytesIO(data)
    data_offset = struct.unpack(">i", stream.read(4))[0]
    count = struct.unpack(">i", stream.read(4))[0]
    if count < 0 or count > 10_000:
        raise ValueError(f"工厂数量异常: {count}")
    entries: list[dict] = []
    for _ in range(count):
        name = _read_utf(stream, data)
        rel = struct.unpack(">i", stream.read(4))[0]
        entries.append({"name": name, "offset": data_offset + rel, "rel": rel})
    if stream.tell() != data_offset:
        raise ValueError(f"工厂索引结束于 {stream.tell()}，与 dataOffset {data_offset} 不一致")
    for i, item in enumerate(entries):
        end = entries[i + 1]["offset"] if i + 1 < len(entries) else len(data)
        item["size"] = end - item["offset"]
    return entries


def parse_factory_objects(blob: bytes) -> tuple[str, list[dict]]:
    """解析单个工厂 bin：索引 + 按 extra 切块，块内 uint32 若指向字符串区则收成字段。"""
    if len(blob) < 8:
        raise ValueError("工厂过短")
    parent_len = struct.unpack_from(">H", blob, 0)[0]
    pos = 2 + parent_len
    data_a, str_off, _mid, count = struct.unpack_from(">iiii", blob, pos)
    pos += 16
    items: list[dict] = []
    for _ in range(count):
        size = struct.unpack_from(">H", blob, pos)[0]
        rec = blob[pos : pos + size]
        obj_id = struct.unpack_from(">I", rec, 2)[0]
        nlen = rec[14]
        name = rec[15 : 15 + nlen].decode("utf-8", "replace")
        extra = struct.unpack_from(">I", rec, 15 + nlen)[0]
        items.append({"id": obj_id, "name": name, "extra": extra})
        pos += size
    if pos != data_a:
        raise ValueError(f"工厂索引结束 {pos} != dataA {data_a}")

    str_at: dict[int, str] = {}
    cls_len = struct.unpack_from(">i", blob, str_off)[0]
    class_name = blob[str_off + 4 : str_off + 4 + cls_len].decode("utf-8", "replace")
    sp = str_off + 4 + cls_len
    while sp + 2 <= len(blob):
        ln = struct.unpack_from(">H", blob, sp)[0]
        if sp + 2 + ln > len(blob) or ln > 8000:
            break
        str_at[sp - str_off] = blob[sp + 2 : sp + 2 + ln].decode("utf-8", "replace")
        sp += 2 + ln

    cursor = data_a
    for item in items:
        chunk = blob[cursor : cursor + item["extra"]]
        fields: dict[int, str] = {}
        ints: dict[int, int] = {}
        for off in range(0, (len(chunk) // 4) * 4, 4):
            ref = struct.unpack_from(">I", chunk, off)[0]
            if ref in str_at:
                fields[off] = str_at[ref]
            else:
                ints[off] = ref
        item["fields"] = fields
        item["ints"] = ints
        cursor += item["extra"]
    if cursor != str_off:
        raise ValueError(f"工厂数据结束 {cursor} != 字符串区 {str_off}")
    return class_name, items


def dump_factory_pack(data: bytes, dest: Path) -> int:
    dest.mkdir(parents=True, exist_ok=True)
    entries = parse_factory_pack(data)
    (dest / "index.json").write_text(
        json.dumps(entries, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    for item in entries:
        blob = data[item["offset"] : item["offset"] + item["size"]]
        out = dest / f"{item['name']}.bin"
        if not (out.exists() and out.stat().st_size == len(blob)):
            out.write_bytes(blob)
    return len(entries)


def iter_utf_pairs(data: bytes):
    stream = BytesIO(data)
    while stream.tell() < len(data):
        name = _read_utf(stream, data)
        payload = _read_utf(stream, data)
        yield name, payload


def dump_utf_catalog(data: bytes, dest: Path) -> int:
    dest.mkdir(parents=True, exist_ok=True)
    count = 0
    names: list[str] = []
    for name, payload in iter_utf_pairs(data):
        names.append(name)
        out = dest / name
        out.parent.mkdir(parents=True, exist_ok=True)
        if name.endswith(".sk") or payload.startswith("{") or payload.startswith("["):
            out = out.with_suffix(".json")
        text = payload
        if payload.startswith("{") or payload.startswith("["):
            try:
                text = json.dumps(json.loads(payload), ensure_ascii=False)
            except json.JSONDecodeError:
                text = payload
        out.write_text(text, encoding="utf-8")
        count += 1
    (dest / "index.json").write_text(
        json.dumps(names, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    return count
