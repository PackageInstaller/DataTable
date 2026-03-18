import os
import sys
import io
import time
import threading
import contextlib
import requests
import json
import hashlib
import shutil
from queue import Queue
from typing import Dict, Any, List, Tuple
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(SCRIPT_DIR))

from rich.console import Console
from rich.progress import (
    Progress,
    SpinnerColumn,
    BarColumn,
    TextColumn,
    TimeRemainingColumn,
    TimeElapsedColumn,
)

console = Console()


VERSION_API_URL = "https://api.cthulhu-rog.net/api/asset_bundle/version"
VERSION_API_PAYLOAD = {"cvr": "1.0.2", "provider": "dmm"}
VERSION_API_HEADERS = {
    "User-Agent": "UnityPlayer/6000.3.5f2 (UnityWebRequest/1.0, libcurl/8.10.1-DEV)",
    "Accept": "application/json",
    "Accept-Encoding": "deflate, gzip",
    "Content-Type": "application/json",
    "x-unity-version": "6000.3.5f2",
}

BASE_URL = "https://assets.cthulhu-rog.net/assetbundles/production"
PLATFORM_DIR = "android_r18"
MAX_THREADS = 16
DEFAULT_OUTPUT_DIR = "Assets"


def base_key(src: str) -> bytes:
    s2 = bytes(b ^ 0x55 for b in src.encode("ascii"))
    sha = hashlib.sha256(s2).digest()
    s4 = bytes(b ^ 0xAA for b in sha)
    even, odd = s4[::2], s4[1::2]
    return even + odd


def xor_stream(data: bytes, key: bytes) -> bytes:
    klen = len(key)
    key_int = int.from_bytes(key, "little")
    out = bytearray(len(data))
    for i in range(0, len(data), klen):
        chunk = data[i : i + klen]
        if len(chunk) == klen:
            chunk_int = int.from_bytes(chunk, "little") ^ key_int
            out[i : i + klen] = chunk_int.to_bytes(klen, "little")
        else:
            out[i:] = bytes(b ^ key[j] for j, b in enumerate(chunk))
    return bytes(out)


def decrypt_table_bytes(enc_data: bytes) -> bytes | None:
    FIRST32 = base_key("KYSSTMDL")
    FULL64 = FIRST32 + FIRST32[::-1]
    return xor_stream(enc_data, FULL64)


def extract_master_data(bundle_data: bytes, output_dir: str) -> None:
    try:
        import UnityPy
        from UnityPy.enums import ClassIDType
    except ImportError:
        console.print(
            "[yellow]未安装 UnityPy，跳过导出步骤。请执行: pip install UnityPy[/yellow]"
        )
        return

    ensure_dir(os.path.join(output_dir, "dummy"))
    env = UnityPy.load(bundle_data)
    count = 0
    for obj in env.objects:
        if obj.type == ClassIDType.MonoBehaviour:
            try:
                data = obj.read()
                name = getattr(data, "name", "")
                tree = obj.read_typetree()

                if not name:
                    name = tree.get("m_Name", "")
                if not name:
                    name = f"MonoBehaviour_{obj.path_id}"

                out_path = os.path.join(output_dir, f"{name}.json")
                with open(out_path, "w", encoding="utf-8") as f:
                    json.dump(tree, f, ensure_ascii=False, indent=2)
                count += 1
            except Exception as e:
                console.print(
                    f"[dim yellow]跳过 {obj.path_id} (解析失败): {e}[/dim yellow]"
                )

    console.print(f"[bold green]共提取 {count} 个数据表[/bold green]")


@contextlib.contextmanager
def suppress_stdout():
    old = sys.stdout
    sys.stdout = io.StringIO()
    try:
        yield
    finally:
        sys.stdout = old


def ensure_dir(fp: str) -> None:
    os.makedirs(os.path.dirname(fp), exist_ok=True)


def fetch_catalog_hash(session: requests.Session) -> str | None:
    """从版本 API 获取 catalog hash（data.version 中 production/ 后面的部分）"""
    try:
        resp = session.post(
            VERSION_API_URL,
            data=json.dumps(VERSION_API_PAYLOAD),
            headers=VERSION_API_HEADERS,
            timeout=30,
        )
        resp.raise_for_status()
        data = resp.json()
        if data.get("status", {}).get("code") != 1:
            console.print(f"[red]版本 API 返回错误: {data}[/red]")
            return None
        version = data.get("data", {}).get("version", "")
        if not version:
            console.print("[red]版本 API 未返回 version 字段[/red]")
            return None
        catalog_hash = version.split("/")[-1] if "/" in version else version
        return catalog_hash
    except Exception as e:
        console.print(f"[red]获取版本号失败: {e}[/red]")
        return None


def fetch_catalog_bytes(session: requests.Session, catalog_hash: str) -> bytes | None:
    catalog_url = f"{BASE_URL}/{catalog_hash}/{PLATFORM_DIR}/ablist.json"
    headers = {"User-Agent": "UnityPlayer/2022.3 (UnityWebRequest/1.0, libcurl/8.4.0)"}
    try:
        resp = session.get(catalog_url, headers=headers, timeout=30)
        resp.raise_for_status()
        return resp.content
    except Exception as e:
        console.print(f"[red]获取 catalog 失败: {e}[/red]")
        return None


DOWNLOAD_HEADERS = {
    "User-Agent": "UnityPlayer/2022.3 (UnityWebRequest/1.0, libcurl/8.4.0)"
}


def download_one(
    session: requests.Session,
    url: str,
    dest_path: str,
    expect_size: int,
    retries: int = 5,
) -> Tuple[bool, str]:
    for attempt in range(retries + 1):
        try:
            resp = session.get(url, headers=DOWNLOAD_HEADERS, stream=True, timeout=60)
            resp.raise_for_status()

            ensure_dir(dest_path)
            with open(dest_path, "wb") as fp:
                for chunk in resp.iter_content(chunk_size=65536):
                    fp.write(chunk)

            real_size = os.path.getsize(dest_path)
            if expect_size > 0 and real_size != expect_size:
                os.remove(dest_path)
                raise ValueError(f"文件大小不符 {real_size} ≠ {expect_size}")
            return True, "完成"
        except Exception as e:
            if attempt < retries:
                time.sleep(1 + attempt)
            else:
                return False, str(e)
    return False, "未知错误"


def worker(
    q: Queue,
    progress: Progress,
    task_id: Any,
    lock: threading.Lock,
    download_failures: Dict[str, str],
) -> None:
    sess = requests.Session()
    while True:
        item = q.get()
        if item is None:
            break

        url, download_dest, final_dest, expect_size, rel_path = item
        ok, msg = download_one(sess, url, download_dest, expect_size)
        if ok and download_dest != final_dest:
            ensure_dir(final_dest)
            shutil.copy2(download_dest, final_dest)

        with lock:
            if not ok:
                console.print(f"[red]✗[/red] {rel_path}  {msg}")
                download_failures[rel_path] = url
            progress.advance(task_id)
        q.task_done()
    sess.close()


def main() -> None:
    sess = requests.Session()
    catalog_hash = fetch_catalog_hash(sess)
    if not catalog_hash:
        sess.close()
        sys.exit(1)
    console.print(f"[cyan]catalog hash: {catalog_hash}[/cyan]")
    catalog_bytes = fetch_catalog_bytes(sess, catalog_hash)
    sess.close()

    if not catalog_bytes:
        sys.exit(1)

    try:
        catalog_data = json.loads(catalog_bytes.decode("utf-8"))
    except Exception as e:
        console.print(f"[red]解析 catalog JSON 失败: {e}[/red]")
        sys.exit(1)

    base_version = catalog_data.get("baseVersion", "1")
    assets = catalog_data.get("data", [])

    output_dir = Path(DEFAULT_OUTPUT_DIR).resolve()
    updates_dir = Path("Updates").resolve()

    is_first_run = True
    if output_dir.exists():
        if any(output_dir.iterdir()):
            is_first_run = False

    old_catalog_path = SCRIPT_DIR / "ablist.json"
    old_catalog_data = {}
    if old_catalog_path.exists():
        try:
            with open(old_catalog_path, "r", encoding="utf-8") as f:
                old_catalog = json.load(f)
                for item in old_catalog.get("data", []):
                    old_path = item.get("path")
                    if old_path:
                        old_catalog_data[old_path] = item.get("hash")
        except Exception as e:
            console.print(f"[yellow]解析本地 ablist.json 失败: {e}[/yellow]")

    tasks: List[Tuple[str, str, str, int, str]] = []
    seen_paths = set()

    master_file_name = "c8fe981361f54d5d4315a3394281a458.bytes"
    master_bytes: bytes | None = None
    master_info: tuple | None = None

    for asset in assets:
        rel_path = asset.get("path")
        asset_hash = asset.get("hash", "")
        expect_size = asset.get("size", 0)

        if not rel_path or rel_path in seen_paths:
            continue
        seen_paths.add(rel_path)

        is_master = Path(rel_path).name == master_file_name

        # 只下载数据表，跳过其他资产，如果需要全资产，把这里注释掉
        if not is_master:
            continue

        final_dest = output_dir / rel_path
        hash_matched = old_catalog_data.get(rel_path) == asset_hash
        needs_update = not hash_matched
        if not is_master:
            file_exists_and_size_matched = final_dest.exists() and (
                expect_size == 0 or final_dest.stat().st_size == expect_size
            )
            if hash_matched and file_exists_and_size_matched:
                continue

        if not needs_update and is_master:
            masterdata_out_dir = SCRIPT_DIR / "MasterData"
            if masterdata_out_dir.exists():
                continue

        download_filename = f"{asset_hash}{rel_path}"
        url = f"{BASE_URL}/ver_{base_version}/{PLATFORM_DIR}/{download_filename}"

        if is_master:
            master_info = (url, expect_size)
        else:
            if is_first_run:
                download_dest = final_dest
            else:
                download_dest = updates_dir / rel_path
            tasks.append(
                (url, str(download_dest), str(final_dest), expect_size, rel_path)
            )

    if master_info:
        url, expect_size = master_info
        console.print(f"[cyan]正在下载数据表...[/cyan]")
        try:
            resp = sess.get(url, headers=DOWNLOAD_HEADERS, timeout=60)
            resp.raise_for_status()
            master_bytes = resp.content
            if expect_size > 0 and len(master_bytes) != expect_size:
                console.print(
                    f"[red]数据表大小校验失败: {len(master_bytes)} != {expect_size}[/red]"
                )
                master_bytes = None
        except Exception as e:
            console.print(f"[red]下载数据表失败: {e}[/red]")

    total = len(tasks)
    if total == 0 and not master_bytes:
        console.print("[green]所有资源已是最新，无需下载。[/green]")
    else:
        if total > 0:
            console.print(f"[cyan]共需下载 {total} 个其他资产文件[/cyan]")
            download_failures: Dict[str, str] = {}
            q: Queue = Queue()
            for t in tasks:
                q.put(t)

            lock = threading.Lock()
            workers: List[threading.Thread] = []
            progress = Progress(
                SpinnerColumn(),
                TextColumn("[progress.description]{task.description}"),
                BarColumn(),
                "[progress.percentage]{task.percentage:>3.0f}%",
                TimeRemainingColumn(compact=True),
                TimeElapsedColumn(),
                console=console,
                transient=True,
            )

            with progress:
                task_id = progress.add_task(
                    "[cyan]正在下载其他资产...[/cyan]", total=total
                )
                for _ in range(min(MAX_THREADS, total)):
                    t = threading.Thread(
                        target=worker,
                        args=(q, progress, task_id, lock, download_failures),
                        daemon=True,
                    )
                    t.start()
                    workers.append(t)

                q.join()
                for _ in workers:
                    q.put(None)
                for t in workers:
                    t.join()

            if download_failures:
                console.print(f"[yellow]失败 {len(download_failures)} 个文件[/yellow]")

    ensure_dir(str(old_catalog_path))
    with open(old_catalog_path, "wb") as f:
        f.write(catalog_bytes)

    masterdata_out_dir = SCRIPT_DIR / "MasterData"
    if master_bytes:
        decrypted_bytes = decrypt_table_bytes(master_bytes)
        if decrypted_bytes:
            extract_master_data(decrypted_bytes, str(masterdata_out_dir))
    elif not masterdata_out_dir.exists():
        master_file_path = output_dir / master_file_name
        if master_file_path.exists():
            with open(master_file_path, "rb") as f:
                decrypted_bytes = decrypt_table_bytes(f.read())
            if decrypted_bytes:
                extract_master_data(decrypted_bytes, str(masterdata_out_dir))


if __name__ == "__main__":
    main()
