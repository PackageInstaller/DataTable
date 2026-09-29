"""Full asset bundle download / update for the Addressables catalogs.

The game keeps three Addressables catalogs (verified with IDA against
AddressablesConst.AssetType / AddressablesUtility):

    https://assets-e.wds-stellarium.com/production/{type}-assets/Android/{ver}/
        catalog_{ver}.json        <- Addressables catalog (JSON)
        catalog_{ver}.hash        <- 24-byte binary hash (not used for update)

Catalog JSON parse (via UnityCatalogReader) yields per-bundle entries with
primary_key like "<group>/<name>_<contentHash>.bundle".  The game downloads
each bundle at (IDA: AddressablesUtility.ToAssetPath + DownloadAssetBundleDataAsync):

    {asset_url}/{type}-assets/Android/{version}/{group}/{name}.bundle

i.e. the primary_key with the content-hash stripped.

Update detection (per user): compare the catalog JSON's md5 with the last
downloaded one; when it changes, diff per-bundle content hashes and fetch
only new/changed bundles.
"""

from __future__ import annotations

import concurrent.futures as _futures
import hashlib
import json
import os
import sys
import time
import urllib.error
import urllib.request
from dataclasses import dataclass
from pathlib import Path
from typing import Any

from .api import EnvironmentResult


ASSET_TYPES = ("2d-assets", "cri-assets", "3d-assets")
USER_AGENT = "BestHTTP/2 v2.8.5"


@dataclass(frozen=True)
class CatalogInfo:
    asset_type: str
    version: str
    catalog_url: str


@dataclass(frozen=True)
class BundleEntry:
    download_path: str  # <group>/<name>.bundle (hash stripped)
    content_hash: str   # <contentHash> from primary_key
    size: int


def catalog_infos(env: EnvironmentResult) -> list[CatalogInfo]:
    """The three catalog URLs for the current environment."""
    base = env.asset_url.rstrip("/")
    ver = env.asset_version
    return [
        CatalogInfo(
            asset_type=t,
            version=ver,
            catalog_url=(
                f"{base}/{t}/Android/{ver}/catalog_{ver}.json"
            ),
        )
        for t in ASSET_TYPES
    ]


def _http_get(url: str, timeout: int = 120, attempts: int = 4) -> bytes:
    req = urllib.request.Request(url, headers={"user-agent": USER_AGENT})
    for i in range(attempts):
        try:
            with urllib.request.urlopen(req, timeout=timeout) as resp:
                return resp.read()
        except (urllib.error.URLError, TimeoutError, OSError):
            if i == attempts - 1:
                raise
            time.sleep(3 + 2 * i)
    raise RuntimeError("unreachable")


def md5_hex(data: bytes) -> str:
    return hashlib.md5(data).hexdigest()


def download_catalog(
    info: CatalogInfo,
    out_dir: str | os.PathLike[str],
    *,
    force: bool = False,
) -> tuple[Path, str]:
    """Download a catalog JSON; returns (path, md5)."""
    dest = Path(out_dir) / info.asset_type / info.version / f"catalog_{info.version}.json"
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.exists() and not force:
        return dest, md5_hex(dest.read_bytes())
    data = _http_get(info.catalog_url)
    dest.write_bytes(data)
    return dest, md5_hex(data)


def load_bundles(catalog_json: str | os.PathLike[str]) -> list[BundleEntry]:
    """Parse a catalog JSON with UnityCatalogReader and collect bundles."""
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
    from UnityCatalogReader import UnityCatalogReader  # type: ignore

    reader = UnityCatalogReader(str(catalog_json))
    assets = reader.get_asset_list()
    seen: dict[str, BundleEntry] = {}
    for a in assets:
        internal = a.get("internal_id", "")
        pk = a.get("primary_key", "")
        if not (internal.startswith("http") and pk.endswith(".bundle")):
            continue
        # primary_key = "<group>/<name>_<contentHash>.bundle"
        idx = pk.rfind("_")
        if idx <= 0:
            continue
        download_path = pk[:idx] + ".bundle"
        content_hash = pk[idx + 1 : -len(".bundle")]
        entry = BundleEntry(
            download_path=download_path,
            content_hash=content_hash,
            size=int(a.get("bundle_size") or 0),
        )
        # keep the largest size when duplicate paths appear
        prev = seen.get(download_path)
        if prev is None or entry.size > prev.size:
            seen[download_path] = entry
    return sorted(seen.values(), key=lambda e: e.download_path)


def bundle_url(info: CatalogInfo, entry: BundleEntry) -> str:
    base = info.catalog_url.rsplit("/", 1)[0]
    return f"{base}/{entry.download_path}"


def _download_one(
    info: CatalogInfo,
    entry: BundleEntry,
    out_dir: str | os.PathLike[str],
    state: dict[str, str],
    *,
    force: bool = False,
) -> tuple[str, str]:
    """Download one bundle; returns (download_path, status)."""
    dest = (
        Path(out_dir) / info.asset_type / info.version / entry.download_path
    )
    if not force and dest.exists():
        if state.get(entry.download_path) == entry.content_hash:
            return entry.download_path, "exists"
        # hash mismatch -> redownload below
    data = _http_get(bundle_url(info, entry))
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(data)
    return entry.download_path, "ok"


def update_assets(
    env: EnvironmentResult,
    *,
    out_dir: str | os.PathLike[str] = "assets",
    concurrency: int = 8,
    force: bool = False,
    types: tuple[str, ...] = ASSET_TYPES,
) -> dict[str, Any]:
    """Download catalogs, diff by md5/hash and fetch new bundles."""
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    manifest_path = out / "manifest.json"
    manifest: dict[str, Any] = {}
    if manifest_path.exists():
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))

    summary: dict[str, Any] = {}
    for info in catalog_infos(env):
        if info.asset_type not in types:
            continue
        started = time.time()
        catalog_path, catalog_md5 = download_catalog(
            info, out, force=force
        )
        prev = manifest.get("catalogs", {}).get(info.asset_type, {})
        changed = force or prev.get("md5") != catalog_md5
        if not changed:
            summary[info.asset_type] = {
                "status": "unchanged",
                "bundles": 0,
                "bytes": 0,
            }
            continue

        bundles = load_bundles(catalog_path)
        state: dict[str, str] = {}
        for b in bundles:
            state[b.download_path] = b.content_hash
        old_state = prev.get("bundles", {})
        todo = [
            b for b in bundles
            if force or old_state.get(b.download_path) != b.content_hash
        ]
        done = 0
        ok_count = 0
        errors: list[tuple[str, str]] = []
        total_bytes = 0

        def one(b: BundleEntry) -> tuple[str, str]:
            nonlocal total_bytes
            try:
                path, status = _download_one(
                    info, b, out, old_state, force=force
                )
                return path, status
            except Exception as ex:  # noqa: BLE001
                return b.download_path, f"err:{type(ex).__name__}"

        with _futures.ThreadPoolExecutor(max_workers=max(1, concurrency)) as pool:
            futures = [pool.submit(one, b) for b in todo]
            for future in _futures.as_completed(futures):
                path, status = future.result()
                done += 1
                if status == "ok":
                    ok_count += 1
                    total_bytes += sum(
                        b.size for b in bundles if b.download_path == path
                    )
                elif status.startswith("err"):
                    errors.append((path, status))
                if done % 200 == 0 or done == len(todo):
                    print(
                        f"[{info.asset_type}] {done}/{len(todo)} "
                        f"ok={ok_count} err={len(errors)}"
                    )

        manifest.setdefault("catalogs", {})[info.asset_type] = {
            "version": info.version,
            "md5": catalog_md5,
            "updated_at": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
            "bundles": state,
            "bundle_count": len(bundles),
        }
        manifest_path.write_text(
            json.dumps(manifest, ensure_ascii=False, indent=2),
            encoding="utf-8",
        )
        summary[info.asset_type] = {
            "status": "updated" if (done or changed) else "unchanged",
            "bundles": ok_count,
            "bytes": total_bytes,
            "errors": len(errors),
            "elapsed_seconds": round(time.time() - started, 1),
        }
        if errors:
            summary[info.asset_type]["error_samples"] = errors[:5]
    return summary
