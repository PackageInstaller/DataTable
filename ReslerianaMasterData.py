from __future__ import annotations

import hashlib
import json
import struct
from pathlib import Path
from typing import Any, Iterator

import lz4.block
import msgpack

MASTERDATA_KEY_PREFIX = "wTmkW6hwnA6HXnItdXjZp/BSOdPuh2L9QzdM3bx1e54="
MASTERDATA_HOST = {
    "Japan": "https://asset.resleriana.jp/master_data/",
    "Global": "https://asset.resleriana.com/master_data/",
}
LZ4_EXT_TYPE = 99


def masterdata_url(server: str, version: str, language: str | None = None) -> str:
    if server == "Japan":
        return f"{MASTERDATA_HOST['Japan']}{version}"
    lang = language or "en"
    return f"{MASTERDATA_HOST['Global']}{lang}/{version}"


def decrypt_masterdata(data: bytes, version: str) -> bytes:
    from Crypto.Cipher import AES 

    digest = hashlib.sha256((MASTERDATA_KEY_PREFIX + version).encode("utf-8")).digest()
    cipher = AES.new(digest[:16], AES.MODE_CBC, digest[16:32])
    return cipher.decrypt(data)


def _lz4_ext(data: bytes) -> Any:
    """msgpack 扩展类型 99：`d2 <u32be 原始长度> <lz4 block>`。"""
    if not data or data[0] != 0xD2:
        raise ValueError("未知的 LZ4 扩展头")
    size = struct.unpack_from(">I", data, 1)[0]
    raw = lz4.block.decompress(data[5:], uncompressed_size=size)
    return msgpack.unpackb(raw, raw=False, strict_map_key=False)


def _ext_hook(code: int, data: bytes) -> Any:
    if code == LZ4_EXT_TYPE:
        return _lz4_ext(data)
    raise ValueError(f"未知的 MessagePack 扩展类型 {code}")


def iter_objects(payload: bytes) -> Iterator[tuple[int, Any]]:
    """逐个产出 (对象结束偏移, 对象)。"""
    unpacker = msgpack.Unpacker(
        raw=False,
        strict_map_key=False,
        ext_hook=_ext_hook,
        max_buffer_size=0,
    )
    unpacker.feed(payload)
    for obj in unpacker:
        yield unpacker.tell(), obj


def unpack_masterdata(payload: bytes) -> dict[str, list[dict[str, Any]]]:
    table_names: list[str] | None = None
    tables: dict[str, list[Any]] = {}
    order: list[str] = []
    for index, (_, obj) in enumerate(iter_objects(payload)):
        if index == 0:
            table_names = [
                name
                for name, _ in sorted(obj.items(), key=lambda kv: kv[1][0])
            ]
            continue
        if table_names is None:
            raise ValueError("masterdata 流缺少目录对象")
        if index > len(table_names):
            break
        name = table_names[index - 1]
        tables[name] = obj
        order.append(name)
    return {name: tables[name] for name in order}


def _json_default(value: Any) -> Any:
    if isinstance(value, (bytes, bytearray)):
        try:
            return value.decode("utf-8")
        except UnicodeDecodeError:
            return value.hex()
    if isinstance(value, msgpack.Timestamp):
        try:
            return value.to_datetime().isoformat()
        except Exception:  # noqa: BLE001
            return int(value.to_unix())
    if hasattr(value, "isoformat"):
        return value.isoformat()
    raise TypeError(f"无法序列化的类型 {type(value)!r}")


def dump_tables(
    tables: dict[str, list[dict[str, Any]]],
    out_dir: Path,
    *,
    indent: int = 2,
    on_table: Any | None = None,
) -> int:
    out_dir.mkdir(parents=True, exist_ok=True)
    written = 0
    for name, rows in tables.items():
        dest = out_dir / f"{name}.json"
        dest.write_text(
            json.dumps(rows, ensure_ascii=False, indent=indent, default=_json_default),
            encoding="utf-8",
        )
        written += 1
        if on_table is not None:
            on_table(name, dest, len(rows) if isinstance(rows, list) else 1)
    return written


def dump_catalog(
    payload: bytes,
    dest: Path,
    *,
    indent: int = 2,
) -> dict[str, Any]:
    first = next(iter_objects(payload), None)
    if first is None:
        raise ValueError("空 masterdata")
    _, catalog = first
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(
        json.dumps(catalog, ensure_ascii=False, indent=indent, default=_json_default),
        encoding="utf-8",
    )
    return catalog
