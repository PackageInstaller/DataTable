import io
import time
import json
import msgpack
import lz4.block
import requests
from pathlib import Path
from typing import List, Optional, Any
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
from rich.console import Console
from rich.progress import Progress, BarColumn, TextColumn, TimeRemainingColumn, DownloadColumn, TransferSpeedColumn
# https://github.com/anosu/AddressablesToolsPy
from AddressablesToolsPy.src.AddressablesTools import parse_binary
from AddressablesToolsPy.src.AddressablesTools.Catalog.SerializedObjectDecoder import SerializedObjectDecoder
from datetime import datetime
from MasterMap import MASTER_RESULT_STRUCTURE


@dataclass
class DownloadTask:
    url: str
    local_path: Path
    expected_size: int

class MuvLuvDownloader:
    def __init__(self, download_dir: str = "Downloads", max_workers: int = 64, max_retries: int = 5):
        self.download_dir = Path(download_dir)
        self.download_dir.mkdir(exist_ok=True)
        # 这个地址其实是本地配置文件里面的
        self.config_url = "https://api-prereg.muvluv-girls-garden.com/api/Environment/EnvConfiguration"
        self.assets_url = ""
        self.platform = "StandaloneWindows64"
        self.catalog_types = ["sound", "spine", "ui", "vfx"]
        self.max_workers = max_workers
        self.max_retries = max_retries
        self.console = Console()
        self.session = requests.Session()

    def _parse_table(self, table_data: list, field_map: dict) -> list:
        parsed_rows = []
        for row in table_data:
            row_dict = {}
            for key_index, field_name in field_map.items():
                if key_index < len(row):
                    value = row[key_index]
                    if isinstance(value, msgpack.ExtType) and value.code == -1:
                        ts = msgpack.unpackb(value.data, raw=False)
                        row_dict[field_name] = datetime.fromtimestamp(ts).isoformat()
                    else:
                        row_dict[field_name] = value
            parsed_rows.append(row_dict)
        return parsed_rows

    def _decompress_and_unpack_recursively(self, data):
        if (isinstance(data, list) and len(data) > 1 and
                isinstance(data[0], msgpack.ExtType) and
                data[0].code == 98):
            
            self.console.print("检测到 Lz4BlockArray，正在解压缩...", style="yellow")
            header_data = data[0].data
            header_unpacker = msgpack.Unpacker(io.BytesIO(header_data), raw=False)

            sizes = list(header_unpacker)
            decompressed_data = bytearray()
            compressed_blocks = data[1:]
            
            for i, block in enumerate(compressed_blocks):
                if i < len(sizes):
                    decompressed_block = lz4.block.decompress(block, uncompressed_size=sizes[i])
                    decompressed_data.extend(decompressed_block)

            unpacked = msgpack.unpackb(decompressed_data, raw=False)
            return self._decompress_and_unpack_recursively(unpacked)

        elif isinstance(data, list):
            return [self._decompress_and_unpack_recursively(item) for item in data]
        elif isinstance(data, dict):
            return {key: self._decompress_and_unpack_recursively(value) for key, value in data.items()}
        else:
            return data

    def download_and_parse_master_data(self) -> bool:
        self.console.print("\n[bold]--- 开始处理主数据表 ---[/bold]", style="cyan")
        url = "https://api-prereg.muvluv-girls-garden.com/api/Home/getMasterData"
        # 这里到时候换成自己的，或者自己研究下生成换成动态生成的
        headers = {
            'User-Agent': "com.Tivadar.Best.HTTP v3.0.11.0/Unity 6000.0.37f1",
            'Accept': "application/vnd.msgpack",
            'Accept-Encoding': "br, gzip, deflate, identity",
            'authorization': "Bearer",
            'authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI1MDQxOSIsImF0diI6IjYyIiwibmJmIjoxNzUzMTcyNDcwLCJleHAiOjE3NTMyNTg4NzAsImlhdCI6MTc1MzE3MjQ3MCwiaXNzIjoiSXphbmFtaS5rbXMzLmNvbSIsImF1ZCI6InBwcHJlcmVnaXN0cmF0aW9uIn0.eXwpUM6HyY4S9JzBEQTaybcJQbAkPoi3tZnJHw98Q18"
        }
        json_output_path = "MasterData.json"
        msgpack_bytes = None

        try:
            response = self.session.get(url, headers=headers, timeout=60)
            response.raise_for_status()
            msgpack_bytes = response.content
        except Exception as e:
            self.console.print(f"下载主数据表失败: {e}", style="bold red")
            return False

        try:
            all_objects = list(msgpack.Unpacker(io.BytesIO(msgpack_bytes), raw=False))
            main_payload = self._decompress_and_unpack_recursively(all_objects[1])
            
            final_json_data = {}
            if isinstance(main_payload, list):
                self.console.print(f"检测到 {len(main_payload)} 个数据表，开始使用 'MASTER_RESULT_STRUCTURE' 进行映射。")
                for i, data_item in enumerate(main_payload):
                    if i in MASTER_RESULT_STRUCTURE:
                        field_name, field_map = MASTER_RESULT_STRUCTURE[i]
                        self.console.print(f"-> 解析表: {field_name}")
                        if field_map and isinstance(data_item, list):
                            final_json_data[field_name] = self._parse_table(data_item, field_map)
                        else:
                            final_json_data[field_name] = data_item
                    else:
                        final_json_data[f"UnknownField_{i}"] = data_item
            else:
                final_json_data = main_payload

            with open(json_output_path, 'w', encoding='utf-8') as f:
                json.dump(final_json_data, f, indent=4, ensure_ascii=False)
            
        except Exception as e:
            self.console.print(f"解析主数据表失败: {e}", style="bold red")
            return False
        
        return True
    
    def get_configuration(self) -> bool:
        try:
            response = self.session.get(self.config_url, timeout=30)
            response.raise_for_status()
            
            config = response.json()
            if 'result' in config and 'assetsUrl' in config['result']:
                self.assets_url = config['result']['assetsUrl']
                return True
            self.console.print("获取配置失败: 'assetsUrl' 未在响应中找到。", style="red")
            return False
        except Exception as e:
            self.console.print(f"获取配置时发生错误: {e}", style="red")
            return False
    
    def create_patcher(self):
        def patcher(match_name: str) -> str:
            if "EncryptedAssetBundleRequestOptions" in match_name:
                return SerializedObjectDecoder.ABRO_MATCHNAME
            elif "AssetBundleRequestOptions" in match_name:
                return SerializedObjectDecoder.ABRO_MATCHNAME
            return match_name
        return patcher
    
    def check_catalog_tasks(self, catalog_type: str) -> List[DownloadTask]:
        self.console.print(f"正在检查 '{catalog_type}' 目录...")
        catalog = self.parse_catalog_from_url(catalog_type)
        if not catalog:
            self.console.print(f"无法解析 '{catalog_type}' 的目录文件。", style="red")
            return []
        
        tasks = []
        base_url = f"{self.assets_url}X/{self.platform}/"
        catalog_dir = self.download_dir / catalog_type
        catalog_dir.mkdir(exist_ok=True)
        
        for name_key, infos in catalog.Resources.items():
            if isinstance(name_key, str) and name_key.endswith('.bundle'):
                info = infos[0]
                bundle_size = info.Data.Object.BundleSize if hasattr(info.Data.Object, 'BundleSize') else 0
                
                asset_url = base_url + name_key
                local_file = catalog_dir / name_key

                need_download = True
                if local_file.exists() and bundle_size > 0:
                    local_size = local_file.stat().st_size
                    if local_size == bundle_size:
                        need_download = False
                
                if need_download:
                    task = DownloadTask(
                        url=asset_url,
                        local_path=local_file,
                        expected_size=bundle_size
                    )
                    tasks.append(task)
        
        self.console.print(f"发现 {len(tasks)} 个需要下载或更新的 '{catalog_type}' 资产。")
        return tasks
    
    def parse_catalog_from_url(self, catalog_type: str) -> Optional[Any]:
        bin_url = f"{self.assets_url}X/{self.platform}/{catalog_type}_catalog.bin"
        
        try:
            response = self.session.get(bin_url, timeout=60)
            response.raise_for_status()
            
            patcher = self.create_patcher()
            catalog = parse_binary(response.content, patcher=patcher)
            return catalog
        except Exception as e:
            self.console.print(f"下载或解析目录失败: {bin_url} - {e}", style="red")
            return None
    
    def prepare_all_download_tasks(self) -> List[DownloadTask]:
        all_tasks = []
        
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            futures = {executor.submit(self.check_catalog_tasks, c_type): c_type for c_type in self.catalog_types}
            for future in as_completed(futures):
                try:
                    catalog_tasks = future.result()
                    all_tasks.extend(catalog_tasks)
                except Exception as e:
                    self.console.print(f"检查目录时发生错误: {e}", style="red")
        
        return all_tasks
    
    def download_file_with_retry(self, task: DownloadTask, progress=None, task_id=None) -> bool:
        if task.local_path.exists() and task.expected_size > 0:
            actual_size = task.local_path.stat().st_size
            if actual_size == task.expected_size:
                if progress and task_id is not None:
                    progress.update(task_id, advance=task.expected_size)
                return True
        
        for attempt in range(self.max_retries):
            try:
                response = self.session.get(task.url, timeout=60, stream=True)
                response.raise_for_status()
                
                task.local_path.parent.mkdir(parents=True, exist_ok=True)
                
                with open(task.local_path, 'wb') as f:
                    for chunk in response.iter_content(chunk_size=8192):
                        if chunk:
                            f.write(chunk)
                            if progress and task_id is not None:
                                progress.update(task_id, advance=len(chunk))
                
                if task.expected_size > 0:
                    actual_size = task.local_path.stat().st_size
                    if actual_size != task.expected_size:
                        raise ValueError(f"文件大小不匹配: 期望 {task.expected_size}, 实际 {actual_size}")
                
                return True
                
            except Exception as e:
                if attempt < self.max_retries - 1:
                    time.sleep(1)
                    continue
                else:
                    self.console.print(f"下载文件 {task.local_path.name} 失败 (尝试 {self.max_retries} 次): {e}", style="red")
                    return False
        
        return False
    
    def run(self):
        self.console.print(f"Unity版本: 6000.0.37f1", style="cyan")
        
        # if not self.download_and_parse_master_data():
        #     self.console.print("处理主数据表失败，程序终止。", style="bold red")
        #     return
        
        self.console.print("\n[bold]--- 开始处理游戏资产 ---[/bold]", style="cyan")
        if not self.get_configuration():
            self.console.print("获取资产配置失败，程序终止。", style="bold red")
            return

        all_tasks = self.prepare_all_download_tasks()
        
        if not all_tasks:
            self.console.print("\n所有资产都是最新版本，无需下载。", style="bold green")
            return
        
        total_size = sum(task.expected_size for task in all_tasks)
        self.console.print(f"\n总计需要下载 [bold]{len(all_tasks)}[/bold] 个文件，总大小 [bold]{total_size/1024/1024:.2f} MB[/bold]。", style="green")
        
        downloaded_count = 0
        with Progress(
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.1f}%",
            "•",
            DownloadColumn(),
            "•",
            TransferSpeedColumn(),
            "•",
            TimeRemainingColumn(),
            console=self.console
        ) as progress:
            
            task_id = progress.add_task("下载资产", total=total_size)
            
            with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
                futures = {
                    executor.submit(self.download_file_with_retry, task, progress, task_id): task 
                    for task in all_tasks
                }
                
                for future in as_completed(futures):
                    try:
                        if future.result():
                            downloaded_count += 1
                    except Exception as exc:
                        self.console.print(f"下载任务生成了异常: {exc}", style="red")
        
        self.console.print(f"\n下载完成: 成功下载 {downloaded_count}/{len(all_tasks)} 个文件。", style="bold green")

if __name__ == "__main__":
    downloader = MuvLuvDownloader()
    downloader.run()