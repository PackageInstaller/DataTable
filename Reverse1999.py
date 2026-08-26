from __future__ import annotations

import argparse
import gzip
import hashlib
import io
import json
import os
import re
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
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    ProgressColumn,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)
from rich.text import Text

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
PORTRAIT_DIR = SCRIPT_DIR / "Painting"
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
AB_MAGICS = (b"UnityFS", b"UnityRaw", b"UnityWeb", b"UnityNEt")
PORTRAIT_AB_DIR = "singlebg/headicon_img"
GAME_TITLE = "重返未来1999"
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


def aes_decrypt(data: bytes) -> bytes:
    """RsaVerity：跳过 48 字节签名后 AES-256-CBC PKCS7。"""
    if len(data) <= SIG_LEN:
        raise ValueError(f"too short for AES: {len(data)}")
    blob = data[SIG_LEN:]
    if len(blob) % 16:
        raise ValueError(f"AES payload not block-aligned: {len(blob)}")
    cipher = AES.new(AES_PASSWORD, AES.MODE_CBC, AES_IV)
    return unpad(cipher.decrypt(blob), 16)


def unwrap_config(data: bytes, *, encrypted: bool) -> bytes:
    if encrypted and not data.startswith(b"{") and data[:2] != b"\x1f\x8b":
        data = aes_decrypt(data)
    return maybe_gunzip(data)


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
        if lua_only and not (
            path.startswith("luabytes/") or path.startswith("configs/")
        ):
            continue
        if path in seen:
            continue
        seen.add(path)
        items.append({**meta, "section": section, "group": group})
    return items


def collect_paths(resinfo: dict, paths: Iterable[str]) -> list[dict]:
    want = {p.replace("\\", "/").lstrip("/") for p in paths}
    items: list[dict] = []
    seen: set[str] = set()
    for section, group, meta in iter_resinfo(resinfo):
        path = meta["path"]
        if path not in want or path in seen:
            continue
        seen.add(path)
        items.append({**meta, "section": section, "group": group})
    missing = want - seen
    if missing:
        console.print(f"[yellow]resinfo 缺少 {len(missing)} 个路径[/yellow]")
    return items


def file_url(item: dict, host: str) -> str:
    return f"{host.rstrip('/')}/{GAME_ID}/{PLATFORM}/{item['v']}/{item['path']}"


def is_bundle_path(path: str) -> bool:
    return path.startswith("bundles/") and path.endswith(".dat")


def ab_encrypt_offset(md5_name: str) -> int:
    """FileLoader.GetAbEncryptKey：对 MD5 文件名（不含路径/.dat）逐字符求和。

    偶数再 +2，奇数再 +4，然后 (sum % 8) + 1，得到 1–8。
    游戏用 AssetBundle.LoadFromFile(path, crc=0, offset=key) 跳过这段头部
    """
    total = sum(ord(c) for c in md5_name)
    extra = 4 if total & 1 else 2
    return (total + extra) % 8 + 1


def looks_like_unityfs(buf: bytes) -> bool:
    return any(buf.startswith(m) for m in AB_MAGICS)


def strip_ab_header(dest: Path, rel_path: str) -> int:
    """去掉 bundles/*.dat 头部字节。返回去掉的长度，已是 UnityFS 则返回 0。"""
    if not is_bundle_path(rel_path) or not dest.is_file():
        return 0
    off = ab_encrypt_offset(Path(rel_path).stem)
    with dest.open("rb") as f:
        head = f.read(off + 8)
    if looks_like_unityfs(head):
        return 0
    if len(head) < off + 7 or not looks_like_unityfs(head[off:]):
        return 0
    tmp = dest.with_name(dest.name + ".strip")
    with dest.open("rb") as src, tmp.open("wb") as out:
        src.seek(off)
        shutil.copyfileobj(src, out, CHUNK_SIZE)
    os.replace(tmp, dest)
    return off


def finalize_asset(dest: Path, item: dict) -> int:
    """校验通过后处理本地文件。返回实际去掉的 AB 头长度。"""
    if is_bundle_path(item["path"]):
        return strip_ab_header(dest, item["path"])
    return 0


def expected_local_size(item: dict) -> int:
    size = int(item.get("size") or 0)
    if is_bundle_path(item["path"]):
        return max(0, size - ab_encrypt_offset(Path(item["path"]).stem))
    return size


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
            finalize_asset(dest, item)
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
            if dest.is_file() and rec.get("md5") == it["md5"]:
                local_sz = dest.stat().st_size
                if local_sz == expected_local_size(it):
                    skipped += 1
                    continue
                if local_sz == it["size"]:
                    rec["offset"] = finalize_asset(dest, it)
                    local_files[it["path"]] = rec
                    skipped += 1
                    continue
            hit = existing_copy(it["path"], it["md5"])
            if hit is not None:
                dest.parent.mkdir(parents=True, exist_ok=True)
                if hit != dest:
                    shutil.copy2(hit, dest)
                off = finalize_asset(dest, it)
                local_files[it["path"]] = {
                    "md5": it["md5"],
                    "size": it["size"],
                    "v": it["v"],
                    "offset": off,
                }
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
                                "offset": ab_encrypt_offset(Path(it["path"]).stem)
                                if is_bundle_path(it["path"])
                                else 0,
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


def find_configs_dir() -> Path | None:
    for p in (ASSETS_DIR / "configs", SCRIPT_DIR / "configs"):
        if p.is_dir():
            return p
    return None


def _write_bytes(dest: Path, data: bytes) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(data)


def convert_configs() -> int:
    """AES/gzip 解开 Assets/configs，拆成 MasterData/configs 下的 JSON 表。"""
    src_root = find_configs_dir()
    if src_root is None:
        console.print("[yellow]没有 configs 目录，跳过配表解密[/yellow]")
        return 0

    excel_dir = MASTER_DIR / "configs" / "excel2json"
    lang_dir = MASTER_DIR / "configs" / "language"
    excel_dir.mkdir(parents=True, exist_ok=True)
    lang_dir.mkdir(parents=True, exist_ok=True)

    fail = 0
    tables = 0
    written: set[str] = set()

    datacfgs = sorted(src_root.glob("datacfg_*.dat"))
    if not datacfgs:
        console.print(f"[yellow]{src_root} 里没有 datacfg_*.dat[/yellow]")

    for src in datacfgs:
        try:
            obj = json.loads(unwrap_config(src.read_bytes(), encrypted=True))
            if not isinstance(obj, dict):
                raise ValueError(f"不是 JSON 对象: {type(obj)}")
            for key, blob in obj.items():
                name = str(key)
                if not name.endswith(".json"):
                    name = name + ".json"
                dest = excel_dir / Path(name).name
                if isinstance(blob, str):
                    dest.write_text(blob, encoding="utf-8")
                else:
                    dest.write_text(
                        json.dumps(blob, ensure_ascii=False, indent=2),
                        encoding="utf-8",
                    )
                written.add(dest.name)
                tables += 1
            console.print(f"  [cyan]拆表[/cyan] {src.name} -> {len(obj)} 张")
        except Exception as exc:
            fail += 1
            console.print(f"[red]失败[/red] {src.name}: {exc}")

    for old in excel_dir.glob("json_*.json"):
        if old.name not in written:
            old.unlink()

    lang_src = src_root / "language"
    lang_n = 0
    if lang_src.is_dir():
        for src in sorted(lang_src.glob("*.dat")):
            try:
                data = unwrap_config(src.read_bytes(), encrypted=True)
                dest = lang_dir / src.name[:-4] if src.name.endswith(".dat") else lang_dir / src.name
                _write_bytes(dest, data)
                lang_n += 1
            except Exception as exc:
                fail += 1
                console.print(f"[red]失败[/red] {src.name}: {exc}")

    extras = (
        ("langcfg.dat", True, "langcfg.json"),
        ("metainfo.dat", False, "metainfo.json"),
        ("aotdlls.json", False, "aotdlls.json"),
    )
    extra_n = 0
    for name, encrypted, out_name in extras:
        src = src_root / name
        if not src.is_file():
            continue
        try:
            raw = src.read_bytes()
            data = unwrap_config(raw, encrypted=encrypted) if name.endswith(".dat") else raw
            _write_bytes(MASTER_DIR / "configs" / out_name, data)
            extra_n += 1
        except Exception as exc:
            fail += 1
            console.print(f"[red]失败[/red] {name}: {exc}")

    console.print(
        f"[bold green]Configs[/bold green] {tables} 张表"
        f"{f' + {lang_n} 语言' if lang_n else ''}"
        f"{f' + {extra_n} 其它' if extra_n else ''}"
        f" -> {MASTER_DIR / 'configs'}"
    )
    return 1 if fail else 0


def _first_existing(*cands: Path) -> Path | None:
    for p in cands:
        if p.is_file():
            return p
    return None


def load_allmanifest_bytes() -> bytes:
    hit = _first_existing(
        ASSETS_DIR / "configs" / "allmanifest.dat",
        SCRIPT_DIR / "configs" / "allmanifest.dat",
        SCRIPT_DIR / "decrypted" / "configs" / "allmanifest",
    )
    if hit is None:
        raise FileNotFoundError("找不到 configs/allmanifest")
    return maybe_gunzip(hit.read_bytes())


def load_datacfg(index: int) -> dict:
    name = f"datacfg_{index}"
    encrypted = _first_existing(
        ASSETS_DIR / "configs" / f"{name}.dat",
        SCRIPT_DIR / "configs" / f"{name}.dat",
    )
    plain = SCRIPT_DIR / "decrypted" / "configs" / name
    if encrypted is not None:
        try:
            return json.loads(unwrap_config(encrypted.read_bytes(), encrypted=True))
        except Exception:
            pass
    if plain.is_file():
        return json.loads(maybe_gunzip(plain.read_bytes()))
    raise FileNotFoundError(f"找不到 configs/{name}")


def parse_excel_rows(blob: Any) -> list[list]:
    if isinstance(blob, str):
        blob = json.loads(blob)
    if isinstance(blob, list) and len(blob) >= 2 and isinstance(blob[1], list):
        return blob[1]
    if isinstance(blob, list):
        return blob
    return []


def is_portrait_ab(ab_name: str) -> bool:
    return ab_name == PORTRAIT_AB_DIR or ab_name.startswith(PORTRAIT_AB_DIR + "_")


def recover_ab_names(allmanifest: bytes, bundle_stems: set[str]) -> dict[str, str]:
    """从 BinaryFormatter 明文串还原 abName -> md5 文件名。"""
    names: dict[str, str] = {}
    for m in re.finditer(rb"[\x20-\x7e]{4,}", allmanifest):
        s = m.group().decode("ascii")
        h = hashlib.md5(s.encode("utf-8")).hexdigest()
        if h in bundle_stems:
            names[s] = h
    return names


def sanitize_filename(name: str) -> str:
    name = re.sub(r'[\\/:*?"<>|\x00-\x1f]', "_", name).strip().rstrip(".")
    return name or "unnamed"


def _cell(row: list, idx: int) -> str:
    if idx >= len(row) or row[idx] is None:
        return ""
    return str(row[idx]).strip()


def load_portrait_mappings() -> dict[str, tuple[str, str, str]]:
    """资源名（皮肤 id / drawing / headIcon）-> (角色名, 皮肤名, 皮肤id)。"""
    cfg = load_datacfg(4)
    skins = parse_excel_rows(cfg.get("json_skin"))
    chars = parse_excel_rows(cfg.get("json_character"))
    char_name = {_cell(r, 0): _cell(r, 1) for r in chars if _cell(r, 0)}
    mapping: dict[str, tuple[str, str, str]] = {}
    for row in skins:
        skin_id = _cell(row, 0)
        if not skin_id:
            continue
        hero = char_name.get(_cell(row, 5)) or _cell(row, 1)
        title = _cell(row, 58) or ""
        if not title:
            raw_name = _cell(row, 1)
            if raw_name and raw_name != hero:
                title = raw_name
        stems = {skin_id, _cell(row, 14), _cell(row, 25), _cell(row, 27)}
        for stem in stems:
            if stem and stem not in mapping:
                mapping[stem] = (hero, title, skin_id)
    return mapping


def portrait_basename(stem: str, mapping: dict[str, tuple[str, str, str]]) -> str:
    hero, title, skin_id = mapping.get(stem, ("", "", stem))
    if hero and title:
        base = f"{GAME_TITLE}_{hero}_{title}"
    elif hero:
        base = f"{GAME_TITLE}_{hero}"
    else:
        base = f"{GAME_TITLE}_{stem}"
    return sanitize_filename(base)


def portrait_dest(stem: str, mapping: dict[str, tuple[str, str, str]], used: set[str]) -> Path:
    base = portrait_basename(stem, mapping)
    name = base + ".png"
    if name in used:
        _, _, skin_id = mapping.get(stem, ("", "", stem))
        name = sanitize_filename(f"{base}_{skin_id or stem}") + ".png"
    used.add(name)
    return PORTRAIT_DIR / name


def _texture_stem(container: str, tex_name: str) -> str:
    if container:
        raw = Path(container.replace("\\", "/")).name
        return Path(raw).stem
    return Path(tex_name).stem


def is_portrait_container(path: str) -> bool:
    p = path.replace("\\", "/").lower()
    return "/singlebg/headicon_img/" in p or p.startswith("singlebg/headicon_img/")


def extract_portrait_textures(bundle: Path) -> list[tuple[str, str, Any]]:
    """返回 (container路径, Texture2D 名, PIL Image)。"""
    import UnityPy

    env = UnityPy.load(str(bundle))
    hits: list[tuple[str, str, Any]] = []
    seen: set[int] = set()

    def take(obj, container: str) -> None:
        try:
            if getattr(getattr(obj, "type", None), "name", None) != "Texture2D":
                return
            if obj.path_id in seen:
                return
            tex = obj.read()
            img = getattr(tex, "image", None)
            if img is None:
                return
            seen.add(obj.path_id)
            hits.append((container, str(getattr(tex, "m_Name", "") or ""), img))
        except Exception:
            return

    for cpath, obj in (getattr(env, "container", None) or {}).items():
        if not is_portrait_container(str(cpath)):
            continue
        entries = obj if isinstance(obj, (list, tuple)) else [obj]
        for one in entries:
            take(one, str(cpath))
    if not hits:
        for obj in env.objects:
            take(obj, "")
    return hits


def export_portraits(
    bundles: list[Path], mapping: dict[str, tuple[str, str, str]], force: bool
) -> tuple[int, int, int]:
    PORTRAIT_DIR.mkdir(parents=True, exist_ok=True)
    used: set[str] = set()
    seen_stems: set[str] = set()
    ok = skip = fail = 0
    failures: dict[str, str] = {}
    progress = Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
        transient=False,
        refresh_per_second=8,
    )
    with progress:
        task = progress.add_task("[cyan]导出立绘", total=len(bundles))
        for bundle in bundles:
            try:
                textures = extract_portrait_textures(bundle)
                if not textures:
                    raise ValueError("没有 Texture2D")
                for container, tex_name, img in textures:
                    stem = _texture_stem(container, tex_name)
                    if stem in seen_stems:
                        skip += 1
                        continue
                    seen_stems.add(stem)
                    dest = portrait_dest(stem, mapping, used)
                    if dest.exists() and not force:
                        skip += 1
                        continue
                    if getattr(img, "mode", "") not in ("RGB", "RGBA"):
                        img = img.convert("RGBA")
                    img.save(dest, "PNG")
                    ok += 1
            except Exception as exc:
                fail += 1
                failures[bundle.name] = str(exc)
                progress.live.print(f"[red]失败[/red] {bundle.name}: {exc}")
            progress.advance(task)
    if failures:
        (SCRIPT_DIR / "portrait_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    return ok, skip, fail


def run_portrait(threads: int, force: bool) -> int:
    console.print("[bold]查询热更[/bold] Android / 国服 50001  立绘模式")
    version_info, resource = query_latest()
    latest = version_info.get("latestVersion") or "?"
    console.print(f"  远程版本 [green]{latest}[/green]")
    resinfo = load_resinfo(resource)

    cfg_items = collect_paths(
        resinfo, ["configs/allmanifest.dat", "configs/datacfg_4.dat"]
    )
    if cfg_items:
        console.print(f"  配置 {len(cfg_items)} 个")
        download_items(cfg_items, threads, force, latest)

    allmanifest = load_allmanifest_bytes()
    bundle_stems = {
        Path(meta["path"]).stem
        for _, _, meta in iter_resinfo(resinfo)
        if is_bundle_path(meta["path"])
    }
    ab_names = recover_ab_names(allmanifest, bundle_stems)
    portrait_abs = {name: md5 for name, md5 in ab_names.items() if is_portrait_ab(name)}
    if not portrait_abs:
        console.print("[red]allmanifest 里没有 singlebg/headicon_img 相关 bundle[/red]")
        return 1
    console.print(f"  识别到 {len(portrait_abs)} 个立绘目录（MD5(abName)=文件名）")

    bundle_paths = [f"bundles/{md5}.dat" for md5 in portrait_abs.values()]
    items = collect_paths(resinfo, bundle_paths)
    total = sum(it["size"] for it in items)
    console.print(
        f"  立绘 bundle {len(items)} 个 / {total / 1024 ** 2:.1f} MB"
        f"（{threads} 线程）  CDN {CDN_HOSTS[0]}"
    )
    ok, fail, skipped = download_items(items, threads, force, latest)
    console.print(
        f"[bold]下载完成[/bold] 成功={ok} 失败={fail} 跳过={skipped}  -> {ASSETS_DIR}"
    )
    if fail:
        console.print("[yellow]存在失败文件，仍尝试导出已有 bundle[/yellow]")

    mapping = load_portrait_mappings()
    console.print(f"  皮肤映射 {len(mapping)} 条")

    local_bundles = []
    for it in items:
        dest = ASSETS_DIR / it["path"]
        if dest.is_file():
            local_bundles.append(dest)
    exported, skipped_png, exp_fail = export_portraits(local_bundles, mapping, force)
    pngs = sum(1 for _ in PORTRAIT_DIR.glob("*.png"))
    console.print(
        f"[bold green]Painting[/bold green] 新导出={exported} 跳过={skipped_png} "
        f"失败={exp_fail}  共 {pngs} 张 -> {PORTRAIT_DIR}"
    )
    return 1 if fail or exp_fail else 0


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
    label = "Lua / 配表" if lua_only else "资产"
    console.print(
        f"  {label} {len(items)} 个 / {total / 1024 ** 3:.2f} GB"
        f"（{threads} 线程）  CDN {CDN_HOSTS[0]}"
    )
    ok, fail, skipped = download_items(items, threads, force, latest)
    console.print(
        f"[bold]下载完成[/bold] 成功={ok} 失败={fail} 跳过={skipped}  -> {ASSETS_DIR}"
    )
    if fail:
        console.print("[yellow]存在失败文件，仍尝试转换已有 Lua / 配表[/yellow]")
    rc_cfg = convert_configs()
    rc = convert_lua(threads)
    return 1 if fail or rc or rc_cfg else 0


def main() -> int:
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "mode",
        nargs="?",
        choices=("lua", "masterdata", "data", "portrait", "painting"),
        help="lua=只转 Lua+配表；portrait=只导出角色立绘到 Painting/；省略则下载全部资产",
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
    threads = max(1, args.threads)
    if args.mode in ("portrait", "painting"):
        return run_portrait(threads, args.force)
    lua_only = args.mode in ("lua", "masterdata", "data")
    return run(
        lua_only=lua_only,
        threads=threads,
        force=args.force,
        include_dlc=not args.no_dlc,
    )


if __name__ == "__main__":
    sys.exit(main())
