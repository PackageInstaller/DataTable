from __future__ import annotations

import hashlib
import json
import os
import shutil
import threading
import time
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime
from pathlib import Path

from rich.console import Console
from rich.markup import escape
from rich.progress import Progress
from rich.table import Table

import TLWConfig as C
import TLWDecrypt as D
import TLWHotUpdate as H

console = Console()

BUNDLE_CATEGORY = "assetbundle"
RESOURCE_CATEGORY = "resource"

SUMMARY_FILE = C.ASSETS_DIR / "_manifest.json"

FAILURE_RECORD_LIMIT = 200
RETRY_ROUNDS = 3
VERIFY_JOBS = 32

PNG_MAGIC = b"\x89PNG\r\n\x1a\n"



def _md5(data: bytes) -> str:
    return hashlib.md5(data).hexdigest()


def _atomic_write(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(path.name + ".part")
    tmp.write_bytes(data)
    os.replace(tmp, path)


def _prepare_dirs() -> None:
    for path in (
        C.ASSETS_DIR,
        C.ASSETBUNDLE_OUT_DIR,
        C.RESOURCE_OUT_DIR,
        C.STATE_DIR,
        C.MANIFEST_CACHE_DIR,
    ):
        path.mkdir(parents=True, exist_ok=True)


def _seed_manifest_cache() -> None:
    for category, meta in C.CATEGORIES.items():
        if category == "master":
            continue
        src = C.MANIFEST_CACHE_DIR / f"{meta['dir_name']}.json"
        dst = C.MANIFEST_CACHE_DIR / f"{category}.json"
        if src.is_file() and not dst.is_file():
            try:
                shutil.copyfile(src, dst)
            except OSError:
                pass



def _entry_relpath(entry: dict) -> str:
    paths = entry.get("AssetPaths") or []
    rel = str(paths[0])
    if rel.startswith("Assets/"):
        rel = rel[len("Assets/") :]
    rel = rel.lstrip("/")
    parts = [part for part in rel.split("/") if part not in ("", ".")]
    if not parts or any(part == ".." for part in parts):
        raise ValueError(f"非法 AssetPaths: {paths[0]!r}")
    return "/".join(parts)


def resource_dest_of(entry: dict) -> Path:
    return C.RESOURCE_OUT_DIR.joinpath(*_entry_relpath(entry).split("/"))


def assetbundle_dest_of(entry: dict) -> Path:
    return C.ASSETBUNDLE_OUT_DIR / str(entry["Name"])



class _ZipReader:

    def __init__(self, apk: Path) -> None:
        self._apk = apk
        self._local = threading.local()
        self._lock = threading.Lock()
        self._handles: list[zipfile.ZipFile] = []

    def read(self, name: str) -> bytes:
        archive = getattr(self._local, "archive", None)
        if archive is None:
            archive = zipfile.ZipFile(self._apk)
            self._local.archive = archive
            with self._lock:
                self._handles.append(archive)
        return archive.read(name)

    def close(self) -> None:
        with self._lock:
            handles, self._handles = self._handles, []
        for archive in handles:
            try:
                archive.close()
            except OSError:
                pass


def _prewarm_category(
    apk: Path,
    category: str,
    infos: list[zipfile.ZipInfo],
    *,
    jobs: int,
    force: bool,
    limit: int,
    progress: Progress | None,
) -> dict:
    dest_of = assetbundle_dest_of if category == BUNDLE_CATEGORY else resource_dest_of
    transform = None if category == BUNDLE_CATEGORY else D.decode_east

    manifest = H.load_manifest(category)
    index = {entry["Name"]: entry for entry in H.manifest_entries(manifest)}
    state = H.load_state(category)

    stats = {
        "category": category,
        "apk_entries": len(infos),
        "in_manifest": 0,
        "not_in_manifest": 0,
        "reused": 0,
        "reused_bytes": 0,
        "stale": 0,
        "stale_bytes": 0,
        "already": 0,
        "failed": 0,
        "fail_list": [],
        "not_in_manifest_list": [],
    }

    targets: list[tuple[zipfile.ZipInfo, dict]] = []
    for info in infos:
        if info.is_dir():
            continue
        name = info.filename.rsplit("/", 1)[-1]
        entry = index.get(name)
        if entry is None:
            stats["not_in_manifest"] += 1
            if len(stats["not_in_manifest_list"]) < 20:
                stats["not_in_manifest_list"].append(name)
            continue
        stats["in_manifest"] += 1
        targets.append((info, entry))
    if limit > 0:
        targets = targets[:limit]

    if not targets:
        return stats

    task_id = None
    if progress is not None:
        total = sum(info.file_size for info, _ in targets) or len(targets)
        task_id = progress.add_task(f"[magenta]APK 预热 {C.CATEGORIES[category]['desc']}", total=total)

    reader = _ZipReader(apk)

    def work(item: tuple[zipfile.ZipInfo, dict]) -> tuple[str, dict, int]:
        info, entry = item
        name = str(entry["Name"])
        dest = dest_of(entry)
        if not force and dest.is_file():
            return ("already", entry, info.file_size)
        expected_size = int(entry.get("Size") or 0)
        if expected_size and info.file_size != expected_size:
            return ("stale", entry, info.file_size)
        try:
            data = reader.read(info.filename)
        except Exception as ex:  # noqa: BLE001
            stats["failed"] += 1
            if len(stats["fail_list"]) < FAILURE_RECORD_LIMIT:
                stats["fail_list"].append({"name": name, "error": f"{type(ex).__name__}: {ex}"})
            return ("failed", entry, info.file_size)
        expected_hash = (entry.get("Hash") or "").lower()
        if expected_hash and _md5(data) != expected_hash:
            return ("stale", entry, info.file_size)
        payload = transform(data) if transform is not None else data
        try:
            _atomic_write(dest, payload)
        except OSError as ex:
            stats["failed"] += 1
            if len(stats["fail_list"]) < FAILURE_RECORD_LIMIT:
                stats["fail_list"].append({"name": name, "error": f"{type(ex).__name__}: {ex}"})
            return ("failed", entry, info.file_size)
        state[name] = {"hash": entry.get("Hash"), "dest": str(dest)}
        return ("reused", entry, len(payload))

    try:
        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futures = {pool.submit(work, item): item for item in targets}
            for future in as_completed(futures):
                info, entry = futures[future]
                status, _entry, size = future.result()
                if status == "reused":
                    stats["reused"] += 1
                    stats["reused_bytes"] += size
                elif status == "stale":
                    stats["stale"] += 1
                    stats["stale_bytes"] += size
                elif status == "already":
                    stats["already"] += 1
                if progress is not None and task_id is not None:
                    progress.advance(task_id, info.file_size or 1)
    finally:
        reader.close()

    if stats["reused"]:
        H.save_state(category, state)
    return stats


def _prewarm_all(
    apk: Path,
    categories: list[str],
    *,
    jobs: int,
    force: bool,
    limit: int,
    progress: Progress | None,
) -> dict:
    with zipfile.ZipFile(apk) as archive:
        all_infos = archive.infolist()
    result = {"path": str(apk), "categories": {}}
    for category in categories:
        prefix = C.APK_ASSETBUNDLE_PREFIX if category == BUNDLE_CATEGORY else C.APK_RESOURCE_PREFIX
        infos = [info for info in all_infos if info.filename.startswith(prefix)]
        category_stats = _prewarm_category(
            apk,
            category,
            infos,
            jobs=jobs,
            force=force,
            limit=limit,
            progress=progress,
        )
        result["categories"][category] = category_stats
        console.print(
            f"[cyan]APK[/cyan] {C.CATEGORIES[category]['desc']}: "
            f"内置 {category_stats['apk_entries']:,} / 命中清单 {category_stats['in_manifest']:,} / "
            f"md5 复用 {category_stats['reused']:,} / 旧版本跳过 {category_stats['stale']:,} / "
            f"清单外 {category_stats['not_in_manifest']:,}"
        )
    return result


def _run_with_retries(label: str, sync_fn, *, rounds: int = RETRY_ROUNDS) -> dict:
    attempts: list[dict] = []
    for index in range(1, rounds + 1):
        stats = sync_fn()
        attempts.append(stats)
        if int(stats.get("fail") or 0) <= 0:
            break
        if index < rounds:
            console.print(
                f"[yellow]{label} 本轮失败 {stats['fail']} 个，"
                f"第 {index + 1}/{rounds} 轮重试…[/yellow]"
            )
            time.sleep(min(2 * index, 5))
    last = attempts[-1] if attempts else {}
    return {
        "attempts": len(attempts),
        "ok": int(last.get("ok") or 0),
        "skip": int(last.get("skip") or 0),
        "fail": int(last.get("fail") or 0),
        "bytes": sum(int(item.get("bytes") or 0) for item in attempts),
        "failed": list(last.get("failed") or []),
    }




def _check_magic(path: Path, category: str) -> bool:
    try:
        with open(path, "rb") as handle:
            head = handle.read(8)
    except OSError:
        return False
    if category == BUNDLE_CATEGORY:
        return head[:7] == b"UnityFS"
    return head[:8] == PNG_MAGIC


def verify_category(category: str, *, limit: int = 0) -> dict:
    manifest = H.load_manifest(category)
    entries = H.manifest_entries(manifest)
    if limit > 0:
        entries = entries[:limit]
    dest_of = assetbundle_dest_of if category == BUNDLE_CATEGORY else resource_dest_of

    stats = {
        "category": category,
        "total": len(entries),
        "files": 0,
        "missing": 0,
        "size_ok": 0,
        "size_bad": 0,
        "magic_ok": 0,
        "magic_bad": 0,
        "bytes": 0,
        "expected_bytes": sum(int(entry.get("Size") or 0) for entry in entries),
        "fail": 0,
        "failures": [],
    }
    present: list[tuple[dict, Path]] = []
    for entry in entries:
        name = str(entry["Name"])
        dest = dest_of(entry)
        expected_size = int(entry.get("Size") or 0)
        if not dest.is_file():
            stats["missing"] += 1
            stats["fail"] += 1
            if len(stats["failures"]) < FAILURE_RECORD_LIMIT:
                stats["failures"].append(
                    {"category": category, "name": name, "path": str(dest), "reason": "missing"}
                )
            continue
        actual_size = dest.stat().st_size
        stats["files"] += 1
        stats["bytes"] += actual_size
        if expected_size and actual_size != expected_size:
            stats["size_bad"] += 1
            stats["fail"] += 1
            if len(stats["failures"]) < FAILURE_RECORD_LIMIT:
                stats["failures"].append(
                    {
                        "category": category,
                        "name": name,
                        "path": str(dest),
                        "reason": "size",
                        "expected": expected_size,
                        "actual": actual_size,
                    }
                )
        else:
            stats["size_ok"] += 1
        present.append((entry, dest))

    def check(item: tuple[dict, Path]) -> tuple[dict, bool]:
        entry, dest = item
        return entry, _check_magic(dest, category)

    if present:
        with ThreadPoolExecutor(max_workers=VERIFY_JOBS) as pool:
            for entry, ok in pool.map(check, present, chunksize=64):
                if ok:
                    stats["magic_ok"] += 1
                else:
                    stats["magic_bad"] += 1
                    stats["fail"] += 1
                    name = str(entry["Name"])
                    if len(stats["failures"]) < FAILURE_RECORD_LIMIT:
                        stats["failures"].append(
                            {"category": category, "name": name, "path": "?", "reason": "magic"}
                        )
    sample_items: list[tuple[dict, Path]] = []
    seen: set[str] = set()
    for entry, dest in present[:3] + present[-3:]:
        key = str(dest)
        if key in seen:
            continue
        seen.add(key)
        sample_items.append((entry, dest))
    stats["samples"] = []
    for entry, dest in sample_items:
        try:
            digest = D.md5_file(dest)
            size = dest.stat().st_size
        except OSError:
            digest, size = None, None
        stats["samples"].append(
            {
                "name": str(entry["Name"]),
                "path": C.relative_posix(dest),
                "size": size,
                "md5": digest,
            }
        )
    return stats




def _apk_fallback(category: str, names: set[str], apk: Path) -> list[str]:
    prefix = C.APK_ASSETBUNDLE_PREFIX if category == BUNDLE_CATEGORY else C.APK_RESOURCE_PREFIX
    dest_of = assetbundle_dest_of if category == BUNDLE_CATEGORY else resource_dest_of
    transform = None if category == BUNDLE_CATEGORY else D.decode_east
    manifest = H.load_manifest(category)
    index = {entry["Name"]: entry for entry in H.manifest_entries(manifest)}
    state = H.load_state(category)
    written: list[str] = []
    with zipfile.ZipFile(apk) as archive:
        for info in archive.infolist():
            if not info.filename.startswith(prefix):
                continue
            name = info.filename.rsplit("/", 1)[-1]
            if name not in names:
                continue
            entry = index.get(name)
            if entry is None:
                continue
            try:
                data = archive.read(info.filename)
                payload = transform(data) if transform is not None else data
                dest = dest_of(entry)
                _atomic_write(dest, payload)
            except Exception as e:
                continue
            state[name] = {"hash": entry.get("Hash"), "dest": str(dest), "fallback_from_apk": True}
            written.append(name)
    if written:
        H.save_state(category, state)
    return written



def _write_summary(payload: dict) -> Path:
    SUMMARY_FILE.parent.mkdir(parents=True, exist_ok=True)
    tmp = SUMMARY_FILE.with_name(SUMMARY_FILE.name + ".part")
    tmp.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
    os.replace(tmp, SUMMARY_FILE)
    return SUMMARY_FILE


def _print_summary(categories: dict[str, dict]) -> None:
    table = Table(title="Assets 导出统计", header_style="bold cyan")
    table.add_column("分类", style="cyan")
    table.add_column("清单条目", justify="right")
    table.add_column("已还原", justify="right")
    table.add_column("字节数", justify="right")
    table.add_column("APK 复用", justify="right")
    table.add_column("失败", justify="right")
    for category, stats in categories.items():
        bytes_text = f"{stats['bytes'] / (1024 ** 3):.2f} GiB"
        table.add_row(
            C.CATEGORIES[category]["desc"],
            f"{stats['total']:,}",
            f"{stats['files']:,}",
            bytes_text,
            f"{stats.get('apk_reused', 0):,}",
            f"{stats['fail']:,}",
        )
    console.print(table)




def export_assets(
    apk: Path | None = None,
    *,
    jobs: int = C.DEFAULT_JOBS,
    force: bool = False,
    refresh: bool = False,
    limit: int = 0,
    skip_apk: bool = False,
    skip_cdn: bool = False,
    skip_resource: bool = False,
    skip_assetbundle: bool = False,
    progress: Progress | None = None,
) -> dict:
    started = time.monotonic()
    _prepare_dirs()
    _seed_manifest_cache()

    if skip_assetbundle and skip_resource:
        console.print("[yellow]! assetbundle 与 resource 都被跳过，无事可做[/yellow]")
        return {"ok": True, "failed": 0, "elapsed": 0.0, "failures": []}

    categories = [category for category in (BUNDLE_CATEGORY, RESOURCE_CATEGORY) if not (
        (category == BUNDLE_CATEGORY and skip_assetbundle)
        or (category == RESOURCE_CATEGORY and skip_resource)
    )]

    owned_progress = progress is None
    if owned_progress:
        progress = H.new_progress()
        progress.start()

    try:
        manifests = {
            category: H.load_manifest(category, refresh=refresh) for category in categories
        }
        entry_counts = {
            category: len(H.manifest_entries(manifests[category])) for category in categories
        }
        console.print(
            "[cyan]CDN 清单:[/cyan] "
            + "  ".join(
                f"{C.CATEGORIES[category]['desc']} {entry_counts[category]:,} 条"
                for category in categories
            )
            + (f"（--limit {limit}）" if limit > 0 else "")
        )

        apk_path = Path(apk) if apk is not None else C.find_default_apk()
        apk_stats: dict | None = None
        if not skip_apk:
            if apk_path is None or not apk_path.is_file():
                console.print("[yellow]! 未找到本地 APK，跳过 APK（可用 --apk 指定）[/yellow]")
                apk_stats = {"path": None, "categories": {}}
            else:
                console.print(f"[cyan]APK:[/cyan] {escape(str(apk_path))}")
                apk_stats = _prewarm_all(
                    apk_path,
                    categories,
                    jobs=jobs,
                    force=force,
                    limit=limit,
                    progress=progress,
                )
        if apk_path is not None and not apk_path.is_file():
            apk_path = None

        cdn_stats: dict[str, dict] = {}
        if not skip_cdn:
            for category in categories:
                if category == BUNDLE_CATEGORY:
                    console.print(
                        "[cyan]开始 CDN 同步 AssetBundle（hash_verify=False，按清单 Size 校验）…[/cyan]"
                    )
                    cdn_stats[category] = _run_with_retries(
                        "AssetBundle",
                        lambda: H.sync_category(
                            BUNDLE_CATEGORY,
                            assetbundle_dest_of,
                            jobs=jobs,
                            force=force,
                            limit=limit,
                            progress=progress,
                            hash_verify=False,
                        ),
                    )
                else:
                    console.print("[cyan]开始 CDN 同步 Resource（md5 校验 + 解 EAST 头）…[/cyan]")
                    cdn_stats[category] = _run_with_retries(
                        "Resource",
                        lambda: H.sync_category(
                            RESOURCE_CATEGORY,
                            resource_dest_of,
                            transform=D.decode_east,
                            jobs=jobs,
                            force=force,
                            limit=limit,
                            progress=progress,
                        ),
                    )

        verify_stats: dict[str, dict] = {}
        fallback_names: dict[str, list[str]] = {}
        for category in categories:
            verify = verify_category(category, limit=limit)
            if (
                verify["fail"] > 0
                and not skip_cdn
                and not skip_apk
                and apk_path is not None
                and apk_path.is_file()
            ):
                failed_names = {item["name"] for item in verify["failures"]}
                rescued = _apk_fallback(category, failed_names, apk_path)
                if rescued:
                    console.print(
                        f"[yellow]! {category} 有 {len(rescued)} 个文件用 APK 旧版本[/yellow]"
                    )
                    fallback_names[category] = rescued
                    verify = verify_category(category, limit=limit)
                    verify["fallback_from_apk"] = rescued
            verify_stats[category] = verify

        failures: list[dict] = []
        for category in categories:
            failures.extend(verify_stats[category]["failures"])
        failed_count = sum(verify_stats[category]["fail"] for category in categories)

        summary_categories: dict[str, dict] = {}
        result_categories: dict[str, dict] = {}
        for category in categories:
            verify = verify_stats[category]
            cdn = cdn_stats.get(category) or {}
            apk_reused = 0
            if apk_stats is not None:
                apk_reused = int(
                    (apk_stats.get("categories", {}).get(category) or {}).get("reused") or 0
                )
            summary_categories[category] = {
                "manifest_version": C.CATEGORIES[category]["dir_name"],
                "manifest": C.manifest_url(category),
                "total": verify["total"],
                "files": verify["files"],
                "bytes": verify["bytes"],
                "expected_bytes": verify["expected_bytes"],
                "size_ok": verify["size_ok"],
                "size_bad": verify["size_bad"],
                "missing": verify["missing"],
                "magic_ok": verify["magic_ok"],
                "magic_bad": verify["magic_bad"],
                "fail": verify["fail"],
                "apk_reused": apk_reused,
                "cdn_attempts": cdn.get("attempts", 0),
                "cdn_downloaded_bytes": cdn.get("bytes", 0),
                "fallback_from_apk": len(fallback_names.get(category, [])),
                "hash_verified": category != BUNDLE_CATEGORY,
                "verify_mode": (
                    "size+UnityFS魔数"
                    if category == BUNDLE_CATEGORY
                    else "md5(清单Hash)+PNG魔数"
                ),
                "manifest_hash_kind": (
                    "bundle内部Hash128(非文件md5)"
                    if category == BUNDLE_CATEGORY
                    else "文件md5"
                ),
                "samples_size_md5": verify.get("samples", []),
            }
            result_categories[category] = {
                "total": verify["total"],
                "files": verify["files"],
                "bytes": verify["bytes"],
                "fail": verify["fail"],
                "apk_reused": apk_reused,
            }

        elapsed = time.monotonic() - started
        summary = {
            "game": C.GAME_TITLE,
            "package": C.GAME_PACKAGE,
            "generated_at": datetime.now().astimezone().isoformat(timespec="seconds"),
            "elapsed_seconds": round(elapsed, 1),
            "options": {
                "jobs": jobs,
                "force": force,
                "refresh": refresh,
                "limit": limit,
                "skip_apk": skip_apk,
                "skip_cdn": skip_cdn,
                "skip_resource": skip_resource,
            },
            "categories": summary_categories,
            "apk": _apk_summary(apk_stats),
            "failures": {
                "total": failed_count,
                "records": failures[:FAILURE_RECORD_LIMIT],
                "truncated": failed_count > FAILURE_RECORD_LIMIT,
            },
        }
        summary_path = _write_summary(summary)

        console.print()
        _print_summary(result_categories)
        if failed_count:
            console.print(f"[red]! 共 {failed_count} 个文件校验失败，明细见 {escape(str(summary_path))}[/red]")
        else:
            console.print(f"[green]✓ 全部校验通过，汇总已写入 {escape(str(summary_path))}[/green]")

        result: dict = {
            "ok": failed_count == 0,
            "failed": failed_count,
            "elapsed": round(elapsed, 1),
            "assetbundle": result_categories.get(BUNDLE_CATEGORY, {}),
            "resource": result_categories.get(RESOURCE_CATEGORY, {}),
            "failures": failures[:FAILURE_RECORD_LIMIT],
            "manifest": C.relative_posix(summary_path),
        }
        if apk_stats is not None:
            result["apk_reused"] = sum(
                int((item or {}).get("reused") or 0)
                for item in apk_stats.get("categories", {}).values()
            )
            result["apk_stale"] = sum(
                int((item or {}).get("stale") or 0)
                for item in apk_stats.get("categories", {}).values()
            )
        return result
    finally:
        if owned_progress:
            progress.stop()


def _apk_summary(apk_stats: dict | None) -> dict:
    if apk_stats is None:
        return {"enabled": False}
    path = apk_stats.get("path")
    summary: dict = {"enabled": True, "path": path, "categories": {}}
    for category, stats in (apk_stats.get("categories") or {}).items():
        summary["categories"][category] = {
            "apk_entries": stats.get("apk_entries", 0),
            "in_manifest": stats.get("in_manifest", 0),
            "not_in_manifest": stats.get("not_in_manifest", 0),
            "reused": stats.get("reused", 0),
            "reused_bytes": stats.get("reused_bytes", 0),
            "stale": stats.get("stale", 0),
            "stale_bytes": stats.get("stale_bytes", 0),
            "already": stats.get("already", 0),
            "failed": stats.get("failed", 0),
            "not_in_manifest_sample": (stats.get("not_in_manifest_list") or [])[:20],
            "failures": (stats.get("fail_list") or [])[:FAILURE_RECORD_LIMIT],
        }
    return summary
