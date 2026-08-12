from __future__ import annotations

import base64
import hashlib
import json
import os
import shutil
import sys
import tempfile
import threading
import time
import uuid
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import msgpack
import requests
from Crypto.Cipher import AES
from Crypto.Util import Counter
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TaskID,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

try:
    import fcntl
except ImportError:
    fcntl = None


VERSION_URL = (
    "https://minasigo-no-shigoto-app-g-server.orphans-order.com/mnsg/user/getVersion"
)
API_BASE = "https://minasigo-no-shigoto-app-g-server.orphans-order.com/mnsg"
RESOURCE_BASE = "https://minasigo-no-shigoto-pd-native-res.orphans-order.com"

ROOT = Path(__file__).resolve().parent
ASSET_DIR = ROOT / "Assets"
MASTER_DATA_DIR = ROOT / "MasterData"
LOCK_FILE = Path(tempfile.gettempdir()) / (
    "mnsg_" + hashlib.md5(str(ROOT).encode("utf-8")).hexdigest()[:12] + ".lock"
)

THREADS = 16
MAX_RETRIES = 5
CHUNK_SIZE = 256 * 1024

# index.518a3.js ApiConstants
MASTER_ENDPOINTS: List[str] = [
    "myPage/getMasterData",
    "user/getMasterData",
    "item/getMasterData",
    "character/getMasterData1",
    "character/getMasterData2",
    "character/getMasterData3",
    "summon/getMasterData",
    "summon/getMasterData2",
    "equipment/getMasterData1",
    "equipment/getMasterData2",
    "equipment/getMasterData3",
    "ability/getMasterData1",
    "ability/getMasterData2",
    "ability/getMasterData3",
    "ability/getMasterData4",
    "regular/quest/getMasterData1",
    "regular/quest/getMasterData2",
    "regular/tower/getMasterData",
    "regular/raid/getMasterData",
    "event/raid/getMasterData",
    "mission/getMasterData",
    "present/getMasterData",
    "payment/getMasterData",
    "shop/getMasterData",
    "story/getMasterData",
    "loginBonus/getMasterData",
    "loginPack/getMasterData",
    "news/getMasterData",
    "serialCode/getMasterData",
    "event/getMasterData",
    "event/quest/getMasterData",
    "tutorial/getMasterData",
    "piece/getMasterData",
    "expedition/getMasterData",
    "guild/getMasterData",
    "guild/tower/getMasterData",
    "campaign/getMasterData",
    "transition/getMasterData",
    "advice/getMasterData",
    "guild/raid/getMasterData",
    "sugoroku/getMasterData",
    "masterLevel/getMasterData",
    "vote/getMasterData",
    "boost/getMasterData",
    "ring/getMasterData",
    "guide/getMasterData",
    "questionnaire/getMasterData",
    "event/getEventGroupMasterData",
]
console = Console()

_THREAD_LOCAL = threading.local()
_CURRENT_VERSION: Optional[Dict[str, Any]] = None


class DownloadError(Exception):
    """下载校验失败."""


def _thread_session() -> requests.Session:
    """每个工作线程一个 Session, 避免 requests 线程安全问题."""
    session = getattr(_THREAD_LOCAL, "session", None)
    if session is None:
        session = requests.Session()
        adapter = requests.adapters.HTTPAdapter(
            pool_connections=THREADS + 4,
            pool_maxsize=THREADS + 4,
            max_retries=0,
        )
        session.mount("https://", adapter)
        session.mount("http://", adapter)
        if _CURRENT_VERSION:
            set_app_version_headers(session, _CURRENT_VERSION)
        _THREAD_LOCAL.session = session
    return session


def set_app_version_headers(session: requests.Session, version: Dict[str, Any]) -> None:
    global _CURRENT_VERSION
    _CURRENT_VERSION = version
    session.headers.update(
        {
            "User-Agent": (
                "Mozilla/5.0 (Linux; Android 12; Pixel 5) "
                "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36"
            ),
            "Accept": "*/*",
            "x-mnsg-app-version": json.dumps(
                {
                    "clientVersion": version.get("clientVersion", ""),
                    "masterVersion": version.get("masterVersion", ""),
                    "resourceVersion": version.get("resourceVersion", ""),
                },
                separators=(",", ":"),
            ),
        }
    )


def atomic_write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp_name = tempfile.mkstemp(
        prefix=path.name + ".", suffix=".tmp", dir=str(path.parent)
    )
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as f:
            f.write(text)
        os.replace(tmp_name, path)
    except Exception:
        try:
            os.unlink(tmp_name)
        except OSError:
            pass
        raise


def md5_file(path: Path) -> str:
    hasher = hashlib.md5()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            hasher.update(chunk)
    return hasher.hexdigest()


def _clean_value(value: Any) -> Any:
    """把 msgpack 特殊类型转成可 JSON 序列化的值."""
    if isinstance(value, bytes):
        return value.hex()
    if isinstance(value, msgpack.ExtType):
        return {"__ext__": value.code, "data": value.data.hex()}
    if isinstance(value, dict):
        return {str(k): _clean_value(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [_clean_value(v) for v in value]
    return value


def _evpkdf(
    password: bytes,
    salt: bytes,
    key_size: int = 32,
    iv_size: int = 16,
    iterations: int = 1,
    hash_algorithm: str = "md5",
) -> Tuple[bytes, bytes]:
    final_length = key_size + iv_size
    key_iv = b""
    block = None
    while len(key_iv) < final_length:
        hasher = hashlib.new(hash_algorithm)
        if block:
            hasher.update(block)
        hasher.update(password)
        hasher.update(salt)
        block = hasher.digest()
        for _ in range(1, iterations):
            block = hashlib.new(hash_algorithm, block).digest()
        key_iv += block
    return key_iv[:key_size], key_iv[key_size:final_length]


def decrypt_manifest(data: bytes) -> Dict[str, Any]:
    encrypted = base64.b64decode(data)
    passphase = base64.b64encode(hashlib.sha256(b"#mnsg#manifest").digest())[:0x20]
    salt = encrypted[8:16]
    ciphertext = encrypted[16:]
    key, iv = _evpkdf(passphase, salt)
    ctr = Counter.new(AES.block_size * 8, initial_value=int.from_bytes(iv, "big"))
    decrypted = AES.new(key, AES.MODE_CTR, counter=ctr).decrypt(ciphertext)

    candidates = []
    try:
        from Crypto.Util.Padding import unpad

        candidates.append(unpad(decrypted, 16))
    except Exception:
        pass
    if decrypted and decrypted[-1] < 16:
        candidates.append(decrypted[: -decrypted[-1]])
    candidates.append(decrypted[: decrypted.rfind(b"}") + 1])

    for candidate in candidates:
        try:
            obj = json.loads(candidate)
            if isinstance(obj, dict) and "assets" in obj:
                return obj
        except Exception:
            continue
    raise ValueError("resource.json 解密或解析失败")


def fetch_version(session: requests.Session) -> Dict[str, Any]:
    response = session.get(VERSION_URL, timeout=(10, 30))
    response.raise_for_status()
    data = response.json()
    if not isinstance(data, dict) or "version" not in data:
        raise ValueError("getVersion 返回格式异常")
    return data["version"]


def fetch_manifest(session: requests.Session, resource_version: str) -> Dict[str, Any]:
    url = f"{RESOURCE_BASE}/{resource_version}/resource.json"
    last_error: Optional[Exception] = None
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            response = session.get(url, timeout=(10, 120))
            response.raise_for_status()
            manifest = decrypt_manifest(response.content)
            return manifest
        except Exception as exc:
            last_error = exc
            if attempt < MAX_RETRIES:
                time.sleep(min(2 ** (attempt - 1), 10))
    raise DownloadError(f"下载/解密资源清单失败: {last_error}")


def select_asset_entry(entry: Dict[str, Any]) -> Tuple[str, Dict[str, Any]]:
    if "3" in entry:
        return "3", entry["3"]
    if "0" in entry:
        return "0", entry["0"]
    quality = next(iter(entry))
    return quality, entry[quality]


def convert_md5_path(asset_path: str, stem: str) -> str:
    """还原 Cocos 的 MD5 分目录路径."""
    e = hashlib.md5(asset_path.encode()).hexdigest()
    s = hashlib.md5(stem.encode()).hexdigest()
    first = s[0]
    if first in ("0", "1", "2", "3"):
        parts = [s[0:2], s[4:6]]
    elif first in ("4", "5", "6", "7"):
        parts = [s[2:4], s[6:8], s[0:2]]
    elif first in ("8", "9", "a", "b"):
        parts = [s[4:6], s[0:2], s[6:8], s[2:4]]
    else:
        parts = [s[6:8], s[2:4], s[4:6], s[0:2]]
    return f"{e}/{'/'.join(parts)}/"


def build_asset_item(
    asset_path: str,
    entry: Dict[str, Any],
    resource_version: str,
) -> Dict[str, Any]:
    _, info = select_asset_entry(entry)
    md5 = info["md5"]
    if "." in asset_path:
        stem, ext = asset_path.rsplit(".", 1)
        ext = "." + ext
    else:
        stem, ext = asset_path, ""
    sub_path = convert_md5_path(asset_path, stem)
    return {
        "path": asset_path,
        "url": f"{RESOURCE_BASE}/{resource_version}/{sub_path}{md5}{ext}",
        "md5": md5,
        "local": ASSET_DIR / asset_path,
    }


def _download_asset_worker(
    item: Dict[str, Any],
    progress: Progress,
    bytes_task: TaskID,
    files_task: TaskID,
    failures: List[Tuple[str, str]],
    fail_lock: threading.Lock,
) -> Tuple[str, str]:
    path = item["path"]
    local = item["local"]

    try:
        session = _thread_session()
        local.parent.mkdir(parents=True, exist_ok=True)
        if local.is_file():
            try:
                if md5_file(local) == item["md5"]:
                    progress.update(files_task, advance=1)
                    return "skip", path
            except OSError:
                pass

        tmp_path = local.with_name(
            f".{local.name}.{os.getpid()}.{threading.get_ident()}.{uuid.uuid4().hex[:8]}.part"
        )
        last_error: Optional[Exception] = None
        for attempt in range(1, MAX_RETRIES + 1):
            tmp_path.unlink(missing_ok=True)
            try:
                hasher = hashlib.md5()
                with session.get(item["url"], stream=True, timeout=(10, 120)) as resp:
                    resp.raise_for_status()
                    with tmp_path.open("wb") as f:
                        for chunk in resp.iter_content(CHUNK_SIZE):
                            if not chunk:
                                continue
                            f.write(chunk)
                            hasher.update(chunk)
                            progress.update(bytes_task, advance=len(chunk))
                if hasher.hexdigest() != item["md5"]:
                    raise DownloadError(
                        f"MD5 不匹配, 期望 {item['md5']}, 实际 {hasher.hexdigest()}"
                    )
                os.replace(tmp_path, local)
                progress.update(files_task, advance=1)
                return "ok", path
            except Exception as exc:
                last_error = exc
                tmp_path.unlink(missing_ok=True)
                if attempt < MAX_RETRIES:
                    time.sleep(min(2 ** (attempt - 1), 15))
        raise DownloadError(f"{last_error}")
    except Exception as exc:
        with fail_lock:
            failures.append((path, str(exc)))
        progress.update(files_task, advance=1)
        return "fail", path


def cleanup_temp_files() -> int:
    """清理上次异常退出留下的临时文件."""
    removed = 0
    patterns = ["*.part", "*.tmp"]
    for base in (ASSET_DIR, MASTER_DATA_DIR):
        if not base.is_dir():
            continue
        for pattern in patterns:
            for path in base.rglob(pattern):
                try:
                    path.unlink()
                    removed += 1
                except OSError:
                    pass
    return removed


def _fetch_master_endpoint(
    endpoint: str,
    version: Dict[str, Any],
    progress: Progress,
    bytes_task: TaskID,
) -> Any:
    url = f"{API_BASE}/{endpoint}"
    session = _thread_session()
    last_error: Optional[Exception] = None
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            with session.get(url, stream=True, timeout=(10, 120)) as resp:
                resp.raise_for_status()
                chunks = []
                for chunk in resp.iter_content(CHUNK_SIZE):
                    if not chunk:
                        continue
                    chunks.append(chunk)
                    progress.update(bytes_task, advance=len(chunk))
                data = b"".join(chunks)
            try:
                return msgpack.unpackb(data, raw=False, strict_map_key=False)
            except Exception:
                try:
                    return json.loads(data.decode("utf-8"))
                except Exception as exc:
                    raise DownloadError(f"数据表不是 MessagePack/JSON: {exc}") from exc
        except Exception as exc:
            last_error = exc
            if attempt < MAX_RETRIES:
                time.sleep(min(2 ** (attempt - 1), 15))
    raise DownloadError(f"数据表下载失败: {last_error}")


def _clear_endpoint_dir(endpoint: str) -> None:
    base = MASTER_DATA_DIR / endpoint
    if base.is_dir():
        for child in base.iterdir():
            try:
                if child.is_dir():
                    shutil.rmtree(child)
                else:
                    child.unlink()
            except OSError:
                pass
    base.mkdir(parents=True, exist_ok=True)


def _save_master_tables(endpoint: str, obj: Any) -> None:
    _clear_endpoint_dir(endpoint)
    if not isinstance(obj, dict):
        target = MASTER_DATA_DIR / endpoint / "_payload.json"
        text = json.dumps(_clean_value(obj), ensure_ascii=False, separators=(",", ":"))
        atomic_write_text(target, text)
        return

    for table_name, table_data in obj.items():
        target = MASTER_DATA_DIR / endpoint / f"{table_name}.json"
        target.parent.mkdir(parents=True, exist_ok=True)
        text = json.dumps(
            _clean_value(table_data),
            ensure_ascii=False,
            indent=1,
        )
        atomic_write_text(target, text)


def _master_endpoint_worker(
    endpoint: str,
    version: Dict[str, Any],
    progress: Progress,
    count_task: TaskID,
    bytes_task: TaskID,
    failures: List[Tuple[str, str]],
    fail_lock: threading.Lock,
) -> Tuple[str, str]:
    try:
        obj = _fetch_master_endpoint(endpoint, version, progress, bytes_task)
        _save_master_tables(endpoint, obj)
        progress.update(count_task, advance=1)
        return "ok", endpoint
    except Exception as exc:
        with fail_lock:
            failures.append((endpoint, str(exc)))
        progress.update(count_task, advance=1)
        return "fail", endpoint


def _acquire_lock() -> Optional[Any]:
    if fcntl is None:
        return None
    ROOT.mkdir(parents=True, exist_ok=True)
    fd = open(LOCK_FILE, "w")
    try:
        fcntl.flock(fd.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
    except OSError:
        fd.close()
        return None
    fd.write(str(os.getpid()))
    fd.flush()
    return fd


def main() -> int:
    lock_fd = _acquire_lock()
    if lock_fd is None:
        console.print("[red]已有下载器在运行, 本次退出。[/red]")
        return 1

    try:
        for directory in (ROOT, ASSET_DIR, MASTER_DATA_DIR):
            directory.mkdir(parents=True, exist_ok=True)
        removed_tmp = cleanup_temp_files()
        if removed_tmp:
            console.print(f"清理上次残留临时文件: {removed_tmp} 个")

        stats = {
            "asset_ok": 0,
            "asset_skip": 0,
            "asset_fail": 0,
            "master_ok": 0,
            "master_fail": 0,
        }
        failures: List[Tuple[str, str]] = []
        fail_lock = threading.Lock()

        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            MofNCompleteColumn(),
            DownloadColumn(),
            TransferSpeedColumn(),
            TimeRemainingColumn(),
            console=console,
            transient=True,
        ) as progress:
            version_task = progress.add_task("检查版本", total=1)
            manifest_task = progress.add_task("获取资源清单", total=1)

            version = fetch_version(_thread_session())
            set_app_version_headers(_thread_session(), version)
            resource_version = version.get("resourceVersion") or version.get(
                "requireResourceVersion", ""
            )
            progress.update(version_task, completed=1)
            progress.remove_task(version_task)
            console.print(
                f"client={version.get('clientVersion')} "
                f"resource={resource_version} "
                f"master={version.get('masterVersion')}"
            )

            manifest = fetch_manifest(_thread_session(), resource_version)
            progress.update(manifest_task, completed=1)
            progress.remove_task(manifest_task)
            asset_count = len(manifest.get("assets", {}))
            console.print(f"资源清单: {asset_count} 个文件")

            master_count_task = progress.add_task(
                "数据表接口", total=len(MASTER_ENDPOINTS)
            )
            master_bytes_task = progress.add_task("数据表字节", total=None)
            with ThreadPoolExecutor(
                max_workers=THREADS, thread_name_prefix="mnsg-data"
            ) as pool:
                futures = []
                for endpoint in MASTER_ENDPOINTS:
                    futures.append(
                        pool.submit(
                            _master_endpoint_worker,
                            endpoint,
                            version,
                            progress,
                            master_count_task,
                            master_bytes_task,
                            failures,
                            fail_lock,
                        )
                    )

                for future in as_completed(futures):
                    try:
                        result, _ = future.result()
                    except Exception as exc:
                        with fail_lock:
                            failures.append(("数据表线程", str(exc)))
                        stats["master_fail"] += 1
                        continue
                    stats[f"master_{result}"] += 1
            progress.remove_task(master_count_task)
            progress.remove_task(master_bytes_task)

            sizes = manifest.get("sizes", {})
            total_bytes = int(sizes.get("0", 0)) + int(sizes.get("3", 0))
            asset_bytes_task = progress.add_task(
                "全资产字节", total=total_bytes if total_bytes else None
            )
            asset_files_task = progress.add_task("全资产文件", total=asset_count)
            asset_items = [
                build_asset_item(path, entry, resource_version)
                for path, entry in manifest.get("assets", {}).items()
            ]

            with ThreadPoolExecutor(
                max_workers=THREADS, thread_name_prefix="mnsg-assets"
            ) as pool:
                futures = []
                for item in asset_items:
                    futures.append(
                        pool.submit(
                            _download_asset_worker,
                            item,
                            progress,
                            asset_bytes_task,
                            asset_files_task,
                            failures,
                            fail_lock,
                        )
                    )

                for future in as_completed(futures):
                    try:
                        result, _ = future.result()
                    except Exception as exc:
                        with fail_lock:
                            failures.append(("资产线程", str(exc)))
                        stats["asset_fail"] += 1
                        continue
                    stats[f"asset_{result}"] += 1
            progress.remove_task(asset_bytes_task)
            progress.remove_task(asset_files_task)

        console.print(
            f"[green]完成[/green]: "
            f"资产 新增 {stats['asset_ok']}, 跳过 {stats['asset_skip']}, 失败 {stats['asset_fail']}; "
            f"数据表 新增 {stats['master_ok']}, 失败 {stats['master_fail']}"
        )
        if failures:
            console.print("[yellow]失败清单(前 50):[/yellow]")
            for name, err in failures[:50]:
                console.print(f"  [red]{name}[/red]: {err}")
            return 1
        return 0
    finally:
        if lock_fd is not None:
            try:
                fcntl.flock(lock_fd.fileno(), fcntl.LOCK_UN)
            except Exception:
                pass
            lock_fd.close()


if __name__ == "__main__":
    sys.exit(main())
