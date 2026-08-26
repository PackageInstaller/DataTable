from __future__ import annotations

import argparse
import gzip
import hashlib
import io
import json
import os
import shutil
import struct
import subprocess
import sys
import tempfile
import threading
import time
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Callable, Iterable
from urllib.parse import urlencode

import requests
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    ProgressColumn,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)
from rich.text import Text

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
MANIFEST_PATH = ASSETS_DIR / ".manifest.json"
RESINFO_CACHE = ASSETS_DIR / ".resinfo.json"

GAME_ID = "50001"
PACKAGE_NAME = "com.shenlan.m.reverse1999"
CHANNEL_ID = 100
SUB_CHANNEL_ID = 1001
APP_VERSION = 160
SERVER_TYPE = 4
OS_TYPE = 0
PLATFORM = "Android"

VERSION_HOSTS = (
    "https://hotupdate-bak.sl916.com",
    "https://hotupdate.sl916.com",
)
CDN_HOSTS = (
    "https://upres.sl916.com",
    "https://upres-bak.sl916.com",
)

USER_AGENT = "UnityPlayer/2022.3.62f2 (UnityWebRequest/1.0, libcurl/8.5.0-DEV)"
DEFAULT_JOBS = 16
RETRY_COUNT = 5
CHUNK_SIZE = 1 << 20
TIMEOUT = (15, 300)

AES_PASSWORD = "@_#*&Reverse2806".ljust(32).encode("utf-8")
AES_IV = b"!_#@2022_Skyfly)"
SIG_LEN = 48

LUA_PACKS_64 = {
    "e4aa0a3b862979c25941c15c5d99a547": "tolua_64",
    "9981b62cca43bcb97f4b9a8f14b534de": "booter_64",
    "6ac5a62c64b72b07e9383583eef5c3ac": "projbooter_64",
    "0152dd935893d08e38c0685092d77c07": "framework_64",
    "9c2019bedb92e2327bfe12024e2922a4": "modules_64",
}

console = Console()
_tls = threading.local()


class TaskStatsColumn(ProgressColumn):
    """字节任务显示 MB/GB，文件任务显示个数。"""

    def render(self, task) -> Text:
        if task.fields.get("kind") == "files":
            completed = int(task.completed)
            total = int(task.total) if task.total is not None else 0
            width = len(str(total)) if total else 1
            return Text(f"{completed:{width}d}/{total} 个", style="progress.download")
        return DownloadColumn().render(task)


class TaskSpeedColumn(ProgressColumn):
    def render(self, task) -> Text:
        if task.fields.get("kind") == "files":
            return Text("")
        return TransferSpeedColumn().render(task)


class _ProgressPump:
    """下载线程只改计数，单独线程定时写进 Progress。"""

    def __init__(self, progress: Progress, t_bytes, t_files):
        self.progress = progress
        self.t_bytes = t_bytes
        self.t_files = t_files
        self._bytes = 0
        self._files = 0
        self._lock = threading.Lock()
        self._stop = threading.Event()
        self._thr = threading.Thread(target=self._run, name="progress-pump", daemon=True)

    def add_bytes(self, n: int) -> None:
        if not n:
            return
        with self._lock:
            self._bytes = max(0, self._bytes + n)

    def add_file(self, n: int = 1) -> None:
        with self._lock:
            self._files += n

    def start(self) -> None:
        self._thr.start()

    def close(self) -> None:
        self._stop.set()
        self._thr.join(timeout=2)
        self._flush()

    def _run(self) -> None:
        while not self._stop.wait(0.15):
            self._flush()
        self._flush()

    def _flush(self) -> None:
        with self._lock:
            b, f = self._bytes, self._files
        self.progress.update(self.t_bytes, completed=b)
        self.progress.update(self.t_files, completed=f)


def get_session() -> requests.Session:
    sess = getattr(_tls, "session", None)
    if sess is None:
        sess = requests.Session()
        sess.headers["User-Agent"] = USER_AGENT
        _tls.session = sess
    return sess


def file_md5(path: Path, chunk: int = CHUNK_SIZE) -> str:
    h = hashlib.md5()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(chunk), b""):
            h.update(block)
    return h.hexdigest()


def maybe_gunzip(data: bytes) -> bytes:
    if data[:2] == b"\x1f\x8b":
        return gzip.decompress(data)
    return data


def read_7bit(buf: io.BytesIO) -> int:
    value = 0
    shift = 0
    while True:
        b = buf.read(1)
        if not b:
            raise EOFError("truncated 7-bit int")
        value |= (b[0] & 0x7F) << shift
        if b[0] & 0x80 == 0:
            return value
        shift += 7
        if shift > 35:
            raise ValueError("invalid 7-bit int")


def lj_source_name(data: bytes) -> str | None:
    if data[:3] != b"\x1bLJ" or len(data) < 6:
        return None
    buf = io.BytesIO(data[5:])
    n = read_7bit(buf)
    name = buf.read(n).decode("utf-8", "replace")
    if not name:
        return None
    return name[1:] if name.startswith("@") else name


def unpack_lua_pack(data: bytes, named_dir: Path) -> int:
    payload = data[SIG_LEN:]
    buf = io.BytesIO(payload)
    count = 0
    while buf.tell() < len(payload):
        n = read_7bit(buf)
        key = buf.read(n).decode("utf-8")
        (size,) = struct.unpack("<i", buf.read(4))
        raw = bytearray(buf.read(size))
        if len(raw) != size:
            raise ValueError(f"short read for {key}: {len(raw)}/{size}")
        kb = key.encode("utf-8")
        for i in range(len(raw)):
            raw[i] ^= kb[i % len(kb)]
        plain = gzip.decompress(bytes(raw))
        src = lj_source_name(plain) or f"_unknown/{key}.lua"
        dest = named_dir / src
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(plain)
        count += 1
    return count


def http_get(url: str, *, headers: dict | None = None, stream: bool = False) -> requests.Response:
    last: Exception | None = None
    for attempt in range(RETRY_COUNT):
        try:
            resp = get_session().get(
                url, headers=headers, stream=stream, timeout=TIMEOUT
            )
            resp.raise_for_status()
            return resp
        except Exception as exc:
            last = exc
            time.sleep(min(2**attempt, 8))
    raise RuntimeError(f"GET 失败 {url}: {last}")


def fetch_json(url: str) -> dict:
    return http_get(url).json()


def query_latest() -> tuple[dict, dict]:
    params = {
        "osType": OS_TYPE,
        "version": "1.0.0",
        "channelId": CHANNEL_ID,
        "appVersion": APP_VERSION,
        "packageName": PACKAGE_NAME,
        "subChannelId": SUB_CHANNEL_ID,
        "serverType": SERVER_TYPE,
    }
    last: Exception | None = None
    for host in VERSION_HOSTS:
        try:
            ver = fetch_json(f"{host}/patch/{GAME_ID}/version?{urlencode(params)}")
            latest = ver.get("latestVersion") or ""
            res_params = dict(params)
            res_params["version"] = "1.0.0"
            res_params["targetVersion"] = latest
            res = fetch_json(f"{host}/patch/{GAME_ID}/resource?{urlencode(res_params)}")
            return ver, res
        except Exception as exc:
            last = exc
    raise RuntimeError(f"查询热更失败: {last}")


def load_resinfo(resource: dict) -> dict:
    hosted = resource.get("selfHostedRes") or {}
    base = hosted.get("baseUrl") or CDN_HOSTS[0]
    bak = hosted.get("baseUrlBak") or CDN_HOSTS[1]
    path = hosted.get("manifestPath") or ""
    if not path:
        raise RuntimeError("resource 没有 selfHostedRes.manifestPath")
    last: Exception | None = None
    for root in (base, bak):
        url = root.rstrip("/") + path
        try:
            raw = http_get(url).content
            with zipfile.ZipFile(io.BytesIO(raw)) as zf:
                names = zf.namelist()
                hit = next((n for n in names if n.endswith("resinfo.dat") or n.endswith("resinfo")), None)
                if hit is None:
                    raise RuntimeError(f"zip 里没有 resinfo: {names}")
                data = maybe_gunzip(zf.read(hit))
            info = json.loads(data)
            ASSETS_DIR.mkdir(parents=True, exist_ok=True)
            RESINFO_CACHE.write_text(json.dumps(info, ensure_ascii=False), encoding="utf-8")
            return info
        except Exception as exc:
            last = exc
    raise RuntimeError(f"下载 resinfo 失败: {last}")


def iter_resinfo(resinfo: dict) -> Iterable[tuple[str, str, dict]]:
    """yield (section, group, {path, md5, size, v})。section 为 main/dlc。"""
    for section in ("main", "dlc"):
        groups = resinfo.get(section) or {}
        if not isinstance(groups, dict):
            continue
        for group, files in groups.items():
            if not isinstance(files, dict):
                continue
            for path, meta in files.items():
                if not isinstance(meta, dict) or "md5" not in meta:
                    continue
                yield section, str(group), {
                    "path": path.replace("\\", "/").lstrip("/"),
                    "md5": str(meta.get("md5") or "").lower(),
                    "size": int(meta.get("size") or 0),
                    "v": str(meta.get("v") or ""),
                }


def collect_items(resinfo: dict, lua_only: bool, include_dlc: bool) -> list[dict]:
    items: list[dict] = []
    seen: set[str] = set()
    for section, group, meta in iter_resinfo(resinfo):
        if section == "dlc" and not include_dlc:
            continue
        path = meta["path"]
        if lua_only and not path.startswith("luabytes/"):
            continue
        if path in seen:
            continue
        seen.add(path)
        items.append({**meta, "section": section, "group": group})
    return items


def file_url(item: dict, host: str) -> str:
    return f"{host.rstrip('/')}/{GAME_ID}/{PLATFORM}/{item['v']}/{item['path']}"


def existing_copy(rel: str, expect_md5: str) -> Path | None:
    for root in (ASSETS_DIR, SCRIPT_DIR):
        cand = root / rel
        if cand.is_file() and (not expect_md5 or file_md5(cand) == expect_md5):
            return cand
    return None


def download_one(item: dict, dest: Path, on_bytes: Callable[[int], None] | None) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_name(dest.name + ".part")
    expect = item["md5"]
    size = item["size"]
    last_err: Exception | None = None
    reported = 0

    def report(n: int) -> None:
        nonlocal reported
        if on_bytes and n:
            on_bytes(n)
            reported += n

    def rewind() -> None:
        nonlocal reported
        if on_bytes and reported:
            on_bytes(-reported)
        reported = 0

    for attempt in range(RETRY_COUNT):
        rewind()
        host = CDN_HOSTS[attempt % len(CDN_HOSTS)]
        url = file_url(item, host)
        try:
            headers = {}
            offset = 0
            hasher = hashlib.md5()
            if tmp.is_file() and tmp.stat().st_size > 0:
                offset = tmp.stat().st_size
                headers["Range"] = f"bytes={offset}-"
                with tmp.open("rb") as old:
                    for block in iter(lambda: old.read(CHUNK_SIZE), b""):
                        hasher.update(block)
            resp = get_session().get(url, headers=headers or None, stream=True, timeout=TIMEOUT)
            if resp.status_code == 416:
                tmp.unlink(missing_ok=True)
                raise RuntimeError("416 range")
            if offset and resp.status_code != 206:
                tmp.unlink(missing_ok=True)
                offset = 0
                hasher = hashlib.md5()
                resp.close()
                resp = get_session().get(url, stream=True, timeout=TIMEOUT)
            resp.raise_for_status()
            mode = "ab" if offset and resp.status_code == 206 else "wb"
            if mode == "wb":
                offset = 0
                hasher = hashlib.md5()
                report(0)
            n = offset
            if offset:
                report(offset)
            with tmp.open(mode) as f:
                for chunk in resp.iter_content(CHUNK_SIZE):
                    if not chunk:
                        continue
                    f.write(chunk)
                    hasher.update(chunk)
                    n += len(chunk)
                    report(len(chunk))
            got = hasher.hexdigest()
            if expect and got != expect:
                raise RuntimeError(f"MD5 不符 {got} != {expect}")
            if size and n != size:
                raise RuntimeError(f"大小不符 {n} != {size}")
            os.replace(tmp, dest)
            if size and reported != size:
                report(size - reported)
            return "ok"
        except Exception as exc:
            last_err = exc
            tmp.unlink(missing_ok=True)
            time.sleep(min(2**attempt, 8))
    rewind()
    raise RuntimeError(f"{item['path']}: {last_err}")


def load_manifest() -> dict:
    if not MANIFEST_PATH.is_file():
        return {}
    try:
        return json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
    except Exception:
        return {}


def save_manifest(mani: dict) -> None:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    MANIFEST_PATH.write_text(json.dumps(mani, ensure_ascii=False, indent=2), encoding="utf-8")


def download_items(items: list[dict], threads: int, force: bool, version: str) -> tuple[int, int, int]:
    mani = load_manifest()
    local_files: dict[str, Any] = dict(mani.get("files") or {})
    pending: list[dict] = []
    skipped = 0
    for it in items:
        dest = ASSETS_DIR / it["path"]
        rec = local_files.get(it["path"]) or {}
        if not force:
            hit = existing_copy(it["path"], it["md5"])
            if hit is not None:
                if hit != dest:
                    dest.parent.mkdir(parents=True, exist_ok=True)
                    if not dest.is_file():
                        shutil.copy2(hit, dest)
                local_files[it["path"]] = {"md5": it["md5"], "size": it["size"], "v": it["v"]}
                skipped += 1
                continue
            if dest.is_file() and rec.get("md5") == it["md5"] and dest.stat().st_size == it["size"]:
                skipped += 1
                continue
        pending.append(it)

    console.print(f"  跳过已是最新 {skipped}，实际下载 {len(pending)}")
    if not pending:
        mani.update({"version": version, "updated": time.strftime("%Y-%m-%d %H:%M:%S"), "files": local_files})
        save_manifest(mani)
        return 0, 0, skipped

    total_bytes = sum(it["size"] for it in pending)
    ok = fail = 0
    lock = threading.Lock()
    failures: dict[str, str] = {}
    progress = Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        "•",
        TaskStatsColumn(),
        "•",
        TaskSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
        transient=False,
        refresh_per_second=8,
        redirect_stdout=False,
        redirect_stderr=False,
    )
    with progress:
        t_bytes = progress.add_task("[cyan]下载", total=total_bytes or None, kind="bytes")
        t_files = progress.add_task("[green]文件", total=len(pending), kind="files")
        pump = _ProgressPump(progress, t_bytes, t_files)
        pump.start()

        def work(it: dict) -> tuple[bool, str, dict]:
            dest = ASSETS_DIR / it["path"]
            try:
                download_one(it, dest, pump.add_bytes)
                return True, "", it
            except Exception as exc:
                return False, str(exc), it

        try:
            with ThreadPoolExecutor(max_workers=max(1, threads)) as pool:
                futs = {pool.submit(work, it): it for it in pending}
                for fut in as_completed(futs):
                    success, msg, it = fut.result()
                    with lock:
                        if success:
                            ok += 1
                            local_files[it["path"]] = {
                                "md5": it["md5"],
                                "size": it["size"],
                                "v": it["v"],
                            }
                        else:
                            fail += 1
                            failures[it["path"]] = msg
                            progress.live.print(f"[red]失败[/red] {it['path']}: {msg}")
                        pump.add_file(1)
                    if (ok + fail) % 50 == 0:
                        with lock:
                            mani.update({"version": version, "files": local_files})
                            save_manifest(mani)
        finally:
            pump.close()

    mani.update(
        {
            "version": version,
            "updated": time.strftime("%Y-%m-%d %H:%M:%S"),
            "files": local_files,
        }
    )
    save_manifest(mani)
    if failures:
        (SCRIPT_DIR / "download_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    return ok, fail, skipped


def find_lua_pack(md5_name: str) -> Path | None:
    rel = f"luabytes/{md5_name}.dat"
    for root in (ASSETS_DIR, SCRIPT_DIR):
        cand = root / rel
        if cand.is_file():
            return cand
    return None


def convert_lua(threads: int) -> int:
    decompiler = shutil.which("luajit-decompiler")
    if not decompiler:
        console.print("[red]未找到 luajit-decompiler，请先安装到 PATH[/red]")
        return 1

    missing = [name for md5, name in LUA_PACKS_64.items() if find_lua_pack(md5) is None]
    if missing:
        console.print(f"[red]缺少 Lua 包: {', '.join(missing)}[/red]")
        return 1

    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="r1999-luabc-") as tmp:
        staging = Path(tmp)
        total = 0
        for md5, name in LUA_PACKS_64.items():
            src = find_lua_pack(md5)
            assert src is not None
            console.print(f"[cyan]拆包[/cyan] {name}  <- {src.name}")
            n = unpack_lua_pack(src.read_bytes(), staging)
            total += n
            console.print(f"  {n} 个字节码")
        console.print(
            f"[cyan]反编译[/cyan] {total} 个文件 -> {MASTER_DIR}  "
            f"({threads} 线程)"
        )
        log_path = ASSETS_DIR / ".luajit-decompile.log"
        ASSETS_DIR.mkdir(parents=True, exist_ok=True)
        with log_path.open("w", encoding="utf-8") as logf:
            proc = subprocess.run(
                [
                    decompiler,
                    str(staging),
                    "-o",
                    str(MASTER_DIR),
                    "-f",
                    "-s",
                    "-j",
                    str(max(1, threads)),
                ],
                stdout=logf,
                stderr=subprocess.STDOUT,
                check=False,
            )
        if proc.returncode != 0:
            console.print(
                f"[red]luajit-decompiler 退出码 {proc.returncode}[/red]  "
                f"日志 {log_path}"
            )
            return proc.returncode
    count = sum(1 for _ in MASTER_DIR.rglob("*.lua"))
    console.print(f"[bold green]MasterData[/bold green] {count} 个 .lua -> {MASTER_DIR}")
    return 0


def run(lua_only: bool, threads: int, force: bool, include_dlc: bool) -> int:
    console.print("[bold]查询热更[/bold] Android / 国服 50001")
    version_info, resource = query_latest()
    latest = version_info.get("latestVersion") or "?"
    console.print(
        f"  远程版本 [green]{latest}[/green]  "
        f"login={version_info.get('loginUri') or ''}"
    )
    resinfo = load_resinfo(resource)
    items = collect_items(resinfo, lua_only=lua_only, include_dlc=include_dlc)
    total = sum(it["size"] for it in items)
    label = "Lua 包" if lua_only else "资产"
    console.print(
        f"  {label} {len(items)} 个 / {total / 1024 ** 3:.2f} GB"
        f"（{threads} 线程）  CDN {CDN_HOSTS[0]}"
    )
    ok, fail, skipped = download_items(items, threads, force, latest)
    console.print(
        f"[bold]下载完成[/bold] 成功={ok} 失败={fail} 跳过={skipped}  -> {ASSETS_DIR}"
    )
    if fail:
        console.print("[yellow]存在失败文件，仍尝试转换已有 Lua[/yellow]")
    rc = convert_lua(threads)
    return 1 if fail or rc else 0


def main() -> int:
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "mode",
        nargs="?",
        choices=("lua", "masterdata", "data"),
        help="只下 luabytes 并转换到 MasterData；省略则下载全部资产",
    )
    parser.add_argument(
        "--threads",
        "--jobs",
        dest="threads",
        type=int,
        default=DEFAULT_JOBS,
        help="下载 / 反编译线程，默认 16",
    )
    parser.add_argument("--force", action="store_true", help="忽略本地清单强制重下")
    parser.add_argument(
        "--no-dlc",
        action="store_true",
        help="全量模式排除 dlc（语音/活动包）",
    )
    args = parser.parse_args()
    lua_only = args.mode in ("lua", "masterdata", "data")
    return run(
        lua_only=lua_only,
        threads=max(1, args.threads),
        force=args.force,
        include_dlc=not args.no_dlc,
    )


if __name__ == "__main__":
    sys.exit(main())
