from __future__ import annotations

import argparse
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
import warnings
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Callable, Iterable
from urllib.parse import urljoin

import requests
from Crypto.Cipher import AES
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)
from rich.table import Table

ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
ZIP_DIR = ROOT / "Zips"
HYBRIDCLR_DIR = ROOT / "HybridCLR"
MASTER_DIR = ROOT / "MasterData"
PAINTING_DIR = ROOT / "Painting"
MANIFEST_PATH = ASSETS_DIR / ".manifest.json"
CHAR_BUNDLE_DIR = ASSETS_DIR / "bundles" / "res" / "character"
RES_MANIFEST_AB = ASSETS_DIR / "bundles" / "resmainfest.ab"
GAME_TITLE = "少女前线：云图计划"

LOGIN_HOST = "https://42lab-login.sunborngame.com"
GAME_CHANNEL_ID = 3
TYPE_ID = 1
APP_VERSION = "3.0.1"
PACKED_RES_VERSION = "3.0.0.0"
PLATFORM = "Android"
PATH_PRE = "Release"  # ChannelConfig.IsQA() == false
USER_AGENT = "UnityPlayer/2021.3.30f1c1 (UnityWebRequest/1.0, libcurl/8.1.1-DEV)"
X_UNITY_VERSION = "2021.3.30f1c1"

# EncryptionHelper.abKey / iv
AB_KEY_RAW = b"XmyxRyl38Yyq9yF7"
AES_IV = b"191twTUApO114514"
HYBRIDCLR_DIR_IN_PACK = "cs_script/release/"
AB_OFFSET = 8
LUA_MAGIC = b"\x1bLua"
UNITYFS = b"UnityFS"
ZIP_MAGIC = b"PK\x03\x04"

DEFAULT_JOBS = 4
RETRY_COUNT = 5
CHUNK_SIZE = 1 << 20
TIMEOUT = (15, 300)
UNLUAC_BIN = shutil.which("unluac") or "unluac"
UNLUAC_TIMEOUT = 180

console = Console()
_tls = threading.local()


def hybridclr_aes_key() -> bytes:
    """GetAssetBundleKey: XOR 下标 → MD5，前 8 字节 ToString("x2")。"""
    xored = bytes(AB_KEY_RAW[i] ^ i for i in range(len(AB_KEY_RAW)))
    digest = hashlib.md5(xored).digest()
    return "".join(f"{b:02x}" for b in digest[:8]).encode("ascii")


AES_KEY = hybridclr_aes_key()


def get_session() -> requests.Session:
    sess = getattr(_tls, "session", None)
    if sess is None:
        sess = requests.Session()
        sess.headers["User-Agent"] = USER_AGENT
        sess.headers["Accept"] = "*/*"
        sess.headers["X-Unity-Version"] = X_UNITY_VERSION
        _tls.session = sess
    return sess


def collect_version_str(packed: str = PACKED_RES_VERSION, app: str = APP_VERSION) -> str:
    """HotUpdateController.GetCollectResVersionStr = version + '_' + Application.version"""
    return f"{packed}_{app}"


def folder_from_res_version(res_version: str) -> str:
    parts = res_version.split(".")
    if len(parts) < 3:
        raise ValueError(f"无法从 ResVersion 取目录: {res_version}")
    return ".".join(parts[:3])


def version_tuple(ver: str) -> tuple[int, ...]:
    nums: list[int] = []
    for p in re.split(r"[._]", ver):
        if p.isdigit():
            nums.append(int(p))
    return tuple(nums)


def format_size(n: int) -> str:
    x = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if x < 1024 or unit == "TB":
            if unit == "B":
                return f"{int(x)} {unit}"
            return f"{x:.2f} {unit}"
        x /= 1024
    return f"{n} B"


def file_md5(path: Path, chunk: int = CHUNK_SIZE) -> str:
    h = hashlib.md5()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(chunk), b""):
            h.update(block)
    return h.hexdigest()


def find_apk() -> Path:
    apks = sorted(ROOT.glob("*.apk"))
    if not apks:
        raise FileNotFoundError(f"{ROOT} 下没有 apk")
    return apks[0]


def looks_like_pe(data: bytes) -> bool:
    return len(data) >= 2 and data[:2] == b"MZ"


def looks_like_zip(data: bytes) -> bool:
    return data[:4] == ZIP_MAGIC


def looks_like_unityfs(data: bytes) -> bool:
    return data[:7] == UNITYFS or (len(data) > AB_OFFSET + 7 and data[AB_OFFSET : AB_OFFSET + 7] == UNITYFS)


def aes_cbc_zeros(data: bytes) -> bytes:
    if len(data) < 16 or len(data) % 16:
        raise ValueError(f"AES 长度非法: {len(data)}")
    return AES.new(AES_KEY, AES.MODE_CBC, AES_IV).decrypt(data)


def decrypt_hybridclr_bytes(data: bytes) -> bytes:
    if looks_like_pe(data):
        return data
    plain = aes_cbc_zeros(data)
    if looks_like_pe(plain):
        return plain
    raise ValueError("解密后不是 PE")


def maybe_decrypt_blob(data: bytes) -> bytes:
    """zip / UnityFS / luac 若套了 HybridCLR 那套 AES，则解开。"""
    if looks_like_zip(data) or data[:4] == LUA_MAGIC or data[:7] == UNITYFS:
        return data
    if len(data) >= 16 and len(data) % 16 == 0:
        try:
            plain = aes_cbc_zeros(data)
        except ValueError:
            return data
        if looks_like_zip(plain) or plain[:4] == LUA_MAGIC or looks_like_pe(plain) or looks_like_unityfs(plain):
            return plain
    return data


def strip_ab(data: bytes) -> bytes:
    if data[:7] == UNITYFS:
        return data
    if len(data) > AB_OFFSET and data[AB_OFFSET : AB_OFFSET + 7] == UNITYFS:
        return data[AB_OFFSET:]
    return data


# ---------------------------------------------------------------------------
# 远端清单
# ---------------------------------------------------------------------------

def fetch_json(method: str, url: str, **kwargs: Any) -> dict[str, Any]:
    sess = get_session()
    last: Exception | None = None
    for attempt in range(1, RETRY_COUNT + 1):
        try:
            if method == "POST":
                resp = sess.post(url, timeout=TIMEOUT, **kwargs)
            else:
                resp = sess.get(url, timeout=TIMEOUT, **kwargs)
            resp.raise_for_status()
            return resp.json()
        except Exception as exc:  # noqa: BLE001
            last = exc
            time.sleep(min(8, attempt))
    raise RuntimeError(f"{url}: {last}")


def fetch_client_res() -> dict[str, Any]:
    version = collect_version_str()
    cfg = fetch_json(
        "POST",
        f"{LOGIN_HOST}/config",
        json={"game_channel_id": GAME_CHANNEL_ID, "version": version, "type_id": TYPE_ID},
        headers={"Content-Type": "application/json; charset=UTF-8"},
    )
    if cfg.get("code") not in (0, None):
        raise RuntimeError(f"config 失败: {cfg}")
    control = ((cfg.get("data") or {}).get("game_control") or {})
    client_url = control.get("client_res_v1") or (
        f"{LOGIN_HOST}/zone/client_res_v1"
        f"?type_id={TYPE_ID}&version={version}&game_channel_id={GAME_CHANNEL_ID}"
    )
    pkg = fetch_json("GET", client_url)
    if pkg.get("code") not in (0, None):
        raise RuntimeError(f"client_res_v1 失败: {pkg}")
    data = pkg.get("data") or {}
    if not data.get("ResUrlCdn") or not data.get("ResVersion"):
        raise RuntimeError(f"client_res 缺字段: {data}")
    return data


def res_base_urls(client: dict[str, Any]) -> tuple[str, list[str]]:
    folder = folder_from_res_version(str(client["ResVersion"]))
    cdn = str(client["ResUrlCdn"]).rstrip("/") + "/"
    oss = str(client.get("ResUrlOss") or "").rstrip("/") + "/"
    prefix = f"{folder}/{PLATFORM}/{PATH_PRE}/"
    bases = [urljoin(cdn, prefix)]
    if oss and oss != cdn:
        bases.append(urljoin(oss, prefix))
    return folder, bases


def fetch_version_res_info(bases: list[str]) -> dict[str, Any]:
    last: Exception | None = None
    for base in bases:
        url = urljoin(base, "VersionResInfo.json")
        try:
            resp = get_session().get(url, timeout=TIMEOUT)
            resp.raise_for_status()
            return resp.json()
        except Exception as exc:  # noqa: BLE001
            last = exc
    raise RuntimeError(f"VersionResInfo.json: {last}")


class ZipItem:
    __slots__ = ("res_name", "md5", "size", "kind", "version")

    def __init__(self, res_name: str, md5: str, size: int, kind: str, version: str) -> None:
        self.res_name = res_name
        self.md5 = md5.lower()
        self.size = int(size)
        self.kind = kind  # group | patch
        self.version = version


def parse_group_end_version(res_name: str) -> str | None:
    """3.0.0.0_3.0.0.1_part0.zip → 3.0.0.1"""
    m = re.match(r"^(\d+(?:\.\d+)*)_(\d+(?:\.\d+)*)_part\d+\.zip$", res_name)
    if m:
        return m.group(2)
    m = re.match(r"^(\d+(?:\.\d+)*)_part\d+\.zip$", res_name)
    if m:
        return m.group(1)
    return None


def build_download_list(info: dict[str, Any]) -> list[ZipItem]:
    """首次安装：resGroupVersion 四包 + 高于组合结束版本的增量。"""
    items: list[ZipItem] = []
    seen: set[str] = set()
    group_end: str | None = None

    groups = info.get("resGroupVersion") or {}
    # HAR / 现网: groups["1"]["0"]
    group_list: list[dict[str, Any]] = []
    if isinstance(groups, dict):
        for _gk, inner in groups.items():
            if not isinstance(inner, dict):
                continue
            for _ik, arr in inner.items():
                if isinstance(arr, list) and arr:
                    group_list = arr
                    break
            if group_list:
                break

    for raw in group_list:
        name = str(raw.get("resName") or "")
        if not name:
            continue
        items.append(
            ZipItem(name, str(raw.get("md5") or ""), int(raw.get("size") or 0), "group", name)
        )
        seen.add(name)
        end = parse_group_end_version(name)
        if end and (group_end is None or version_tuple(end) > version_tuple(group_end)):
            group_end = end

    res_version = info.get("resVersion") or {}
    versions = sorted(res_version.keys(), key=version_tuple)
    for ver in versions:
        if group_end and version_tuple(ver) <= version_tuple(group_end):
            continue
        for raw in res_version[ver]:
            name = str(raw.get("resName") or "")
            if not name or name in seen:
                continue
            items.append(
                ZipItem(name, str(raw.get("md5") or ""), int(raw.get("size") or 0), "patch", ver)
            )
            seen.add(name)
    return items


def print_status(client: dict[str, Any], items: list[ZipItem]) -> None:
    table = Table(title="云图计划 热更")
    table.add_column("项")
    table.add_column("值")
    table.add_row("ResVersion", str(client.get("ResVersion")))
    table.add_row("App 兼容", ",".join(client.get("AppVersionCompatible") or []))
    table.add_row("CDN", str(client.get("ResUrlCdn")))
    table.add_row("OSS", str(client.get("ResUrlOss")))
    table.add_row("清单条数", str(len(items)))
    table.add_row("总大小", format_size(sum(i.size for i in items)))
    console.print(table)
    detail = Table()
    detail.add_column("类型")
    detail.add_column("版本")
    detail.add_column("文件")
    detail.add_column("大小", justify="right")
    for it in items:
        detail.add_row(it.kind, it.version, it.res_name, format_size(it.size))
    console.print(detail)


# ---------------------------------------------------------------------------
# 下载 / 解压
# ---------------------------------------------------------------------------

def download_file(urls: list[str], dest: Path, item: ZipItem, force: bool, on_bytes: Callable[[int], None] | None) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if not force and dest.is_file() and dest.stat().st_size == item.size:
        if on_bytes:
            on_bytes(item.size)
        return "skip"
    tmp = dest.with_name(dest.name + ".part")
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
        url = urls[attempt % len(urls)]
        try:
            headers: dict[str, str] = {}
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
            if item.md5 and got != item.md5:
                raise RuntimeError(f"md5 {got} != {item.md5}")
            if item.size and n != item.size:
                raise RuntimeError(f"size {n} != {item.size}")
            with tmp.open("rb") as fh:
                head = fh.read(16)
            if not looks_like_zip(head):
                if tmp.stat().st_size % 16:
                    raise RuntimeError(f"不是 zip: {head[:8]!r}")
                fixed = dest.with_name(dest.stem + "_fixed.zip")
                _decrypt_file_aes(tmp, fixed)
                with fixed.open("rb") as fh:
                    head = fh.read(16)
                if not looks_like_zip(head):
                    fixed.unlink(missing_ok=True)
                    raise RuntimeError(f"解密后仍不是 zip: {head[:8]!r}")
                tmp.unlink(missing_ok=True)
                os.replace(fixed, dest)
            else:
                os.replace(tmp, dest)
            if item.size and reported != item.size:
                report(item.size - reported)
            return "ok"
        except Exception as exc:  # noqa: BLE001
            last_err = exc
            tmp.unlink(missing_ok=True)
            time.sleep(min(2 ** attempt, 8))
    rewind()
    raise RuntimeError(f"{item.res_name}: {last_err}")


def _decrypt_file_aes(src: Path, dest: Path) -> None:
    cipher = AES.new(AES_KEY, AES.MODE_CBC, AES_IV)
    with src.open("rb") as inf, dest.open("wb") as out:
        while True:
            chunk = inf.read(CHUNK_SIZE)
            if not chunk:
                break
            out.write(cipher.decrypt(chunk))


def safe_zip_name(name: str) -> str | None:
    name = name.replace("\\", "/").lstrip("/")
    if not name or name.endswith("/"):
        return None
    parts = name.split("/")
    if any(p in ("", ".", "..") for p in parts):
        return None
    return "/".join(parts)


def unzip_one(
    zip_path: Path,
    dest_root: Path,
    only: re.Pattern[str] | None = None,
    exclude: re.Pattern[str] | None = None,
) -> int:
    written = 0
    with zipfile.ZipFile(zip_path) as zf:
        for info in zf.infolist():
            rel = safe_zip_name(info.filename)
            if rel is None:
                continue
            low = rel.replace("\\", "/").lower()
            if only and not only.search(low):
                continue
            if exclude and exclude.search(low):
                continue
            out = dest_root / rel
            out.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(info, "r") as src, out.open("wb") as dst:
                shutil.copyfileobj(src, dst, CHUNK_SIZE)
            written += 1
    return written


def cmd_assets(jobs: int, force: bool, unzip: bool) -> int:
    client = fetch_client_res()
    folder, bases = res_base_urls(client)
    info = fetch_version_res_info(bases)
    items = build_download_list(info)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    ZIP_DIR.mkdir(parents=True, exist_ok=True)
    (ASSETS_DIR / "VersionResInfo.json").write_text(
        json.dumps(info, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print_status(client, items)

    total_bytes = sum(i.size for i in items)
    stats = {"ok": 0, "skip": 0, "fail": 0}
    errors: list[str] = []

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        TimeElapsedColumn(),
        console=console,
    ) as progress:
        t_bytes = progress.add_task("下载热更 zip", total=max(total_bytes, 1))
        lock = threading.Lock()
        done_bytes = 0

        def on_bytes(n: int) -> None:
            nonlocal done_bytes
            with lock:
                done_bytes = max(0, done_bytes + n)
                progress.update(t_bytes, completed=done_bytes)

        def work(item: ZipItem) -> tuple[str, ZipItem]:
            urls = [urljoin(b, item.res_name) for b in bases]
            dest = ZIP_DIR / item.res_name
            status = download_file(urls, dest, item, force, on_bytes)
            return status, item

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futs = [pool.submit(work, it) for it in items]
            for fut in as_completed(futs):
                try:
                    status, item = fut.result()
                    stats[status] = stats.get(status, 0) + 1
                    if status == "ok":
                        console.print(f"[green]完成[/] {item.res_name} ({format_size(item.size)})")
                except Exception as exc:  # noqa: BLE001
                    stats["fail"] += 1
                    errors.append(str(exc))
                    console.print(f"[red]失败[/] {exc}")

    console.print(
        f"[bold]下载[/] 完成 {stats['ok']}  跳过 {stats['skip']}  失败 {stats['fail']}"
    )
    if errors:
        (ROOT / "download_errors.log").write_text("\n".join(errors) + "\n", encoding="utf-8")

    if stats["fail"]:
        return 1
    if not unzip:
        return 0

    console.print("[cyan]解压到 Assets/（先 Lua/HybridCLR，再其余，按版本覆盖）[/]")
    priority = re.compile(r"(luascripts|cs_script|/tables\.ab$)", re.I)
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("解压优先", total=len(items) * 2)
        for item in items:
            zpath = ZIP_DIR / item.res_name
            progress.update(task, description=f"优先 {item.res_name}")
            n = unzip_one(zpath, ASSETS_DIR, only=priority)
            console.print(f"  优先 {item.res_name}: {n} 个文件")
            progress.advance(task)
        for item in items:
            zpath = ZIP_DIR / item.res_name
            progress.update(task, description=f"全量 {item.res_name}")
            n = unzip_one(zpath, ASSETS_DIR, exclude=priority)
            console.print(f"  其余 {item.res_name}: {n} 个文件")
            progress.advance(task)
    extract_apk_streaming_assets(force=False)
    return 0


def extract_apk_streaming_assets(force: bool = False) -> tuple[int, int]:
    """APK StreamingAssets 是 3.0.0.0 底包。热更 zip 不重复打进去的文件（Cubism 材质、大量 shared_*.ab）要从这里补。已存在的热更文件不覆盖。"""
    apk = find_apk()
    written = skipped = 0
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(apk) as zf:
        members = [
            info
            for info in zf.infolist()
            if info.filename.replace("\\", "/").startswith("assets/bundles/") and not info.is_dir()
        ]
        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            MofNCompleteColumn(),
            TimeElapsedColumn(),
            console=console,
        ) as progress:
            task = progress.add_task("APK bundles → Assets/", total=len(members))
            for info in members:
                rel = safe_zip_name(info.filename.replace("\\", "/")[len("assets/") :])
                progress.advance(task)
                if rel is None:
                    continue
                out = ASSETS_DIR / rel
                if out.is_file() and not force:
                    skipped += 1
                    continue
                out.parent.mkdir(parents=True, exist_ok=True)
                with zf.open(info, "r") as src, out.open("wb") as dst:
                    shutil.copyfileobj(src, dst, CHUNK_SIZE)
                written += 1
    console.print(f"[bold]APK 底包[/] 写出 {written}  已有热更跳过 {skipped}")
    return written, skipped


# ---------------------------------------------------------------------------
# HybridCLR
# ---------------------------------------------------------------------------

def iter_encrypted_dlls() -> Iterable[tuple[str, bytes, str]]:
    """(文件名, 密文, 来源)。Assets 覆盖 APK。"""
    found: dict[str, tuple[bytes, str]] = {}
    apk = find_apk()
    with zipfile.ZipFile(apk) as zf:
        for name in zf.namelist():
            low = name.replace("\\", "/").lower()
            if "/cs_script/release/" in low and name.lower().endswith(".dll.bytes"):
                found[Path(name).name] = (zf.read(name), f"apk:{name}")
    for path in ASSETS_DIR.rglob("*.dll.bytes"):
        rel = path.as_posix().lower()
        if "cs_script" in rel and "release" in rel:
            found[path.name] = (path.read_bytes(), str(path.relative_to(ASSETS_DIR)))
    for fname, (data, src) in sorted(found.items()):
        yield fname, data, src


def cmd_hybridclr() -> int:
    HYBRIDCLR_DIR.mkdir(parents=True, exist_ok=True)
    ok = fail = 0
    table = Table(title="HybridCLR AOT")
    table.add_column("DLL")
    table.add_column("来源")
    table.add_column("大小")
    table.add_column("状态")
    for fname, data, src in iter_encrypted_dlls():
        out_name = fname[: -len(".bytes")] if fname.endswith(".bytes") else fname
        out = HYBRIDCLR_DIR / out_name
        try:
            plain = decrypt_hybridclr_bytes(data)
            out.write_bytes(plain)
            ok += 1
            table.add_row(out_name, src, format_size(len(plain)), "[green]OK[/]")
        except Exception as exc:  # noqa: BLE001
            fail += 1
            table.add_row(fname, src, format_size(len(data)), f"[red]{exc}[/]")
    console.print(table)
    console.print(f"[bold]HybridCLR[/] 成功 {ok}  失败 {fail} → {HYBRIDCLR_DIR}")
    csharp = HYBRIDCLR_DIR / "Assembly-CSharp.dll"
    if csharp.is_file():
        blob = csharp.read_bytes()
        for needle in (
            b"LuaScripts",
            b"lua.bytes",
            b"AESEncrypt",
            b"DecryptHotRes",
            b"AesDecryptFile",
            b"CommonResHelper",
        ):
            console.print(f"  Assembly-CSharp 包含 {needle!r}: {blob.find(needle) >= 0}")
    return 1 if fail else 0


# ---------------------------------------------------------------------------
# MasterData / Lua
# ---------------------------------------------------------------------------

def load_bundle(path: Path):
    import UnityPy

    data = strip_ab(path.read_bytes())
    return UnityPy.load(io.BytesIO(data))


def textasset_payload(obj) -> tuple[str, bytes]:
    """从 TextAsset 取原始字节。m_Script 走 str 会破坏 luac 里的 0x80-0xFF。"""
    d = obj.read() if not hasattr(obj, "m_Script") else obj
    name = str(getattr(d, "m_Name", "") or "")
    reader = getattr(d, "object_reader", None)
    if reader is not None:
        try:
            return name, _textasset_script_from_raw(reader.get_raw_data())
        except Exception:
            pass
    return name, script_to_bytes(getattr(d, "m_Script", b""))


def _align4(n: int) -> int:
    return (n + 3) & ~3


def _textasset_script_from_raw(raw: bytes) -> bytes:
    def aligned_blob(off: int) -> tuple[bytes, int]:
        ln = struct.unpack_from("<I", raw, off)[0]
        start = off + 4
        end = start + ln
        if ln > len(raw) or end > len(raw):
            raise ValueError("TextAsset blob 越界")
        return raw[start:end], _align4(end)

    _name, off = aligned_blob(0)
    script, _ = aligned_blob(off)
    if not script:
        raise ValueError("空 m_Script")
    return script


def script_to_bytes(script) -> bytes:
    """UnityPy 把 TextAsset 二进制收成 str 时，0x80-0xFF 会变成 surrogate。"""
    if isinstance(script, (bytes, bytearray)):
        return bytes(script)
    out = bytearray()
    for ch in script:
        o = ord(ch)
        if o <= 0xFF:
            out.append(o)
        elif 0xDC00 <= o <= 0xDCFF:
            out.append(o - 0xDC00)
        else:
            out.extend(ch.encode("utf-8"))
    return bytes(out)


def is_luac(data: bytes) -> bool:
    return data[:4] == LUA_MAGIC


def normalize_luac(data: bytes) -> bytes:
    """libxlua checkHeader: format=1，且省略 sizeof(size_t)。补成 unluac 能吃的 5.3 头。"""
    if len(data) < 18 or data[:4] != LUA_MAGIC or data[4] != 0x53:
        return data
    if data[5] == 0:
        return data
    buf = bytearray(data)
    buf[5] = 0
    # signature(4)+ver(1)+fmt(1)+LUAC_DATA(6)+sizeof(int) → 插入 sizeof(size_t)=4
    ins_off = 13
    return bytes(buf[:ins_off] + b"\x04" + buf[ins_off:])


def as_lua_bytes(data: bytes) -> bytes:
    data = maybe_decrypt_blob(data)
    if data[:AB_OFFSET] == b"\x00" * AB_OFFSET and data[AB_OFFSET : AB_OFFSET + 4] == LUA_MAGIC:
        return data[AB_OFFSET:]
    return data


def rel_from_container(container: str, name: str) -> str:
    """Unity 里是 AvgConfig.xxx.Yyy.lua.bytes；require 用点号，落盘改成目录。"""
    p = container.replace("\\", "/").lstrip("/")
    for prefix in (
        "assets/res/luascripts/",
        "assets/res/luascrpts/",
        "res/luascripts/",
        "assets/",
    ):
        if p.lower().startswith(prefix):
            p = p[len(prefix) :]
            break
    if not p:
        p = name
    if p.lower().endswith(".bytes"):
        p = p[: -len(".bytes")]
    if p.lower().endswith(".lua"):
        stem = p[: -len(".lua")]
    else:
        stem = p
    parts: list[str] = []
    for seg in stem.replace("\\", "/").split("/"):
        if not seg:
            continue
        parts.extend(x for x in seg.split(".") if x)
    if not parts:
        parts = ["unknown"]
    return "/".join(parts) + ".lua"


def find_lua_bundles() -> list[Path]:
    hits: list[Path] = []
    for path in ASSETS_DIR.rglob("*.ab"):
        low = path.as_posix().lower()
        if "luascripts" in low or path.name.lower() in {"configs.ab", "avgconfig.ab"}:
            hits.append(path)
    return sorted(hits)


def extract_lua_from_bundle(path: Path, luac_root: Path) -> int:
    env = load_bundle(path)
    n = 0
    seen: set[str] = set()
    items: list[tuple[str, Any]] = []
    if getattr(env, "container", None):
        items.extend(env.container.items())
    else:
        for obj in env.objects:
            if obj.type.name == "TextAsset":
                items.append(("", obj))
    for container, obj in items:
        if obj.type.name != "TextAsset":
            continue
        name, raw = textasset_payload(obj)
        payload = as_lua_bytes(raw)
        if not (is_luac(payload) or name.lower().endswith((".lua", ".lua.bytes"))):
            if not (payload.lstrip().startswith(b"--") or payload.lstrip().startswith(b"local ")):
                continue
        rel = rel_from_container(container or name, name)
        key = rel.lower()
        if key in seen:
            continue
        seen.add(key)
        dest = luac_root / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(payload)
        n += 1
    return n


def unluac_one(src: Path, dest: Path) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    data = src.read_bytes()
    if not is_luac(data):
        dest.write_bytes(data)
        return "copy"
    data = normalize_luac(data)
    tmp_in = dest.with_suffix(dest.suffix + ".luac")
    tmp_out = dest.with_suffix(dest.suffix + ".tmp")
    tmp_in.write_bytes(data)
    try:
        proc = subprocess.run(
            [UNLUAC_BIN, "--rawstring", "--output", str(tmp_out), str(tmp_in)],
            capture_output=True,
            text=True,
            timeout=UNLUAC_TIMEOUT,
            check=False,
        )
        if proc.returncode != 0:
            err = (proc.stderr or proc.stdout or f"exit {proc.returncode}").strip()
            raise RuntimeError(err[:300])
        if not tmp_out.is_file():
            raise RuntimeError("unluac 没有写出文件")
        if tmp_out.stat().st_size == 0:
            # 只有 return 的空 chunk，unluac 会写出空文件
            tmp_out.write_text("return\n", encoding="utf-8")
        os.replace(tmp_out, dest)
        return "ok"
    except subprocess.TimeoutExpired as exc:
        raise RuntimeError("timeout") from exc
    finally:
        tmp_in.unlink(missing_ok=True)
        tmp_out.unlink(missing_ok=True)


def cmd_masterdata(jobs: int) -> int:
    bundles = find_lua_bundles()
    if not bundles:
        console.print("[yellow]Assets 里没有 luascripts AB，先跑 assets[/]")
        return 1
    if MASTER_DIR.exists():
        shutil.rmtree(MASTER_DIR)
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    staging = Path(tempfile.mkdtemp(prefix="neuralcloud-luac-"))
    try:
        return _cmd_masterdata(jobs, bundles, staging)
    finally:
        shutil.rmtree(staging, ignore_errors=True)


def _cmd_masterdata(jobs: int, bundles: list[Path], staging: Path) -> int:
    total = 0
    for path in bundles:
        n = extract_lua_from_bundle(path, staging)
        total += n
        console.print(f"[cyan]抽出[/] {path.relative_to(ASSETS_DIR)} → {n} 个 Lua")
    files = [p for p in staging.rglob("*") if p.is_file()]
    if not files:
        console.print("[red]没有抽出任何 Lua[/]")
        return 1
    console.print(f"[cyan]unluac[/] {len(files)} 个 → {MASTER_DIR}  ({jobs} 线程)")
    ok = fail = copied = 0
    err_log = MASTER_DIR / "unluac_fail.log"
    with err_log.open("w", encoding="utf-8") as log, Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("unluac", total=len(files))

        def work(src: Path) -> tuple[Path, str, str | None]:
            rel = src.relative_to(staging)
            dest = MASTER_DIR / rel
            try:
                return src, unluac_one(src, dest), None
            except Exception as exc:  # noqa: BLE001
                return src, "fail", str(exc)

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futs = [pool.submit(work, p) for p in files]
            for fut in as_completed(futs):
                src, status, err = fut.result()
                if status == "ok":
                    ok += 1
                elif status == "copy":
                    copied += 1
                else:
                    fail += 1
                    log.write(f"{src.relative_to(staging)}: {err}\n")
                progress.advance(task)
    lua_n = sum(1 for _ in MASTER_DIR.rglob("*.lua"))
    console.print(
        f"[bold green]MasterData[/] lua={lua_n}  反编译={ok}  原文={copied}  失败={fail} → {MASTER_DIR}"
    )
    if fail:
        console.print(f"[yellow]失败列表[/] {err_log}")
    return 1 if fail else 0


# ---------------------------------------------------------------------------
# 立绘（character/*/lpic_*.ab + face.ab）
# PathConsts: Res/Character/{resName}/lpic_{resName}.png
#             Res/Character/{resName}/Face/{resName}_face_{faceId}.png
# UINAvgHeroPic.AvgHeroChangeFace: _FaceTex scale=faceSize/sizeDelta,
#   offset=(facePos - faceSize/2 + sizeDelta/2)/sizeDelta
# ---------------------------------------------------------------------------

_FACE_NAME_RE = re.compile(r"_face_(\d+)$", re.I)
_res_manifest_deps: dict[str, list[str]] | None = None


def _bin_7bit(buf: bytes, off: int) -> tuple[int, int]:
    val = 0
    shift = 0
    while True:
        b = buf[off]
        off += 1
        val |= (b & 0x7F) << shift
        if not (b & 0x80):
            return val, off
        shift += 7


def _bin_cstr(buf: bytes, off: int) -> tuple[str, int]:
    n, off = _bin_7bit(buf, off)
    return buf[off : off + n].decode("utf-8"), off + n


def load_res_manifest_deps() -> dict[str, list[str]]:
    """ResManifest.Load：bundle 名 → 依赖 bundle 列表（C# BinaryReader 字符串）。"""
    global _res_manifest_deps
    if _res_manifest_deps is not None:
        return _res_manifest_deps
    deps_map: dict[str, list[str]] = {}
    if not RES_MANIFEST_AB.is_file():
        _res_manifest_deps = deps_map
        return deps_map
    env = load_bundle(RES_MANIFEST_AB)
    raw = None
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        blob = obj.get_raw_data()

        def aligned_blob(buf: bytes, pos: int) -> tuple[bytes, int]:
            ln = struct.unpack_from("<I", buf, pos)[0]
            start = pos + 4
            end = start + ln
            return buf[start:end], _align4(end)

        _name, pos = aligned_blob(blob, 0)
        raw, _ = aligned_blob(blob, pos)
        break
    if not raw or raw[:3] != b"ABD":
        _res_manifest_deps = deps_map
        return deps_map
    off = 3
    _ver = struct.unpack_from("<i", raw, off)[0]
    off += 4
    nassets = struct.unpack_from("<i", raw, off)[0]
    off += 4
    for _ in range(nassets):
        _s, off = _bin_cstr(raw, off)
    nb = struct.unpack_from("<i", raw, off)[0]
    off += 4
    bundles: list[str] = []
    pending: list[tuple[str, tuple[int, ...]]] = []
    for _ in range(nb):
        bname, off = _bin_cstr(raw, off)
        bundles.append(bname)
        na = struct.unpack_from("<i", raw, off)[0]
        off += 4 + na * 4
        nd = struct.unpack_from("<i", raw, off)[0]
        off += 4
        dep_idx = struct.unpack_from("<" + "i" * nd, raw, off) if nd else ()
        off += nd * 4
        if nd:
            pending.append((bname, dep_idx))
    for bname, dep_idx in pending:
        deps_map[bname] = [bundles[i] for i in dep_idx]
    _res_manifest_deps = deps_map
    return deps_map


def bundle_disk_path(bundle_name: str) -> Path:
    return ASSETS_DIR / "bundles" / bundle_name.replace("\\", "/")


def lpic_dep_paths(lpic: Path) -> list[Path]:
    rel = lpic.relative_to(ASSETS_DIR / "bundles").as_posix()
    deps = load_res_manifest_deps().get(rel) or load_res_manifest_deps().get(rel.lower()) or []
    out: list[Path] = []
    for name in deps:
        p = bundle_disk_path(name)
        if p.is_file():
            out.append(p)
    return out


@dataclass
class PaintingNames:
    locale: dict[int, str] = field(default_factory=dict)
    hero_name: dict[int, str] = field(default_factory=dict)
    hero_res: dict[int, str] = field(default_factory=dict)
    res_to_hero: dict[str, int] = field(default_factory=dict)
    skin_res: dict[str, int] = field(default_factory=dict)
    rectify_res: dict[str, int] = field(default_factory=dict)
    skin_hero: dict[int, int] = field(default_factory=dict)
    skin_name: dict[int, str] = field(default_factory=dict)
    skin_theme: dict[int, str] = field(default_factory=dict)
    hero_skin_names: dict[int, list[str]] = field(default_factory=dict)


def _lua_int(val: Any) -> int | None:
    if val is None:
        return None
    if isinstance(val, bool):
        return int(val)
    if isinstance(val, (int, float)):
        return int(val)
    return None


def _lua_str(val: Any) -> str:
    if val is None:
        return ""
    return str(val)


def _locale_text(names: PaintingNames, idx: Any) -> str:
    if isinstance(idx, str):
        return idx
    n = _lua_int(idx)
    if n is None:
        return ""
    return names.locale.get(n, "")


def load_painting_names() -> PaintingNames:
    """从 MasterData/LuaConfigs 读 hero_data / skin / locale_text（metatable 默认值一并生效）。"""
    from lupa import LuaRuntime

    lua = LuaRuntime(unpack_returned_tuples=True)
    g = lua.globals()
    cfg = MASTER_DIR / "LuaConfigs"
    locale_tbl = g.dofile(str(cfg / "locale_text.lua"))
    hero_tbl = g.dofile(str(cfg / "hero_data.lua"))
    skin_tbl = g.dofile(str(cfg / "skin.lua"))
    model_tbl = g.dofile(str(cfg / "resource_model.lua"))
    theme_tbl = g.dofile(str(cfg / "skinTheme.lua"))

    names = PaintingNames()
    for k, v in locale_tbl.items():
        ik = _lua_int(k)
        if ik is not None:
            names.locale[ik] = _lua_str(v)

    theme_name: dict[int, str] = {}
    for k, v in theme_tbl.items():
        tid = _lua_int(getattr(v, "id", None)) or _lua_int(k)
        if tid is None:
            continue
        theme_name[tid] = _locale_text(names, getattr(v, "name", None))

    res_name_by_id: dict[int, str] = {}
    for k, v in model_tbl.items():
        mid = _lua_int(k)
        if mid is None:
            continue
        res_name_by_id[mid] = _lua_str(getattr(v, "res_Name", "")) or "agent"

    for k, v in hero_tbl.items():
        hid = _lua_int(k)
        if hid is None:
            continue
        cname = _locale_text(names, getattr(v, "name", None)) or _lua_str(getattr(v, "name_en", ""))
        src_id = _lua_int(getattr(v, "src_id", None)) or hid
        res = res_name_by_id.get(src_id, "") or _lua_str(getattr(v, "name_en", "")).lower()
        names.hero_name[hid] = cname
        names.hero_res[hid] = res
        if res and res not in names.res_to_hero:
            names.res_to_hero[res] = hid
        elif res and hid == src_id:
            names.res_to_hero[res] = hid

    for k, v in skin_tbl.items():
        sid = _lua_int(k)
        if sid is None:
            continue
        hero_id = _lua_int(getattr(v, "heroId", None)) or 0
        sname = _locale_text(names, getattr(v, "name", None))
        theme_id = _lua_int(getattr(v, "theme", None)) or 0
        pic = _lua_str(getattr(v, "src_id_pic", ""))
        rectify = _lua_str(getattr(v, "src_id_pic_rectify", ""))
        names.skin_hero[sid] = hero_id
        names.skin_name[sid] = sname
        names.skin_theme[sid] = theme_name.get(theme_id, "")
        if pic:
            names.skin_res[pic] = sid
        if rectify:
            names.rectify_res[rectify] = sid
        if hero_id:
            names.hero_skin_names.setdefault(hero_id, []).append(sname)

    raw_map = getattr(skin_tbl, "skinRes2SkinId", None)
    if raw_map is not None:
        for k, v in raw_map.items():
            key = _lua_str(k)
            sid = _lua_int(v)
            if key and sid is not None:
                names.skin_res[key] = sid
    return names


def _match_hero_res(res_name: str, names: PaintingNames) -> int | None:
    if res_name in names.res_to_hero:
        return names.res_to_hero[res_name]
    best: tuple[int, int] | None = None
    for res, hid in names.res_to_hero.items():
        if not res_name.startswith(res):
            continue
        rest = res_name[len(res) :]
        if rest == "" or rest[:1] == "_" or (rest[:1].isdigit()):
            if best is None or len(res) > best[0]:
                best = (len(res), hid)
    return None if best is None else best[1]


def resolve_painting_name(res_name: str, names: PaintingNames) -> tuple[str, str]:
    """返回 (角色名, 皮肤/变体名)。优先 skin.skinRes2SkinId，其次 resource_model.res_Name 前缀。"""
    extra: list[str] = []
    skin_id = names.skin_res.get(res_name)
    if skin_id is None and res_name in names.rectify_res:
        skin_id = names.rectify_res[res_name]
        extra.append("rectify")
    if skin_id is None and res_name.endswith("_avg"):
        stem = res_name[: -len("_avg")]
        skin_id = names.skin_res.get(stem)
        if skin_id is not None:
            extra.append("avg")

    hero_id: int | None = None
    variant = ""
    if skin_id is not None:
        hero_id = names.skin_hero.get(skin_id) or None
        variant = names.skin_name.get(skin_id, "")
        theme = names.skin_theme.get(skin_id, "")
        if hero_id and variant:
            same = [n for n in names.hero_skin_names.get(hero_id, []) if n == variant]
            if len(same) > 1 and theme and theme != variant:
                variant = f"{variant}_{theme}"
        variant = "_".join(x for x in (variant, *extra) if x)

    if hero_id is None:
        hero_id = _match_hero_res(res_name, names)

    cha = names.hero_name.get(hero_id, "") if hero_id else ""
    if not cha:
        cha = res_name
    if variant:
        return cha, variant

    hero_res = names.hero_res.get(hero_id, "") if hero_id else ""
    if hero_res and res_name.startswith(hero_res):
        rest = res_name[len(hero_res) :]
        if rest.startswith("_"):
            rest = rest[1:]
        return cha, rest or "default"
    if hero_id is None and res_name.endswith("_avg") and len(res_name) > 4:
        return res_name[: -len("_avg")], "avg"
    if hero_id is None:
        return res_name, "default"
    return cha, "default"


def _safe_fs_name(text: str) -> str:
    table = str.maketrans(
        {
            "/": "／",
            "\\": "＼",
            ":": "：",
            "*": "＊",
            "?": "？",
            '"': "'",
            "<": "＜",
            ">": "＞",
            "|": "｜",
            "\n": "",
            "\r": "",
            "\t": " ",
        }
    )
    out = text.translate(table).strip()
    return out or "unknown"


def painting_filename(cha: str, variant: str, used: set[str], face: str = "") -> str:
    parts = [GAME_TITLE, _safe_fs_name(cha), _safe_fs_name(variant)]
    if face:
        parts.append(_safe_fs_name(face))
    base = "_".join(parts) + ".png"
    if base not in used:
        used.add(base)
        return base
    n = 2
    while True:
        name = "_".join(parts + [str(n)]) + ".png"
        if name not in used:
            used.add(name)
            return name
        n += 1


def iter_lpic_abs() -> list[tuple[str, Path, Path | None]]:
    """(resName, lpic.ab, face.ab|None)。"""
    root = CHAR_BUNDLE_DIR
    if not root.is_dir():
        return []
    out: list[tuple[str, Path, Path | None]] = []
    for folder in sorted(root.iterdir()):
        if not folder.is_dir():
            continue
        res = folder.name
        lpic = folder / f"lpic_{res}.ab"
        if not lpic.is_file():
            hits = sorted(folder.glob("lpic_*.ab"))
            if not hits:
                continue
            lpic = hits[0]
        face = folder / "face.ab"
        out.append((res, lpic, face if face.is_file() else None))
    return out


def _vec2(val: Any) -> tuple[float, float] | None:
    if not isinstance(val, dict):
        return None
    if "x" in val and "y" in val:
        return float(val["x"]), float(val["y"])
    return None


def _overlay_face(base, face, face_pos: tuple[float, float], face_size: tuple[float, float], hero_size: tuple[float, float]):
    """按 UINAvgHeroPic.AvgHeroChangeFace 的 _FaceTex ST 把表情贴到立绘上。"""
    bw, bh = base.size
    hx, hy = hero_size
    fx, fy = face_size
    px, py = face_pos
    if hx == 0 or hy == 0:
        return base
    u0 = (px - fx / 2 + hx / 2) / hx
    v0 = (py - fy / 2 + hy / 2) / hy
    u1 = u0 + fx / hx
    v1 = v0 + fy / hy
    left = round(u0 * bw)
    right = round(u1 * bw)
    top = round(bh - v1 * bh)
    bottom = round(bh - v0 * bh)
    w = max(1, right - left)
    h = max(1, bottom - top)
    from PIL import Image

    fr = face.convert("RGBA").resize((w, h), Image.Resampling.LANCZOS)
    out = base.convert("RGBA").copy()
    # 允许贴到画布外一点点：裁掉负坐标
    dx, dy = left, top
    sx = sy = 0
    if dx < 0:
        sx = -dx
        dx = 0
    if dy < 0:
        sy = -dy
        dy = 0
    if sx or sy:
        fr = fr.crop((sx, sy, fr.width, fr.height))
    if dx >= bw or dy >= bh or fr.width <= 0 or fr.height <= 0:
        return out
    if dx + fr.width > bw or dy + fr.height > bh:
        fr = fr.crop((0, 0, min(fr.width, bw - dx), min(fr.height, bh - dy)))
    out.alpha_composite(fr, (dx, dy))
    return out


def _largest_texture(env) -> Any:
    image = None
    for obj in env.objects:
        if obj.type.name != "Texture2D":
            continue
        data = obj.read()
        img = data.image
        if img is None:
            continue
        if image is None or img.width * img.height > image.width * image.height:
            image = img
    return image


def _read_lpic(path: Path, dep_paths: list[Path] | None = None) -> tuple[Any, tuple[float, float] | None, tuple[float, float] | None, tuple[float, float] | None]:
    env = load_bundle(path)
    image = _largest_texture(env)
    face_pos = face_size = hero_size = None
    avg_sizes: list[tuple[float, float]] = []
    for obj in env.objects:
        kind = obj.type.name
        if kind == "MonoBehaviour":
            tree = obj.read_typetree()
            if "avgFacePos" in tree:
                face_pos = _vec2(tree.get("avgFacePos"))
                face_size = _vec2(tree.get("avgFaceSize"))
                for item in tree.get("posData") or []:
                    if str(item.get("name", "")).startswith("AvgHero"):
                        sz = _vec2(item.get("sizeDelta"))
                        if sz:
                            avg_sizes.append(sz)
        elif kind == "RectTransform":
            tree = obj.read_typetree()
            hero_size = _vec2(tree.get("m_SizeDelta")) or hero_size
    if avg_sizes:
        hero_size = avg_sizes[0]
    if image is None:
        for dep in dep_paths or []:
            image = _largest_texture(load_bundle(dep))
            if image is not None:
                break
    return image, face_pos, face_size, hero_size


def _read_faces(path: Path) -> dict[str, Any]:
    env = load_bundle(path)
    faces: dict[str, Any] = {}
    for obj in env.objects:
        if obj.type.name != "Texture2D":
            continue
        data = obj.read()
        img = data.image
        if img is None:
            continue
        m = _FACE_NAME_RE.search(str(data.m_Name or ""))
        if not m:
            continue
        faces[m.group(1)] = img
    return faces


def _export_one(
    res_name: str,
    lpic: Path,
    face_ab: Path | None,
    dest_base: Path,
    face_pos: tuple[float, float] | None,
    face_size: tuple[float, float] | None,
    hero_size: tuple[float, float] | None,
    force: bool,
) -> tuple[int, int, str | None]:
    """写出完整立绘 + 表情差分。返回 (写出, 跳过, 错误)。"""
    image, fp, fs, hs = _read_lpic(lpic, lpic_dep_paths(lpic))
    if image is None:
        return 0, 0, "没有 Texture2D"
    face_pos = fp or face_pos
    face_size = fs or face_size
    hero_size = hs or hero_size
    written = skipped = 0
    dest_base.parent.mkdir(parents=True, exist_ok=True)
    if dest_base.is_file() and not force:
        skipped += 1
    else:
        image.convert("RGBA").save(dest_base, "PNG")
        written += 1
    if face_ab is None or face_pos is None or face_size is None or hero_size is None:
        return written, skipped, None
    faces = _read_faces(face_ab)
    for face_id, face_img in sorted(faces.items(), key=lambda kv: (len(kv[0]), kv[0])):
        dest = dest_base.with_name(dest_base.stem + f"_{face_id}.png")
        if dest.is_file() and not force:
            skipped += 1
            continue
        composed = _overlay_face(image, face_img, face_pos, face_size, hero_size)
        composed.save(dest, "PNG")
        written += 1
    return written, skipped, None


def masterdata_ready() -> bool:
    cfg = MASTER_DIR / "LuaConfigs"
    return (cfg / "skin.lua").is_file() and (cfg / "locale_text.lua").is_file() and (cfg / "hero_data.lua").is_file()


def ensure_painting_prereq(jobs: int, force: bool) -> int:
    """立绘模式：没有 Lua 先下/生成 MasterData，再补 character 资产。"""
    if not masterdata_ready():
        if not find_lua_bundles():
            console.print("[cyan]立绘模式[/] 没有 Lua AB，先下载热更资产")
            rc = cmd_assets(jobs=jobs, force=force, unzip=True)
            if rc:
                return rc
        console.print("[cyan]立绘模式[/] 生成 MasterData")
        rc = cmd_masterdata(jobs=max(jobs, 8))
        if rc:
            return rc
    if not iter_lpic_abs():
        console.print("[cyan]立绘模式[/] 没有 character/lpic，下载热更资产")
        rc = cmd_assets(jobs=jobs, force=force, unzip=True)
        if rc:
            return rc
        if not iter_lpic_abs():
            console.print("[red]下载后仍没有 lpic AB[/]")
            return 1
    return 0


def cmd_painting(jobs: int, force: bool, limit: int) -> int:
    rc = ensure_painting_prereq(jobs, force)
    if rc:
        return rc
    warnings.filterwarnings("ignore", message="No valid Unity version found")
    names = load_painting_names()
    load_res_manifest_deps()
    targets = iter_lpic_abs()
    if limit > 0:
        targets = targets[:limit]
        console.print(f"[yellow]--limit {limit}[/] 立绘")
    PAINTING_DIR.mkdir(parents=True, exist_ok=True)
    used: set[str] = set()
    jobs_list: list[tuple[str, Path, Path | None, Path]] = []
    named = 0
    for res_name, lpic, face_ab in targets:
        cha, variant = resolve_painting_name(res_name, names)
        if cha != res_name:
            named += 1
        fname = painting_filename(cha, variant, used)
        jobs_list.append((res_name, lpic, face_ab, PAINTING_DIR / fname))
    console.print(
        f"[cyan]立绘名称[/] Lua 命中 {named}/{len(jobs_list)}  → {PAINTING_DIR}"
    )
    written = skipped = fail = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出立绘", total=max(len(jobs_list), 1))

        def work(item: tuple[str, Path, Path | None, Path]) -> tuple[str, int, int, str | None]:
            res_name, lpic, face_ab, dest = item
            try:
                w, s, err = _export_one(res_name, lpic, face_ab, dest, None, None, None, force)
                return res_name, w, s, err
            except Exception as exc:  # noqa: BLE001
                return res_name, 0, 0, str(exc)

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futs = [pool.submit(work, it) for it in jobs_list]
            for fut in as_completed(futs):
                res_name, w, s, err = fut.result()
                written += w
                skipped += s
                if err:
                    fail += 1
                    console.print(f"[red]立绘失败[/] {res_name}: {err}")
                progress.advance(task)
    console.print(
        f"[bold green]Painting[/] 写出 {written}  跳过 {skipped}  失败 {fail} → {PAINTING_DIR}"
    )
    return 1 if fail else 0


def cmd_status() -> int:
    client = fetch_client_res()
    _, bases = res_base_urls(client)
    info = fetch_version_res_info(bases)
    items = build_download_list(info)
    print_status(client, items)
    return 0


def cmd_all(jobs: int, force: bool) -> int:
    rc = cmd_hybridclr()
    rc |= cmd_assets(jobs=jobs, force=force, unzip=True)
    if rc:
        return rc
    rc |= cmd_hybridclr()
    rc |= cmd_masterdata(jobs=max(jobs, 8))
    return rc


def main() -> int:
    parser = argparse.ArgumentParser(description="云图计划 资产下载 / HybridCLR 解密 / Lua 反编译 / 立绘导出")
    parser.add_argument(
        "cmd",
        nargs="?",
        default="all",
        choices=("all", "assets", "apk", "hybridclr", "masterdata", "painting", "status"),
    )
    parser.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    parser.add_argument("--force", action="store_true")
    parser.add_argument("--no-unzip", action="store_true", help="assets 只下载不解压")
    parser.add_argument("--limit", type=int, default=0, help="立绘模式只导出前 N 个 lpic")
    args = parser.parse_args()
    if args.cmd == "status":
        return cmd_status()
    if args.cmd == "apk":
        extract_apk_streaming_assets(force=args.force)
        return 0
    if args.cmd == "assets":
        return cmd_assets(jobs=args.jobs, force=args.force, unzip=not args.no_unzip)
    if args.cmd == "hybridclr":
        return cmd_hybridclr()
    if args.cmd == "masterdata":
        return cmd_masterdata(jobs=max(args.jobs, 8))
    if args.cmd == "painting":
        return cmd_painting(jobs=args.jobs, force=args.force, limit=args.limit)
    return cmd_all(jobs=args.jobs, force=args.force)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/]")
        raise SystemExit(130)
