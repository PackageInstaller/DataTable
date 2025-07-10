# 特么的数据表还要auth才能下，所以不包含数据表

import time
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


@dataclass
class DownloadTask:
    url: str
    local_path: Path
    expected_size: int

class MuvLuvDownloader:
    def __init__(self, download_dir: str = "Downloads", max_workers: int = 64, max_retries: int = 5):
        self.download_dir = Path(download_dir)
        self.download_dir.mkdir(exist_ok=True)
        
        self.config_url = "https://api-prereg.muvluv-girls-garden.com/api/Environment/EnvConfiguration"
        self.assets_url = ""
        self.platform = "StandaloneWindows64"
        self.catalog_types = ["sound", "spine", "ui", "vfx"]
        self.max_workers = max_workers
        self.max_retries = max_retries
        self.console = Console()
        self.session = requests.Session()
    
    def get_configuration(self) -> bool:
        try:
            response = self.session.get(self.config_url, timeout=30)
            response.raise_for_status()
            
            config = response.json()
            if 'result' in config and 'assetsUrl' in config['result']:
                self.assets_url = config['result']['assetsUrl']
                return True
            return False
        except Exception:
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
        catalog = self.parse_catalog_from_url(catalog_type)
        if not catalog:
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
        
        return tasks
    
    def parse_catalog_from_url(self, catalog_type: str) -> Optional[Any]:
        bin_url = f"{self.assets_url}X/{self.platform}/{catalog_type}_catalog.bin"
        
        try:
            response = self.session.get(bin_url, timeout=60)
            response.raise_for_status()
            
            patcher = self.create_patcher()
            catalog = parse_binary(response.content, patcher=patcher)
            return catalog
        except Exception:
            return None
    
    def prepare_all_download_tasks(self) -> List[DownloadTask]:
        all_tasks = []
        
        for catalog_type in self.catalog_types:
            catalog_tasks = self.check_catalog_tasks(catalog_type)
            all_tasks.extend(catalog_tasks)
        
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
                        raise ValueError(f"文件大小不匹配")
                
                return True
                
            except Exception:
                if attempt < self.max_retries - 1:
                    time.sleep(1)
                    continue
                else:
                    return False
        
        return False
    
    def run(self):
        self.console.print(f"Unity版本: 6000.0.37f1", style="cyan")
        if not self.get_configuration():
            self.console.print("获取配置失败", style="red")
            return

        all_tasks = self.prepare_all_download_tasks()
        total_size = sum(task.expected_size for task in all_tasks)

        if not all_tasks:
            self.console.print("所有资产都是最新版本", style="green")
            return
        
        self.console.print(f"开始下载 {len(all_tasks)} 个文件...", style="green")
        
        downloaded_count = 0
        with Progress(
            TextColumn("[bold blue]下载进度"),
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
            
            task_id = progress.add_task("下载", total=total_size)
            
            with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
                futures = {
                    executor.submit(self.download_file_with_retry, task, progress, task_id): task 
                    for task in all_tasks
                }
                
                for future in as_completed(futures):
                    try:
                        success = future.result()
                        if success:
                            downloaded_count += 1
                    except Exception:
                        pass
        
        self.console.print(f"下载: {downloaded_count}/{len(all_tasks)} 个文件", style="green")

if __name__ == "__main__":
    downloader = MuvLuvDownloader()
    downloader.run()