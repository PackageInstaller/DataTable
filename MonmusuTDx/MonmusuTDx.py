import os
import time
import argparse
import threading
import requests
import hashlib
from queue import Queue
from typing import Dict, Any, Tuple
from rich.console import Console
from rich.progress import (
    Progress,
    SpinnerColumn,
    BarColumn,
    TextColumn,
    TimeRemainingColumn,
    TimeElapsedColumn
)

MAX_THREADS = 32
ASSET_ROOT  = "Asset"
UPDATE_ROOT = "AssetUpdate"
TABLES_ROOT = "MasterData"
TABLES_UPDATE_ROOT = "MasterUpdate"
APP_INFO_URL = "https://api.store.games.dmm.com/freeapp/688044"
VERSION_API  = "https://gapi.game-monmusu-td.net/api/asset_bundle/version"
UNITY_HEADER = b"\x55\x6E\x69\x74\x79"
console = Console()


def base_key(src: str) -> bytes:
    s2  = bytes(b ^ 0x55 for b in src.encode('ascii'))
    sha = hashlib.sha256(s2).digest()
    s4  = bytes(b ^ 0xAA for b in sha)
    even, odd = s4[::2], s4[1::2]
    return even + odd


def xor_stream(data: bytes, key: bytes) -> bytes:
    klen = len(key)
    return bytes(b ^ key[i % klen] for i, b in enumerate(data))


def decrypt_table_file(src_path: str, dest_path: str) -> bool:
    try:
        FIRST32 = base_key("KYSSTMDL")
        FULL64 = FIRST32 + FIRST32[::-1]
        
        with open(src_path, "rb") as f:
            enc_data = f.read()
            
        dec_data = xor_stream(enc_data, FULL64)
        
        ensure_dir(dest_path)
        with open(dest_path, "wb") as f:
            f.write(dec_data)
        return True
    except Exception as e:
        console.print(f"[red]解密文件失败 {src_path}: {e}[/red]")
        return False


def is_unity_file(file_path: str) -> bool:
    try:
        with open(file_path, "rb") as f:
            header = f.read(5)
        return header == UNITY_HEADER
    except Exception:
        return False


def get_app_version_name(session: requests.Session) -> str | None:
    try:
        resp = session.get(APP_INFO_URL, timeout=10)
        resp.raise_for_status()
        app_version_name = resp.json()["free_appinfo"]["app_version_name"]
        return app_version_name
    except Exception as e:
        console.print(f"[red]获取 app_version_name 失败：{e}[/red]")
        return None


def get_bundle_version(session: requests.Session, cvr: str) -> str | None:
    """
    通过 POST /api/asset_bundle/version 拿到远端资源版本号。
    只要服务器返回 {"data":{"version": "..."} } 就拼成 ver_xxxxxxx.
    """
    payload = {"cvr": cvr, "provider": "dmm"}
    try:
        resp = session.post(VERSION_API, json=payload, timeout=10)
        resp.raise_for_status()
        ver = resp.json()["data"]["version"]
        return f"ver_{ver}"
    except Exception as e:
        console.print(f"[red]获取资源版本号失败：{e}[/red]")
        return None


def ensure_dir(fp: str) -> None:
    os.makedirs(os.path.dirname(fp), exist_ok=True)


def process_downloaded_file(src_path: str, asset_path: str, is_update: bool) -> None:
    if not is_unity_file(src_path):
        if is_update:
            dest_path = os.path.join(TABLES_UPDATE_ROOT, asset_path)
        else:
            dest_path = os.path.join(TABLES_ROOT, asset_path)
        
        if decrypt_table_file(src_path, dest_path):
            console.print(f"[blue]已解密数据表: {asset_path}[/blue]")


def download_one(
    session: requests.Session,
    asset: Dict[str, Any],
    base_url: str,
    dest_path: str,
    expect_size: int,
    is_update: bool = False,
    retries: int = 10,
) -> Tuple[bool, str]:
    url = f"{base_url}/{asset['hash']}{asset['path']}"
    for attempt in range(retries + 1):
        try:
            resp = session.get(url, stream=True, timeout=20)
            resp.raise_for_status()

            ensure_dir(dest_path)
            with open(dest_path, "wb") as fp:
                for chunk in resp.iter_content(8192):
                    fp.write(chunk)

            real_size = os.path.getsize(dest_path)
            if real_size != expect_size:
                os.remove(dest_path)
                raise ValueError(f"文件大小不符 {real_size} ≠ {expect_size}")
            
            process_downloaded_file(dest_path, asset['path'], is_update)
            return True, "完成"
        except Exception as e:
            if attempt < retries:
                time.sleep(1)
            else:
                return False, str(e)
    return False, "未知错误"


def worker(q: Queue, base_url: str, progress: Progress, task_id, lock: threading.Lock, download_failures: dict):
    sess = requests.Session()
    while True:
        item = q.get()
        if item is None:
            break
        asset, dest, size, is_update = item
        ok, msg = download_one(sess, asset, base_url, dest, size, is_update)
        with lock:
            status = "[green][/green]" if ok else "[red]✗[/red]"
            console.print(f"{status} {asset['path']}  {msg}")
            if not ok:
                url = f"{base_url}/{asset['hash']}{asset['path']}"
                console.print(f"  下载链接: {url}")
                download_failures[asset["path"]] = url
            progress.advance(task_id)
        q.task_done()
    sess.close()


def main():
    ap = argparse.ArgumentParser(
        description="MonmusuTDx 资源全自动下载 / 增量更新",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    ap.add_argument("-t", "--threads", type=int, default=MAX_THREADS, help="下载线程数")
    ap.add_argument("-f", "--force", action="store_true", help="强制重新下载所有文件")
    args = ap.parse_args()

    sess = requests.Session()

    cvr = get_app_version_name(sess)
    if not cvr:
        return
    console.print(f"[yellow]客户端版本：{cvr}[/yellow]")

    bundle_version = get_bundle_version(sess, cvr)
    if not bundle_version:
        return

    ablist_url = (
        f"https://assets.game-monmusu-td.net/assetbundles/"
        f"{bundle_version}/webgl_r18/ablist.json"
    )
    try:
        ab = sess.get(ablist_url, timeout=10).json()
    except Exception as e:
        console.print(f"[red]获取 ablist.json 失败：{e}[/red]")
        return

    base_ver  = ab["baseVersion"]
    base_url  = f"https://assets.game-monmusu-td.net/assetbundles/ver_{base_ver}/webgl_r18"
    assets    = ab["data"]

    console.print(
        f"[bold yellow]远端资源版本：{bundle_version}[/bold yellow]\n"
        f"[bold yellow]资产基准版本：ver_{base_ver}[/bold yellow]"
    )

    os.makedirs(ASSET_ROOT, exist_ok=True)
    os.makedirs(UPDATE_ROOT, exist_ok=True)
    os.makedirs(TABLES_ROOT, exist_ok=True)
    os.makedirs(TABLES_UPDATE_ROOT, exist_ok=True)

    processed_files = set()
    processed_tasks = set()
    tasks = []
    for asset in assets:
        asset_path = asset["path"]
        if asset_path in processed_files:
            continue
        processed_files.add(asset_path)
            
        local_path  = os.path.join(ASSET_ROOT, asset_path)
        remote_size = int(asset["size"])

        if args.force or not os.path.exists(local_path):
            task_key = (asset_path, False)
            if task_key not in processed_tasks:
                tasks.append((asset, local_path, remote_size, False))
                processed_tasks.add(task_key)
            continue

        try:
            local_size = os.path.getsize(local_path)
        except OSError:
            local_size = -1

        if local_size != remote_size:
            upd_path = os.path.join(UPDATE_ROOT, asset_path)
            if not args.force and os.path.exists(upd_path):
                try:
                    upd_size = os.path.getsize(upd_path)
                    if upd_size == remote_size:
                        continue
                except OSError:
                    pass
            
            task_key = (asset_path, True)
            if task_key not in processed_tasks:
                tasks.append((asset, upd_path, remote_size, True))
                processed_tasks.add(task_key)

    total = len(tasks)
    if total == 0:
        console.print("[green]所有资源已是最新，无需下载。[/green]")
        return

    console.print(f"[cyan]共需下载 {total} 个文件，线程数：{min(args.threads, total)}[/cyan]")

    download_failures = {}
    
    q: Queue = Queue()
    for t in tasks:
        q.put(t)

    lock     = threading.Lock()
    workers  = []
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
        task_id = progress.add_task("[cyan]正在下载...[/cyan]", total=total)

        for _ in range(min(args.threads, total)):
            t = threading.Thread(
                target=worker,
                args=(q, base_url, progress, task_id, lock, download_failures),
                daemon=True,
            )
            t.start()
            workers.append(t)

        q.join()
        for _ in workers:
            q.put(None)
        for t in workers:
            t.join()

    console.print("[bold green]全部下载完成！[/bold green]")
    
    failed_files = []
    for asset_path in processed_files:
        local_path = os.path.join(ASSET_ROOT, asset_path)
        upd_path = os.path.join(UPDATE_ROOT, asset_path)
        
        if os.path.exists(upd_path):
            console.print(f"[blue]更新文件: {asset_path}[/blue]")
        elif not os.path.exists(local_path) or asset_path in download_failures:
            failed_files.append(asset_path)

if __name__ == "__main__":
    main()
