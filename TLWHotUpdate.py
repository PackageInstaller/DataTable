from __future__ import annotations

import json
import os
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Callable

import requests
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
    DownloadColumn,
)

import TLWConfig as C
from TLWDecrypt import md5_bytes, md5_file


def _request(url: str, attempts: int = C.HTTP_RETRIES) -> requests.Response:
    last: Exception | None = None
    for attempt in range(1, attempts + 1):
        try:
            resp = requests.get(
                url,
                timeout=C.HTTP_TIMEOUT,
                headers={"User-Agent": C.USER_AGENT},
            )
            if resp.status_code == 404:
                raise FileNotFoundError(f"404 Not Found: {url}")
            resp.raise_for_status()
            return resp
        except Exception as ex:  # noqa: BLE001
            last = ex
            if attempt < attempts:
                time.sleep(min(2 ** attempt, 8))
    raise RuntimeError(f"请求失败 {url}: {last}")


def fetch_bytes(url: str) -> bytes:
    return _request(url).content


def fetch_text(url: str) -> str:
    return _request(url).text


def load_manifest(category: str, refresh: bool = False) -> dict:
    cache = C.MANIFEST_CACHE_DIR / f"{category}.json"
    if cache.is_file() and not refresh:
        try:
            return json.loads(cache.read_bytes())
        except ValueError:
            pass
    raw = fetch_bytes(C.manifest_url(category))
    payload = json.loads(raw)
    cache.parent.mkdir(parents=True, exist_ok=True)
    cache.write_bytes(raw)
    return payload


def manifest_entries(manifest: dict) -> list[dict]:
    return list(manifest.get("AssetInfos") or [])


def load_state(category: str) -> dict:
    path = C.STATE_DIR / f"{category}.json"
    if path.is_file():
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except ValueError:
            return {}
    return {}


def save_state(category: str, state: dict) -> None:
    C.STATE_DIR.mkdir(parents=True, exist_ok=True)
    path = C.STATE_DIR / f"{category}.json"
    tmp = path.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(state, ensure_ascii=False), encoding="utf-8")
    os.replace(tmp, path)


def _atomic_write(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(path.name + ".part")
    tmp.write_bytes(data)
    os.replace(tmp, path)


def sync_category(
    category: str,
    dest_of: Callable[[dict], Path],
    *,
    transform: Callable[[bytes], bytes] | None = None,
    jobs: int = C.DEFAULT_JOBS,
    force: bool = False,
    limit: int = 0,
    filter_fn: Callable[[dict], bool] | None = None,
    progress: Progress | None = None,
    state: dict | None = None,
    hash_verify: bool = True,
) -> dict:
    manifest = load_manifest(category)
    entries = manifest_entries(manifest)
    if filter_fn is not None:
        entries = [entry for entry in entries if filter_fn(entry)]
    if limit > 0:
        entries = entries[:limit]

    if state is None:
        state = load_state(category)

    todo: list[tuple[dict, Path]] = []
    skipped = 0
    for entry in entries:
        dest = dest_of(entry)
        record = state.get(entry["Name"]) or {}
        if not force and dest.is_file():
            if record.get("hash") == entry.get("Hash") and record.get("dest") == str(dest):
                skipped += 1
                continue
            if hash_verify and transform is None and entry.get("Hash"):
                if md5_file(dest).lower() == entry["Hash"].lower():
                    state[entry["Name"]] = {"hash": entry["Hash"], "dest": str(dest)}
                    skipped += 1
                    continue
            if transform is not None and record.get("dest") == str(dest):
                skipped += 1
                continue
            if not hash_verify and dest.stat().st_size == (entry.get("Size") or -1):
                state[entry["Name"]] = {"hash": entry.get("Hash"), "dest": str(dest)}
                skipped += 1
                continue
        todo.append((entry, dest))

    stats = {
        "category": category,
        "total": len(entries),
        "ok": 0,
        "skip": skipped,
        "fail": 0,
        "bytes": 0,
    }
    if not todo:
        save_state(category, state)
        return stats

    task_id = None
    if progress is not None:
        task_id = progress.add_task(
            f"[cyan]{C.CATEGORIES[category]['desc']}",
            total=sum(entry.get("Size") or 0 for entry, _ in todo) or len(todo),
        )

    def work(entry: dict) -> tuple[dict, Path, int]:
        url = C.source_url(category, entry["Name"])
        data = fetch_bytes(url)
        if hash_verify:
            expected = (entry.get("Hash") or "").lower()
            if expected and md5_bytes(data).lower() != expected:
                raise ValueError(f"MD5 校验失败 {entry['Name']}")
        else:
            expected_size = entry.get("Size")
            if expected_size and len(data) != expected_size:
                raise ValueError(f"大小校验失败 {entry['Name']}: {len(data)} != {expected_size}")
        if transform is not None:
            data = transform(data)
        dest = dest_of(entry)
        _atomic_write(dest, data)
        return entry, dest, len(data)

    with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
        futures = {pool.submit(work, entry): entry for entry, _ in todo}
        for future in as_completed(futures):
            pending_entry = futures[future]
            try:
                entry, dest, size = future.result()
                state[entry["Name"]] = {"hash": entry.get("Hash"), "dest": str(dest)}
                stats["ok"] += 1
                stats["bytes"] += size
            except Exception as ex:  # noqa: BLE001
                stats["fail"] += 1
                if progress is not None:
                    progress.console.print(
                        f"[yellow]下载失败[/yellow] {category}: {type(ex).__name__}: {ex}"
                    )
            if progress is not None and task_id is not None:
                progress.advance(task_id, pending_entry.get("Size") or 1)
            if stats["ok"] % 200 == 0:
                save_state(category, state)

    save_state(category, state)
    return stats


def download_single(
    category: str,
    name: str,
    dest: Path,
    *,
    transform: Callable[[bytes], bytes] | None = None,
    hash_value: str | None = None,
    force: bool = False,
) -> int:
    if dest.is_file() and not force:
        return dest.stat().st_size
    data = fetch_bytes(C.source_url(category, name))
    expected = (hash_value or "").lower()
    if expected and md5_bytes(data).lower() != expected:
        raise ValueError(f"MD5 校验失败 {name}")
    if transform is not None:
        data = transform(data)
    _atomic_write(dest, data)
    return len(data)


def new_progress() -> Progress:
    return Progress(
        SpinnerColumn(),
        TextColumn("[bold blue]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(compact=True),
    )
