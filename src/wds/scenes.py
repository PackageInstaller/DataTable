"""Story scene bin discovery and bulk download.

How a scene asset URL is produced (verified against the game + HAR):

  * the master data tables do NOT contain the scene path/hash;
  * the server issues it per episode:
        POST /api/Episodes/{episodeId}/GetDetails
        -> EpisodeResult [EpisodeTitle, StoryType, EpisodeOrder, EpisodeDetailAssetSource]
  * EpisodeDetailAssetSource = "scenes/<episodeId>_<contentHash>.bin?<Azure SAS>"
    (the hash and SAS are server-side; the SAS makes the URL self-sufficient)
  * full URL = Environment.MasterDataUrl + "/" + EpisodeDetailAssetSource
    e.g. https://assets-e.wds-stellarium.com/master-data/production/scenes/2077_....bin?sv=...
  * the CDN answers with NO special headers (the SAS in the URL is enough);
    locked episodes (not yet unlocked in the account) return HTTP 400 EPI001.
"""

from __future__ import annotations

import concurrent.futures as _futures
import json
import os
import time
import urllib.error
import urllib.request
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from . import codec
from .api import ApiClient, ApiError
from .login import LoginService
from .token_store import TokenStore


EPISODE_TABLES: list[tuple[str, str]] = [
    ("EpisodeMaster", "Id"),                      # main story
    ("StoryEventEpisodeMaster", "Id"),            # event story
    ("SpotConversationMaster", "EpisodeMasterId"),# spot conversations
    ("SpecialEpisodeMaster", "Id"),               # specials
    ("CharacterEpisodeMaster", "EpisodeMasterId"),# character episodes (may be locked)
]


@dataclass
class SceneFetchResult:
    fetched: list[str] = field(default_factory=list)
    existing: list[str] = field(default_factory=list)
    locked: list[int] = field(default_factory=list)
    errors: list[tuple[int, str]] = field(default_factory=list)
    manifest: dict[str, Any] = field(default_factory=dict)


def collect_episode_ids(masterdata_dir: str = "masterdata/tables") -> list[int]:
    ids: set[int] = set()
    for table, key in EPISODE_TABLES:
        path = Path(masterdata_dir) / f"{table}.json"
        if not path.exists():
            continue
        rows = json.loads(path.read_text(encoding="utf-8"))
        for row in rows:
            value = row.get(key)
            if isinstance(value, int):
                ids.add(value)
    return sorted(ids)


def get_episode_asset_source(api: ApiClient, token: str, episode_id: int) -> str | None:
    """POST /api/Episodes/{id}/GetDetails -> EpisodeDetailAssetSource (or None if locked)."""
    payloads = api._request(
        "POST",
        f"/api/Episodes/{episode_id}/GetDetails",
        b"",
        token=token,
    )
    for obj in payloads:
        if isinstance(obj, list) and len(obj) == 4 and isinstance(obj[3], str):
            return obj[3]
    return None


def download_scene(url: str, dest: Path, retries: int = 5) -> bytes:
    """Download with retries: the CDN intermittently drops TLS connections
    (SSL: UNEXPECTED_EOF_WHILE_READING), which is transient per request.
    HTTP 4xx (404 etc.) are permanent and never retried."""
    last: Exception | None = None
    for i in range(retries):
        try:
            req = urllib.request.Request(
                url, headers={"user-agent": "BestHTTP/2 v2.8.5"}
            )
            with urllib.request.urlopen(req, timeout=120) as resp:
                data = resp.read()
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_bytes(data)
            return data
        except urllib.error.HTTPError:
            raise
        except Exception as ex:  # noqa: BLE001
            last = ex
            if i < retries - 1:
                time.sleep(0.5 * (i + 1))
    raise last  # type: ignore[misc]


def _existing_episode_ids(out: Path) -> set[int]:
    """Episode ids that already have a local scenes/{id}_*.bin file."""
    found: set[int] = set()
    if not out.is_dir():
        return found
    for name in os.listdir(out):
        if not name.endswith(".bin"):
            continue
        prefix = name.split("_", 1)[0]
        if prefix.isdigit():
            found.add(int(prefix))
    return found


def fetch_scenes(
    api: ApiClient,
    token: str,
    *,
    episode_ids: list[int] | None = None,
    masterdata_dir: str = "masterdata/tables",
    out_dir: str | os.PathLike[str] = "scenes",
    concurrency: int = 4,
    limit: int | None = None,
    force: bool = False,
    delay: float = 0.0,
) -> SceneFetchResult:
    ids = episode_ids if episode_ids is not None else collect_episode_ids(masterdata_dir)
    if limit:
        ids = ids[:limit]
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)

    result = SceneFetchResult()
    manifest: dict[str, Any] = {}

    # Local-first: episodes already on disk are skipped without any API call
    # (GetDetails is only issued for episodes that are actually missing).
    local = (_existing_episode_ids(out) if not force else set()) & set(ids)
    pending = [eid for eid in ids if eid not in local]
    result.existing = sorted(local)
    for eid in local:
        manifest[str(eid)] = "exists"

    started = time.time()
    if not pending:
        print(
            f"[*] {len(ids)}/{len(ids)} (ok=0 exists={len(result.existing)} "
            f"locked=0 err=0)"
        )
        result.manifest = {
            "count": len(ids),
            "fetched": 0,
            "existing": len(result.existing),
            "locked": 0,
            "errors": 0,
            "elapsed_seconds": round(time.time() - started, 1),
            "episodes": manifest,
        }
        (out / "manifest.json").write_text(
            json.dumps(result.manifest, ensure_ascii=False, indent=2),
            encoding="utf-8",
        )
        return result

    env = api.fetch_environment()
    base = env.master_data_url.rstrip("/")

    def one(eid: int) -> tuple[int, str, str | None]:
        try:
            asset = get_episode_asset_source(api, token, eid)
            if not asset:
                return eid, "locked", None
            url = f"{base}/{asset}"
            name = asset.split("?")[0].rsplit("/", 1)[-1]
            dest = out / name
            if dest.exists() and not force:
                return eid, "exists", name
            download_scene(url, dest)
            return eid, "ok", name
        except ApiError as ex:
            if ex.status in (400, 403):
                return eid, "locked", None
            return eid, f"err:{ex.status}", None
        except Exception as ex:  # noqa: BLE001
            detail = f"{type(ex).__name__}:{ex}"
            return eid, f"err:{detail[:120]}", None

    with _futures.ThreadPoolExecutor(max_workers=max(1, concurrency)) as pool:
        futures = {pool.submit(one, eid): eid for eid in pending}
        done = len(local)
        for future in _futures.as_completed(futures):
            eid, status, name = future.result()
            done += 1
            manifest[str(eid)] = status
            if status == "ok":
                result.fetched.append(name)
            elif status == "exists":
                result.existing.append(eid)
            elif status == "locked":
                result.locked.append(eid)
            else:
                result.errors.append((eid, status))
            if done % 100 == 0 or done == len(ids):
                print(
                    f"[*] {done}/{len(ids)} (ok={len(result.fetched)} "
                    f"exists={len(result.existing)} "
                    f"locked={len(result.locked)} err={len(result.errors)})"
                )
            if delay:
                time.sleep(delay)

    result.manifest = {
        "count": len(ids),
        "fetched": len(result.fetched),
        "existing": len(result.existing),
        "locked": len(result.locked),
        "errors": len(result.errors),
        "elapsed_seconds": round(time.time() - started, 1),
        "episodes": manifest,
    }
    (out / "manifest.json").write_text(
        json.dumps(result.manifest, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    return result


def ensure_token(
    credentials: str | os.PathLike[str],
    linkage_code: str | None = None,
    password: str | None = None,
) -> str:
    store = TokenStore(credentials)
    api = ApiClient()
    login = LoginService(api, store)
    login_token, _ = login.ensure_login_token(linkage_code, password)
    return login.get_api_token(login_token)
