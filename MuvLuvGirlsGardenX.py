from __future__ import annotations

import argparse
import gzip
import io
import json
import os
import re
import threading
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Iterable, Optional
from urllib.parse import urljoin

import lz4.block
import msgpack
import requests
from rich.console import Console
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
)

from MasterMap import ENUM_MAPPINGS, FIELD_TYPE_MAP, MASTER_SCHEMA_BY_ID, MASTER_SCHEMA_BY_NAME
from UnityCatalogReader import UnityCatalogReader

console = Console()

ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
CATALOG_DIR = ASSETS_DIR / "Catalogs"
BUNDLE_DIR = ASSETS_DIR / "BundleAssets"
DIRECT_DIR = ASSETS_DIR / "DirectAssets"
LOGICAL_MAP_PATH = ASSETS_DIR / "logical_map.json"

API_BASE = "https://api-game.muvluv-girls-garden.com"
ENV_PATH = "/api/Environment/EnvConfiguration"
MASTER_API_PATH = "/api/data/master"

DEFAULT_HEADERS = {
    "User-Agent": "com.Tivadar.Best.HTTP v3.0.17.0/Unity 6000.0.59f2",
    "X-Platform": "dmm",
    "X-Device": "sp",
    "X-Rating": "adult",
    "X-Client-Version": "69",
}

CATALOGS = ("catalog", "ui_catalog", "spine_catalog", "vfx_catalog", "sound_catalog")
RUNTIME_PATH_MARK = "{UnityEngine.AddressableAssets.Addressables.RuntimePath}"
RLP_MARK = "rlp"

DIRECT_BANNER_PREFIX = {
    "Gacha": "ImageFiles/Banners/Gacha/",
    "EventTop": "ImageFiles/Banners/Event/",
    "LimitedTimeShop": "ImageFiles/Banners/Shop/",
    "Subscription": "ImageFiles/Banners/Shop/",
    "Shop": "ImageFiles/Banners/Shop/",
    "LoginBonus": "ImageFiles/Banners/LoginBonus/",
    "Information": "ImageFiles/Banners/Functional/",
}
DIRECT_FIXED = (
    "GZ/dmm_products.json",
    "GZ/TextFiles/Policies/UserAgreements.json",
    "Origin/VideoFiles/Title/title_movie.mp4",
)

MAX_WORKERS = 12
RETRIES = 4
SESSION = requests.Session()
SESSION.headers.update(DEFAULT_HEADERS)



def conv(obj: Any) -> Any:
    if isinstance(obj, msgpack.Timestamp):
        return obj.to_datetime().isoformat()
    if isinstance(obj, dict):
        return {k: conv(v) for k, v in obj.items()}
    if isinstance(obj, list):
        return [conv(i) for i in obj]
    return obj


def decom(dat: list) -> bytes:
    sizes = list(msgpack.Unpacker(io.BytesIO(dat[0].data), raw=False, strict_map_key=False))
    out = bytearray()
    for i, block in enumerate(dat[1:]):
        if i < len(sizes):
            out.extend(lz4.block.decompress(block, uncompressed_size=sizes[i]))
    return bytes(out)


def restore(obj: Any, th: Optional[str] = None) -> Any:
    if th:
        if th.endswith("[]") and isinstance(obj, list):
            bt = th[:-2]
            return [restore(i, bt) for i in obj]

        if th.startswith("IDictionary<") and isinstance(obj, dict):
            m = re.search(r"IDictionary<([\w\.]+)\s*,\s*([\w\.]+)>", th)
            if m:
                kt, vt = m.groups()
                kt, vt = kt.split(".")[-1], vt.split(".")[-1]
                return {str(restore(k, kt)): restore(v, vt) for k, v in obj.items()}

        if th in MASTER_SCHEMA_BY_NAME and isinstance(obj, list):
            ro: dict[str, Any] = {"type": th}
            for i, fn in enumerate(MASTER_SCHEMA_BY_NAME[th]):
                if i < len(obj):
                    ro[fn] = restore(obj[i], FIELD_TYPE_MAP.get(th, {}).get(fn))
            return ro

        if th in ENUM_MAPPINGS and isinstance(obj, int):
            return ENUM_MAPPINGS[th].get(obj, obj)

    if isinstance(obj, list) and len(obj) == 2 and isinstance(obj[0], int) and obj[0] in MASTER_SCHEMA_BY_ID:
        tid, dat = obj
        cn, _ = MASTER_SCHEMA_BY_ID[tid]
        return restore(dat, cn)

    if isinstance(obj, dict):
        return {k: restore(v) for k, v in obj.items()}
    if isinstance(obj, list):
        return [restore(i) for i in obj]
    return obj


def unpack_msgpack_root(data: bytes) -> Any:
    unpacker = msgpack.Unpacker(io.BytesIO(data), raw=False, strict_map_key=False)
    objs = list(unpacker)
    if not objs:
        raise ValueError("empty msgpack")

    def one(raw_obj: Any) -> Any:
        if (
            isinstance(raw_obj, list)
            and raw_obj
            and isinstance(raw_obj[0], msgpack.ExtType)
            and raw_obj[0].code == 98
        ):
            return msgpack.unpackb(decom(raw_obj), raw=False, strict_map_key=False)
        return raw_obj

    if len(objs) == 1:
        return one(objs[0])
    return [one(o) for o in objs]


def dump_json(path: Path, obj: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def http_get(url: str, *, headers: Optional[dict] = None, stream: bool = False, timeout: int = 60) -> requests.Response:
    last: Optional[Exception] = None
    for attempt in range(RETRIES):
        try:
            r = SESSION.get(url, headers=headers, stream=stream, timeout=timeout)
            r.raise_for_status()
            return r
        except Exception as e:
            last = e
            if attempt + 1 == RETRIES:
                break
    raise RuntimeError(f"GET failed {url}: {last}")


def download_file(url: str, dest: Path, expected_size: int = 0) -> bool:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.exists() and expected_size > 0 and dest.stat().st_size == expected_size:
        return True
    if dest.exists() and expected_size <= 0 and dest.stat().st_size > 0:
        return True

    for attempt in range(RETRIES):
        try:
            headers = {}
            mode = "wb"
            pos = 0
            if dest.exists() and expected_size > 0:
                pos = dest.stat().st_size
                if pos == expected_size:
                    return True
                if pos > expected_size:
                    dest.unlink()
                    pos = 0
                elif pos > 0:
                    headers["Range"] = f"bytes={pos}-"
                    mode = "ab"

            r = SESSION.get(url, headers=headers, stream=True, timeout=60)
            if r.status_code == 200:
                mode, pos = "wb", 0
            elif r.status_code != 206:
                r.raise_for_status()

            with dest.open(mode) as f:
                for chunk in r.iter_content(1024 * 256):
                    if chunk:
                        f.write(chunk)

            if expected_size > 0 and dest.stat().st_size != expected_size:
                raise ValueError(f"size {dest.stat().st_size} != {expected_size}")
            return True
        except Exception as e:
            if attempt + 1 == RETRIES:
                console.print(f"[red]下载失败[/] {url}: {e}")
                if dest.exists():
                    dest.unlink(missing_ok=True)
                return False
    return False


def fetch_env() -> dict[str, Any]:
    r = http_get(urljoin(API_BASE, ENV_PATH), headers={"Accept": "application/json"})
    body = r.json()
    if body.get("errors"):
        raise RuntimeError(f"EnvConfiguration errors: {body['errors']}")
    env = body["result"]
    dump_json(MASTER_DIR / "EnvConfiguration.json", env)
    console.print(f"[green]Env[/] assets={env.get('assetsUrl')} adult={env.get('isAdult')}")
    return env


def rating_folder(env: dict[str, Any], override: Optional[str] = None) -> str:
    if override:
        return override
    # EntryProcess / AddressablesKeyProvider：成人档用 X，普通用 N
    return "X" if env.get("isAdult") else "N"


def bundle_base(env: dict[str, Any], rating: str, platform: str) -> str:
    base = env["assetsUrl"].rstrip("/") + "/"
    return f"{base}{rating}/{platform}/"


def direct_base(env: dict[str, Any], rating: str) -> str:
    base = env["staticContentUrl"].rstrip("/") + "/"
    return f"{base}{rating}/"


def sync_catalogs(cdn_base: str, names: Iterable[str] = CATALOGS) -> dict[str, Path]:
    CATALOG_DIR.mkdir(parents=True, exist_ok=True)
    out: dict[str, Path] = {}
    for name in names:
        hash_url = f"{cdn_base}{name}.hash"
        bin_url = f"{cdn_base}{name}.bin"
        hash_path = CATALOG_DIR / f"{name}.hash"
        bin_path = CATALOG_DIR / f"{name}.bin"
        json_path = CATALOG_DIR / f"{name}.json"

        remote_hash = http_get(hash_url).text.strip()
        local_hash = hash_path.read_text().strip() if hash_path.exists() else ""
        need = remote_hash != local_hash or not bin_path.exists()
        if need:
            console.print(f"[cyan]catalog[/] {name} {remote_hash}")
            if not download_file(bin_url, bin_path):
                raise RuntimeError(f"catalog bin failed: {name}")
            hash_path.write_text(remote_hash + "\n", encoding="utf-8")
        else:
            console.print(f"[dim]catalog skip[/] {name}")

        reader = UnityCatalogReader(str(bin_path))
        reader.export_to_json(str(json_path), flat_structure=True)
        out[name] = bin_path
        console.print(f"  → {len(reader.get_asset_list())} locations")
    return out


def collect_remote_bundles(catalog_paths: dict[str, Path]) -> tuple[dict[str, int], list[dict[str, Any]]]:
    """返回 {bundle_name: size} 与 logical_map 条目。"""
    bundles: dict[str, int] = {}
    logical: list[dict[str, Any]] = []
    seen_logical: set[str] = set()

    for cat, path in catalog_paths.items():
        reader = UnityCatalogReader(str(path))
        for asset in reader.get_asset_list():
            iid = asset["internal_id"]
            pk = str(asset["primary_key"])
            provider = asset["provider_id"]

            if "AssetBundleProvider" in provider and RLP_MARK in iid:
                name = pk if pk.endswith(".bundle") else iid.split("/")[-1]
                size = int(asset.get("bundle_size") or 0)
                bundles[name] = max(bundles.get(name, 0), size)

            if "BundledAssetProvider" in provider and ("/" in pk or pk.startswith("GameUi")):
                deps = []
                for dep in asset.get("dependencies") or []:
                    di = dep.get("internal_id") or ""
                    if RLP_MARK in di:
                        deps.append(dep.get("primary_key") or di.split("/")[-1])
                if deps and pk not in seen_logical:
                    seen_logical.add(pk)
                    logical.append(
                        {
                            "key": pk,
                            "catalog": cat,
                            "internal_id": iid,
                            "bundles": deps,
                            "resource_type": (asset.get("resource_type") or {}).get("class_name"),
                        }
                    )
    return bundles, logical


def sync_bundles(cdn_base: str, bundles: dict[str, int], workers: int = MAX_WORKERS) -> None:
    BUNDLE_DIR.mkdir(parents=True, exist_ok=True)
    items = sorted(bundles.items())
    if not items:
        console.print("[yellow]无远程 bundle[/]")
        return

    ok = fail = 0
    lock = threading.Lock()

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("bundles", total=len(items))

        def one(name: str, size: int) -> None:
            nonlocal ok, fail
            dest = BUNDLE_DIR / name
            url = f"{cdn_base}{name}"
            good = download_file(url, dest, expected_size=size)
            with lock:
                if good:
                    ok += 1
                else:
                    fail += 1
                progress.advance(task)

        with ThreadPoolExecutor(max_workers=workers) as ex:
            futs = [ex.submit(one, n, s) for n, s in items]
            for f in as_completed(futs):
                f.result()

    console.print(f"[green]bundles[/] ok={ok} fail={fail} dir={BUNDLE_DIR}")


def maybe_extract_logical(logical: list[dict[str, Any]], limit: int = 0) -> None:
    """可选：用 UnityPy 按逻辑 key 从依赖 bundle 抽出对象到 Assets/Logical/…"""
    try:
        import UnityPy
        from UnityPy.enums import ClassIDType
    except ImportError:
        console.print("[yellow]未安装 UnityPy，跳过逻辑目录解包。pip install UnityPy[/]")
        return

    UnityPy.config.FALLBACK_UNITY_VERSION = "6000.0.59f2"
    entries = logical if limit <= 0 else logical[:limit]
    out_root = ASSETS_DIR / "Logical"
    n = 0

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("extract", total=len(entries))
        for entry in entries:
            key = entry["key"]
            dest_dir = out_root / key
            # 已有内容则跳过
            if dest_dir.exists() and any(dest_dir.iterdir()):
                progress.advance(task)
                continue

            loaded = False
            for bname in entry.get("bundles") or []:
                bpath = BUNDLE_DIR / bname
                if not bpath.exists():
                    continue
                try:
                    env = UnityPy.load(str(bpath))
                except Exception:
                    continue
                for obj in env.objects:
                    if obj.type in (
                        ClassIDType.Texture2D,
                        ClassIDType.Sprite,
                        ClassIDType.TextAsset,
                        ClassIDType.AudioClip,
                        ClassIDType.GameObject,
                    ):
                        try:
                            data = obj.read()
                        except Exception:
                            continue
                        name = getattr(data, "name", None) or getattr(data, "m_Name", None) or str(obj.path_id)
                        dest_dir.mkdir(parents=True, exist_ok=True)
                        # ponytail: 粗暴按类型落盘，复杂 Prefab 仅存 JSON 壳；升级路径=按 Addressables internal_id 精确匹配
                        if obj.type == ClassIDType.Texture2D:
                            try:
                                data.image.save(str(dest_dir / f"{name}.png"))
                                loaded = True
                            except Exception:
                                pass
                        elif obj.type == ClassIDType.TextAsset:
                            raw = getattr(data, "script", None) or getattr(data, "m_Script", b"")
                            if isinstance(raw, str):
                                raw = raw.encode("utf-8", errors="surrogateescape")
                            (dest_dir / f"{name}.txt").write_bytes(raw or b"")
                            loaded = True
                        elif obj.type == ClassIDType.AudioClip:
                            # UnityPy 导出音频因版本而异，有则写
                            samples = getattr(data, "samples", None)
                            if isinstance(samples, dict):
                                for fn, blob in samples.items():
                                    (dest_dir / fn).write_bytes(blob)
                                    loaded = True
                if loaded:
                    break
            if loaded:
                n += 1
            progress.advance(task)

    console.print(f"[green]Logical extract[/] wrote≈{n} → {out_root}")

def _maybe_gunzip(data: bytes) -> bytes:
    if len(data) >= 2 and data[0] == 0x1F and data[1] == 0x8B:
        return gzip.decompress(data)
    return data


def fetch_direct(url: str, dest: Path, *, quiet_404: bool = True) -> bool:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.exists() and dest.stat().st_size > 0:
        return True
    try:
        r = SESSION.get(url, timeout=60, headers={**SESSION.headers, "Accept-Encoding": "identity"})
        if r.status_code == 404:
            if not quiet_404:
                console.print(f"[dim]404[/] {url}")
            return False
        r.raise_for_status()
        dest.write_bytes(_maybe_gunzip(r.content))
        return True
    except Exception as e:
        console.print(f"[red]direct fail[/] {url}: {e}")
        return False


def collect_direct_jobs(master_by_type: dict[str, list[dict]], astc: bool = True) -> list[tuple[str, str]]:
    tex = "ASTC" if astc else "DDS"
    jobs: list[tuple[str, str]] = []
    seen: set[str] = set()

    def add(cdn_rel: str, local_rel: Optional[str] = None) -> None:
        local_rel = local_rel or cdn_rel
        if local_rel.endswith(".gz"):
            local_rel = local_rel[:-3]
        if cdn_rel not in seen:
            seen.add(cdn_rel)
            jobs.append((cdn_rel, local_rel))

    for rel in DIRECT_FIXED:
        if rel.startswith("GZ/"):
            add(f"{rel}.gz" if not rel.endswith(".gz") else rel, rel)
        else:
            add(rel, rel)

    for row in master_by_type.get("BannerMaster", []):
        path = row.get("ImageStaticPath")
        if not path:
            continue
        jt = str(row.get("JumpType") or "")
        prefix = DIRECT_BANNER_PREFIX.get(jt, "ImageFiles/Banners/Gacha/")
        if path == "Information":
            prefix = "ImageFiles/Banners/Functional/"
        rel = f"{tex}/{prefix}{path}.astc.gz"
        add(rel, f"{tex}/{prefix}{path}.astc")

    for row in master_by_type.get("LoginBonusMaster", []):
        for field, folder in (
            ("BackgroundAssetId", "ImageFiles/Backgrounds/LoginBonus/"),
            ("AssetId", "ImageFiles/Logos/LoginBonus/"),
        ):
            aid = row.get(field)
            if aid is None or aid == "":
                continue
            rel = f"{tex}/{folder}{aid}.astc.gz"
            add(rel, f"{tex}/{folder}{aid}.astc")

    for row in master_by_type.get("GachaMaster", []):
        for field, folder in (
            ("BannerAssetId", "ImageFiles/Banners/Gacha/"),
            ("LogoAssetId", "ImageFiles/Logos/Gacha/"),
        ):
            aid = row.get(field)
            if not aid:
                continue
            rel = f"{tex}/{folder}{aid}.astc.gz"
            add(rel, f"{tex}/{folder}{aid}.astc")
        # GachaBackgroundTypes.DirectAssetTexture = 4
        if row.get("BackgroundAssetType") in (4, "DirectAssetTexture") and row.get("BackgroundAssetId"):
            aid = row["BackgroundAssetId"]
            rel = f"{tex}/ImageFiles/Backgrounds/Gacha/{aid}.astc.gz"
            add(rel, f"{tex}/ImageFiles/Backgrounds/Gacha/{aid}.astc")

    for row in master_by_type.get("EventMaster", []):
        aid = row.get("LogoAssetId")
        if aid:
            rel = f"{tex}/ImageFiles/Logos/Event/{aid}.astc.gz"
            add(rel, f"{tex}/ImageFiles/Logos/Event/{aid}.astc")

    return jobs


def sync_direct(cdn_base: str, jobs: list[tuple[str, str]], workers: int = MAX_WORKERS) -> None:
    if not jobs:
        return
    ok = fail = 0
    lock = threading.Lock()
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("direct", total=len(jobs))

        def one(cdn_rel: str, local_rel: str) -> None:
            nonlocal ok, fail
            url = f"{cdn_base}{cdn_rel}"
            dest = DIRECT_DIR / local_rel
            good = fetch_direct(url, dest)
            with lock:
                ok += int(good)
                fail += int(not good)
                progress.advance(task)

        with ThreadPoolExecutor(max_workers=workers) as ex:
            futs = [ex.submit(one, a, b) for a, b in jobs]
            for f in as_completed(futs):
                f.result()
    console.print(f"[green]direct[/] ok={ok} fail={fail} (404 计入 fail，可忽略)")


def fetch_master_manifest(token: str) -> dict[str, Any]:
    headers = {
        **DEFAULT_HEADERS,
        "Accept": "application/vnd.msgpack",
        "Authorization": f"Bearer {token}",
    }
    r = http_get(urljoin(API_BASE, MASTER_API_PATH), headers=headers)
    objs = unpack_msgpack_root(r.content)
    if isinstance(objs, list) and len(objs) >= 2:
        data = objs[1]
    else:
        data = objs
    if not (isinstance(data, list) and len(data) >= 4):
        raise RuntimeError(f"unexpected master manifest: {data!r}")
    manifest = {
        "Uri": data[0],
        "SasToken": data[1],
        "Version": data[2],
        "PublishTimestamp": data[3],
    }
    dump_json(MASTER_DIR / "_manifest.json", manifest)
    return manifest


def download_master_bin(env: dict[str, Any], manifest: dict[str, Any], dest: Path) -> Path:
    url = env["masterDataUrl"].rstrip("/") + "/" + manifest["Uri"] + manifest["SasToken"]
    console.print(f"[cyan]master bin[/] {manifest['Uri']}")
    if not download_file(url, dest):
        raise RuntimeError("masterdata download failed")
    return dest


def export_master_tables(records: list[Any], version: Any) -> dict[str, list[dict]]:
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    by: dict[str, list[dict]] = defaultdict(list)
    unknown = 0
    for r in records:
        if isinstance(r, dict) and "type" in r:
            t = r["type"]
            by[t].append({k: v for k, v in r.items() if k != "type"})
        else:
            unknown += 1
            by["_unknown"].append(r if not isinstance(r, dict) else r)

    keep = {f"{t}.json" for t in by} | {"_package.json", "_manifest.json", "EnvConfiguration.json"}
    for p in MASTER_DIR.glob("*.json"):
        if p.name not in keep:
            p.unlink()

    for t, rows in by.items():
        dump_json(MASTER_DIR / f"{t}.json", rows)

    dump_json(
        MASTER_DIR / "_package.json",
        {"version": version, "tables": sorted(by), "row_count": sum(len(v) for v in by.values()), "unknown": unknown},
    )
    dump_json(ROOT / "MasterData.json", [records, version])
    console.print(f"[green]MasterData[/] tables={len(by)} version={version} → {MASTER_DIR}")
    return by


def process_master_bin(path: Path) -> dict[str, list[dict]]:
    data = path.read_bytes()
    unpacker = msgpack.Unpacker(raw=True, strict_map_key=False)
    unpacker.feed(data)
    root = next(unpacker)
    if (
        isinstance(root, list)
        and len(root) > 1
        and isinstance(root[0], msgpack.ExtType)
        and root[0].code == 98
    ):
        payload = decom(root)
        obj = msgpack.unpackb(payload, raw=False, strict_map_key=False)
    else:
        obj = msgpack.unpackb(data, raw=False, strict_map_key=False)
    restored = conv(restore(obj))
    if not (isinstance(restored, list) and len(restored) >= 2):
        raise RuntimeError("bad master package")
    return export_master_tables(restored[0], restored[1])


def main() -> None:
    ap = argparse.ArgumentParser(description="MuvLuv Girls Garden X asset/master sync")
    ap.add_argument("--token", default=os.environ.get("MLGGX_TOKEN", ""), help="Bearer JWT（拉 master 清单）")
    ap.add_argument("--master-bin", type=Path, help="本地 masterdata.bin，跳过下载")
    ap.add_argument("--rating", choices=("X", "N"), help="覆盖 X/N 目录")
    ap.add_argument("--platform", default="Android", choices=("Android", "iOS"))
    ap.add_argument("--catalogs", default=",".join(CATALOGS), help="逗号分隔 catalog 名")
    ap.add_argument("--skip-bundles", action="store_true")
    ap.add_argument("--skip-direct", action="store_true")
    ap.add_argument("--skip-master", action="store_true")
    ap.add_argument("--extract", action="store_true", help="UnityPy 按逻辑 key 解包（慢）")
    ap.add_argument("--extract-limit", type=int, default=0, help="解包条数上限，0=全部")
    ap.add_argument("--workers", type=int, default=MAX_WORKERS)
    ap.add_argument("--dds", action="store_true", help="Direct 纹理用 DDS/ 而非 ASTC/")
    args = ap.parse_args()

    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    MASTER_DIR.mkdir(parents=True, exist_ok=True)

    env = fetch_env()
    rating = rating_folder(env, args.rating)
    bbase = bundle_base(env, rating, args.platform)
    dbase = direct_base(env, rating)
    console.print(f"[blue]bundle CDN[/] {bbase}")
    console.print(f"[blue]direct CDN[/] {dbase}")

    master_by: dict[str, list[dict]] = {}
    if not args.skip_master:
        bin_path = args.master_bin
        if bin_path is None:
            bin_path = MASTER_DIR / "masterdata.bin"
            if args.token:
                manifest = fetch_master_manifest(args.token)
                download_master_bin(env, manifest, bin_path)
            elif bin_path.exists():
                console.print(f"[yellow]使用已有[/] {bin_path}")
            else:
                man_path = MASTER_DIR / "_manifest.json"
                if man_path.exists():
                    manifest = json.loads(man_path.read_text(encoding="utf-8"))
                    download_master_bin(env, manifest, bin_path)
                else:
                    console.print("[yellow]无 --token / --master-bin / _manifest.json，跳过 Master[/]")
                    bin_path = None
        if bin_path and bin_path.exists():
            master_by = process_master_bin(bin_path)

    cat_names = [c.strip() for c in args.catalogs.split(",") if c.strip()]
    catalog_paths = sync_catalogs(bbase, cat_names)
    bundles, logical = collect_remote_bundles(catalog_paths)
    dump_json(LOGICAL_MAP_PATH, {"count": len(logical), "entries": logical})
    console.print(f"[green]logical keys[/] {len(logical)} remote bundles={len(bundles)}")

    if not args.skip_bundles:
        sync_bundles(bbase, bundles, workers=args.workers)

    if args.extract:
        maybe_extract_logical(logical, limit=args.extract_limit)

    if not args.skip_direct:
        if not master_by and (MASTER_DIR / "BannerMaster.json").exists():
            for p in MASTER_DIR.glob("*.json"):
                if p.name.startswith("_"):
                    continue
                master_by[p.stem] = json.loads(p.read_text(encoding="utf-8"))
        jobs = collect_direct_jobs(master_by, astc=not args.dds)
        sync_direct(dbase, jobs, workers=args.workers)

    console.print("[bold green]done[/]")


if __name__ == "__main__":
    main()
