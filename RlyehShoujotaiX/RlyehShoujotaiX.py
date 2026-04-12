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
    "advscene-scenarioexcel-option.book",  # AdvScene/ScenarioExcel/option.book.asset
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


def extract_audio_data(bundle_data: bytes, output_dir: str) -> int:
    """从音频AssetBundle中提取AudioClip资源，按 container path 保存"""
    try:
        import UnityPy
        from UnityPy.enums import ClassIDType
    except ImportError:
        return 0

    try:
        env = UnityPy.load(bundle_data)
    except Exception as e:
        return 0

    count = 0
    base_rel_path = ""
    if env.container:
        first_container_path = list(env.container.keys())[0]
        base_rel_path = os.path.splitext(first_container_path)[0]

    for obj in env.objects:
        try:
            if obj.type == ClassIDType.AudioClip:
                clip = obj.read()

                name = (
                    getattr(clip, "name", "")
                    or getattr(clip, "m_Name", "")
                    or f"AudioClip_{obj.path_id}"
                )
                final_rel = base_rel_path if base_rel_path else name
                if base_rel_path and name and name not in base_rel_path:
                    final_rel = f"{base_rel_path}_{name}"
                if hasattr(clip, "samples") and clip.samples:
                    for sample_name, audio_data in clip.samples.items():
                        ext = os.path.splitext(sample_name)[1]
                        if not ext:
                            ext = ".wav"
                        out_path = os.path.join(output_dir, f"{final_rel}{ext}")
                        ensure_dir(out_path)
                        with open(out_path, "wb") as f:
                            f.write(audio_data)
                        count += 1
        except Exception as e:
            pass

    return count


def extract_spine_data(bundle_data: bytes, output_dir: str) -> int:
    """从纹理AssetBundle中提取Texture2D资源及Spine相关文件 (.skel, .atlas, .json)，按 container path 保存"""
    try:
        import UnityPy
        from UnityPy.enums import ClassIDType
    except ImportError:
        return 0

    try:
        env = UnityPy.load(bundle_data)
    except Exception:
        return 0

    count = 0
    base_rel_path = ""
    container_dir = ""
    if env.container:
        first_container_path = list(env.container.keys())[0]
        base_rel_path = os.path.splitext(first_container_path)[0]
        container_dir = os.path.dirname(first_container_path)

    for obj in env.objects:
        try:
            if obj.type == ClassIDType.Texture2D:
                data = obj.read()
                name = (
                    getattr(data, "m_Name", "")
                    or getattr(data, "name", "")
                    or f"Texture_{obj.path_id}"
                )

                final_rel = base_rel_path if base_rel_path else name
                if base_rel_path and name and name not in base_rel_path:
                    if not base_rel_path.endswith(name):
                        final_rel = f"{base_rel_path}_{name}"

                try:
                    image = data.image
                    if image:
                        out_path = os.path.join(output_dir, f"{final_rel}.png")
                        ensure_dir(out_path)
                        image.save(out_path)
                        count += 1
                except Exception:
                    pass

            elif obj.type == ClassIDType.TextAsset:
                try:
                    data = obj.read()
                    name = (
                        getattr(data, "m_Name", "")
                        or getattr(data, "name", "")
                        or f"TextAsset_{obj.path_id}"
                    )
                    content = getattr(data, "m_Script", None)
                    if content is None:
                        content = getattr(data, "script", None)

                    if content is not None:
                        if isinstance(content, str):
                            try:
                                content_bytes = content.encode(
                                    "utf-8", "surrogateescape"
                                )
                            except Exception:
                                content_bytes = content.encode("utf-8", "ignore")
                        else:
                            content_bytes = content

                        if container_dir:
                            out_path = os.path.join(output_dir, container_dir, name)
                        else:
                            out_path = os.path.join(output_dir, name)

                        ensure_dir(out_path)
                        with open(out_path, "wb") as f:
                            f.write(content_bytes)
                        count += 1
                except Exception:
                    pass
        except Exception:
            pass

    return count


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


def scan_scenarios_for_r18_voices(adv_dir: Path) -> Set[str]:
    """扫描已解压的剧情文件，提取 R18 语音资源路径并转换为资产名称 MD5"""
    voice_md5s = set()
    character_adv_dir = adv_dir / "scenarioexcel" / "character"
    if not character_adv_dir.exists():
        return voice_md5s

    console.print("[magenta]正在扫描 R18 剧情文件以获取语音...[/magenta]")
    count = 0
    for root, _, files in os.walk(character_adv_dir):
        for f in files:
            if f.lower().endswith("_r18.book.json"):
                try:
                    with open(os.path.join(root, f), "r", encoding="utf-8") as file:
                        data = json.load(file)
                        for grid in data.get("importGridList", []):
                            for row in grid.get("rows", []):
                                s = row.get("strings", [])
                                if len(s) > 11:
                                    voice_path = s[11]
                                    if voice_path and "Character/" in voice_path:
                                        asset_name = f"advscene-sound-voice-{voice_path.lower().replace('/', '-')}"
                                        voice_md5s.add(
                                            f"{get_md5_string(asset_name)}.bytes"
                                        )
                    count += 1
                except Exception:
                    pass
    if count > 0:
        console.print(
            f"[green]已分析 {count} 个 R18 剧情文件，共定位 {len(voice_md5s)} 条语音[/green]"
        )
    return voice_md5s


def scan_masterdata_for_resource_ids(
    master_dir: Path,
) -> Tuple[Set[int], Dict[int, Set[int]]]:
    """扫描 MasterData 中 unit 和 enemy 数据获取角色资源 ID。返回(resource_ids, {resource_id: {skin_ids}})。"""
    resource_ids: Set[int] = set()
    skin_ids_map: Dict[int, Set[int]] = {}

    if not master_dir.exists():
        return resource_ids, skin_ids_map

    # 扫描 unit 目录
    unit_dir = master_dir / "unit"
    if unit_dir.exists():
        for f in unit_dir.glob("*.json"):
            try:
                with open(f, "r", encoding="utf-8") as file:
                    data = json.load(file)
                    # 提取 resource 字段
                    resource_id = data.get("resource")
                    if isinstance(resource_id, int) and resource_id > 0:
                        resource_ids.add(resource_id)
                        if resource_id not in skin_ids_map:
                            skin_ids_map[resource_id] = {0, 1}  # 默认探测 0 和 1
                        
            except Exception:
                pass

    # 扫描 enemy 目录
    enemy_dir = master_dir / "enemy"
    if enemy_dir.exists():
        for f in enemy_dir.glob("*.json"):
            try:
                with open(f, "r", encoding="utf-8") as file:
                    data = json.load(file)
                    resource_id = data.get("resource")
                    if isinstance(resource_id, int) and resource_id > 0:
                        resource_ids.add(resource_id)
                        if resource_id not in skin_ids_map:
                            skin_ids_map[resource_id] = {0}
            except Exception:
                pass

    # 额外扫描 R18 单元关联
    story_data_path = master_dir / "data" / "story_data_unit.json"
    if story_data_path.exists():
        try:
            with open(story_data_path, "r", encoding="utf-8") as f:
                story_data = json.load(f)
                for record in story_data.get("records", []):
                    if record.get("r18") == 1:
                        sn = record.get("scenario_name", "")
                        if sn and "_" in sn:
                            rid_str = sn.split("A")[0]
                            if rid_str.isdigit():
                                rid = int(rid_str)
                                resource_ids.add(rid)
                                if rid not in skin_ids_map:
                                    skin_ids_map[rid] = {0, 1}
        except Exception:
            pass

    return resource_ids, skin_ids_map


def scan_chapter_config_for_textures(adv_dir: Path) -> Set[str]:
    """解析 config.chapter.json，根据每一行的 FileName 字段生成资产 MD5"""
    texture_md5s = set()
    config_path = adv_dir / "scenariochapter" / "config.chapter.json"
    if not config_path.exists():
        return texture_md5s

    console.print(
        "[magenta]正在解析spine列表...[/magenta]"
    )
    try:
        with open(config_path, "r", encoding="utf-8") as f:
            data = json.load(f)

        for sheet in data.get("settingList", []):
            rows = sheet.get("rows", [])
            if not rows:
                continue

            # 第一行是表头
            headers = rows[0].get("strings", [])
            try:
                file_name_idx = headers.index("FileName")
            except ValueError:
                continue

            for row in rows[1:]:
                strings = row.get("strings", [])
                if len(strings) > file_name_idx:
                    file_path = strings[file_name_idx]
                    if not file_path or not isinstance(file_path, str):
                        continue
                    clean_path = file_path.lower()
                    if clean_path.endswith(".prefab"):
                        clean_path = clean_path[:-7]

                    asset_name = (
                        f"advscene-texture-character-{clean_path.replace('/', '-')}"
                    )
                    texture_md5s.add(f"{get_md5_string(asset_name)}.bytes")

    except Exception as e:
        console.print(f"[red]解析 config.chapter.json 失败: {e}[/red]")
    return texture_md5s


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

    resource_ids, skin_ids_map = scan_masterdata_for_resource_ids(masterdata_out_dir)
    console.print(f"[cyan]共查找到 {len(resource_ids)} 个角色资源。[/cyan]")
    target_audio_files: Set[str] = set()
    for rid in resource_ids:
        asset_name = f"advscene-sound-bgm-bgm_{rid}"
        target_audio_files.add(f"{get_md5_string(asset_name)}.bytes")
        asset_name = f"advscene-sound-se-se_{rid}"
        target_audio_files.add(f"{get_md5_string(asset_name)}.bytes")
        asset_name = f"advscene-sound-ambience-amb_{rid}"
        target_audio_files.add(f"{get_md5_string(asset_name)}.bytes")
        for voice_id in range(100):
            asset_name = f"advscene-sound-voice-character-ch_{rid}-general-vo_general_{rid}_{voice_id:03d}"
            target_audio_files.add(f"{get_md5_string(asset_name)}.bytes")

    r18_voice_md5s = scan_scenarios_for_r18_voices(advscene_out_dir)
    if r18_voice_md5s:
        target_audio_files |= r18_voice_md5s

    target_texture_files = scan_chapter_config_for_textures(advscene_out_dir)
    for rid in resource_ids:
        skins = skin_ids_map.get(rid, {0, 1})
        for skin_id in skins:
            asset_name = f"advscene-texture-character-chr_poses-pose_{rid}_{skin_id}-pose_{rid}_{skin_id}"
            target_texture_files.add(f"{get_md5_string(asset_name)}.bytes")

    target_advscene_all_files = (
        target_advscene_files | target_audio_files | target_texture_files
    )

    advscene_tasks = [
        t for t in other_asset_infos if Path(t[4]).name in target_advscene_all_files
    ]
    other_tasks = [
        t for t in other_asset_infos if Path(t[4]).name not in target_advscene_all_files
    ]
    files_to_extract = [
        str(output_dir / a.get("path"))
        for a in assets
        if a.get("path") and Path(a["path"]).name in target_advscene_files
    ]
    audio_files_to_download = [
        str(output_dir / a.get("path"))
        for a in assets
        if a.get("path") and Path(a["path"]).name in target_audio_files
    ]
    texture_files_to_download = [
        str(output_dir / a.get("path"))
        for a in assets
        if a.get("path") and Path(a["path"]).name in target_texture_files
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
                f"[bold green]已导出 {extracted_count} 个剧情包的 AdvScene[/bold green]"
            )

    audio_out_dir = SCRIPT_DIR / "Audio"
    audio_extracted_count = 0
    if audio_files_to_download:
        console.print(f"[cyan]开始处理 {len(audio_files_to_download)} 个音频...[/cyan]")

        for i, file_path in enumerate(audio_files_to_download):
            if os.path.exists(file_path):
                try:
                    with open(file_path, "rb") as f:
                        count = extract_audio_data(f.read(), str(audio_out_dir))
                        if count:
                            audio_extracted_count += count
                except Exception as e:
                    console.print(f"[dim red]处理音频 {file_path} 异常: {e}[/dim red]")
        console.print(
            f"[bold green]音频处理完成：解包 {audio_extracted_count} 个[/bold green]"
        )
    spine_out_dir = SCRIPT_DIR / "Spine"
    spine_extracted_count = 0
    if texture_files_to_download:
        console.print(
            f"[cyan]开始处理 {len(texture_files_to_download)} 个spine...[/cyan]"
        )

        for i, file_path in enumerate(texture_files_to_download):
            if os.path.exists(file_path):
                try:
                    count = 0
                    with open(file_path, "rb") as f:
                        count = extract_spine_data(f.read(), str(spine_out_dir))
                        if count:
                            spine_extracted_count += count

                except Exception as e:
                    console.print(
                        f"[dim red]处理spine包 {file_path} 异常: {e}[/dim red]"
                    )

        console.print(
            f"[bold green]spine处理完成：解包 {spine_extracted_count} 个[/bold green]"
        )
    if other_tasks:
        console.print(f"[cyan]正在下载 {len(other_tasks)} 个其他资产...[/cyan]")
        fails = run_download_workers(other_tasks, "正在下载其他资产...")
        if fails:
            console.print(
                f"[yellow]提示：有 {len(fails)} 个非目标资产下载失败[/yellow]"
            )
    elif not master_bytes_list and not advscene_tasks:
        console.print("[green]所有目标资源已是最新，无需下载。[/green]")

    ensure_dir(str(old_catalog_path))
    with open(old_catalog_path, "wb") as f:
        f.write(catalog_bytes)
    sess.close()


if __name__ == "__main__":
    main()
