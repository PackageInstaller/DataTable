import os
import time
import json
import argparse
import threading
import requests
import hashlib
from queue import Queue
from typing import Dict, Any, Tuple, List, Set

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
ADVSCENE_ROOT = "AdvScene"
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
    try:
        env = UnityPy.load(decrypted_bytes)
    except Exception:
        return extracted_names

    container_map = {}
    for container_path, obj in env.container.items():
        container_map[obj.path_id] = container_path

    for obj in env.objects:
        if obj.type == ClassIDType.MonoBehaviour:
            try:
                # data = obj.read()
                tree = obj.read_typetree()
                name = tree.get("m_Name", "")
                container_path = container_map.get(obj.path_id)
                if container_path:
                    rel_dir = os.path.dirname(container_path.replace("\\", "/")).lstrip(
                        "/"
                    )
                    target_dir = os.path.normpath(os.path.join(output_dir, rel_dir))
                else:
                    target_dir = output_dir

                os.makedirs(target_dir, exist_ok=True)
                out_path = os.path.join(target_dir, f"{name}.json")
                with open(out_path, "w", encoding="utf-8") as f:
                    json.dump(tree, f, ensure_ascii=False, indent=2)

                extracted_names.append(name)
            except Exception:
                pass

    return extracted_names


def get_asset_hash(real_path: str) -> str:
    bundle_name = real_path.lower().replace("/", "-")
    return hashlib.md5(bundle_name.encode("utf-8")).hexdigest() + ".bytes"


def scan_masterdata_for_scenario_names(master_dir: str) -> Set[str]:
    scenario_names = set()
    if not os.path.exists(master_dir):
        return scenario_names

    for root, _, files in os.walk(master_dir):
        for f in files:
            if not f.endswith(".json"):
                continue
            try:
                with open(os.path.join(root, f), "r", encoding="utf-8") as file:
                    data = json.load(file)

                    def find_scenario_names(obj: Any) -> None:
                        if isinstance(obj, dict):
                            for k, v in obj.items():
                                if k == "scenario_name" and isinstance(v, str) and v:
                                    scenario_names.add(v)
                                else:
                                    find_scenario_names(v)
                        elif isinstance(obj, list):
                            for item in obj:
                                find_scenario_names(item)

                    find_scenario_names(data)
            except Exception:
                pass
    return scenario_names


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
    task_type: str = "normal",
    retries: int = 10,
) -> Tuple[bool, str, str]:
    url = f"{base_url}/{asset['hash']}{asset['path']}"
    for attempt in range(retries + 1):
        try:
            if task_type in ("master", "advscene"):
                resp = session.get(url, timeout=20)
                resp.raise_for_status()
                content = resp.content

                if len(content) != expect_size:
                    raise ValueError(f"文件大小不符 {len(content)} ≠ {expect_size}")

                ensure_dir(dest_path)
                with open(dest_path, "wb") as f:
                    f.write(content)

                if task_type == "master":
                    content = decrypt_table_data(content)

                out_dir = TABLES_ROOT if task_type == "master" else ADVSCENE_ROOT
                names = extract_master_data_to_json(content, out_dir)

                if len(names) > 10:
                    names_str = f"{len(names)} 个配置子项"
                else:
                    names_str = ", ".join(names)

                return True, f"成功导出 -> [ {names_str} ]", task_type

            else:
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

                return True, "完成", "normal"
        except Exception as e:
            if attempt < retries:
                time.sleep(1)
            else:
                return False, str(e), task_type
    return False, "未知错误", task_type


def run_download_workers(
    tasks: List[Tuple],
    desc_text: str,
    color: str,
    base_url: str,
    download_failures: dict,
):
    if not tasks:
        return

    q = Queue()
    for t in tasks:
        q.put(t)

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
        task_id = progress.add_task(f"[{color}]{desc_text}[/{color}]", total=len(tasks))

        def _worker():
            sess = requests.Session()
            while True:
                item = q.get()
                if item is None:
                    break

                asset, dest, size, task_type = item
                ok, msg, real_task_type = download_one(
                    sess, asset, base_url, dest, size, task_type
                )

                with lock:
                    status = "[green]✓[/green]" if ok else "[red]✗[/red]"
                    if real_task_type == "master":
                        log_prefix = "[bold magenta][数据表][/bold magenta] "
                    elif real_task_type == "advscene":
                        log_prefix = "[bold yellow][剧情包][/bold yellow] "
                    else:
                        log_prefix = ""

                    console.print(f"{status} {log_prefix}{asset['path']}  {msg}")

                    if not ok:
                        url = f"{base_url}/{asset['hash']}{asset['path']}"
                        console.print(f"  下载链接: {url}")
                        download_failures[asset["path"]] = url

                    progress.advance(task_id)
                q.task_done()
            sess.close()

        for _ in range(min(MAX_THREADS, len(tasks))):
            t = threading.Thread(target=_worker, daemon=True)
            t.start()
            workers.append(t)

        q.join()
        for _ in workers:
            q.put(None)
        for t in workers:
            t.join()


def main():
    ap = argparse.ArgumentParser(
        description="MonmusuTDx 资源全自动下载 / 表格导出 / 剧情导出",
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
        f"{bundle_version}/windows_r18/ablist.json" # 这里还可以换成android_r18，webgl_r18，有啥不同我也不知道
    )
    try:
        ab = sess.get(ablist_url, timeout=10).json()
    except Exception as e:
        console.print(f"[red]获取 ablist.json 失败：{e}[/red]")
        return

    base_ver = ab["baseVersion"]
    base_url = (
        f"https://assets.game-monmusu-td.net/assetbundles/ver_{base_ver}/windows_r18"
    ) # 这里还可以换成android_r18，webgl_r18，有啥不同我也不知道
    assets = ab["data"]

    console.print(
        f"[bold yellow]远端资源版本：{bundle_version}[/bold yellow]\n"
        f"[bold yellow]资产基准版本：ver_{base_ver}[/bold yellow]"
    )

    os.makedirs(ASSETS_ROOT, exist_ok=True)
    os.makedirs(TABLES_ROOT, exist_ok=True)
    os.makedirs(ADVSCENE_ROOT, exist_ok=True)

    processed_files = set()
    master_tasks = []
    pending_assets = []

    for asset in assets:
        asset_path = asset["path"]
        if asset_path in processed_files:
            continue
        processed_files.add(asset_path)

        remote_size = int(asset["size"])
        local_path = os.path.join(ASSETS_ROOT, asset_path)
        is_master = asset_path in MASTER_FILE_NAMES

        needs_download = False
        if args.force or not os.path.exists(local_path):
            needs_download = True
        else:
            try:
                local_size = os.path.getsize(local_path)
                if local_size != remote_size:
                    needs_download = True
            except OSError:
                needs_download = True

        if is_master:
            if needs_download:
                master_tasks.append((asset, local_path, remote_size, "master"))
        else:
            pending_assets.append((asset, local_path, remote_size, needs_download))

    download_failures = {}

    if master_tasks:
        run_download_workers(
            master_tasks, "正在下载数据表...", "magenta", base_url, download_failures
        )

    scenario_names = scan_masterdata_for_scenario_names(TABLES_ROOT)
    console.print(
        f"[cyan]从已解压数据表中查找到 {len(scenario_names)} 个剧情场景引用。[/cyan]"
    )

    target_advscene_files = set()
    target_advscene_files.add(get_asset_hash("ScenarioChapter/config.chapter"))

    for sn in scenario_names:
        target_advscene_files.add(get_asset_hash(f"ScenarioChapter/{sn}.book"))

    advscene_tasks = []
    normal_tasks = []

    for asset, local_path, remote_size, needs_download in pending_assets:
        if needs_download:
            if asset["path"] in target_advscene_files:
                advscene_tasks.append((asset, local_path, remote_size, "advscene"))
            else:
                normal_tasks.append((asset, local_path, remote_size, "normal"))

    total = len(master_tasks) + len(advscene_tasks) + len(normal_tasks)
    if total == 0:
        console.print("[green]所有资源已是最新，无需下载。[/green]")
        return

    console.print(
        f"[cyan]共需下载 {total} 个文件 (数据表: {len(master_tasks)}, 剧情包: {len(advscene_tasks)}, 其它: {len(normal_tasks)})，线程数：{min(args.threads, total)}[/cyan]"
    )

    run_download_workers(
        advscene_tasks, "正在下载剧情包...", "yellow", base_url, download_failures
    )
    run_download_workers(
        normal_tasks, "正在下载其他资产...", "cyan", base_url, download_failures
    )

    console.print("[bold green]全部下载及导出流程完成！[/bold green]")

    if download_failures:
        console.print("\n[red]以下文件下载失败：[/red]")
        for f_path, f_url in download_failures.items():
            console.print(f"[red]{f_path} : {f_url}[/red]")


if __name__ == "__main__":
    main()
