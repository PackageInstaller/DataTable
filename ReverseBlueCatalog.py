from __future__ import annotations

"""反向蓝资源 catalog（Aura addressables）解析。

远端 catalog:  https://cdn.rxr.grimoire.codes/assets/Android/master.Android.v{ver}.catalog.gz
结构（msgpack）：[2, 地址able 列表, providers, bundle 名列表, assemblies, types, 依赖记录, 额外记录]
- 地址able 列表元素: "AB:<bundleName>_<md5>" 或资源路径（如 "AprilFool2026/1/Prefabs/LoadContentView"）
- 依赖记录 [i][5] 为该地址able 依赖的 AB 项下标列表；[i][6][2] 为 bundle 元数据 blob:
  u32be(name+hash 长度) + "<bundleName>_<md5>" + 16B md5 + u32be crc32 + u32be 0 + u32be size
- 单 bundle URL: https://cdn.rxr.grimoire.codes/assets/Android/<name>_<hash>.Android.bundle
"""

import gzip
import hashlib
import json
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

import msgpack
import requests

import ReverseBlueApi as Api

CATALOG_BASE = f"{Api.CDN_BASE}/assets/{Api.PLATFORM}/"
CATALOG_RE = re.compile(r"^(?P<name>[^/]+)\.(?P<platform>[^./]+)\.v(?P<version>\d+)\.catalog\.gz$")
BUNDLE_FILE_RE = re.compile(r"^(?P<name>.+)_(?P<hash>[0-9a-f]{32})\.(?P<platform>[^./]+)\.bundle$")


@dataclass
class BundleInfo:
    name: str
    hash: str
    size: int
    crc32: int
    flat_index: int
    ref_count: int = 0

    @property
    def file_name(self) -> str:
        return f"{self.name}_{self.hash}.{Api.PLATFORM}.bundle"

    @property
    def url(self) -> str:
        return f"{CATALOG_BASE}{self.file_name}"

    @property
    def relative_path(self) -> str:
        return f"{Api.PLATFORM}/{self.file_name}"


@dataclass
class AuraCatalog:
    version: str
    catalog_name: str
    info: dict[str, Any]
    raw_size: int
    bundles: dict[str, BundleInfo] = field(default_factory=dict)
    addressables: dict[str, list[str]] = field(default_factory=dict)
    markers: list[str] = field(default_factory=list)

    @property
    def total_size(self) -> int:
        return sum(bundle.size for bundle in self.bundles.values())

    def readable(self, *, with_resources: bool = False) -> dict[str, Any]:
        data: dict[str, Any] = {
            "catalog": self.catalog_name,
            "version": self.version,
            "platform": Api.PLATFORM,
            "catalogInfo": self.info,
            "rawSize": self.raw_size,
            "bundleCount": len(self.bundles),
            "totalSize": self.total_size,
            "addressableCount": len(self.addressables),
            "markers": self.markers,
            "bundles": [
                {
                    "name": b.name,
                    "hash": b.hash,
                    "size": b.size,
                    "crc32": b.crc32,
                    "refCount": b.ref_count,
                    "url": b.url,
                }
                for b in self.bundles.values()
            ],
        }
        if with_resources:
            data["addressables"] = self.addressables
        return data


def catalog_name(version: str) -> str:
    return f"master.{Api.PLATFORM}.v{version}.catalog"


def catalog_urls(version: str) -> tuple[str, str]:
    stem = catalog_name(version)
    return f"{CATALOG_BASE}{stem}_info", f"{CATALOG_BASE}{stem}.gz"


def fetch_catalog_info(cache_dir: Path, version: str, *, force: bool = False, timeout: int = 60) -> dict[str, Any]:
    cache_dir.mkdir(parents=True, exist_ok=True)
    dest = cache_dir / f"{catalog_name(version)}_info"
    info_url, _ = catalog_urls(version)
    if not dest.is_file() or force:
        resp = requests.get(info_url, timeout=timeout)
        resp.raise_for_status()
        dest.write_bytes(resp.content)
    return json.loads(dest.read_text(encoding="utf-8"))


def fetch_catalog(
    cache_dir: Path,
    version: str,
    *,
    force: bool = False,
    timeout: int = 300,
) -> AuraCatalog:
    """下载并解析 Aura catalog（本地缓存 .gz，返回解析结果）。"""
    cache_dir.mkdir(parents=True, exist_ok=True)
    info = fetch_catalog_info(cache_dir, version, force=force, timeout=60)
    stem = catalog_name(version)
    dest = cache_dir / f"{stem}.catalog.gz"
    _, url = catalog_urls(version)
    if force or not dest.is_file():
        tmp = dest.with_suffix(dest.suffix + ".part")
        with requests.get(url, stream=True, timeout=timeout) as resp:
            resp.raise_for_status()
            with tmp.open("wb") as handle:
                for chunk in resp.iter_content(Api.CHUNK):
                    if chunk:
                        handle.write(chunk)
        tmp.replace(dest)
    compressed = dest.read_bytes()
    raw = gzip.decompress(compressed)
    expect_size = int(info.get("size") or 0)
    if expect_size and len(raw) != expect_size:
        raise RuntimeError(f"catalog 解压后大小 {len(raw)} != catalog_info.size {expect_size}")
    # catalog_info.hash 是 Aura 的构建/缓存标识（不是文件 md5），仅用 size 做完整性校验
    expect_hash = info.get("hash") or ""
    if expect_hash and hashlib.md5(raw).hexdigest() != expect_hash:
        print(f"注: catalog_info.hash={expect_hash} 与解压文件 md5 不同（Aura 构建 hash，跳过文件校验）")
    return parse_catalog(raw, version, info)


def parse_catalog(raw: bytes, version: str, info: dict[str, Any]) -> AuraCatalog:
    obj = msgpack.unpackb(raw, raw=False, strict_map_key=False)
    if not isinstance(obj, list) or len(obj) < 7:
        raise RuntimeError("catalog 结构异常")
    flat, records, names = obj[1], obj[6], obj[3]
    catalog = AuraCatalog(
        version=version,
        catalog_name=catalog_name(version),
        info=info,
        raw_size=len(raw),
    )
    by_flat: dict[int, BundleInfo] = {}
    for index, item in enumerate(flat):
        if not isinstance(item, str) or not item.startswith("AB:"):
            continue
        body = item[3:]
        if len(body) < 33:
            continue
        bundle_hash = body[-32:]
        bundle_name = body[:-33]
        blob = records[index][6][2]
        name_len = int.from_bytes(blob[:4], "big")
        name_in_blob = blob[4 : 4 + name_len].decode("utf-8")
        hash_bytes = blob[4 + name_len : 4 + name_len + 16]
        crc = int.from_bytes(blob[4 + name_len + 16 : 4 + name_len + 20], "big")
        size = int.from_bytes(blob[4 + name_len + 24 : 4 + name_len + 28], "big")
        if name_in_blob != body or hash_bytes.hex() != bundle_hash:
            raise RuntimeError(f"catalog bundle blob 校验失败 @{index}")
        bundle = BundleInfo(
            name=bundle_name,
            hash=bundle_hash,
            size=size,
            crc32=crc,
            flat_index=index,
        )
        catalog.bundles[bundle_name] = bundle
        by_flat[index] = bundle
    for index, item in enumerate(flat):
        if not isinstance(item, str) or item.startswith("AB:"):
            continue
        try:
            deps = records[index][5]
        except (IndexError, TypeError):
            deps = []
        bundle_names = [by_flat[j].name for j in deps if j in by_flat]
        catalog.addressables[item] = bundle_names
        for j in deps:
            if j in by_flat:
                by_flat[j].ref_count += 1
    catalog.markers = [name for name in names if name not in catalog.bundles]
    return catalog


def normalize_relative(relative_path: str) -> str:
    return relative_path.lstrip("/")


def write_readable(catalog: AuraCatalog, dest: Path, *, with_resources: bool = False) -> Path:
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(
        json.dumps(catalog.readable(with_resources=with_resources), ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    return dest


LOCAL_BUNDLE_RE = re.compile(r"^(?P<name>.+)_assets_all_(?P<hash>[0-9a-f]{32})\.bundle$")


def collect_local_addressables(assets_dir: Path) -> dict[str, Any]:
    """解析 split_UnityDataAssetPack.apk 解包出的本地 Unity Addressables。

    catalog.json 的 m_InternalIds 里每个 internal_*_assets_all_<md5>.bundle
    都能映射到 Assets/aa/Android/ 下的实际文件。
    """
    catalog_path = assets_dir / "aa" / "catalog.json"
    bundle_dir = assets_dir / "aa" / "Android"
    if not catalog_path.is_file():
        return {}
    catalog = json.loads(catalog_path.read_text(encoding="utf-8"))
    internal_ids = catalog.get("m_InternalIds", [])
    bundles: dict[str, dict[str, Any]] = {}
    total = 0
    for internal_id in internal_ids:
        match = re.search(r"(internal_[^/]+\.bundle)$", internal_id)
        if not match:
            continue
        file_name = match.group(1)
        path = bundle_dir / file_name
        if not path.is_file():
            continue
        name_match = LOCAL_BUNDLE_RE.match(file_name)
        size = path.stat().st_size
        total += size
        bundles[file_name] = {
            "name": name_match.group("name") if name_match else file_name,
            "hash": name_match.group("hash") if name_match else "",
            "path": str(path.relative_to(assets_dir)),
            "size": size,
            "internalId": internal_id,
        }
    return {
        "_meta": {
            "catalog": str(catalog_path.relative_to(assets_dir)),
            "locator": catalog.get("m_LocatorId"),
            "buildResultHash": catalog.get("m_BuildResultHash"),
            "bundleCount": len(bundles),
            "bundleBytes": total,
            "note": "split_UnityDataAssetPack.apk 内置的本地 Unity Addressables（与 Aura 远端 catalog 是两套系统）",
        },
        "bundles": bundles,
    }


def write_local_addressables(assets_dir: Path, dest: Path) -> dict[str, Any]:
    data = collect_local_addressables(assets_dir)
    if not data:
        return {}
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    return data
