import io
import os
import sys
import json
import struct
import threading
from enum import IntEnum
from pathlib import Path
from typing import Dict, List, Literal
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
import time
from MasterMap import TABLE_FIELD_MAPS
try:
    import requests
    import lz4.block
    import msgpack
    import UnityPy
    from google_play_scraper import app as playstore_app
    from Crypto.Cipher import AES
    from Crypto.Util.Padding import unpad
    from rich.console import Console
    from rich.progress import (
        Progress, SpinnerColumn, TextColumn, BarColumn, 
        TaskProgressColumn, TimeElapsedColumn, TimeRemainingColumn
    )
    from rich.table import Table
    from rich.panel import Panel
except ImportError as e:
    print(f"缺少必要的依赖库: {e}")
    print("请运行: pip install requests lz4 msgpack UnityPy google-play-scraper pycryptodome rich")
    sys.exit(1)

MAX_RETRIES = 5
RETRY_DELAY = 1.0
TIMEOUT = 10

# AES 解密密钥和初始向量
KEY_BYTES = bytes.fromhex(
    "16 96 22 b3 73 3c bc a9 40 bb 32 99 d2 87 6a 12"
    "4a aa e3 21 e8 cf d6 f5 a4 54 d0 b4 2a 06 47 e3"
)
IV_BYTES = bytes.fromhex("5c 36 6b f1 d1 54 e4 f0 ab ec 73 7f 2b 4c 2e 14")
# 需要自己抓包获取最新版本号并替换下面的 version 变量
version = "1053901-f5e816d8"
version_suffix = "01"  # 版本后缀，通常是 "01"，如果更新后无法下载表格，可以尝试改成 "02"
console = Console()

class TableFileType(IntEnum):
    """数据表类型"""
    TrickcalTables = 1
    Kr = 2
    En = 3
    Jp = 4
    Zh_chs = 5
    Zh_cht = 6
    TrickcalDialogueTable = 1001
    TrickcalDialogueCharacterStoryTable = 1002
    TrickcalDialogueMainStoryTable = 1003
    TrickcalDialogueRestaurantTable = 1004
    TrickcalDialogueThemeEventTable = 1005
    TrickcalDialogueReplayTable = 1006
    TrickcalDialogueScheduleTable = 1007
    ScenarioTextKr = 2002
    ScenarioTextEn = 2003
    ScenarioTextJp = 2004
    ScenarioTextZh_chs = 2005
    ScenarioTextZh_cht = 2006


@dataclass
class FileInfo:
    """文件信息数据类"""
    filename: str
    hash_value: str
    size: int
    offset: int
    pak_idx: int
    selective_pak_info: str


class TrickcalUpdater:
    """Trickcal数据表更新器"""
    
    def __init__(self, base_dir: Path):
        self.base_dir = base_dir or Path.cwd()
        self.table_dir = self.base_dir / "MasterData"
        self.cache_file = self.table_dir / "PatchList.txt"
        self.table_dir.mkdir(exist_ok=True)
        self.max_workers = min(32, os.cpu_count())
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'TrickcalUpdater/2.0'
        })
        self._pak_cache: Dict[int, bytes] = {}
        self._cache_lock = threading.Lock()
        self._progress_lock = threading.Lock()

    def get_latest_version(self) -> str:
        """获取最新版本号"""
        console.print("[bold blue]正在获取最新版本信息...[/bold blue]")
        try:
            result = playstore_app(app_id="com.epidgames.trickcalrevive", lang="en", country="kr")
            version = result["version"] + version_suffix
            console.print(f"[green]当前最新版本: {version}[/green]")
            return version
        except Exception as e:
            console.print(f"[red]获取版本信息失败: {e}[/red]")
            raise

    def get_patch_list(self, version: str) -> List[str]:
        """获取补丁列表"""
        addr = f"https://cdn.aws.trickcal.io/production/Android/{version}/PatchInfo/PatchList.txt"
        
        for attempt in range(MAX_RETRIES):
            try:
                r = self.session.get(addr, timeout=TIMEOUT)
                r.raise_for_status()
                return list(filter(None, r.text.split("\n")))
            except Exception as e:
                if attempt < MAX_RETRIES - 1:
                    console.print(f"[yellow]获取补丁列表失败，正在重试... ({attempt + 1}/{MAX_RETRIES})[/yellow]")
                    time.sleep(RETRY_DELAY)
                else:
                    console.print(f"[red]获取补丁列表失败: {e}[/red]")
                    raise

    def parse_patch_list(self, patch_list: List[str]) -> Dict[int, List[FileInfo]]:
        """解析补丁列表，返回按PAK索引分组的文件信息"""
        table_files: Dict[int, List[FileInfo]] = {}
        
        for line in patch_list:
            parts = line.split("#")
            if len(parts) < 8:
                continue
                
            filename = parts[0]
            hash_value = parts[4]
            size = int(parts[2])
            offset = int(parts[3])
            pak_idx = int(parts[5])
            selective_pak_info = parts[6]
            
            if filename.startswith("table/"):
                file_info = FileInfo(
                    filename=filename,
                    hash_value=hash_value,
                    size=size,
                    offset=offset,
                    pak_idx=pak_idx,
                    selective_pak_info=selective_pak_info
                )
                
                if pak_idx not in table_files:
                    table_files[pak_idx] = []
                table_files[pak_idx].append(file_info)
        
        return table_files

    def load_local_cache(self) -> Dict[str, FileInfo]:
        """加载本地缓存的文件信息"""
        if not self.cache_file.exists():
            return {}
        
        local_files = {}
        try:
            with open(self.cache_file, 'r', encoding='utf-8') as f:
                for line in f:
                    line = line.strip()
                    if not line:
                        continue
                    
                    parts = line.split("#")
                    if len(parts) >= 8:
                        filename = parts[0]
                        if filename.startswith("table/"):
                            file_info = FileInfo(
                                filename=filename,
                                hash_value=parts[4],
                                size=int(parts[2]),
                                offset=int(parts[3]),
                                pak_idx=int(parts[5]),
                                selective_pak_info=parts[6]
                            )
                            local_files[filename] = file_info
        except Exception as e:
            console.print(f"[yellow]读取本地缓存失败: {e}[/yellow]")
            
        return local_files

    def save_local_cache(self, patch_list: List[str]) -> None:
        """保存补丁列表到本地缓存"""
        try:
            with open(self.cache_file, 'w', encoding='utf-8') as f:
                f.write('\n'.join(patch_list))
        except Exception as e:
            console.print(f"[yellow]保存本地缓存失败: {e}[/yellow]")

    def download_pak(self, version: str, pak_idx: int) -> bytes:
        """下载PAK文件，带缓存和重试机制"""
        with self._cache_lock:
            if pak_idx in self._pak_cache:
                return self._pak_cache[pak_idx]
        
        addr = f"https://cdn.aws.trickcal.io/production/Android/{version}/Packages_Install/InstallPackage{pak_idx:04}.pak"
        for attempt in range(MAX_RETRIES):
            try:
                r = self.session.get(addr, timeout=TIMEOUT)
                r.raise_for_status()
                data = r.content
                
                with self._cache_lock:
                    self._pak_cache[pak_idx] = data
                
                return data
            except Exception as e:
                if attempt < MAX_RETRIES - 1:
                    console.print(f"[yellow]下载PAK {pak_idx:04} 失败，正在重试... ({attempt + 1}/{MAX_RETRIES})[/yellow]")
                    time.sleep(RETRY_DELAY)
                else:
                    console.print(f"[red]下载PAK {pak_idx:04} 失败: {e}[/red]")
                    raise

    def extract_from_pak(self, pak_data: bytes, file_info: FileInfo) -> bytes:
        """从PAK数据中提取指定文件"""
        pak = Pak(pak_data)
        return pak.get_file_data(file_info.filename)

    def decrypt_data(self, data: bytes) -> bytes:
        """解密数据"""
        try:
            cipher = AES.new(KEY_BYTES, AES.MODE_CBC, IV_BYTES)
            return unpad(cipher.decrypt(data), 16)
        except ValueError:
            return data

    def export_textassets(self, data: bytes) -> tuple[bytes, str]:
        """从AssetBundle数据中提取TextAsset，返回数据和正确的名称"""
        try:
            env = UnityPy.load(data)
            for obj in env.objects:
                if obj.type.name == "TextAsset":
                    ta = obj.read()
                    script_data = getattr(ta, "m_Script", None)
                    if script_data is not None:
                        asset_name = getattr(ta, "m_Name", "")
                        
                        if isinstance(script_data, str):
                            return script_data.encode("utf-8", "surrogateescape"), asset_name
                        return script_data, asset_name
        except Exception:
            pass
        return data, ""

    def decode_table_data(self, data: bytes) -> dict:
        """解码表格数据"""
        decoder = Decoder(data)
        return decoder.decode()

    def cleanse_data(self, obj):
        """清理数据以便JSON序列化"""
        if isinstance(obj, (bytes, bytearray)):
            try:
                return obj.decode("utf-8")
            except UnicodeDecodeError:
                return obj.hex()
        
        if hasattr(msgpack, "Timestamp") and isinstance(obj, msgpack.Timestamp):
            return obj.to_unix()
        
        if isinstance(obj, msgpack.ExtType):
            if obj.code == -1:
                ts = msgpack.unpackb(obj.data, raw=False, strict_map_key=False)
                return f"Timestamp({ts})"
            else:
                return {"ExtType_code": obj.code, "ExtType_data": obj.data.hex()}
        
        if isinstance(obj, dict):
            return {self.cleanse_key(k): self.cleanse_data(v) for k, v in obj.items()}
        
        if isinstance(obj, (list, tuple)):
            return [self.cleanse_data(x) for x in obj]
        
        return obj

    def cleanse_key(self, k):
        """清理字典键"""
        if isinstance(k, (bytes, bytearray)):
            try:
                return k.decode("utf-8")
            except UnicodeDecodeError:
                return k.hex()
        if isinstance(k, tuple):
            return str([self.cleanse_key(x) for x in k])
        return k

    def process_file(self, version: str, file_info: FileInfo, progress, task_id, counters: dict) -> bool:
        """处理单个文件：下载、解密、转换（完全在内存中处理）"""
        try:
            pak_data = self.download_pak(version, file_info.pak_idx)
            file_data = self.extract_from_pak(pak_data, file_info)
            decrypted_data = self.decrypt_data(file_data)
            extracted_data, asset_name = self.export_textassets(decrypted_data)
            final_data = self.decrypt_data(extracted_data)
            decoded_data = self.decode_table_data(final_data)
            cleaned_data = self.cleanse_data(decoded_data)
            if asset_name:
                clean_name = asset_name.replace(".client", "")
                json_filename = f"{clean_name}.json"
            else:
                json_filename = f"{Path(file_info.filename).stem}.json"
            
            json_path = self.table_dir / json_filename
            json_path.write_text(
                json.dumps(cleaned_data, ensure_ascii=False, indent=2),
                encoding="utf-8"
            )
            
            with self._progress_lock:
                counters['processed'] += 1
                current_count = counters['processed']
                total_count = counters['total']
            
            progress.update(task_id, advance=1, 
                            description=f"处理文件中... ({current_count}/{total_count})")
            return True
            
        except Exception as e:
            console.print(f"[red]处理文件 {file_info.filename} 失败: {e}[/red]")
            return False

    def compare_files(self, remote_files: Dict[int, List[FileInfo]], local_files: Dict[str, FileInfo]) -> List[FileInfo]:
        """比较远程和本地文件，返回需要更新的文件列表"""
        files_to_update = []
        
        for pak_files in remote_files.values():
            for file_info in pak_files:
                filename = file_info.filename
                
                local_info = local_files.get(filename)
                
                if (local_info is None or 
                    local_info.hash_value != file_info.hash_value or 
                    local_info.size != file_info.size):
                    files_to_update.append(file_info)
        
        return files_to_update

    def run(self) -> None:
        """主运行方法"""
        console.print(Panel.fit(
            "[bold cyan]Trickcal 数据表更新器 v2[/bold cyan]\n"
            f"工作目录: {self.base_dir}\n"
            f"最大并发: {self.max_workers} 线程",
            title="欢迎使用"
        ))
        
        try:
            # version = self.get_latest_version()
            
            console.print("[bold blue]正在获取补丁列表...[/bold blue]")
            patch_list = self.get_patch_list(version)
            remote_files = self.parse_patch_list(patch_list)
            local_files = self.load_local_cache()
            files_to_update = self.compare_files(remote_files, local_files)
            
            if not files_to_update:
                console.print("[green]所有文件都是最新的，无需更新！[/green]")
                return
            
            table = Table(title=f"需要更新的文件 ({len(files_to_update)} 个)")
            table.add_column("文件名", style="cyan")
            table.add_column("大小", justify="right", style="magenta")
            table.add_column("PAK索引", justify="center", style="green")
            
            for file_info in files_to_update[:20]:
                table.add_row(
                    file_info.filename,
                    f"{file_info.size:,} bytes",
                    str(file_info.pak_idx)
                )

            console.print(table)
            
            console.print(f"[bold blue]开始更新 {len(files_to_update)} 个文件...[/bold blue]")
            
            with Progress(
                SpinnerColumn(),
                TextColumn("[progress.description]{task.description}"),
                BarColumn(),
                TaskProgressColumn(),
                TimeElapsedColumn(),
                TimeRemainingColumn(),
                console=console
            ) as progress:
                
                task_id = progress.add_task(
                    f"处理文件中... (0/{len(files_to_update)})",
                    total=len(files_to_update)
                )
                
                counters = {'processed': 0, 'total': len(files_to_update)}
                
                success_count = 0
                with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
                    future_to_file = {
                        executor.submit(self.process_file, version, file_info, progress, task_id, counters): file_info
                        for file_info in files_to_update
                    }
                    
                    for future in as_completed(future_to_file):
                        try:
                            if future.result():
                                success_count += 1
                        except Exception as e:
                            console.print(f"[red]任务执行失败: {e}[/red]")
            
            self.save_local_cache(patch_list)
            
            if success_count == len(files_to_update):
                console.print(f"[green]成功更新了所有 {success_count} 个文件！[/green]")
            else:
                failed_count = len(files_to_update) - success_count
                console.print(f"[yellow]成功: {success_count}, 失败: {failed_count}[/yellow]")
            
            console.print(f"[blue]所有文件保存在: {self.table_dir}[/blue]")
            
        except KeyboardInterrupt:
            console.print("\n[yellow]用户中断了操作[/yellow]")
        except Exception as e:
            console.print(f"[red]发生未预期的错误: {e}[/red]")
            raise


class Pak:
    """PAK文件解析器"""
    
    def __init__(self, data: bytes):
        self.reader = io.BytesIO(data)
        self.footer_offset = int.from_bytes(self.reader.read(8), "little")
        self.files = {}

        self.reader.seek(self.footer_offset)
        count = int.from_bytes(self.reader.read(4), "little")
        for _ in range(count):
            name_size = int.from_bytes(self.reader.read(1), "little")
            name = self.reader.read(name_size).decode("utf-8")
            offset = int.from_bytes(self.reader.read(8), "little")
            size = int.from_bytes(self.reader.read(8), "little")
            self.files[name] = (offset, size)

    def get_file_data(self, filename: str) -> bytes:
        """获取文件数据"""
        if filename not in self.files:
            raise KeyError(f"文件 {filename} 不存在于PAK中")
        
        offset, size = self.files[filename]
        self.reader.seek(offset)
        return self.reader.read(size)


class Decoder:
    """表格数据解码器"""
    
    def __init__(self, raw: bytes):
        self.stream = io.BytesIO(raw)

    def _read_byte(self) -> int:
        return self.stream.read(1)[0]

    def _read_int(self, n: int, endian: Literal["little", "big"] = "little") -> int:
        return int.from_bytes(self.stream.read(n), endian)

    def _read_str(self) -> str:
        ln = self._read_int(4)
        return self.stream.read(ln - 1).decode("utf-8")

    def _read_7bit_encoded_int32(self):
        result = 0
        shift = 0
        for _ in range(5):
            x = self._read_byte()
            result |= (x & 0x7F) << shift
            if result > 0xFFFFFFFF:
                raise RuntimeError("Too many bits for an int32!")
            if x >> 7 == 0:
                return result
            shift += 7
        raise RuntimeError("Too many bits for an int32!")
    
    def _apply_field_map(self, table_name: str, data: dict) -> dict:
        """
        如果存在字段映射，则将数组递归地转换为带键的字典。
        """
        field_map = TABLE_FIELD_MAPS.get(table_name)
        
        if not field_map:
            return data

        console.print(f"[green]✓[/green] 发现 '{table_name}' 的字段映射，正在应用...")
        
        def recursive_apply(current_data):
            if isinstance(current_data, list):
                row_dict = {}
                for index, field_name in field_map.items():
                    if index < len(current_data):
                        row_dict[field_name] = recursive_apply(current_data[index])
                    else:
                        row_dict[field_name] = None
                return row_dict

            elif isinstance(current_data, dict):
                return {key: recursive_apply(value) for key, value in current_data.items()}
            else:
                return current_data

        return recursive_apply(data)

    def decode(self) -> dict:
        """
        解码表格数据
        
        文件结构:
        - 对话表类型 (1001-1007): [TableFileType] [MessagePack Data]
        - 其他类型: [TableFileType] [Header Count] [Headers...] [MessagePack Data]
        """
        try:
            # 读取 TableFileType
            table_type_value = self._read_7bit_encoded_int32()
            
            # 检查是否是对话表类型 (1001-1007)
            is_dialogue_table = 1001 <= table_type_value <= 1007
            
            if is_dialogue_table:
                # 对话表没有 Headers,直接解析 MessagePack
                try:
                    file_type = TableFileType(table_type_value)
                    table_name = file_type.name
                except ValueError:
                    table_name = f"Unknown_{table_type_value}"
                
                unpacker = msgpack.Unpacker(self.stream, raw=False, strict_map_key=False, use_list=False)
                
                try:
                    packet = unpacker.unpack()
                except msgpack.OutOfData:
                    return {table_name: None}
                
                # 处理 LZ4 压缩
                if (isinstance(packet, (list, tuple)) and
                    len(packet) > 1 and
                    isinstance(packet[0], msgpack.ext.ExtType) and
                    packet[0].code == 98):
                    
                    hdr_reader = msgpack.Unpacker(io.BytesIO(packet[0].data), raw=False, strict_map_key=False)
                    decompressed = bytearray()
                    
                    sizes = list(hdr_reader)
                    for i, blk in enumerate(packet[1:]):
                        if i < len(sizes):
                            uncompressed_size = sizes[i]
                            decompressed_block = lz4.block.decompress(blk, uncompressed_size=uncompressed_size)
                            decompressed.extend(decompressed_block)
                    
                    packet = msgpack.unpackb(decompressed, raw=False, strict_map_key=False, use_list=False)
                
                # 转换 tuple 为 list
                def tuple_to_list(obj):
                    if isinstance(obj, tuple):
                        return [tuple_to_list(x) for x in obj]
                    if isinstance(obj, dict):
                        return {k: tuple_to_list(v) for k, v in obj.items()}
                    return obj
                
                packet_as_list = tuple_to_list(packet)
                structured_packet = self._apply_field_map(table_name, packet_as_list)
                
                return {table_name: structured_packet}
            
            else:
                # 普通表:读取 Header Count 和 Headers
                sub_cnt = self._read_7bit_encoded_int32()
                headers = [(self._read_str(), self._read_str(), self._read_int(4))
                            for _ in range(sub_cnt)]
                
                unpacker = msgpack.Unpacker(self.stream, raw=False, strict_map_key=False, use_list=False)
                
                result = {}
                for name, _, _ in headers:
                    try:
                        packet = unpacker.unpack()
                    except msgpack.OutOfData:
                        continue

                    # 处理 LZ4 压缩
                    if (isinstance(packet, (list, tuple)) and
                        len(packet) > 1 and
                        isinstance(packet[0], msgpack.ext.ExtType) and
                        packet[0].code == 98):
                        
                        hdr_reader = msgpack.Unpacker(io.BytesIO(packet[0].data), raw=False, strict_map_key=False)
                        decompressed = bytearray()
                        
                        sizes = list(hdr_reader)
                        for i, blk in enumerate(packet[1:]):
                            if i < len(sizes):
                                uncompressed_size = sizes[i]
                                decompressed_block = lz4.block.decompress(blk, uncompressed_size=uncompressed_size)
                                decompressed.extend(decompressed_block)
                        
                        packet = msgpack.unpackb(decompressed, raw=False, strict_map_key=False, use_list=False)
                    
                    # 转换 tuple 为 list
                    def tuple_to_list(obj):
                        if isinstance(obj, tuple):
                            return [tuple_to_list(x) for x in obj]
                        if isinstance(obj, dict):
                            return {k: tuple_to_list(v) for k, v in obj.items()}
                        return obj

                    packet_as_list = tuple_to_list(packet)
                    structured_packet = self._apply_field_map(name, packet_as_list)
                    result[name] = structured_packet
                
                return result
                
        except (struct.error, RuntimeError) as e:
            # 解析失败,返回原始数据
            console.print(f"[yellow]解析失败: {e}, 返回原始数据[/yellow]")
            self.stream.seek(0)
            return {"_raw_data_": self.stream.read().hex()}


def main():
    """主函数"""
    try:
        if len(sys.argv) > 1:
            base_dir = Path(sys.argv[1]).resolve()
        else:
            base_dir = Path.cwd()
        
        if not base_dir.exists():
            console.print(f"[red]错误: 目录不存在: {base_dir}[/red]")
            sys.exit(1)
        
        updater = TrickcalUpdater(base_dir)
        updater.run()
        
    except KeyboardInterrupt:
        console.print("\n[yellow]程序被用户中断[/yellow]")
    except Exception as e:
        console.print(f"[red]程序发生错误: {e}[/red]")
        sys.exit(1)


if __name__ == "__main__":
    main() 