from __future__ import annotations
from typing import Dict, List, Optional, Tuple

import argparse
import hashlib
import json
import sys
import threading
import time
import traceback
import urllib.error
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

from rich.console import Console
from rich.live import Live
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    TaskID,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)
from rich.table import Table

DEFAULT_API = (
    "https://open.ys4fun.com/game-website-server/pass/sdk/"
    "get_game_hot_update_version?gameId=1"
)
USER_AGENT = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
)


def _opener() -> urllib.request.OpenerDirector:
    return urllib.request.build_opener(urllib.request.ProxyHandler({}))


def http_get_text(url: str, timeout: int = 30) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with _opener().open(req, timeout=timeout) as resp:
        return resp.read()


def fetch_hot_version(api_url: str, timeout: int = 30) -> Dict:
    data = json.loads(http_get_text(api_url, timeout).decode("utf-8"))
    if data.get("errorCode") not in ("0", None):
        raise RuntimeError(f"热更新版本接口返回错误: {data}")
    info = data.get("data") or {}
    if not info.get("downloadUrl"):
        raise RuntimeError("热更新版本接口未返回 downloadUrl")
    if not info.get("assethash"):
        raise RuntimeError("热更新版本接口未返回 assethash")
    return info


def fetch_manifest(info: Dict, timeout: int = 60) -> Dict:
    bases = [b for b in info["downloadUrl"].split(";") if b]
    last_err: Optional[Exception] = None
    for base in bases:
        url = base.rstrip("/") + "/" + info["assethash"]
        try:
            raw = http_get_text(url, timeout)
            manifest = json.loads(raw.decode("utf-8"))
            if "assetHashList" not in manifest:
                raise RuntimeError("清单缺少 assetHashList")
            manifest["_mirror"] = base
            return manifest
        except Exception as exc:  # noqa: BLE001
            last_err = exc
            print(f"[!] 从 {url} 获取清单失败: {exc}", file=sys.stderr)
    raise RuntimeError(f"所有 CDN 镜像均无法获取清单: {last_err}")


def parse_entries(manifest: Dict) -> List[Dict]:
    entries: List[Dict] = []
    for line in manifest.get("assetHashList", []):
        parts = line.split("|")
        if len(parts) < 3:
            continue
        path, md5, size = parts[0], parts[1], parts[2]
        try:
            size_i = int(size)
        except ValueError:
            size_i = 0
        entries.append({"path": path, "hash": md5, "size": size_i})
    return entries


def build_path_index(entries: List[Dict]) -> Dict[str, Dict]:
    index: Dict[str, Dict] = {}
    for entry in entries:
        index.setdefault(entry["path"], entry)
        index.setdefault(entry["hash"], entry)
    return index


def select_entries(entries: List[Dict], manifest: Dict, only: List[str]) -> List[Dict]:
    """按下载包/分类筛选。only=['all'] 表示全部资源。"""
    if "all" in only:
        return entries

    pend = manifest.get("assetPendDict") or {}
    wanted_paths: set[str] = set()
    known_groups = {
        "assetList": pend.get("assetList") or [],
        "voiceList": pend.get("voiceList") or [],
        "newbieList": pend.get("newbieList") or [],
        "advanceList": pend.get("advanceList") or [],
        "permanentList": pend.get("permanentList") or [],
    }

    for group in only:
        group = group.strip().lower()
        if group == "voice":
            for key in ("voiceList", "allVoice"):
                wanted_paths.update(pend.get(key) or [])
            for paths in (pend.get("voiceDict") or {}).values():
                wanted_paths.update(paths)
            continue
        if group == "single":
            wanted_paths.update(known_groups["assetList"])
            wanted_paths.update(known_groups["voiceList"])
            continue
        if group in known_groups:
            wanted_paths.update(known_groups[group])
            continue
        if group == "lua":
            # Lua bundle：scripts32 / scripts64（热更分发），外加 tolua 原生运行时
            for e in entries:
                if e["path"] in ("scripts32", "scripts64") or e["path"].endswith(
                    "/p08_tolua_dll.ys"
                ):
                    wanted_paths.add(e["path"])
            continue
        # 具体包名，例如 assetpend_common_chapter_2
        wanted_paths.update((pend.get("pendDict") or {}).get(group, []))
        wanted_paths.update((pend.get("voiceDict") or {}).get(group, []))

    if not wanted_paths:
        raise RuntimeError(f"没有匹配到任何资源: {only}")

    path_index = build_path_index(entries)
    selected: Dict[str, Dict] = {}
    for p in wanted_paths:
        entry = path_index.get(p)
        if entry:
            selected[entry["hash"]] = entry
    return list(selected.values())


def safe_join(root: Path, rel: str) -> Path:
    """按清单原始路径保存，防止路径穿越。"""
    target = (root / rel).resolve()
    root_resolved = root.resolve()
    if root_resolved not in target.parents and target != root_resolved:
        raise ValueError(f"非法路径: {rel}")
    return target


def local_path_for(entry: Dict, root: Path) -> Path:
    rel = entry.get("rel_path") or entry["path"]
    return safe_join(root, rel)


def entry_key(entry: Dict) -> str:
    """状态里使用的唯一键：语音带语言前缀，避免中日同名文件互相覆盖。"""
    return entry.get("rel_path") or entry["path"]


def remote_urls_for(entry: Dict, bases: List[str]) -> List[str]:
    return [b.rstrip("/") + "/" + entry["hash"] + ".ys" for b in bases]


def fetch_voice_entries(
    bases: List[str],
    langs: List[str],
    app_version: str,
    res_version: str,
    timeout: int,
) -> Tuple[List[Dict], Dict]:
    """从 voice_package_list_{app}_{res}.bytes 读取各语言语音包版本，
    再逐个下载 voice_hash_<lang>_<version>.bytes 并合并解析。"""
    list_filename = f"voice_package_list_{app_version}_{res_version}.bytes"
    raw = None
    last_err = ""
    for base in bases:
        url = base.rstrip("/") + "/" + list_filename
        try:
            raw = http_get_text(url, timeout)
            break
        except Exception as exc:  # noqa: BLE001
            last_err = f"{url}: {exc}"
    if raw is None:
        raise RuntimeError(f"无法下载 {list_filename}: {last_err}")

    pkg = json.loads(raw.decode("utf-8"))
    infos = pkg.get("infos") or []
    all_entries: List[Dict] = []
    languages: List[Dict] = []
    errors: List[str] = []

    for lang in langs:
        info = next((i for i in infos if i.get("name") == lang), None)
        if info is None:
            errors.append(f"语音包列表中没有语言 {lang}")
            continue

        version = info.get("version")
        filename = f"voice_hash_{lang}_{version}.bytes"
        fetched = False
        for base in bases:
            url = base.rstrip("/") + "/" + filename
            try:
                raw = http_get_text(url, timeout)
                voice_manifest = json.loads(raw.decode("utf-8"))
                if "assetHashList" not in voice_manifest:
                    raise RuntimeError("语音哈希清单缺少 assetHashList")
                voice_entries = parse_entries(voice_manifest)
                for e in voice_entries:
                    e["rel_path"] = f"voice/{lang}/{e['path']}"
                print(f"[*] 语音包 {lang} v{version}: {len(voice_entries)} 条")
                all_entries.extend(voice_entries)
                languages.append({"lang": lang, "version": version, "mirror": base})
                fetched = True
                break
            except Exception as exc:  # noqa: BLE001
                last_err = f"{url}: {exc}"
        if not fetched:
            errors.append(f"无法获取语音哈希清单 {filename}: {last_err}")

    if not all_entries:
        raise RuntimeError("所有语音哈希清单均获取失败: " + "; ".join(errors))
    if errors:
        print(f"[!] 部分语音包获取失败: {'; '.join(errors)}", file=sys.stderr)

    return all_entries, {"languages": languages}


def file_md5(path: Path) -> str:
    h = hashlib.md5()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


class Downloader:
    def __init__(
        self,
        bases: List[str],
        jobs: int,
        retries: int,
        verify: bool,
        force: bool,
        timeout: int,
        status_interval: int = 10,
        log_path: Optional[Path] = None,
    ):
        self.bases = bases
        self.jobs = jobs
        self.retries = retries
        self.verify = verify
        self.force = force
        self.timeout = timeout
        self.status_interval = status_interval
        self.log_path = log_path
        self.lock = threading.Lock()
        self.done = 0
        self.total = 0
        self.total_bytes = 0
        self.completed_bytes = 0
        self.failures: List[Tuple[str, str]] = []
        self.ok_hashes: set[str] = set()
        self._stop_status = threading.Event()
        self.console = Console()
        self.progress: Optional[Progress] = None
        self.task_id: Optional[TaskID] = None

    def _report(self, path: str, ok: bool, detail: str = "", size: int = 0) -> None:
        with self.lock:
            self.done += 1
            if ok:
                self.completed_bytes += size
                if self.progress is not None and self.task_id is not None and size:
                    self.progress.advance(self.task_id, size)
            else:
                if self.log_path is not None:
                    try:
                        with self.log_path.open("a", encoding="utf-8") as f:
                            f.write(f"{path}\t{detail}\n")
                    except Exception:  # noqa: BLE001
                        pass
                self.failures.append((path, detail))

    def _status_loop(self) -> None:
        while not self._stop_status.wait(self.status_interval):
            with self.lock:
                done = self.done
                total = self.total
                failed = len(self.failures)
            if total:
                print(
                    f"[进度] {done}/{total} 已处理，失败 {failed}，"
                    f"耗时 {time.time() - self.start_time:.0f}s",
                    flush=True,
                )

    def _download_one_url(
        self, url: str, target: Path, expected_size: int, pos: int
    ) -> bool:
        headers = {
            "User-Agent": USER_AGENT,
        }
        if pos:
            headers["Range"] = f"bytes={pos}-"
        req = urllib.request.Request(url, headers=headers)
        mode = "ab" if pos else "wb"
        with _opener().open(req, timeout=self.timeout) as resp, target.open(
            mode
        ) as out:
            while True:
                chunk = resp.read(1024 * 1024)
                if not chunk:
                    break
                out.write(chunk)
                if self.progress is not None and self.task_id is not None:
                    self.progress.advance(self.task_id, len(chunk))
        return target.stat().st_size >= expected_size

    def download_entry(self, entry: Dict, root: Path) -> bool:
        target = local_path_for(entry, root)
        target.parent.mkdir(parents=True, exist_ok=True)
        expected = entry.get("size", 0)

        if not self.force and target.exists() and target.stat().st_size == expected:
            if not self.verify or file_md5(target) == entry["hash"]:
                self._report(entry["path"], True, "skip", size=expected)
                self.ok_hashes.add(entry["hash"])
                return True
            target.unlink()

        urls = remote_urls_for(entry, self.bases)
        last_err = ""
        for attempt in range(max(1, self.retries)):
            for url in urls:
                pos = target.stat().st_size if target.exists() else 0
                if expected and pos > expected:
                    target.unlink()
                    pos = 0
                try:
                    self._download_one_url(url, target, expected, pos)
                    if expected and target.stat().st_size < expected:
                        raise RuntimeError(
                            f"大小不足 {target.stat().st_size}/{expected}"
                        )
                    if self.verify and file_md5(target) != entry["hash"]:
                        raise RuntimeError("MD5 校验失败")
                    self._report(entry["path"], True, size=expected)
                    self.ok_hashes.add(entry["hash"])
                    return True
                except Exception as exc:  # noqa: BLE001
                    last_err = f"{url}: {exc}"
                    # 服务器忽略 Range 时，重写整个文件
                    if target.exists() and target.stat().st_size > pos:
                        target.unlink()
        self._report(entry["path"], False, last_err)
        return False

    def _build_display(self, progress: Progress, task: TaskID) -> Table:
        """进度条 + 状态信息表（参考 DataTable/MementoMori 的 rich 写法）。"""
        with self.lock:
            done = self.done
            failed = len(self.failures)
        elapsed = time.time() - self.start_time
        pct = done / self.total * 100 if self.total else 0.0

        box = Table(show_header=False, box=None, padding=(0, 1))
        box.add_row(progress)
        info = Table(show_header=False, box=None)
        info.add_column(style="cyan", no_wrap=True)
        info.add_column(style="white")
        info.add_row("文件", f"{done}/{self.total} ({pct:.1f}%)")
        info.add_row("失败", f"{failed}")
        info.add_row("耗时", f"{elapsed:.0f}s")
        box.add_row(info)
        return box

    def run(self, entries: List[Dict], root: Path) -> bool:
        self.total = len(entries)
        self.total_bytes = sum(e.get("size", 0) for e in entries)
        self.done = 0
        self.failures = []
        self.ok_hashes = set()
        self.completed_bytes = 0
        self.start_time = time.time()

        tty = sys.stdout.isatty()
        progress = Progress(
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.0f}%",
            "•",
            DownloadColumn(),
            "•",
            TransferSpeedColumn(),
            "•",
            TimeRemainingColumn(),
            console=self.console,
            disable=not tty,
        )
        task = progress.add_task(
            f"[cyan]下载 {self.total} 个文件[/cyan]", total=self.total_bytes or 1
        )
        self.progress = progress
        self.task_id = task

        def periodic(live: Live, prog: Progress, t: TaskID) -> None:
            while not prog.tasks[t].finished:
                live.update(self._build_display(prog, t))
                time.sleep(0.2)

        if tty:
            with Live(
                self._build_display(progress, task),
                refresh_per_second=8,
                console=self.console,
            ) as live:
                updater = threading.Thread(
                    target=periodic, args=(live, progress, task), daemon=True
                )
                updater.start()
                try:
                    self._dispatch(entries, root)
                finally:
                    updater.join(timeout=1)
                    live.update(self._build_display(progress, task))
        else:
            status_thread = threading.Thread(target=self._status_loop, daemon=True)
            status_thread.start()
            try:
                self._dispatch(entries, root)
            finally:
                self._stop_status.set()
                status_thread.join(timeout=1)
        return not self.failures

    def _dispatch(self, entries: List[Dict], root: Path) -> None:
        """并发下载主体（Live 与非 TTY 两种模式共用）。"""
        with ThreadPoolExecutor(max_workers=self.jobs) as pool:
            futures = [pool.submit(self.download_entry, e, root) for e in entries]
            for fut in as_completed(futures):
                try:
                    fut.result()
                except Exception as exc:  # noqa: BLE001
                    traceback.print_exc()
                    with self.lock:
                        self.done += 1
                        self.failures.append(("<task>", str(exc)))


def write_artifact_files(
    output: Path,
    info: Dict,
    manifest: Dict,
    entries: List[Dict],
    bases: List[str],
) -> None:
    output.mkdir(parents=True, exist_ok=True)

    manifest_copy = dict(manifest)
    manifest_copy.pop("_mirror", None)
    (output / "hot_version.json").write_text(
        json.dumps(info, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    (output / "assethash.json").write_text(
        json.dumps(manifest_copy, ensure_ascii=False, indent=2), encoding="utf-8"
    )

    with (output / "download_urls.txt").open("w", encoding="utf-8") as f:
        for e in entries:
            for url in remote_urls_for(e, bases):
                f.write(f"{url}\t{e['path']}\t{e['size']}\n")

    with (output / "filelist.txt").open("w", encoding="utf-8") as f:
        for e in sorted(entries, key=lambda x: x["path"]):
            f.write(f"{e['path']}\t{e['hash']}\t{e['size']}\n")


def write_voice_artifacts(
    output: Path,
    voice_entries: List[Dict],
    voice_meta: Dict,
    bases: List[str],
) -> None:
    with (output / "voice_urls.txt").open("w", encoding="utf-8") as f:
        for e in voice_entries:
            for url in remote_urls_for(e, bases):
                f.write(f"{url}\t{e['path']}\t{e['size']}\n")
    (output / "voice_info.json").write_text(
        json.dumps(voice_meta, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def load_state(path: Path) -> Dict:
    if path.exists():
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except Exception:  # noqa: BLE001
            pass
    return {}


def save_state(
    path: Path,
    info: Dict,
    entries: List[Dict],
    voice_meta: Dict,
    full_complete: bool = True,
) -> None:
    state = {
        "hot_version": info,
        "entries": {entry_key(e): e["hash"] for e in entries},
        "voice": voice_meta,
        "full_complete": full_complete,
        "entry_count": len(entries),
    }
    path.write_text(json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8")


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(line_buffering=True)

    parser = argparse.ArgumentParser(description="深空之眼 PC 资源下载更新器")
    parser.add_argument("--api", default=DEFAULT_API, help="热更新版本接口")
    parser.add_argument("--output", default="./aethergazer", help="输出根目录")
    parser.add_argument(
        "--only",
        default="all,voice",
        help="下载范围: all / single / voice / lua / newbie / advance / permanent / 具体包名(逗号分隔)",
    )
    parser.add_argument(
        "--voice-lang",
        default="zh,ja",
        help="语音包语言缩写，逗号分隔，例如 zh / ja / zh,ja",
    )
    parser.add_argument("--jobs", type=int, default=8, help="并发下载数")
    parser.add_argument("--retries", type=int, default=3, help="每个文件重试次数")
    parser.add_argument("--timeout", type=int, default=30, help="单请求超时秒数")
    parser.add_argument(
        "--status-interval",
        type=int,
        default=10,
        help="无文件完成时打印一次进度的间隔秒数",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=0,
        help="只处理前 N 条资源（调试用）",
    )
    parser.add_argument(
        "--illustration",
        action="store_true",
        help="立绘模式：只下载 textureconfig/character/portrait 与 portraitdlc 到 Illustration/",
    )
    parser.add_argument(
        "--masterdata",
        action="store_true",
        help="下载/更新完成后，从 Assets/config.ys 提取并反序列化数据表到 MasterData/",
    )
    parser.add_argument("--verify", action="store_true", help="下载后做 MD5 校验")
    parser.add_argument("--force", action="store_true", help="忽略已存在文件重新下载")
    parser.add_argument(
        "--force-full",
        action="store_true",
        help="忽略已有状态，重新全量下载到 Assets",
    )
    parser.add_argument(
        "--list-only",
        action="store_true",
        help="只生成清单和下载链接，不下载文件",
    )
    args = parser.parse_args()

    output = Path(args.output)
    output.mkdir(parents=True, exist_ok=True)
    assets_dir = output / "Assets"
    updates_dir = output / "Updates"
    state_path = output / "updater_state.json"

    print("[*] 获取热更新版本信息 ...")
    info = fetch_hot_version(args.api, args.timeout)
    print(
        f"[*] 版本 {info.get('versionName')} "
        f"(app={info.get('matchedAppVersion')}, build={info.get('version')})"
    )
    print(f"[*] 资源 CDN: {info['downloadUrl']}")
    print(f"[*] 清单文件: {info['assethash']}")

    print("[*] 下载资源清单 ...")
    manifest = fetch_manifest(info, args.timeout)
    entries_all = parse_entries(manifest)
    print(f"[*] 清单条目: {len(entries_all)}")
    bases = [b for b in info["downloadUrl"].split(";") if b]

    only = [x.strip().lower() for x in args.only.split(",") if x.strip()]
    want_voice = "voice" in only and not args.illustration
    only_main = [x for x in only if x != "voice"]
    entries = select_entries(entries_all, manifest, only_main) if only_main else []
    voice_entries: List[Dict] = []
    voice_meta: Dict = {}

    if want_voice:
        try:
            voice_entries, voice_meta = fetch_voice_entries(
                bases,
                [x.strip().lower() for x in args.voice_lang.split(",") if x.strip()],
                info.get("matchedAppVersion"),
                info.get("version"),
                args.timeout,
            )
            entries = entries + voice_entries
        except Exception as exc:  # noqa: BLE001
            if only == ["voice"]:
                raise
            print(f"[!] 语音包获取失败（继续主资源下载）: {exc}", file=sys.stderr)

    if args.illustration:
        prefixes = (
            "textureconfig/character/portrait/",
            "textureconfig/character/portraitdlc/",
        )
        entries = [e for e in entries_all if e["path"].startswith(prefixes)]
        for e in entries:
            e["rel_path"] = e["path"][len("textureconfig/character/") :]
        voice_entries = []
        voice_meta = {}

    if args.limit > 0:
        entries = entries[: args.limit]

    total_size = sum(e["size"] for e in entries)
    print(f"[*] 选中条目: {len(entries)}，" f"预计 {total_size / 1073741824:.2f} GiB")

    write_artifact_files(output, info, manifest, entries, bases)
    if voice_entries:
        write_voice_artifacts(output, voice_entries, voice_meta, bases)
    print(f"[*] 已写出 hot_version.json / assethash.json / download_urls.txt")

    if args.list_only:
        print("[*] --list-only，不执行下载。")
        return 0

    if args.illustration:
        target_dir = output / "Illustration"
        print(f"[*] 立绘模式 -> {target_dir}")
        target_dir.mkdir(parents=True, exist_ok=True)
        dl = Downloader(
            bases=bases,
            jobs=args.jobs,
            retries=args.retries,
            verify=args.verify,
            force=args.force,
            timeout=args.timeout,
            status_interval=args.status_interval,
            log_path=output / "download_errors.log",
        )
        dl.run(entries, target_dir)
        if dl.failures:
            print(f"[!] 立绘下载失败 {len(dl.failures)} 个文件：", file=sys.stderr)
            for p, err in dl.failures[:20]:
                print(f"    {p}: {err}", file=sys.stderr)
            return 1
        print(f"[*] 立绘完成：{len(entries)} 个文件。")
        return 0

    state = load_state(state_path)
    full_complete = (
        bool(state.get("full_complete"))
        and state.get("entry_count") == len(entries)
        and assets_dir.exists()
    )
    first_run = args.force_full or not full_complete
    if first_run:
        target_dir = assets_dir
        mode_name = "首次全量下载到 Assets"
        force_download = args.force
        old_map = {} if args.force_full else state.get("entries", {})
        download_entries = [
            e for e in entries if old_map.get(entry_key(e)) != e["hash"]
        ]
        if not download_entries:
            print("[*] Assets 已完整，标记为已完成。")
            save_state(state_path, info, entries, voice_meta, full_complete=True)
            return 0
    else:
        old_map = state.get("entries", {})
        diff = [e for e in entries if old_map.get(entry_key(e)) != e["hash"]]
        target_dir = updates_dir
        mode_name = f"检查更新（{len(diff)} 个变更）"
        force_download = True  # Updates 里同路径旧文件直接覆盖
        download_entries = diff
        if not diff:
            print("[*] 没有检测到更新。")
            save_state(state_path, info, entries, voice_meta, full_complete=True)
            return 0

    print(f"[*] {mode_name} -> {target_dir}")
    target_dir.mkdir(parents=True, exist_ok=True)
    dl = Downloader(
        bases=bases,
        jobs=args.jobs,
        retries=args.retries,
        verify=args.verify,
        force=force_download,
        timeout=args.timeout,
        status_interval=args.status_interval,
        log_path=output / "download_errors.log",
    )
    ok = dl.run(download_entries, target_dir)

    if first_run:
        merged = dict(old_map)
        for e in download_entries:
            if e["hash"] in dl.ok_hashes:
                merged[entry_key(e)] = e["hash"]
        saved_entries = [{"path": p, "hash": h} for p, h in merged.items()]
        full_complete = not dl.failures
    else:
        merged = dict(old_map)
        for e in diff:
            if e["hash"] in dl.ok_hashes:
                merged[entry_key(e)] = e["hash"]
        saved_entries = [{"path": p, "hash": h} for p, h in merged.items()]
        full_complete = True
    save_state(
        state_path,
        info,
        saved_entries,
        voice_meta,
        full_complete=full_complete,
    )

    if dl.failures:
        print(f"[!] 失败 {len(dl.failures)} 个文件：", file=sys.stderr)
        for p, err in dl.failures[:20]:
            print(f"    {p}: {err}", file=sys.stderr)
        return 1
    done_count = sum(1 for e in download_entries if e["hash"] in dl.ok_hashes)
    print(f"[*] 完成：{done_count}/{len(download_entries)} 个文件已就绪。")

    if args.masterdata:
        run_masterdata(output)
    return 0


def run_masterdata(output: Path) -> None:
    """从 Assets/config.ys 提取 Config 并反序列化到 <output>/MasterData。"""
    ys = output / "Assets" / "config.ys"
    if not ys.exists():
        print(
            f"[!] 未找到 {ys}，跳过数据表解析（请先下载 config.ys）",
            file=sys.stderr,
        )
        return
    repo_root = Path(__file__).resolve().parent.parent
    sys.path.insert(0, str(repo_root / "masterdata"))
    try:
        from extract_config import extract_config_bin  # noqa: PLC0415
        from config_parser import (
            load_schema,
            parse_config,
            write_masterdata,
        )  # noqa: PLC0415
    except ImportError:
        print(
            "[!] 缺少 masterdata 模块（UnityPy 依赖），请先: "
            "pip install UnityPy tpk_ar",
            file=sys.stderr,
        )
        return
    try:
        print("[*] 提取 Config 数据表 ...")
        cfg = extract_config_bin(ys)
        schema = load_schema(repo_root / "masterdata" / "config_schema.json")
        tables = parse_config(cfg, schema)
        write_masterdata(tables, output / "MasterData")
        raw_rows = sum(1 for t in tables for r in t["rows"] if "__raw__" in r["data"])
        unknown = sum(
            len(r["data"].get("__unknown__", []))
            for t in tables
            for r in t["rows"]
            if "__unknown__" in r["data"]
        )
        print(
            f"[*] 数据表完成：{len(tables)} 表 / "
            f"{sum(t['rowCount'] for t in tables)} 行，"
            f"未解码 {raw_rows}，未知字段 {unknown}"
        )
        print(f"[*] MasterData -> {output / 'MasterData'}")
    except Exception as exc:  # noqa: BLE001
        print(f"[!] 数据表解析失败: {exc}", file=sys.stderr)


if __name__ == "__main__":
    sys.exit(main())
