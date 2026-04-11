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
from typing import Dict, Any, List, Tuple, Set
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
BASE_URL = "https://assets.cthulhu-rog.net/assetbundles/production"
PLATFORM_DIR = "android_r18"
MAX_THREADS = 16
DEFAULT_OUTPUT_DIR = "Assets"


FIXED_ADVSCENE_ASSETS = {
    "advscene-scenariochapter-config.chapter",  # AdvScene/ScenarioChapter/config.chapter.asset
    "advscene-scenarioexcel-option.book",       # AdvScene/ScenarioExcel/option.book.asset
}

master_file_names = {
    "c8fe981361f54d5d4315a3394281a458.bytes",  # MasterData/Data
    "01cca872ea5621dcd6457b12ee93f940.bytes",  # MasterData/Message
    "158549cabb35676aba1a7e6127628912.bytes",  # MasterData/Bom
    "4a71172835b1a40770d6f07c97d65ab2.bytes",  # MasterData/UnitClass
    "66307aa2d98387e660afec0af36b4ce3.bytes",  # MasterData/Unit
    "6bd1c066828badba0bd9a1b480eef82a.bytes",  # MasterData/Enemy
}


def get_md5_string(source: str) -> str:
    return hashlib.md5(source.encode("utf-8")).hexdigest()


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


def decode_obscured_data(obj: Any) -> Any:
    if isinstance(obj, dict):
        if "hiddenChars" in obj and isinstance(obj["hiddenChars"], list):
            return "".join(chr(c) for c in obj["hiddenChars"])

        if "hiddenValue" in obj and "currentCryptoKey" in obj:
            hidden_val = obj["hiddenValue"]
            crypto_key = obj["currentCryptoKey"]

            if isinstance(hidden_val, int) and isinstance(crypto_key, int):
                return (hidden_val - crypto_key) ^ crypto_key

        return {k: decode_obscured_data(v) for k, v in obj.items()}

    elif isinstance(obj, list):
        return [decode_obscured_data(item) for item in obj]

    else:
        return obj


def extract_master_data(bundle_data: bytes, output_dir: str) -> None:
    try:
        import UnityPy
        from UnityPy.enums import ClassIDType
    except ImportError:
        console.print(
            "[yellow]未安装 UnityPy，跳过导出步骤。请执行: pip install UnityPy[/yellow]"
        )
        return

    env = UnityPy.load(bundle_data)

    obj_to_container = {}
    for container_path, obj in env.container.items():
        obj_to_container[obj.path_id] = container_path

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

                container_path = obj_to_container.get(obj.path_id, "")
                sub_dir = ""
                if container_path:
                    idx = container_path.lower().find("masterdata/")
                    if idx != -1:
                        after_masterdata = container_path[idx + len("masterdata/") :]
                        sub_dir = os.path.dirname(after_masterdata)

                final_dir = os.path.join(output_dir, sub_dir) if sub_dir else output_dir
                out_path = os.path.join(final_dir, f"{name}.json")
                ensure_dir(out_path)

                clean_tree = decode_obscured_data(tree)
                with open(out_path, "w", encoding="utf-8") as f:
                    json.dump(clean_tree, f, ensure_ascii=False, indent=4)
                count += 1
            except Exception as e:
                console.print(
                    f"[dim yellow]跳过 {obj.path_id} (解析失败): {e}[/dim yellow]"
                )

    console.print(f"[bold green]共提取 {count} 个数据表[/bold green]")


def extract_advscene_data(bundle_data: bytes, output_base_dir: str) -> None:
    try:
        import UnityPy
        from UnityPy.enums import ClassIDType
    except ImportError:
        console.print(
            "[yellow]未安装 UnityPy，跳过 AdvScene 导出。请执行: pip install UnityPy[/yellow]"
        )
        return

    try:
        env = UnityPy.load(bundle_data)
    except Exception as e:
        console.print(f"[red]无法加载此剧情资源包: {e}[/red]")
        return

    obj_to_container = {}
    for container_path, obj in env.container.items():
        obj_to_container[obj.path_id] = container_path

    count = 0
    for obj in env.objects:
        if obj.type != ClassIDType.MonoBehaviour:
            continue
        try:
            data = obj.read()
            name = getattr(data, "name", "")
            tree = obj.read_typetree()
            if not name:
                name = tree.get("m_Name", "")
            if not name:
                name = f"MonoBehaviour_{obj.path_id}"

            container_path = obj_to_container.get(obj.path_id, "")
            sub_dir = ""
            if container_path:
                idx = container_path.lower().find("advscene/")
                if idx != -1:
                    after_keyword = container_path[idx + len("advscene/") :]
                    sub_dir = os.path.dirname(after_keyword)

            final_dir = (
                os.path.join(output_base_dir, sub_dir) if sub_dir else output_base_dir
            )
            out_path = os.path.join(final_dir, f"{name}.json")
            ensure_dir(out_path)
            with open(out_path, "w", encoding="utf-8") as f:
                json.dump(tree, f, ensure_ascii=False, indent=4)
            count += 1
        except Exception as e:
            console.print(
                f"[dim yellow]跳过 {obj.path_id} (解析失败): {e}[/dim yellow]"
            )
    # if count > 0:
    #     console.print(
    #         f"[green]成功提取了 {count} 个剧情脚本到 {output_base_dir}[/green]"
    #     )


def scan_masterdata_for_scenario_names(master_dir: Path) -> Set[str]:
    scenario_names: Set[str] = {"option"}
    if not master_dir.exists():
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
                                if k == "scenario_name" and isinstance(v, str):
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
    try:
        resp = session.post(
            VERSION_API_URL,
            timeout=10,
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
    try:
        resp = session.get(catalog_url, timeout=10)
        resp.raise_for_status()
        return resp.content
    except Exception as e:
        console.print(f"[red]获取 catalog 失败: {e}[/red]")
        return None


def download_one(
    session: requests.Session,
    url: str,
    dest_path: str,
    expect_size: int,
    retries: int = 5,
) -> Tuple[bool, str]:
    for attempt in range(retries + 1):
        try:
            resp = session.get(url, stream=True, timeout=60)
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


def run_download_workers(
    tasks: List[Tuple[str, str, str, int, str]],
    desc: str = "正在下载...",
) -> Dict[str, str]:
    download_failures: Dict[str, str] = {}
    total = len(tasks)
    if total == 0:
        return download_failures
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
        task_id = progress.add_task(f"[cyan]{desc}[/cyan]", total=total)
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
    return download_failures


def main() -> None:
    sess = requests.Session()
    catalog_hash = fetch_catalog_hash(sess)
    if not catalog_hash:
        sess.close()
        sys.exit(1)
    console.print(f"[cyan]catalog hash: {catalog_hash}[/cyan]")
    catalog_bytes = fetch_catalog_bytes(sess, catalog_hash)
    if not catalog_bytes:
        sess.close()
        sys.exit(1)

    try:
        catalog_data = json.loads(catalog_bytes.decode("utf-8"))
    except Exception as e:
        console.print(f"[red]解析 catalog JSON 失败: {e}[/red]")
        sess.close()
        sys.exit(1)

    base_version = catalog_data.get("baseVersion", "1")
    assets = catalog_data.get("data", [])

    output_dir = Path(DEFAULT_OUTPUT_DIR).resolve()
    updates_dir = Path("Updates").resolve()
    masterdata_out_dir = SCRIPT_DIR / "MasterData"
    advscene_out_dir = SCRIPT_DIR / "AdvScene"

    is_first_run = True
    if output_dir.exists() and any(output_dir.iterdir()):
        is_first_run = False

    old_catalog_path = SCRIPT_DIR / "ablist.json"
    old_catalog_data: Dict[str, str] = {}
    if old_catalog_path.exists():
        try:
            with open(old_catalog_path, "r", encoding="utf-8") as f:
                old_catalog = json.load(f)
                for item in old_catalog.get("data", []):
                    old_path = item.get("path")
                    if old_path:
                        old_catalog_data[old_path] = item.get("hash", "")
        except Exception as e:
            console.print(f"[yellow]解析本地 ablist.json 失败: {e}[/yellow]")

    seen_paths: set = set()
    master_info_list: List[Tuple[str, str, int]] = []
    other_asset_infos: List[Tuple[str, str, str, int, str]] = []

    for asset in assets:
        rel_path = asset.get("path")
        asset_hash = asset.get("hash", "")
        expect_size = asset.get("size", 0)
        if not rel_path or rel_path in seen_paths:
            continue
        seen_paths.add(rel_path)

        is_master = Path(rel_path).name in master_file_names
        final_dest = output_dir / rel_path
        hash_matched = old_catalog_data.get(rel_path) == asset_hash
        download_filename = f"{asset_hash}{rel_path}"
        url = f"{BASE_URL}/ver_{base_version}/{PLATFORM_DIR}/{download_filename}"

        if is_master:
            file_exists = final_dest.exists() and (
                expect_size == 0 or final_dest.stat().st_size == expect_size
            )
            if hash_matched and file_exists and masterdata_out_dir.exists():
                continue
            master_info_list.append((rel_path, url, expect_size))
        else:
            file_exists_and_size_matched = final_dest.exists() and (
                expect_size == 0 or final_dest.stat().st_size == expect_size
            )
            if hash_matched and file_exists_and_size_matched:
                continue
            download_dest = final_dest if is_first_run else updates_dir / rel_path
            other_asset_infos.append(
                (url, str(download_dest), str(final_dest), expect_size, rel_path)
            )

    master_bytes_list: List[Tuple[str, bytes]] = []
    if master_info_list:
        console.print(f"[cyan]正在下载 {len(master_info_list)} 个数据表文件...[/cyan]")
        for rel_path, url, expect_size in master_info_list:
            try:
                resp = sess.get(url, timeout=60)
                resp.raise_for_status()
                mb = resp.content
                if expect_size > 0 and len(mb) != expect_size:
                    console.print(
                        f"[red]{rel_path} 大小校验失败: {len(mb)} != {expect_size}[/red]"
                    )
                else:
                    master_bytes_list.append((rel_path, mb))
            except Exception as e:
                console.print(f"[red]下载数据表 {rel_path} 失败: {e}[/red]")

    if master_bytes_list:
        for rel_path, mb in master_bytes_list:
            decrypted = decrypt_table_bytes(mb)
            if decrypted:
                extract_master_data(decrypted, str(masterdata_out_dir))
    elif not masterdata_out_dir.exists():
        for m_name in master_file_names:
            master_path = output_dir / m_name
            if master_path.exists():
                with open(master_path, "rb") as f:
                    decrypted = decrypt_table_bytes(f.read())
                if decrypted:
                    extract_master_data(decrypted, str(masterdata_out_dir))
                    break

    scenario_names = scan_masterdata_for_scenario_names(masterdata_out_dir)
    console.print(f"[cyan]共查找到 {len(scenario_names)} 个剧情配置目标。[/cyan]")

    target_advscene_files: Set[str] = set()
    for sn in scenario_names:
        asset_name = f"advscene-scenarioexcel-{sn.lower()}.book"
        target_advscene_files.add(f"{get_md5_string(asset_name)}.bytes")
    for fixed_name in FIXED_ADVSCENE_ASSETS:
        target_advscene_files.add(f"{get_md5_string(fixed_name)}.bytes")

    advscene_tasks = [
        t for t in other_asset_infos if Path(t[4]).name in target_advscene_files
    ]
    other_tasks = [
        t for t in other_asset_infos if Path(t[4]).name not in target_advscene_files
    ]
    files_to_extract = [
        str(output_dir / a.get("path"))
        for a in assets
        if a.get("path") and Path(a["path"]).name in target_advscene_files
    ]

    if advscene_tasks:
        console.print(f"[cyan]正在下载 {len(advscene_tasks)} 个剧情包...[/cyan]")
        fails = run_download_workers(advscene_tasks, "正在下载剧情包...")
        if fails:
            console.print(f"[yellow]失败 {len(fails)} 个剧情文件[/yellow]")

    extracted_count = 0
    if files_to_extract:
        console.print(
            f"[cyan]开始从 {len(files_to_extract)} 份剧情包提取 AdvScene...[/cyan]"
        )
        for file_path in files_to_extract:
            if os.path.exists(file_path):
                with open(file_path, "rb") as bf:
                    extract_advscene_data(bf.read(), str(advscene_out_dir))
                extracted_count += 1
        if extracted_count > 0:
            console.print(
                f"[bold green]已从 {extracted_count} 个剧情包导出 AdvScene 到 {advscene_out_dir}[/bold green]"
            )

    # 如果需要下载全资产，取消这几行注释即可
    # if other_tasks:
    #     console.print(f"[cyan]正在下载 {len(other_tasks)} 个其他资产...[/cyan]")
    #     fails = run_download_workers(other_tasks, "正在下载其他资产...")
    #     if fails:
    #         console.print(f"[yellow]失败 {len(fails)} 个文件[/yellow]")
    elif not master_bytes_list and not advscene_tasks:
        console.print("[green]所有资源已是最新，无需下载。[/green]")

    ensure_dir(str(old_catalog_path))
    with open(old_catalog_path, "wb") as f:
        f.write(catalog_bytes)
    sess.close()


if __name__ == "__main__":
    main()
