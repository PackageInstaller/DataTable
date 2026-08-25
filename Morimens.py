from __future__ import annotations

import argparse
import hashlib
import json
import multiprocessing
import os
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
    args = ap.parse_args()
    try:
        return run(args)
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        return 130
    except Exception as e:
        console.print(f"[red]错误[/red] {e}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
