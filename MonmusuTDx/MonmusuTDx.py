import os
import time
import json
import argparse
import threading
import requests
import hashlib
from queue import Queue
from typing import Dict, Any, Tuple, List

import UnityPy
from UnityPy.enums import ClassIDType

from rich.console import Console
from rich.progress import (
    Progress,
    SpinnerColumn,
    BarColumn,
    TextColumn,
    TimeRemainingColumn,
    TimeElapsedColumn,
)

MAX_THREADS = 32
ASSETS_ROOT = "Assets"
TABLES_ROOT = "MasterData"
APP_INFO_URL = "https://api.store.games.dmm.com/freeapp/688044"
VERSION_API = "https://gapi.game-monmusu-td.net/api/asset_bundle/version"
MASTER_FILE_NAMES = {
    "a4a197b8ff3816f0ddf353ead4768c80.bytes",  # MdF_Output/Data
    "75e09e20429de1372f375685aa4386b3.bytes",  # MdF_Output/Bomcard
    "2c4638ec28d824dfc4992d2f2b492c1f.bytes",  # MdF_Output/UnitClass
    "94840ed598854fe89a08f12ceb25fd1e.bytes",  # MdF_Output/UnitCard
    "6ccdbcdbe6ce4a57abcd31247745c242.bytes",  # MdF_Output/EnemyData
}

console = Console()


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


def decrypt_table_data(enc_data: bytes) -> bytes:
    FIRST32 = base_key("KYSSTMDL")
    FULL64 = FIRST32 + FIRST32[::-1]
    return xor_stream(enc_data, FULL64)


def extract_master_data_to_json(decrypted_bytes: bytes, output_dir: str) -> List[str]:
    extracted_names = []
    env = UnityPy.load(decrypted_bytes)
    container_map = {}

    for container_path, obj in env.container.items():
        container_map[obj.path_id] = container_path

    for obj in env.objects:
        if obj.type == ClassIDType.MonoBehaviour:
            try:
                data = obj.read()
                name = getattr(data, "m_Name", getattr(data, "name", ""))
                if not name:
                    name = f"Unnamed_{obj.path_id}"
                container_path = container_map.get(obj.path_id)
                if container_path:
                    rel_dir = os.path.dirname(container_path.replace("\\", "/")).lstrip(
                        "/"
                    )
                    target_dir = os.path.normpath(os.path.join(output_dir, rel_dir))
                else:
                    target_dir = output_dir

                os.makedirs(target_dir, exist_ok=True)
                tree = obj.read_typetree()
                out_path = os.path.join(target_dir, f"{name}.json")
                with open(out_path, "w", encoding="utf-8") as f:
                    json.dump(tree, f, ensure_ascii=False, indent=2)

                extracted_names.append(name)
            except Exception:
                pass

    return extracted_names


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


def download_one(
    session: requests.Session,
    asset: Dict[str, Any],
    base_url: str,
    dest_path: str,
    expect_size: int,
    is_master: bool = False,
    retries: int = 10,
) -> Tuple[bool, str, bool]:
    url = f"{base_url}/{asset['hash']}{asset['path']}"
    for attempt in range(retries + 1):
        try:
            if is_master:
                resp = session.get(url, timeout=20)
                resp.raise_for_status()
                content = resp.content

                if len(content) != expect_size:
                    raise ValueError(f"文件大小不符 {len(content)} ≠ {expect_size}")
                ensure_dir(dest_path)
                with open(dest_path, "wb") as f:
                    f.write(content)
                dec_data = decrypt_table_data(content)
                extract_master_data_to_json(dec_data, TABLES_ROOT)

                return True, f"", True

            else:
                resp = session.get(url, stream=True, timeout=20)
                resp.raise_for_status()

                iterator = resp.iter_content(8192)
                try:
                    first_chunk = next(iterator)
                except StopIteration:
                    first_chunk = b""

                ensure_dir(dest_path)
                with open(dest_path, "wb") as fp:
                    fp.write(first_chunk)
                    for chunk in iterator:
                        fp.write(chunk)

                real_size = os.path.getsize(dest_path)
                if real_size != expect_size:
                    os.remove(dest_path)
                    raise ValueError(f"文件大小不符 {real_size} ≠ {expect_size}")

                return True, "完成", False
        except Exception as e:
            if attempt < retries:
                time.sleep(1)
            else:
                return False, str(e), False
    return False, "未知错误", False


def worker(
    q: Queue,
    base_url: str,
    progress: Progress,
    lock: threading.Lock,
    download_failures: dict,
):
    sess = requests.Session()
    while True:
        item = q.get()
        if item is None:
            break

        asset, dest, size, is_master, task_id = item
        ok, msg, actually_master = download_one(
            sess, asset, base_url, dest, size, is_master
        )

        with lock:
            if not ok:
                url = f"{base_url}/{asset['hash']}{asset['path']}"
                console.print(f"  下载链接: {url}")
                download_failures[asset["path"]] = url

            progress.advance(task_id)
        q.task_done()
    sess.close()


def main():
    ap = argparse.ArgumentParser(
        description="MonmusuTDx 资源全自动下载 / 表格导出",
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

    base_ver = ab["baseVersion"]
    base_url = (
        f"https://assets.game-monmusu-td.net/assetbundles/ver_{base_ver}/webgl_r18"
    )
    assets = ab["data"]

    console.print(
        f"[bold yellow]远端资源版本：{bundle_version}[/bold yellow]\n"
        f"[bold yellow]资产基准版本：ver_{base_ver}[/bold yellow]"
    )

    os.makedirs(ASSETS_ROOT, exist_ok=True)
    os.makedirs(TABLES_ROOT, exist_ok=True)

    processed_files = set()
    master_tasks = []
    normal_tasks = []

    for asset in assets:
        asset_path = asset["path"]
        if asset_path in processed_files:
            continue
        processed_files.add(asset_path)

        remote_size = int(asset["size"])
        local_path = os.path.join(ASSETS_ROOT, asset_path)
        is_master = asset_path in MASTER_FILE_NAMES

        if args.force or not os.path.exists(local_path):
            task_tuple = (asset, local_path, remote_size, is_master)
            if is_master:
                master_tasks.append(task_tuple)
            else:
                normal_tasks.append(task_tuple)
        else:
            try:
                local_size = os.path.getsize(local_path)
            except OSError:
                local_size = -1

            if local_size != remote_size:
                task_tuple = (asset, local_path, remote_size, is_master)
                if is_master:
                    master_tasks.append(task_tuple)
                else:
                    normal_tasks.append(task_tuple)

    total_master = len(master_tasks)
    total_normal = len(normal_tasks)
    total = total_master + total_normal

    if total == 0:
        console.print("[green]所有资源已是最新，无需下载。[/green]")
        return

    console.print(
        f"[cyan]共需下载 {total} 个文件 (数据表: {total_master}, 其他资产: {total_normal})，线程数：{min(args.threads, total)}[/cyan]"
    )

    download_failures = {}
    q: Queue = Queue()
    lock = threading.Lock()
    workers = []

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
        num_threads = min(args.threads, total)
        for _ in range(num_threads):
            t = threading.Thread(
                target=worker,
                args=(q, base_url, progress, lock, download_failures),
                daemon=True,
            )
            t.start()
            workers.append(t)

        if total_master > 0:
            task_id_master = progress.add_task(
                "[magenta]正在下载数据表...[/magenta]", total=total_master
            )
            for t in master_tasks:
                q.put((*t, task_id_master))
            q.join()

        if total_normal > 0:
            task_id_normal = progress.add_task(
                "[cyan]正在下载其他资产...[/cyan]", total=total_normal
            )
            for t in normal_tasks:
                q.put((*t, task_id_normal))
            q.join()

        for _ in workers:
            q.put(None)
        for t in workers:
            t.join()

    console.print("[bold green]全部下载完成！[/bold green]")

    if download_failures:
        console.print("\n[red]以下文件下载失败：[/red]")
        for f_path, f_url in download_failures.items():
            console.print(f"[red]{f_path} : {f_url}[/red]")


if __name__ == "__main__":
    main()
