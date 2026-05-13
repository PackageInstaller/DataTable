import os
import re
import io
import time
import json
import msgpack
import requests
import base64
import threading
import shutil
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from google_play_scraper import app
from typing import Dict, Union, Any
from rich.progress import (
    Progress,
    TaskID,
    BarColumn,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
    DownloadColumn,
)
from rich.console import Console
from rich.live import Live
from rich.table import Table


class MementoMoriUpdater:
    def __init__(
        self,
        download_path: str = "./MementoMori",
        update_path: str = "./MementoMori_Update",
        master_path: str = "./MasterData",
    ):
        self.download_path = Path(download_path)
        self.update_path = Path(update_path)
        self.master_path = Path(master_path)

        # 首次下载判断：目标目录不存在或为空时视为首次
        self.is_first_download = (
            not self.download_path.exists()
            or not any(self.download_path.iterdir())
        )

        self.download_path.mkdir(parents=True, exist_ok=True)
        self.master_path.mkdir(parents=True, exist_ok=True)
        
        # 仅在非首次下载时才需要 update_path
        if not self.is_first_download:
            self.update_path.mkdir(parents=True, exist_ok=True)

        self.session = requests.Session()
        self.app_id = "jp.boi.mementomori.android"
        self.auth_url = "https://prd1-auth.mememori-boi.com/api/auth/getDataUri"
        self.cdn_base = "https://cdn-mememori.akamaized.net"
        self.console = Console()
        self.download_lock = threading.Lock()
        self.total_downloaded = 0
        self.start_time = 0
        self.current_downloads = set()
        self.completed_files = 0
        self.total_files = 0
        self.files_to_copy = []

    def needs_update(self, file_info: dict) -> bool:
        """检查文件是否需要更新"""
        if file_info.get("is_master"):
            original_path = self.master_path / file_info["name"]
        else:
            original_path = self.download_path / file_info["name"]

        # 如果是数据表，使用 hash 校验
        if file_info.get("is_master"):
            hash_path = original_path.with_suffix(".hash")
            if not original_path.exists() or not hash_path.exists():
                return True
            try:
                with open(hash_path, "r") as f:
                    content = f.read().strip()
                    return content != file_info["hash"]
            except:
                return True

        # 如果原文件不存在，需要更新
        if not original_path.exists():
            return True

        # 如果文件大小不同，需要更新
        if original_path.stat().st_size != file_info["size"]:
            return True

        # 文件存在且大小正确，不需要更新
        return False

    def get_app_version(self) -> str:
        try:
            self.console.print("[cyan]正在从Google Play Store获取版本信息...[/cyan]")
            app_info = app(app_id=self.app_id, lang="en", country="jp")
            version = app_info["version"]
            self.console.print(f"[green]获取到版本号: {version}[/green]")
            return version
        except Exception as e:
            self.console.print(f"[red]获取版本号失败: {e}[/red]")
            raise

    def get_game_versions(self) -> tuple[str, str, str]:

        try:
            headers = {
                "OrtegaDeviceType": "4",
                "ortegaappversion": self.get_app_version(),
            }
            # 根据 masterbook 项目，需要发送请求体
            payload = {"CountryCode": "JP", "UserId": 0}
            body = msgpack.packb(payload)

            response = self.session.post(self.auth_url, headers=headers, data=body)
            response.raise_for_status()

            version_headers = response.headers
            cver = version_headers["ortegaassetversion"]
            mver = version_headers["ortegamasterversion"]
            master_uri_format = f"{self.cdn_base}/master/prd1/version/{{0}}/{{1}}"

            self.console.print(
                f"[green]资源版本: {cver}, Master版本: {mver}[/green]"
            )
            return cver, mver, master_uri_format
        except Exception as e:
            self.console.print(f"[red]获取游戏版本失败: {e}[/red]")
            raise

    def read_catalog_object(self, reader, pos: int) -> Union[str, int, Dict[str, Any]]:
        """读取U3D目录对象"""
        reader.seek(pos)
        obj_type = int.from_bytes(reader.read(1), "little")

        if obj_type == 0:  # ascii string
            length = int.from_bytes(reader.read(4), "little")
            return reader.read(length).decode("ascii")
        elif obj_type == 1:  # unicode string
            length = int.from_bytes(reader.read(4), "little")
            return reader.read(length).decode("utf-16le")
        elif obj_type == 2:  # u16
            return int.from_bytes(reader.read(2), "little")
        elif obj_type == 3:  # u32
            return int.from_bytes(reader.read(4), "little")
        elif obj_type == 4:  # i32
            return int.from_bytes(reader.read(4), "little", signed=True)
        elif obj_type == 7:  # json object
            an_length = int.from_bytes(reader.read(1), "little")
            an = reader.read(an_length).decode("ascii")
            cn_length = int.from_bytes(reader.read(1), "little")
            cn = reader.read(cn_length).decode("ascii")
            js_length = int.from_bytes(reader.read(4), "little", signed=True)
            js_data = reader.read(js_length).decode("utf-16le")
            return {"an": an, "cn": cn, "js": json.loads(js_data)}
        elif obj_type == 8:
            reader.read(1)  # skip
            return int.from_bytes(reader.read(4), "little")
        else:
            raise RuntimeError(f"不支持的对象类型: {obj_type}")

    def process_assets(self, cver: str) -> Dict[str, dict]:
        catalog_url = f"{self.cdn_base}/asset/MementoMori/Win64/{cver}.json"
        response = self.session.get(catalog_url)
        response.raise_for_status()
        catalog = response.json()

        file_list = {}

        url = f"{self.cdn_base}/asset/MementoMori/Win64/"  # durl
        sign = "\\"  # split
        name = True  # name
        start, end = "", ".bundle"
        deln = True

        key_data = base64.b64decode(catalog["m_KeyDataString"])
        entry_data = base64.b64decode(catalog["m_EntryDataString"])
        extra_data = base64.b64decode(catalog["m_ExtraDataString"])

        key_reader = io.BytesIO(key_data)
        entry_reader = io.BytesIO(entry_data)
        extra_reader = io.BytesIO(extra_data)

        key_count = int.from_bytes(key_reader.read(4), "little")
        skds = []
        for _ in range(key_count):
            pos = key_reader.tell()
            key_obj = self.read_catalog_object(key_reader, pos)
            skds.append(key_obj)

        mii = catalog["m_InternalIds"]  # m_InternalIds
        md = catalog.get("m_InternalIdPrefixes", [])  # m_InternalIdPrefixes

        # 构建seds和temp
        seds, temp = {}, {}
        entry_count = int.from_bytes(entry_reader.read(4), "little")

        for _ in range(entry_count):
            ii = int.from_bytes(
                entry_reader.read(4), "little", signed=True
            )  # internal_id_index
            pi = int.from_bytes(
                entry_reader.read(4), "little", signed=True
            )  # provider_index
            dki = int.from_bytes(
                entry_reader.read(4), "little", signed=True
            )  # dependency_key_index
            dh = int.from_bytes(
                entry_reader.read(4), "little", signed=True
            )  # dependency_hash
            di = int.from_bytes(
                entry_reader.read(4), "little", signed=True
            )  # data_index
            pk = int.from_bytes(
                entry_reader.read(4), "little", signed=True
            )  # primary_key_index
            rt = int.from_bytes(
                entry_reader.read(4), "little", signed=True
            )  # resource_type

            obj = 0
            if di >= 0:
                try:
                    extra_obj = self.read_catalog_object(extra_reader, di)
                    if isinstance(extra_obj, dict) and "js" in extra_obj:
                        js_data = extra_obj["js"]
                        if "m_BundleSize" in js_data:
                            obj = js_data["m_BundleSize"]
                        elif "m_FileSize" in js_data:
                            obj = js_data["m_FileSize"]
                except:
                    obj = 0

            on = mii[ii]
            nn = skds[pk] if pk >= 0 else on
            d = skds[dki] if dki >= 0 else None

            checkname = on.endswith(end) if end else True
            if checkname:
                seds[on] = {"n": on, "nn": nn, "s": obj}

            if name and isinstance(nn, str) and isinstance(d, str):
                temp[d] = nn

        if name:
            for i, j in seds.items():
                key = j["nn"]
                if key in temp:
                    j["nn"] = temp[key]

        for i, j in seds.items():
            n, nn, s = j["n"], j["nn"], j["s"]

            if sign and sign in n:
                n = n.rsplit(sign, 1)[1]
            if "=" in n:
                n = n[:-7].replace("=", "%3D")

            if name:
                nnn = n
                if isinstance(nn, str):
                    if (".acb" in nn or ".awb" in nn) and nn.endswith(".asset"):
                        if ".acb" in nn:
                            nn = nn.rsplit(".acb", 1)[0] + ".acb"
                        else:
                            nn = nn.rsplit(".awb", 1)[0] + ".awb"
                    elif not nn.endswith(".bundle") and not nn.endswith(".asset"):
                        nn += ".asset"
            else:
                nn, nnn = n, n

            if deln:
                nn = self.delstr(nn)
                nnn = self.delstr(nnn)

            if "{" in n or "}" in n:
                continue

            file_list[nnn] = {"name": nn, "url": f"{url}{n}", "size": s}

        return file_list

    def process_master_data(self, mver: str, master_uri_format: str) -> Dict[str, dict]:
        if not master_uri_format:
            return {}

        catalog_url = master_uri_format.format(mver, "master-catalog")
        response = self.session.get(catalog_url)
        response.raise_for_status()
        catalog = msgpack.unpackb(response.content, raw=False)

        file_list = {}
        info_map = catalog.get("MasterBookInfoMap", {})
        self.console.print(f"[cyan]从 Master Catalog 发现 {len(info_map)} 个数据表[/cyan]")
        
        for name, info in info_map.items():
            file_name = f"{name}.json"
            file_list[file_name] = {
                "name": file_name,
                "url": master_uri_format.format(mver, name),
                "size": info["Size"],
                "hash": info["Hash"],
                "is_master": True,
            }
        return file_list

    def delstr(self, name: str) -> str:
        if "%3D" in name:
            return name.split("%3D")[0]

        if name.endswith(".bundle"):
            n, e = name[:-7], ".bundle"
        else:
            n, e = name, ""

        c = re.search(r"_([a-f0-9]{32})$", n)
        if c:
            n = n[:-33]

        if n.endswith("_all"):
            n = n[:-4]
        if n.endswith("_assets"):
            n = n[:-7]

        return f"{n}{e}"

    def process_raw_data(self, mver: str) -> Dict[str, dict]:
        raw_data_url = f"{self.cdn_base}/master/prd1/version/{mver}/DownloadRawDataMB"
        response = self.session.get(raw_data_url)
        response.raise_for_status()
        raw_data = response.content

        raw_list = msgpack.unpackb(raw_data, raw=False)

        file_list = {}
        raw_url_template = f"{self.cdn_base}/asset/MementoMori/Raw/{{}}"

        for item in raw_list:
            file_path = item["FilePath"]
            file_size = item["FileSize"]

            file_list[file_path] = {
                "name": file_path,
                "url": raw_url_template.format(file_path),
                "size": file_size,
            }

        return file_list

    def download_file(self, file_info: dict, progress: Progress, task: TaskID) -> bool:
        # 首次下载直接写入目标目录，更新模式写入 update_path（中转）
        if self.is_first_download:
            if file_info.get("is_master"):
                file_path = self.master_path / file_info["name"]
            else:
                file_path = self.download_path / file_info["name"]
        else:
            file_path = self.update_path / file_info["name"]
        file_name = file_info["name"]

        with self.download_lock:
            self.current_downloads.add(file_name)

        try:
            # 如果是数据表，跳过简单的 size 校验，由 needs_update 处理
            if not file_info.get("is_master"):
                if file_path.exists() and file_path.stat().st_size == file_info["size"]:
                    progress.advance(task, file_info["size"])
                    with self.download_lock:
                        self.completed_files += 1
                        # 更新模式才需要后续复制
                        if not self.is_first_download:
                            self.files_to_copy.append(file_info)
                    return True

            file_path.parent.mkdir(parents=True, exist_ok=True)

            if file_info.get("is_master"):
                # 数据表特殊处理：全量下载并转换为 JSON
                response = self.session.get(file_info["url"])
                response.raise_for_status()
                content = response.content

                if len(content) != file_info["size"]:
                    return False

                # 反序列化并保存为 JSON
                data = msgpack.unpackb(content, raw=False)
                with open(file_path, "w", encoding="utf-8") as f:
                    json.dump(data, f, indent=4, ensure_ascii=False)

                # 保存 Hash 供以后校验
                with open(file_path.with_suffix(".hash"), "w") as f:
                    f.write(file_info["hash"])

                with self.download_lock:
                    self.total_downloaded += len(content)
                    self.completed_files += 1
                    if not self.is_first_download:
                        self.files_to_copy.append(file_info)
                progress.advance(task, len(content))
                return True
            else:
                response = self.session.get(file_info["url"], stream=True)
                response.raise_for_status()

                downloaded_size = 0
                with open(file_path, "wb") as f:
                    for chunk in response.iter_content(chunk_size=8192):
                        if chunk:
                            f.write(chunk)
                            chunk_size = len(chunk)
                            downloaded_size += chunk_size

                            with self.download_lock:
                                self.total_downloaded += chunk_size
                            progress.advance(task, chunk_size)

                if file_path.stat().st_size == file_info["size"]:
                    with self.download_lock:
                        self.completed_files += 1
                        # 更新模式才需要后续复制
                        if not self.is_first_download:
                            self.files_to_copy.append(file_info)
                    return True
                else:
                    file_path.unlink(missing_ok=True)
                    return False

        except Exception as e:
            self.console.print(f"[red]下载失败: {file_name}[/red]")
            file_path.unlink(missing_ok=True)
            return False
        finally:
            with self.download_lock:
                self.current_downloads.discard(file_name)

    def format_size(self, size_bytes: int) -> str:
        if size_bytes < 1024:
            return f"{size_bytes} B"
        elif size_bytes < 1024**2:
            return f"{size_bytes/1024:.1f} KB"
        elif size_bytes < 1024**3:
            return f"{size_bytes/1024**2:.1f} MB"
        else:
            return f"{size_bytes/1024**3:.1f} GB"

    def format_speed(self, bytes_per_second: float) -> str:
        if bytes_per_second < 1024:
            return f"{bytes_per_second:.1f} B/s"
        elif bytes_per_second < 1024**2:
            return f"{bytes_per_second/1024:.1f} KB/s"
        elif bytes_per_second < 1024**3:
            return f"{bytes_per_second/1024**2:.1f} MB/s"
        else:
            return f"{bytes_per_second/1024**3:.1f} GB/s"

    def create_download_display(self, progress: Progress, task: TaskID) -> Table:
        table = Table(show_header=True, header_style="bold magenta")
        table.add_column("状态", style="cyan", width=20)
        table.add_column("信息", style="white")

        with self.download_lock:
            elapsed_time = time.time() - self.start_time
            if elapsed_time > 0 and self.total_downloaded > 0:
                speed = self.total_downloaded / elapsed_time
                speed_str = self.format_speed(speed)
            else:
                speed_str = "计算中..."

        task_info = progress.tasks[task]
        if task_info.total and task_info.total > 0:
            completed_pct = task_info.completed / task_info.total * 100
        else:
            completed_pct = 0

        table.add_row(
            "下载进度",
            f"{self.completed_files}/{self.total_files} 文件 ({self.completed_files/self.total_files*100 if self.total_files > 0 else 0:.1f}%)",
        )
        table.add_row(
            "数据进度",
            f"{self.format_size(int(task_info.completed))}/{self.format_size(int(task_info.total or 0))} ({completed_pct:.1f}%)",
        )
        table.add_row("下载速度", speed_str)

        return table

    def copy_updated_files(self) -> tuple[int, int]:
        """将更新的文件从update目录复制到原目录"""
        if not self.files_to_copy:
            self.console.print("[yellow]没有文件需要复制[/yellow]")
            return 0, 0

        self.console.print(
            f"[cyan]开始复制 {len(self.files_to_copy)} 个更新文件到原目录...[/cyan]"
        )

        copied_count = 0
        failed_count = 0

        progress = Progress(
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.0f}%",
            console=self.console,
        )

        with progress:
            task = progress.add_task(
                "[green]复制文件...", total=len(self.files_to_copy)
            )

            for file_info in self.files_to_copy:
                try:
                    source_path = self.update_path / file_info["name"]
                    if file_info.get("is_master"):
                        dest_path = self.master_path / file_info["name"]
                    else:
                        dest_path = self.download_path / file_info["name"]
                        
                    dest_path.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(source_path, dest_path)

                    # 如果有 Hash 文件也一并复制
                    source_hash = source_path.with_suffix(".hash")
                    if source_hash.exists():
                        shutil.copy2(source_hash, dest_path.with_suffix(".hash"))

                    # 验证
                    if file_info.get("is_master"):
                        # 数据表校验 dest 是否存在即可（因为转换过 size 不对等）
                        if dest_path.exists():
                            copied_count += 1
                        else:
                            failed_count += 1
                    else:
                        if (
                            dest_path.exists()
                            and dest_path.stat().st_size == file_info["size"]
                        ):
                            copied_count += 1
                        else:
                            failed_count += 1
                            self.console.print(
                                f"[red]复制验证失败: {file_info['name']}[/red]"
                            )

                except Exception as e:
                    failed_count += 1
                    self.console.print(f"[red]复制失败 {file_info['name']}: {e}[/red]")

                progress.advance(task)

        self.console.print(
            f"[green]复制完成: 成功 {copied_count} 个, 失败 {failed_count} 个[/green]"
        )
        return copied_count, failed_count

    def download_files(
        self, file_list: Dict[str, dict], max_workers: int
    ) -> tuple[int, int]:
        if not file_list:
            return 0, 0

        success_count = 0
        failed_count = 0
        total_size = sum(file_info["size"] for file_info in file_list.values())

        with self.download_lock:
            self.total_downloaded = 0
            self.start_time = time.time()
            self.current_downloads.clear()
            self.completed_files = 0
            self.total_files = len(file_list)

        progress = Progress(
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.0f}%",
            "•",
            DownloadColumn(),
            "•",
            TransferSpeedColumn(),
            "•",
            TimeRemainingColumn(),
            console=self.console,
            disable=True,
        )

        task = progress.add_task(
            f"[cyan]下载文件 (并发数: {max_workers})[/cyan]", total=total_size
        )

        def update_display():
            display_table = Table(show_header=False)
            display_table.add_column()
            display_table.add_row(progress)
            display_table.add_row("")
            info_table = self.create_download_display(progress, task)
            display_table.add_row(info_table)

            return display_table

        with Live(update_display(), refresh_per_second=4, console=self.console) as live:

            def periodic_update():
                while not progress.tasks[task].finished:
                    live.update(update_display())
                    time.sleep(0.25)
                live.update(update_display())

            update_thread = threading.Thread(target=periodic_update, daemon=True)
            update_thread.start()

            with ThreadPoolExecutor(max_workers=max_workers) as executor:
                future_to_file = {
                    executor.submit(
                        self.download_file, file_info, progress, task
                    ): file_name
                    for file_name, file_info in file_list.items()
                }

                for future in as_completed(future_to_file):
                    file_name = future_to_file[future]
                    try:
                        success = future.result()
                        if success:
                            success_count += 1
                        else:
                            failed_count += 1
                    except Exception:
                        failed_count += 1
                        pass

            update_thread.join(timeout=1.0)

        return success_count, failed_count

    def update(self, max_workers: int):
        try:
            cver, mver, master_uri_format = self.get_game_versions()

            # 按优先级定义的任务列表
            categories = [
                ("数据表 (Master Data)", lambda: self.process_master_data(mver, master_uri_format)),
                ("原始资产 (Raw Data)", lambda: self.process_raw_data(mver)),
                ("普通资产 (Assets)", lambda: self.process_assets(cver)),
            ]

            total_success = 0
            total_failed = 0
            any_update_performed = False

            for cat_name, process_func in categories:
                self.console.print(f"\n[bold blue]正在处理 {cat_name}...[/bold blue]")
                all_cat_files = process_func()

                if cat_name == "普通资产 (Assets)":
                    # 特殊处理 Assets 的前缀
                    catalog_url = f"{self.cdn_base}/asset/MementoMori/Win64/{cver}.json"
                    response = self.session.get(catalog_url)
                    response.raise_for_status()
                    catalog = response.json()
                    prefixes = catalog.get("m_InternalIdPrefixes", [])

                    for k, v in all_cat_files.items():
                        if "#/" not in v["name"]:
                            continue
                        i, n = v["name"].split("#", 1)
                        if i.isdigit() and int(i) < len(prefixes):
                            v["name"] = "".join((prefixes[int(i)], n))

                files_to_download = {}
                skipped_count = 0

                for file_name, file_info in all_cat_files.items():
                    if self.needs_update(file_info):
                        files_to_download[file_name] = file_info
                    else:
                        skipped_count += 1

                if files_to_download:
                    any_update_performed = True
                    if self.is_first_download:
                        self.console.print(
                            f"[yellow]首次下载 {cat_name}, 共 {len(files_to_download)} 个文件[/yellow]"
                        )
                    else:
                        self.console.print(
                            f"[yellow]更新 {cat_name}: 需要下载 {len(files_to_download)} 个文件, 跳过 {skipped_count} 个[/yellow]"
                        )

                    self.files_to_copy = []
                    success, failed = self.download_files(files_to_download, max_workers)
                    total_success += success
                    total_failed += failed

                    if success > 0 and not self.is_first_download:
                        self.copy_updated_files()
                else:
                    self.console.print(f"[green]{cat_name} 已经是最新的[/green]")

            if any_update_performed:
                self.console.print(f"\n[bold green]全部更新流程结束![/bold green]")
                if self.is_first_download:
                    self.console.print(f"数据已下载至: [cyan]{self.download_path}[/cyan] 和 [cyan]{self.master_path}[/cyan]")
                self.console.print(f"总计成功: [green]{total_success}[/green], 总计失败: [red]{total_failed}[/red]")
            else:
                self.console.print(f"\n[bold green]所有内容都已经是最新，无需操作。[/bold green]")

        except Exception as e:
            self.console.print(f"[bold red]更新失败: {e}[/bold red]")
            import traceback
            traceback.print_exc()


def main():
    workers = (os.cpu_count() or 4) * 2
    download_path = "./MementoMori"
    update_path = "./MementoMori_Update"
    master_path = "./MasterData"
    updater = MementoMoriUpdater(
        download_path=download_path, 
        update_path=update_path,
        master_path=master_path
    )
    updater.update(max_workers=workers)


if __name__ == "__main__":
    main()
