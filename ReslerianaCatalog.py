from __future__ import annotations

import base64
import json
import struct
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Iterator

from ReslerianaBundle import BundleInfo

PLATFORMS = ("Android", "iOS", "StandaloneWindows64")
OBJ_ASCII = 0
OBJ_UNICODE = 1
OBJ_UINT16 = 2
OBJ_UINT32 = 3
OBJ_INT32 = 4
OBJ_HASH = 5
OBJ_JSON = 7


class Reader:
    def __init__(self, data: bytes) -> None:
        self.data = data
        self.pos = 0

    def int32(self) -> int:
        v = struct.unpack_from("<i", self.data, self.pos)[0]
        self.pos += 4
        return v

    def uint32(self) -> int:
        v = struct.unpack_from("<I", self.data, self.pos)[0]
        self.pos += 4
        return v

    def u8(self) -> int:
        v = self.data[self.pos]
        self.pos += 1
        return v

    def take(self, n: int) -> bytes:
        v = self.data[self.pos:self.pos + n]
        self.pos += n
        return v


def read_object(reader: Reader) -> Any:
    kind = reader.u8()
    if kind == OBJ_ASCII:
        return reader.take(reader.int32()).decode("ascii", "replace")
    if kind == OBJ_UNICODE:
        return reader.take(reader.int32()).decode("utf-16-le", "replace")
    if kind == OBJ_UINT16:
        return struct.unpack_from("<H", reader.take(2))[0]
    if kind == OBJ_UINT32:
        return reader.uint32()
    if kind == OBJ_INT32:
        return reader.int32()
    if kind == OBJ_HASH:
        return reader.uint32()
    if kind == OBJ_JSON:
        asm_len = reader.u8()
        reader.take(asm_len)
        cls_len = reader.u8()
        reader.take(cls_len)
        text = reader.take(reader.int32()).decode("utf-16-le", "replace")
        try:
            return json.loads(text)
        except json.JSONDecodeError:
            return text
    raise ValueError(f"未知 ObjectType {kind} @ {reader.pos}")


def read_keys(catalog: dict[str, Any]) -> list[Any]:
    reader = Reader(base64.b64decode(catalog["m_KeyDataString"]))
    count = reader.int32()
    return [read_object(reader) for _ in range(count)]


def read_buckets(catalog: dict[str, Any]) -> list[dict[str, Any]]:
    reader = Reader(base64.b64decode(catalog["m_BucketDataString"]))
    count = reader.int32()
    buckets = []
    for _ in range(count):
        index = reader.int32()
        entries = [reader.int32() for _ in range(reader.int32())]
        buckets.append({"index": index, "entries": entries})
    return buckets


def read_entries(catalog: dict[str, Any], keys: list[Any], buckets: list[dict[str, Any]]) -> list[dict[str, Any]]:
    reader = Reader(base64.b64decode(catalog["m_EntryDataString"]))
    extras = Reader(base64.b64decode(catalog["m_ExtraDataString"]))
    count = reader.int32()
    entries = []
    for _ in range(count):
        internal_id = reader.int32()
        provider_index = reader.int32()
        dependency_key_index = reader.int32()
        dep_hash = reader.int32()
        data_index = reader.int32()
        primary_key_index = reader.int32()
        resource_type_index = reader.int32()
        container = (
            catalog["m_InternalIds"][internal_id]
            if 0 <= internal_id < len(catalog["m_InternalIds"])
            else None
        )
        provider = (
            catalog["m_ResourceProviderData"][provider_index]["m_Id"]
            if 0 <= provider_index < len(catalog["m_ResourceProviderData"])
            else None
        )
        resource_type = (
            catalog["m_resourceTypes"][resource_type_index]["m_ClassName"]
            if 0 <= resource_type_index < len(catalog["m_resourceTypes"])
            else None
        )
        data = None
        if data_index >= 0:
            extras.pos = data_index
            try:
                data = read_object(extras)
            except Exception:  # noqa: BLE001 - 个别条目数据不完整，忽略即可
                data = None
        entries.append(
            {
                "container": container,
                "provider": provider,
                "dependencyKey": keys[dependency_key_index]
                if 0 <= dependency_key_index < len(keys)
                else None,
                "depHash": dep_hash,
                "primary": keys[primary_key_index]
                if 0 <= primary_key_index < len(keys)
                else None,
                "resourceType": resource_type,
                "data": data,
            }
        )
    key_positions: dict[Any, int] = {}
    for index, key in enumerate(keys):
        key_positions.setdefault(key, index)
    for entry in entries:
        dep = entry["dependencyKey"]
        if isinstance(dep, bool):
            continue
        if isinstance(dep, int) or (isinstance(dep, str) and dep.lstrip("-").isdigit()):
            key_index = key_positions.get(dep)
            if key_index is None:
                continue
            try:
                first = buckets[key_index]["entries"][0]
                entry["dependencyKey"] = entries[first]["primary"]
            except (ValueError, IndexError):
                pass
    return entries


@dataclass
class Resource:
    """catalog 里的一条资源定位记录。"""

    key: str
    bundle: str | None
    resource_type: str | None
    container: str | None
    data: Any = None


class Catalog:
    """已解析的 Addressables catalog。"""

    def __init__(self, raw: dict[str, Any], path: Path | None = None) -> None:
        self.raw = raw
        self.path = path
        self.bundles: list[BundleInfo] = [
            BundleInfo.from_catalog(b) for b in raw["_fileCatalog"]["_bundles"]
        ]
        self._by_name = {b.relative_path: b for b in self.bundles}
        self._by_bundle_name = {b.bundle_name: b for b in self.bundles}
        self.keys = read_keys(raw)
        self.buckets = read_buckets(raw)
        self.entries = read_entries(raw, self.keys, self.buckets)

    # -- 加载 --------------------------------------------------------------
    @classmethod
    def load(cls, path: Path) -> "Catalog":
        return cls(json.loads(Path(path).read_text(encoding="utf-8")), Path(path))

    @property
    def main_asset_bundles(self) -> list[str]:
        return list(self.raw.get("_mainAssetBundles") or [])

    @property
    def unique_build_id(self) -> str:
        return str(self.raw.get("_uniqueBuildId") or "")

    # -- 查询 --------------------------------------------------------------
    def bundle(self, relative_path: str) -> BundleInfo | None:
        return self._by_name.get(relative_path)

    def resources(self) -> Iterator[Resource]:
        for i, bucket in enumerate(self.buckets):
            key = self.keys[i] if i < len(self.keys) else None
            if not isinstance(key, str):
                continue
            for entry_index in bucket["entries"]:
                entry = self.entries[entry_index]
                dep = entry["dependencyKey"]
                yield Resource(
                    key=key,
                    bundle=dep if isinstance(dep, str) else None,
                    resource_type=entry["resourceType"],
                    container=entry["container"],
                    data=entry["data"],
                )

    def bundles_with_type(self, resource_type: str) -> list[BundleInfo]:
        wanted: set[str] = set()
        for resource in self.resources():
            if resource.bundle and (resource.resource_type or "").endswith(resource_type):
                wanted.add(resource.bundle)
        return [self._by_name[n] for n in sorted(wanted) if n in self._by_name]

    def text_asset_bundles(self) -> list[BundleInfo]:
        return self.bundles_with_type("TextAsset")

    def readable(self, *, include_resources: bool = False) -> dict[str, Any]:
        out: dict[str, Any] = {
            "locatorId": self.raw.get("m_LocatorId"),
            "buildResultHash": self.raw.get("m_BuildResultHash"),
            "uniqueBuildId": self.unique_build_id,
            "mainAssetLabel": self.raw.get("_mainAssetLabel"),
            "mainAssetBundles": self.main_asset_bundles,
            "bundleCount": len(self.bundles),
            "bundles": [
                {
                    "relativePath": b.relative_path,
                    "bundleName": b.bundle_name,
                    "hash": b.hash,
                    "crc": b.crc,
                    "fileSize": b.file_size,
                    "fileMd5": b.file_md5,
                    "compression": b.compression,
                    "userData": b.user_data,
                }
                for b in self.bundles
            ],
        }
        if include_resources:
            out["resources"] = [
                {
                    "key": r.key,
                    "bundle": r.bundle,
                    "type": r.resource_type,
                    "container": r.container,
                }
                for r in self.resources()
            ]
        return out
