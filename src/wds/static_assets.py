"""Backup of CDN static assets (Home/Gacha/Event/Notification banners, ...).

These live outside the Addressables catalogs under

    {asset_url}/static-assets/Resources/Textures/Banners/{category}/{name}.astc.gz

and are publicly readable (verified).  The path list is collected from:

  * master data tables (the full history, not just current banners):
      BannerMaster.ImagePath                  -> Banners/{ImagePath}
      GachaMaster.Id                          -> Banners/Gacha/{id}
      StoryEventMaster.ExchangeShopMasterId   -> Banners/Event/{id}
  * GET /api/Home/GetNotificationsAsync -> result[].bannerPath
    (e.g. "Home/11", "Notification/1" -> Banners/{bannerPath}.astc.gz)

URL rules come from the client (IDA): StaticImageLoader builds
{StaticContentUrl}/{StaticImagePaths.*}/{key}{.astc}{.gz} where
StaticContentUrl = Environment.static_content_url.  The CDN also keeps a
plain PNG variant for most banners ({key}.png), which the game's debug/web
side uses (verified: Home/11, Gacha/1165, Event/20001, Notification/1).

Downloads use the same local-first / retry pattern as fetch-scenes and write
a manifest.json next to the files.
"""

from __future__ import annotations

import json
import os
import re
import time
import concurrent.futures as _futures
import urllib.request
from pathlib import Path
from typing import Any

from .scenes import download_scene
from .story import StorySession


STATIC_ASSETS_PREFIX = "static-assets/Resources/Textures/Banners"
_STORAGE_PREFIX = "static-assets/Resources/Textures/"


def collect_paths_from_har(har_files: list[str | os.PathLike[str]]) -> list[str]:
    """Unique /static-assets/ paths (relative to the asset root) from HARs."""
    paths: set[str] = set()
    for f in har_files:
        try:
            data = json.loads(Path(f).read_text(encoding="utf-8"))
        except Exception:  # noqa: BLE001
            continue
        for entry in data.get("log", {}).get("entries", []):
            url = entry.get("request", {}).get("url", "")
            marker = "/static-assets/"
            idx = url.find(marker)
            if idx < 0:
                continue
            rel = url[idx + 1:].split("?", 1)[0]
            paths.add(rel)
    return sorted(paths)


def collect_paths_from_notifications(session: StorySession) -> list[str]:
    """Banner paths from GET /api/Home/GetNotificationsAsync.

    Result rows are [id, bannerPath, title, ...]; each maps to
    {STATIC_ASSETS_PREFIX}/{bannerPath}.astc.gz.
    """
    payloads = session.post_bytes("/api/Home/GetNotificationsAsync", b"")
    paths: set[str] = set()
    result = payloads[1] if len(payloads) > 1 else []
    for row in result:
        if (
            isinstance(row, list)
            and len(row) >= 2
            and isinstance(row[1], str)
            and row[1]
        ):
            paths.add(f"{STATIC_ASSETS_PREFIX}/{row[1]}.astc.gz")
            paths.add(f"{STATIC_ASSETS_PREFIX}/{row[1]}.png")
    return sorted(paths)


def collect_paths_from_notification_contents(
    api_base: str = "https://lb-api.wds-stellarium.com",
) -> list[str]:
    """Static refs inside anonymous notification bodies.

    GET /api/Home/GetNotificationsInTitleAsync (no auth) lists every
    notification; each content body embeds asset keys like
    "Information/1860" or "Home/Banner01616".  These cover the otherwise
    unknown Information id set.
    """
    def get(path: str) -> dict[str, Any]:
        req = urllib.request.Request(
            api_base + path, headers={"User-Agent": "BestHTTP/2 v2.8.5"}
        )
        with urllib.request.urlopen(req, timeout=30) as resp:
            return json.loads(resp.read())

    paths: set[str] = set()
    try:
        rows = (get("/api/Home/GetNotificationsInTitleAsync").get("result") or [])
        for row in rows:
            nid = row.get("id")
            if nid is None:
                continue
            try:
                content = get(f"/api/Home/GetNotificationsInTitleAsync/{nid}")
            except Exception:  # noqa: BLE001
                continue
            body = (content.get("result") or {}).get("body") or ""
            for m in re.finditer(
                r'"(Home|Event|Gacha|Information|Notification|EventBonus|'
                r'Help|Comic|JewelShop|HomePoster)/[^"\\]+',
                body,
            ):
                key = m.group(0).strip('"')
                paths.add(f"static-assets/Resources/Textures/Banners/{key}.astc.gz")
                paths.add(f"static-assets/Resources/Textures/Banners/{key}.png")
    except Exception as ex:  # noqa: BLE001
        print(f"[-] notification content scan failed: {type(ex).__name__}: {ex}")
    return sorted(paths)


def collect_paths_from_masterdata(
    masterdata_dir: str | os.PathLike[str] = "masterdata/tables",
) -> list[str]:
    """Static asset paths derived from master data (historical coverage).

    These keys are what the game feeds into StaticImagePaths (IDA):
      * BannerMaster.ImagePath -> Resources/Textures/Banners/{ImagePath}
      * GachaMaster.Id         -> Resources/Textures/Banners/Gacha/{id}
      * StoryEventMaster.ExchangeShopMasterId
                               -> Resources/Textures/Banners/Event/{id}
      * TrialPartyEventMaster.Id
                               -> Resources/Textures/Banners/Information/{id}
      * StoryEventMaster.Id    -> Resources/Textures/EventBonus/{id}
      * ComicMaster episodes   -> Resources/Textures/Comic/{key}.png
    """
    base = Path(masterdata_dir)
    paths: set[str] = set()

    def add(category: str, key: str) -> None:
        parts = [
            p for p in (
                "static-assets", "Resources", "Textures", "Banners",
                category,
            ) if p
        ]
        prefix = "/".join(parts)
        paths.add(f"{prefix}/{key}.astc.gz")
        paths.add(f"{prefix}/{key}.png")

    banner = base / "BannerMaster.json"
    if banner.exists():
        for r in json.loads(banner.read_text(encoding="utf-8")):
            v = r.get("ImagePath")
            if isinstance(v, str) and v:
                add("", v)

    gacha = base / "GachaMaster.json"
    if gacha.exists():
        for r in json.loads(gacha.read_text(encoding="utf-8")):
            if isinstance(r.get("Id"), int):
                add("Gacha", str(r["Id"]))

    event = base / "StoryEventMaster.json"
    if event.exists():
        for r in json.loads(event.read_text(encoding="utf-8")):
            v = r.get("ExchangeShopMasterId")
            if isinstance(v, int):
                add("Event", str(v))

    info = base / "TrialPartyEventMaster.json"
    if info.exists():
        for r in json.loads(info.read_text(encoding="utf-8")):
            if isinstance(r.get("Id"), int):
                add("Information", str(r["Id"]))

    bonus = base / "StoryEventMaster.json"
    if bonus.exists():
        for r in json.loads(bonus.read_text(encoding="utf-8")):
            if isinstance(r.get("Id"), int):
                prefix = "static-assets/Resources/Textures/EventBonus"
                paths.add(f"{prefix}/{r['Id']}.astc.gz")
                paths.add(f"{prefix}/{r['Id']}.png")

    comic = base / "ComicMaster.json"
    if comic.exists():
        import re as _re

        for r in json.loads(comic.read_text(encoding="utf-8")):
            for ep in r.get("Episodes") or []:
                if isinstance(ep, list) and len(ep) > 3 and isinstance(ep[3], str):
                    m = _re.search(r'"Data":"([^"]+)"', ep[3])
                    if m:
                        paths.add(
                            f"static-assets/Resources/Textures/Comic/"
                            f"{m.group(1)}.png"
                        )

    return sorted(paths)


def _storage_rel(rel: str) -> str:
    """Strip the CDN prefix so files land under out_dir/Banners/..."""
    return rel.removeprefix(_STORAGE_PREFIX)


def backup_static_assets(
    asset_url: str,
    paths: list[str],
    *,
    out_dir: str | os.PathLike[str] = "static_assets",
    concurrency: int = 4,
    force: bool = False,
) -> dict[str, Any]:
    """Download every static asset path, skipping files already on disk."""
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    base = asset_url.rstrip("/")

    local: set[str] = set()
    if not force and out.is_dir():
        for root, _dirs, files in os.walk(out):
            for name in files:
                if name == "manifest.json":
                    continue
                local.add(os.path.relpath(os.path.join(root, name), out))

    prev: dict[str, str] = {}
    manifest_path = out / "manifest.json"
    if manifest_path.exists():
        try:
            prev = json.loads(
                manifest_path.read_text(encoding="utf-8")
            ).get("files", {})
        except Exception:  # noqa: BLE001
            prev = {}

    manifest: dict[str, str] = {}
    ok = existing = errors = known_404 = 0
    errors_list: list[tuple[str, str]] = []
    started = time.time()

    pending: list[str] = []
    for rel in paths:
        dest_rel = _storage_rel(rel)
        if dest_rel in local:
            manifest[rel] = "exists"
            existing += 1
            continue
        if not force and prev.get(rel, "").startswith("err:HTTPError"):
            manifest[rel] = prev[rel]
            known_404 += 1
            continue
        pending.append(rel)

    def one(rel: str) -> tuple[str, str]:
        try:
            download_scene(f"{base}/{rel}", out / _storage_rel(rel))
            return rel, "ok"
        except Exception as ex:  # noqa: BLE001
            return rel, f"err:{type(ex).__name__}:{ex}"

    done = 0
    with _futures.ThreadPoolExecutor(max_workers=max(1, concurrency)) as pool:
        futures = {pool.submit(one, rel): rel for rel in pending}
        for future in _futures.as_completed(futures):
            rel, status = future.result()
            done += 1
            manifest[rel] = status
            if status == "ok":
                ok += 1
            else:
                errors += 1
                errors_list.append((rel, status))
            if done % 200 == 0 or done == len(pending):
                print(
                    f"[*] {done}/{len(pending)} ok={ok} err={errors} "
                    f"({round(time.time() - started, 1)}s)"
                )

    summary = {
        "count": len(paths),
        "fetched": ok,
        "existing": existing,
        "known404": known_404,
        "errors": errors,
        "elapsed_seconds": round(time.time() - started, 1),
        "files": manifest,
    }
    (out / "manifest.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    print(
        f"[*] static assets: total={len(paths)} ok={ok} "
        f"exists={existing} known404={known_404} err={errors}"
    )
    for rel, err in errors_list[:10]:
        print(f"    {rel}: {err[:120]}")
    return summary
