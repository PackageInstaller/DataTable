from __future__ import annotations

import argparse
import hashlib
import json
import multiprocessing
import os
import re
import shutil
import struct
import sys
import threading
import time
import uuid
from concurrent.futures import ProcessPoolExecutor, ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Tuple

import requests
import spookyhash
import UnityPy
from Crypto.Cipher import AES
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
from UnityPy.helpers import ArchiveStorageManager

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MANIFEST_PATH = ASSETS_DIR / ".manifest.json"

CARBON_URL = (
    "https://ww-hk-carbon-api.qookkagames.com/client/api.config.query"
    "?ver=1.3&df=json&gt=ng&cver=3.12.0&os={os}"
)
CDN_LIST = [
    "https://qz-z1g-cdn.qookkagames.com",
    "https://qz-z1g-alicdn.qookkagames.com",
]
DEFAULT_CHANNEL = "Z1G_2025_11_OB"
DEFAULT_JOBS = 16
RETRY_COUNT = 5
CHUNK_SIZE = 1 << 20
GAME_ID = "10000245"
PRODUCT_CODE = "p11222"
STEAM_PKG = "com.lingxigames.z1.steam.global"
ANDROID_PKG = "com.qookkagames.z1.gp.hk"
UNITYCN_PASSWORD = b"514/wedsjjhfb#0v"
UNITY3D_SIGNATURE = b"#$unity3dchina!@"
DEFAULT_DECRYPT_JOBS = 2

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
    """下载线程只改计数，单独线程定时写进 Progress。

    Rich Live 刷新也要 GIL；UnityPy 解密若在同进程里跑，转圈会停。
    Worker 再直接 advance，还会和 Live 抢同一把锁。
    """

    def __init__(self, progress: Progress, t_bytes, t_files):
        self.progress = progress
        self.t_bytes = t_bytes
        self.t_files = t_files
        self._bytes = 0
        self._files = 0
        self._lock = threading.Lock()
        self._stop = threading.Event()
        self._thr = threading.Thread(
            target=self._run, name="progress-pump", daemon=True
        )

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


def unitycn_key() -> bytes:
    h1, h2 = spookyhash.hash128_pair(UNITYCN_PASSWORD)
    return struct.pack("<QQ", h1, h2).hex()[:16].encode()


def _decrypt_key_aes(key: bytes, data: bytes, keybytes: bytes) -> bytes:
    enc = AES.new(keybytes, AES.MODE_ECB).encrypt(key)
    return bytes(x ^ y for x, y in zip(data, enc))


def _read_vector(reader):
    data = reader.read_bytes(0x10)
    key = reader.read_bytes(0x10)
    reader.Position += 1
    return data, key


class TuanjieArchiveDecryptor:
    """团结引擎 UnityCN：加密头后多 8 字节 padding。"""

    substitute: bytes = bytes(0x10)

    def __init__(self, reader):
        self.unknown_1 = reader.read_u_int()
        self.data, self.key = _read_vector(reader)
        self.data_sig, self.key_sig = _read_vector(reader)
        reader.Position += 8
        keybytes = ArchiveStorageManager.DECRYPT_KEY
        sig = _decrypt_key_aes(self.key_sig, self.data_sig, keybytes)
        if sig != UNITY3D_SIGNATURE:
            raise LookupError(f"UnityCN 签名不匹配: {sig!r}")
        data = _decrypt_key_aes(self.key, self.data, keybytes)
        nibbles = [n for b in data for n in (b >> 4, b & 0xF)]
        index = [0] * 0x10
        for i, nibble in enumerate(nibbles[:0x10]):
            index[nibble] = i
        self.index = bytes(index)
        self.substitute = bytes(
            nibbles[0x10 + i * 4 + j] for j in range(4) for i in range(4)
        )

    def decrypt_block(self, data, index):
        offset = 0
        size = len(data)
        data = bytearray(data)
        view = memoryview(data)
        while offset < len(data):
            offset += self.decrypt(view[offset:], index, size - offset)
            index += 1
        return data

    def decrypt_byte(self, view, offset, index):
        b = (
            self.substitute[((index >> 2) & 3) + 4]
            + self.substitute[index & 3]
            + self.substitute[((index >> 4) & 3) + 8]
            + self.substitute[(index % 256 >> 6) + 12]
        )
        view[offset] = (
            (self.index[view[offset] & 0xF] - b) & 0xF
            | 0x10 * (self.index[view[offset] >> 4] - b)
        ) % 256
        return view[offset], offset + 1, index + 1

    def decrypt(self, data, index, remaining):
        offset = 0
        cur_byte, offset, index = self.decrypt_byte(data, offset, index)
        byte_high = cur_byte >> 4
        byte_low = cur_byte & 0xF
        if byte_high == 0xF:
            b = 0xFF
            while b == 0xFF:
                b, offset, index = self.decrypt_byte(data, offset, index)
                byte_high += b
        offset += byte_high
        if offset < remaining:
            _, offset, index = self.decrypt_byte(data, offset, index)
            _, offset, index = self.decrypt_byte(data, offset, index)
            if byte_low == 0xF:
                b = 0xFF
                while b == 0xFF:
                    b, offset, index = self.decrypt_byte(data, offset, index)
        return offset


def install_unitycn():
    key = unitycn_key()
    UnityPy.set_assetbundle_decrypt_key(key)
    ArchiveStorageManager.DECRYPT_KEY = key
    ArchiveStorageManager.ArchiveStorageDecryptor = TuanjieArchiveDecryptor
    return key


def decrypt_unitycn(src: Path, dst: Path) -> str:
    """解密 UnityCN AssetBundle，返回 decompiled / skip / raw。"""
    with src.open("rb") as f:
        magic = f.read(7)
    if magic != b"UnityFS":
        if src != dst:
            dst.parent.mkdir(parents=True, exist_ok=True)
            if dst.exists():
                dst.unlink()
            src.replace(dst)
        return "raw"
    env = UnityPy.load(str(src))
    data = env.file.save()
    dst.parent.mkdir(parents=True, exist_ok=True)
    tmp = dst.with_suffix(dst.suffix + ".dec.tmp")
    tmp.write_bytes(data)
    tmp.replace(dst)
    if src != dst and src.exists():
        src.unlink(missing_ok=True)
    return "unitycn"


def _decrypt_process_init() -> None:
    """子进程独立 stdout，避免 UnityPy 打印把父进程 Live 进度条打乱。"""
    try:
        dn = os.open(os.devnull, os.O_WRONLY)
        os.dup2(dn, 1)
        os.dup2(dn, 2)
        os.close(dn)
    except OSError:
        pass
    install_unitycn()


def _decrypt_process_job(src: str, dst: str) -> str:
    return decrypt_unitycn(Path(src), Path(dst))


def md5_file(path: Path, chunk: int = CHUNK_SIZE) -> str:
    h = hashlib.md5()
    with path.open("rb") as f:
        while True:
            b = f.read(chunk)
            if not b:
                break
            h.update(b)
    return h.hexdigest()


def session() -> requests.Session:
    s = getattr(_tls, "session", None)
    if s is None:
        s = requests.Session()
        s.headers.update({"User-Agent": "EjoySDK-http-client"})
        _tls.session = s
    return s


def load_manifest() -> Dict[str, Any]:
    if not MANIFEST_PATH.exists():
        return {}
    try:
        return json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
    except Exception:
        return {}


def save_manifest(mani: Dict[str, Any]) -> None:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    tmp = MANIFEST_PATH.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(mani, ensure_ascii=False, indent=2), encoding="utf-8")
    tmp.replace(MANIFEST_PATH)


def carbon_body(platform: str) -> Dict[str, Any]:
    os_name = "windows" if platform == "windows" else "android"
    pkg = STEAM_PKG if platform == "windows" else ANDROID_PKG
    uid = str(uuid.uuid4())
    return {
        "id": int(time.time() * 1000),
        "client": {
            "contextInfo": {
                "devInfo": {
                    "os": os_name,
                    "system": os_name,
                    "publishArea": "global",
                    "language": "zh",
                    "langScript": "zh-hans",
                    "airline": "qookka",
                    "uuid": uid,
                    "deviceId": uid,
                    "utdid": uid,
                    "isSimulator": False,
                    "net": "wifi",
                },
                "runId": uid,
                "customInfo": {},
                "gmInfo": {
                    "pkgName": pkg,
                    "app_version_name": "2.5.2",
                    "lua_version": "3.12.0",
                    "ejoysdk_version": "2.10.77",
                    "appVer": "2.5.2",
                },
                "chInfo": {"ch": "", "subCh": ""},
                "accInfo": {},
            },
            "ve": "3.12.0",
            "os": os_name,
            "appId": GAME_ID,
            "env": PRODUCT_CODE,
        },
        "data": {
            "namespaceList": [
                {"version": -1, "namespace": ns, "hash": ""}
                for ns in ("qz_patch", "qz_config", "qz_boot", "apm", "ejoysdk_biz")
            ],
            "exInfos": {},
            "type": 0,
        },
    }


def query_channel(platform: str, channel: str) -> Dict[str, Any]:
    os_name = "windows" if platform == "windows" else "android"
    url = CARBON_URL.format(os=os_name)
    r = session().post(
        url,
        json=carbon_body(platform),
        headers={"Content-Type": "application/json"},
        timeout=30,
    )
    r.raise_for_status()
    body = r.json()
    if (body.get("state") or {}).get("code") != 2000000:
        raise RuntimeError(f"配置中心失败: {body.get('state')}")
    cfgs = body.get("data", {}).get("configList") or []
    patch = next((c for c in cfgs if c.get("namespace") == "qz_patch"), None)
    if not patch:
        raise RuntimeError("配置中心没有 qz_patch")
    cfg = patch.get("config") or {}
    init = cfg.get("initConf") or {}
    addrs = init.get("addressList") or list(CDN_LIST)
    info = cfg.get(channel)
    if not info or not info.get("version"):
        available = [k for k, v in cfg.items() if isinstance(v, dict) and v.get("version")]
        raise RuntimeError(f"没有频道 {channel}，可用: {available}")
    info = dict(info)
    info["_cdns"] = [str(a).rstrip("/") for a in addrs] or list(CDN_LIST)
    info["_hash"] = patch.get("hash", "")
    return info


def http_get(url: str, timeout=60, cdns: Optional[List[str]] = None) -> requests.Response:
    urls = [url]
    if cdns:
        for cdn in cdns:
            if url.startswith(cdn):
                urls = [url.replace(cdn, other, 1) if other != cdn else url for other in cdns]
                break
    last = None
    for u in urls:
        try:
            r = session().get(u, timeout=timeout, stream=True)
            if r.status_code == 200:
                return r
            last = RuntimeError(f"HTTP {r.status_code} {u}")
        except Exception as e:
            last = e
    raise last or RuntimeError(f"下载失败 {url}")


def fetch_json(url: str, cdns: List[str]) -> Any:
    r = http_get(url, timeout=60, cdns=cdns)
    r.raw.decode_content = True
    return json.loads(r.content)


def file_url(cdns: List[str], folder: str, from_name: str) -> str:
    return f"{cdns[0]}/z1g/{folder}/{from_name}"


def collect_items(
    file_list: List[Dict[str, Any]],
    groups: Optional[Iterable[str]],
    skip_groups: Iterable[str],
) -> List[Dict[str, Any]]:
    want = set(groups) if groups else None
    skip = set(skip_groups)
    items: List[Dict[str, Any]] = []
    seen = set()
    for g in file_list:
        name = g.get("g") or "default"
        if name in skip:
            continue
        if want is not None and name not in want:
            continue
        for it in g.get("items") or []:
            dest = (it.get("to") or "").replace("\\", "/").lstrip("/")
            if not dest or dest in seen:
                continue
            seen.add(dest)
            items.append(
                {
                    "from": it["from"],
                    "to": dest,
                    "md5": it.get("md5") or "",
                    "size": int(it.get("size") or 0),
                    "group": name,
                }
            )
    return items


def download_one(
    item: Dict[str, Any],
    dest: Path,
    cdns: List[str],
    folder: str,
    decrypt: bool,
    on_bytes=None,
    decrypt_pool: Optional[ProcessPoolExecutor] = None,
) -> Tuple[str, int]:
    """返回 (status, 已向进度条上报的字节数)。"""
    dest.parent.mkdir(parents=True, exist_ok=True)
    url = file_url(cdns, folder, item["from"])
    tmp = dest.with_suffix(dest.suffix + ".part")
    expect = item["md5"].lower()
    size = int(item["size"] or 0)
    last_err = None
    reported = 0

    def report(n: int):
        nonlocal reported
        if on_bytes and n:
            on_bytes(n)
            reported += n

    def rewind():
        nonlocal reported
        if on_bytes and reported:
            on_bytes(-reported)
        reported = 0

    for attempt in range(1, RETRY_COUNT + 1):
        rewind()
        try:
            r = http_get(url, timeout=(15, 300), cdns=cdns)
            h = hashlib.md5()
            n = 0
            with tmp.open("wb") as f:
                for chunk in r.iter_content(CHUNK_SIZE):
                    if not chunk:
                        continue
                    f.write(chunk)
                    h.update(chunk)
                    n += len(chunk)
                    report(len(chunk))
            got = h.hexdigest()
            if expect and got != expect.lower():
                raise RuntimeError(f"md5 不符 {got} != {expect}")
            if size and n != size:
                raise RuntimeError(f"大小不符 {n} != {size}")
            if decrypt:
                if decrypt_pool is not None:
                    decrypt_pool.submit(
                        _decrypt_process_job, str(tmp), str(dest)
                    ).result()
                else:
                    decrypt_unitycn(tmp, dest)
            else:
                tmp.replace(dest)
            if size and reported != size:
                report(size - reported)
            return "ok", reported
        except Exception as e:
            last_err = e
            if tmp.exists():
                tmp.unlink(missing_ok=True)
            time.sleep(min(2 * attempt, 8))
    rewind()
    raise RuntimeError(f"{item['to']}: {last_err}")


def run(args: argparse.Namespace) -> int:
    install_unitycn()
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    platform = args.platform
    channel = args.channel
    console.print(f"[bold]查询热更[/bold] platform={platform} channel={channel}")
    info = query_channel(platform, channel)
    pack_key = info.get("packKey") or platform
    version = info["version"]
    origin = info.get("origin") or {}
    folder = origin.get("folder") or channel
    index_file = origin.get("indexFile")
    cdns = info.get("_cdns") or list(CDN_LIST)
    console.print(
        f"  远程 {channel}  packKey={pack_key}  version=[green]{version}[/green]  "
        f"文件={origin.get('cnt')}  约 {int(origin.get('size') or 0) / 1024 / 1024 / 1024:.2f} GiB"
    )
    console.print(f"  CDN {cdns[0]}")

    index_url = f"{cdns[0]}/z1g/{folder}/{index_file}"
    console.print(f"  清单 {index_url}")
    file_list = fetch_json(index_url, cdns)
    groups = None
    if args.groups:
        groups = [g.strip() for g in args.groups.split(",") if g.strip()]
    skip = set()
    if args.skip_debug:
        skip.add("Debug")
    items = collect_items(file_list, groups, skip)
    if args.limit:
        items = items[: args.limit]
    if skip:
        console.print(f"  待处理 {len(items)} 个文件（已排除组: {sorted(skip)}）")
    else:
        console.print(f"  待处理 {len(items)} 个文件")

    mani = load_manifest()
    local_ver = mani.get("version")
    local_files: Dict[str, Any] = dict(mani.get("files") or {})
    if local_ver and local_ver != version:
        console.print(f"[yellow]本地版本 {local_ver} → 远程 {version}，按 hash 增量[/yellow]")
    elif local_ver == version:
        console.print("本地已是该版本，检查缺文件 / 损坏")
    else:
        console.print("本地无清单，全量下载")

    pending: List[Dict[str, Any]] = []
    skipped = 0
    for it in items:
        rec = local_files.get(it["to"]) or {}
        dest = ASSETS_DIR / it["to"]
        if (
            not args.fresh
            and dest.is_file()
            and dest.stat().st_size > 0
            and rec.get("md5") == it["md5"]
        ):
            skipped += 1
            continue
        pending.append(it)

    console.print(f"  跳过已是最新 {skipped}，实际下载 {len(pending)}")
    if not pending:
        mani.update(
            {
                "channel": channel,
                "packKey": pack_key,
                "version": version,
                "platform": platform,
                "updated": time.strftime("%Y-%m-%d %H:%M:%S"),
                "files": local_files,
            }
        )
        save_manifest(mani)
        console.print("[green]没有更新[/green]")
        return 0

    total_bytes = sum(int(i["size"] or 0) for i in pending)
    ok = fail = 0
    lock = threading.Lock()
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
    decrypt_pool = None
    if not args.no_decrypt:
        decrypt_pool = ProcessPoolExecutor(
            max_workers=max(1, args.decrypt_threads),
            mp_context=multiprocessing.get_context("spawn"),
            initializer=_decrypt_process_init,
        )
    try:
        with progress:
            t_bytes = progress.add_task(
                "[cyan]下载", total=total_bytes or None, kind="bytes"
            )
            t_files = progress.add_task(
                "[green]文件", total=len(pending), kind="files"
            )
            pump = _ProgressPump(progress, t_bytes, t_files)
            pump.start()

            def work(it: Dict[str, Any]) -> Tuple[bool, str, Dict[str, Any]]:
                dest = ASSETS_DIR / it["to"]
                try:
                    download_one(
                        it,
                        dest,
                        cdns,
                        folder,
                        decrypt=not args.no_decrypt,
                        on_bytes=pump.add_bytes,
                        decrypt_pool=decrypt_pool,
                    )
                    return True, "", it
                except Exception as e:
                    return False, str(e), it

            try:
                with ThreadPoolExecutor(max_workers=max(1, args.threads)) as pool:
                    futs = {pool.submit(work, it): it for it in pending}
                    for fut in as_completed(futs):
                        success, msg, it = fut.result()
                        with lock:
                            if success:
                                ok += 1
                                local_files[it["to"]] = {
                                    "md5": it["md5"],
                                    "size": it["size"],
                                    "group": it["group"],
                                }
                            else:
                                fail += 1
                                progress.live.print(f"[red]失败[/red] {it['to']}: {msg}")
                            pump.add_file(1)

                        if (ok + fail) % 50 == 0:
                            with lock:
                                mani.update(
                                    {
                                        "channel": channel,
                                        "packKey": pack_key,
                                        "version": version,
                                        "platform": platform,
                                        "files": local_files,
                                    }
                                )
                                save_manifest(mani)
            finally:
                pump.close()
    finally:
        if decrypt_pool is not None:
            decrypt_pool.shutdown(wait=True, cancel_futures=True)

    mani.update(
        {
            "channel": channel,
            "packKey": pack_key,
            "version": version,
            "platform": platform,
            "updated": time.strftime("%Y-%m-%d %H:%M:%S"),
            "files": local_files,
        }
    )
    save_manifest(mani)
    console.print(
        f"[bold]完成[/bold] 成功={ok} 失败={fail} 跳过={skipped}  "
        f"版本={version} → {ASSETS_DIR}"
    )
    return 1 if fail else 0


# ---- 立绘名称还原 -----------------------------------------------------------

_LUA_PIPE = re.compile(r"^[^|]*\|(.*)$")
_FACE_SUF = ("_AF", "_NF", "_HF")
_BAD_NAMES = {"", "？", "?", "？？", "？？？", "临时文本", "testonly"}
_SKIP_AWAKER_CN = ("测试", "训练模式")
_UNSAFE_FS = re.compile(r'[<>:"/\\|?*]')


def _lua_text(s: Optional[str]) -> str:
    if not s:
        return ""
    m = _LUA_PIPE.match(s)
    return (m.group(1) if m else s).strip()


def _lua_field_str(body: str, name: str) -> str:
    m = re.search(rf"{re.escape(name)}\s*=\s*\"([^\"]*)\"", body)
    return m.group(1) if m else ""


def _lua_field_int(body: str, name: str, default: int = 0) -> int:
    m = re.search(rf"{re.escape(name)}\s*=\s*(-?\d+)", body)
    return int(m.group(1)) if m else default


def _iter_lua_records(path: Path):
    text = path.read_text(encoding="utf-8", errors="replace")
    for m in re.finditer(r"\[(\d+)\]\s*=\s*\{", text):
        start = m.end()
        depth = 1
        i = start
        while i < len(text) and depth:
            c = text[i]
            if c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
            i += 1
        yield int(m.group(1)), text[start : i - 1]


def _is_bad_name(s: str) -> bool:
    t = s.strip().strip("「」\"'")
    return t.lower() in _BAD_NAMES or t.startswith("SpChar_") or t.startswith("Awaker")


def _safe_filename(s: str) -> str:
    s = _UNSAFE_FS.sub("、", s).strip(" .")
    return s or "未命名"


def _pick_awaker(cands: List[Dict[str, Any]]) -> Dict[str, Any]:
    def score(r: Dict[str, Any]) -> Tuple[int, int]:
        cn = r.get("cnid") or ""
        en = (r.get("name_en") or "").strip()
        sc = 0
        if any(x in cn for x in _SKIP_AWAKER_CN):
            sc -= 100
        if en.lower() in ("testonly", "？", "?", ""):
            sc -= 10
        q = r.get("quality") or ""
        if q in ("UR", "Orange", "Purple"):
            sc += 5
        return sc, -r.get("basesort", 10**9)

    return max(cands, key=score)


def _load_awaker_maps(master: Path) -> Tuple[Dict[int, Dict[str, Any]], Dict[str, Dict[str, Any]]]:
    by_id: Dict[int, Dict[str, Any]] = {}
    by_res: Dict[str, List[Dict[str, Any]]] = {}
    path = master / "config" / "AwakerConfig.lua"
    for rid, body in _iter_lua_records(path):
        rec = {
            "id": rid,
            "cnid": _lua_field_str(body, "CnID"),
            "name": _lua_text(_lua_field_str(body, "Name")),
            "name_en": _lua_field_str(body, "NameEn"),
            "res": _lua_field_str(body, "AwakerResNum"),
            "quality": _lua_field_str(body, "Quality"),
            "basesort": _lua_field_int(body, "BaseSortID", 10**9),
        }
        if not rec["name"] and rec["cnid"]:
            rec["name"] = rec["cnid"].split("@")[-1]
        by_id[rid] = rec
        if rec["res"]:
            by_res.setdefault(rec["res"], []).append(rec)
    chosen = {res: _pick_awaker(cands) for res, cands in by_res.items()}
    return by_id, chosen


def _load_skin_map(master: Path, awakers: Dict[int, Dict[str, Any]]) -> Dict[str, Dict[str, str]]:
    out: Dict[str, Dict[str, str]] = {}
    path = master / "config" / "AwakerSkin.lua"
    for _rid, body in _iter_lua_records(path):
        res = _lua_field_str(body, "ClothersResNum")
        if not res:
            continue
        owner = _lua_field_int(body, "OwnerAwaker")
        name = _lua_text(_lua_field_str(body, "Name"))
        cnid = _lua_field_str(body, "CnID")
        if _is_bad_name(name):
            tail = cnid.split("@")[-1]
            char = (awakers.get(owner) or {}).get("name") or ""
            if char and tail.startswith(char):
                tail = tail[len(char) :]
            name = tail.replace("时装", "").strip() or tail
        char = (awakers.get(owner) or {}).get("name") or ""
        out[res] = {"char": char, "skin": name or "默认"}
    return out


def _paren_name(cnid: str) -> str:
    m = re.search(r"[（(]([^）)]+)[）)]", cnid)
    return m.group(1).strip() if m else ""


def _avg_names(cnid: str, role: str) -> Tuple[str, str]:
    role = _lua_text(role)
    inner = _paren_name(cnid)
    if role.startswith("「") or role.startswith("『"):
        char = re.sub(r"(特制NF|特制|纸板|无猫版)$", "", cnid).strip("？? ") or role
        extra = cnid
        if char and extra.startswith(char):
            extra = extra[len(char) :]
        extra = re.sub(r"(特制)?NF$", "特制" if "特制" in extra else "", extra)
        extra = extra.strip("_ ")
        return char, extra or "默认"
    if not _is_bad_name(role):
        char = role
        extra = cnid
        if char and char in extra:
            extra = extra.replace(char, "", 1)
        extra = extra.strip("_ ")
        if extra.endswith("无猫版"):
            extra = "无猫"
        extra = re.sub(r"(特制)?NF$", lambda m: "特制" if m.group(1) else "", extra)
        extra = extra.strip("_ ")
        return char, extra or "默认"
    if inner and not _is_bad_name(inner):
        return inner, "默认"
    raw = re.sub(r"^[？?]+", "", cnid).strip("（）() ")
    raw = re.sub(r"(特制)?NF$", lambda m: "特制" if m.group(1) else "", raw)
    m = re.match(r"^(.+?)(纸板|特制|无猫|精二|太阳帽|冰淇淋)$", raw)
    if m:
        return m.group(1), m.group(2)
    return raw or "未知", "默认"


def _load_spchar_map(master: Path) -> Dict[str, Tuple[str, str]]:
    """AwakerResource -> (角色名, 皮肤名)，先出现的有效条目优先。"""
    path = master / "config" / "AvgRole.lua"
    out: Dict[str, Tuple[str, str]] = {}
    for _rid, body in _iter_lua_records(path):
        res = _lua_field_str(body, "AwakerResource")
        if not res or res in out:
            continue
        cnid = _lua_field_str(body, "CnID")
        role = _lua_field_str(body, "RoleName")
        char, skin = _avg_names(cnid, role)
        if _is_bad_name(char):
            continue
        out[res] = (char, skin)
        if res.endswith("_NF"):
            out.setdefault(res[:-3] + "_AF", (char, skin))
            out.setdefault(res[:-3], (char, skin))
    return out


def _split_face(res: str) -> Tuple[str, str]:
    for suf in _FACE_SUF:
        if res.endswith(suf):
            return res[: -len(suf)], suf[1:]
    return res, ""


def _lookup_portrait(
    stem: str,
    awaker_by_res: Dict[str, Dict[str, Any]],
    skins: Dict[str, Dict[str, str]],
    spchars: Dict[str, Tuple[str, str]],
) -> Tuple[str, str, str]:
    """返回 (角色, 皮肤, 表情)。表情 AF 为空。"""
    name = stem
    if name.startswith("Portrait_Full_"):
        name = name[len("Portrait_Full_") :]
    face = ""

    if name.startswith("SpChar_") or "SpChar_" in name:
        key = name
        hit = spchars.get(key) or spchars.get(key + "_NF")
        core, face = _split_face(name)
        if not hit:
            hit = spchars.get(core) or spchars.get(core + "_NF")
        if hit:
            return hit[0], hit[1], ""
        pretty = core.replace("SpChar_", "")
        return pretty, "默认", ""

    res_full = name[len("Awaker_") :] if name.startswith("Awaker_") else name
    res_core, res_face = _split_face(res_full)
    face = res_face or "AF"
    res_full = f"{res_core}_{face}"

    m = re.match(r"^(.+?)Skin(\d+)$", res_core)
    if m:
        base, idx = m.group(1), m.group(2)
        alt = f"{base}S{int(idx):02d}_{face}"
        if alt in skins:
            rec = skins[alt]
            return rec["char"], rec["skin"] + "·动态", "" if face == "AF" else face
        aw = awaker_by_res.get(f"{base}_{face}") or awaker_by_res.get(f"{base}_AF")
        return (aw or {}).get("name") or base, "动态", "" if face == "AF" else face

    if res_full in skins:
        rec = skins[res_full]
        return rec["char"], rec["skin"] or "默认", "" if face == "AF" else face
    aw = awaker_by_res.get(res_full)
    if aw:
        return aw["name"], "默认", "" if face == "AF" else face
    aw = awaker_by_res.get(res_core + "_AF")
    if aw:
        return aw["name"], "默认", "" if face == "AF" else face
    m = re.match(r"^(.+?)S(\d+)$", res_core)
    if m:
        base = m.group(1)
        aw = awaker_by_res.get(f"{base}_AF")
        char = (aw or {}).get("name") or base
        sk = skins.get(res_full) or skins.get(res_core + "_AF")
        return char, (sk or {}).get("skin") or f"皮肤{m.group(2)}", "" if face == "AF" else face
    return res_core, "默认", "" if face == "AF" else face


def _portrait_dest_name(char: str, skin: str, face: str) -> str:
    char = _safe_filename(char or "未知")
    skin = _safe_filename(skin or "默认")
    if face and face != "AF":
        return f"忘却前夜_{char}_{skin}_{face}.png"
    return f"忘却前夜_{char}_{skin}.png"


def run_portraits(args: argparse.Namespace) -> int:
    src = Path(args.portraits).expanduser().resolve()
    if not src.is_dir():
        raise FileNotFoundError(f"立绘目录不存在: {src}")
    master = Path(args.master).expanduser().resolve() if args.master else SCRIPT_DIR / "MasterData"
    if not (master / "config" / "AwakerConfig.lua").is_file():
        alt = SCRIPT_DIR / "lua_readable"
        if (alt / "config" / "AwakerConfig.lua").is_file():
            master = alt
        else:
            raise FileNotFoundError(f"找不到 MasterData: {master}")
    out = Path(args.painting).expanduser().resolve() if args.painting else SCRIPT_DIR / "Painting"
    out.mkdir(parents=True, exist_ok=True)

    console.print(f"[bold]立绘还原[/bold] 源={src}")
    console.print(f"  表 {master}")
    console.print(f"  输出 {out}")

    awakers, awaker_by_res = _load_awaker_maps(master)
    skins = _load_skin_map(master, awakers)
    spchars = _load_spchar_map(master)

    files = sorted(
        p for p in src.iterdir() if p.is_file() and p.suffix.lower() in (".png", ".jpg", ".webp")
    )
    if not files:
        console.print("[yellow]目录里没有图片[/yellow]")
        return 1

    ok = miss = 0
    used: Dict[str, int] = {}
    for p in files:
        char, skin, face = _lookup_portrait(p.stem, awaker_by_res, skins, spchars)
        dest_name = _portrait_dest_name(char, skin, face)
        n = used.get(dest_name, 0)
        used[dest_name] = n + 1
        if n:
            dest_name = dest_name[:-4] + f"_{n + 1}.png"
        dest = out / dest_name
        shutil.copy2(p, dest)
        known = bool(char) and char not in ("未知",) and not re.match(
            r"^(Awaker_|[A-Z]\d{2})", char
        )
        tag = "green" if known else "yellow"
        if known:
            ok += 1
        else:
            miss += 1
        console.print(f"  [{tag}]{p.name}[/] → {dest_name}")
    console.print(f"[bold]完成[/bold] 命名={ok} 兜底={miss} 共 {len(files)} → {out}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="忘却前夜热更下载（Steam/Android QZ CDN）")
    ap.add_argument(
        "--platform",
        choices=("windows", "android"),
        default="windows",
        help="windows=Steam，android=手机（默认 windows）",
    )
    ap.add_argument("--channel", default=DEFAULT_CHANNEL, help="QZ 资源频道")
    ap.add_argument("--threads", type=int, default=DEFAULT_JOBS, help="下载线程，默认 16")
    ap.add_argument(
        "--decrypt-threads",
        type=int,
        default=DEFAULT_DECRYPT_JOBS,
        help="同时解密的 UnityCN 进程数，默认 2",
    )
    ap.add_argument("--groups", default="", help="只下这些组，逗号分隔，如 Scripts,Lang_Text_CN")
    ap.add_argument("--skip-debug", action="store_true", help="排除 Debug 组")
    ap.add_argument("--fresh", action="store_true", help="忽略本地清单，全部重下")
    ap.add_argument("--no-decrypt", action="store_true", help="只下载，不解密 UnityCN")
    ap.add_argument("--limit", type=int, default=0, help="最多下载 N 个文件（调试）")
    ap.add_argument(
        "--portraits",
        metavar="DIR",
        default="",
        help="立绘还原：指定立绘文件夹（如 assets/artres/portraits/full）",
    )
    ap.add_argument("--master", default="", help="MasterData 目录，默认脚本旁 MasterData")
    ap.add_argument("--painting", default="", help="立绘输出目录，默认脚本旁 Painting")
    args = ap.parse_args()
    try:
        if args.portraits:
            return run_portraits(args)
        return run(args)
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        return 130
    except Exception as e:
        console.print(f"[red]错误[/red] {e}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
