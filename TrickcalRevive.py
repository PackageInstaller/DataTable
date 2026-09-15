from __future__ import annotations

import argparse
import io
import json
import os
import shutil
import socket
import struct
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
from enum import IntEnum
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple


try:
    import lz4.block
    import lz4.frame
    import msgpack
    import requests
    import UnityPy
    from Crypto.Cipher import AES
    from Crypto.Util.Padding import unpad
    from rich.console import Console
    from rich.panel import Panel
    from rich.progress import (
        BarColumn,
        DownloadColumn,
        Progress,
        SpinnerColumn,
        TaskID,
        TaskProgressColumn,
        TextColumn,
        TimeElapsedColumn,
        TimeRemainingColumn,
        TransferSpeedColumn,
    )
    from rich.table import Table
except ImportError as e:
    print(f"[错误] 缺少必要依赖: {e}")
    print("请执行: pip install requests lz4 msgpack UnityPy pycryptodome rich")
    sys.exit(1)


try:
    from MasterMap import TABLE_FIELD_MAPS
except ImportError:
    TABLE_FIELD_MAPS = {}

GAME_TITLE = "Trickcal Revive (트릭컬 리바이브)"
DEFAULT_GATEWAY_HOST = "app.a.prod.service.trickcal.io"
DEFAULT_GATEWAY_PORT = 29001
DEFAULT_APP_VERSION = 10633
DEFAULT_PROTOCOL_VERSION = 58
DEFAULT_CDN_BASE = "https://cdn.aws.trickcal.io/production"
DEFAULT_TIMEOUT = 15
DEFAULT_MAX_RETRIES = 5
DEFAULT_JOBS = 16


KEY_BYTES = bytes.fromhex(
    "16 96 22 b3 73 3c bc a9 40 bb 32 99 d2 87 6a 12 "
    "4a aa e3 21 e8 cf d6 f5 a4 54 d0 b4 2a 06 47 e3"
)
IV_BYTES = bytes.fromhex("5c 36 6b f1 d1 54 e4 f0 ab ec 73 7f 2b 4c 2e 14")

console = Console()


class TableFileType(IntEnum):
    """数据表类型枚举"""
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
class VersionInfo:
    """网关版本信息"""
    app_version: int
    bundle_version: int
    hash_str: str
    version_str: str
    cdn_url: str
    server_version: str
    table_version: str


@dataclass
class FileInfo:
    """补丁文件信息"""
    filename: str
    hash_value: str
    size: int
    offset: int
    pak_idx: int
    selective_pak_info: str


@dataclass
class PakEntry:
    """PAK 包内条目"""
    name: str
    offset: int
    size: int


# ==============================================================================
# 网关 TCP 客户端：全自动无抓包版本探测
# ==============================================================================
class TrickcalGatewayClient:
    """负责与游戏网关 TCP 通信，获取最新版本号及 Hash"""

    ALIAS_PQ_CHECK_VERSION = 1071256458  # 0x3FDA138A
    ALIAS_PR_CHECK_VERSION = 255401227   # 0x0F391D0B

    def __init__(self, host: str = DEFAULT_GATEWAY_HOST, port: int = DEFAULT_GATEWAY_PORT):
        self.host = host
        self.port = port

    def _send_check_version_req(
        self,
        s: socket.socket,
        app_version: int,
        bundle_version: int,
        key: int = 85313,
    ) -> List[Any]:
        # PqCheckVersion: [OsType(2=Android), AppVersion, BundleVersion, ProtocolVersion, Reason(1), IpAddresses(None)]
        payload = msgpack.packb(
            [2, app_version, bundle_version, DEFAULT_PROTOCOL_VERSION, 1, None],
            use_bin_type=True,
        )

        req_body = bytearray()
        req_body.append(0x82)  # flags: Request | HasMessage
        req_body.append(0x01)  # requestId = 1
        req_body.extend(struct.pack("<I", self.ALIAS_PQ_CHECK_VERSION))
        req_body.extend(payload)

        # 加密
        h = 0
        enc_body = bytearray(len(req_body))
        for idx, b in enumerate(req_body):
            h = (h ^ (b << (8 * (idx & 3)))) & 0xFFFFFFFF
            enc_body[idx] = (b ^ key) & 0xFF

        packet = struct.pack("<II", 4 + len(enc_body), h) + bytes(enc_body)
        s.sendall(packet)

        # 接收响应
        header = s.recv(8)
        if len(header) < 8:
            raise ConnectionError("网关响应过早关闭")
        resp_len, resp_hash = struct.unpack("<II", header)

        enc_resp = bytearray()
        to_read = resp_len - 4
        while len(enc_resp) < to_read:
            chunk = s.recv(to_read - len(enc_resp))
            if not chunk:
                break
            enc_resp.extend(chunk)

        # 解密
        dec_resp = bytearray(len(enc_resp))
        for idx, b in enumerate(enc_resp):
            dec_resp[idx] = (b ^ key) & 0xFF

        flags = dec_resp[0]
        is_compressed = bool(flags & 0x10)

        if is_compressed:
            lz4_data = bytes(dec_resp[5:])
            decompressed = lz4.frame.decompress(lz4_data)
        else:
            decompressed = bytes(dec_resp[1:])

        alias_bytes = struct.pack("<I", self.ALIAS_PR_CHECK_VERSION)
        pos = decompressed.find(alias_bytes)
        if pos == -1:
            raise ValueError("未在网关响应中找到 PrCheckVersion 标识")

        msg_data = decompressed[pos + 4 :]
        unpacker = msgpack.Unpacker(raw=False)
        unpacker.feed(msg_data)
        for obj in unpacker:
            return obj

        raise ValueError("无法解析 PrCheckVersion 报文数据")

    def fetch_version_info(self, app_version: int = DEFAULT_APP_VERSION) -> VersionInfo:
        """两步握手，获取最新版本号及准确的 CDN Hash"""
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(DEFAULT_TIMEOUT)
            s.connect((self.host, self.port))

            # 第 1 步：传 BundleVersion=0，查询需要的 BundleVersion
            pr1 = self._send_check_version_req(s, app_version, bundle_version=0)
            bundle_update_req = pr1[1]
            if bundle_update_req and isinstance(bundle_update_req, list):
                req_bundle_ver = bundle_update_req[0]
                bundle_url = bundle_update_req[1]
            else:
                req_bundle_ver = pr1[8]
                bundle_url = pr1[3]

        # 第 2 步：重连并传入最新的 BundleVersion，获取包含对应 Hash 的响应
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(DEFAULT_TIMEOUT)
            s.connect((self.host, self.port))
            pr2 = self._send_check_version_req(s, app_version, bundle_version=req_bundle_ver)

            server_ver = pr2[4] or ""
            table_ver = pr2[5] or ""
            bundle_url = pr2[3] or bundle_url or DEFAULT_CDN_BASE
            hash_str = pr2[12] or ""

        if not hash_str:
            version_str = str(req_bundle_ver)
        else:
            version_str = f"{req_bundle_ver}-{hash_str}"

        cdn_url = f"{bundle_url}/Android/{version_str}"

        return VersionInfo(
            app_version=app_version,
            bundle_version=req_bundle_ver,
            hash_str=hash_str,
            version_str=version_str,
            cdn_url=cdn_url,
            server_version=server_ver,
            table_version=table_ver,
        )


# ==============================================================================
# PAK 包解析与 AES 解密工具
# ==============================================================================
class CryptoHelper:
    @staticmethod
    def decrypt_aes(data: bytes, key: bytes = KEY_BYTES, iv: bytes = IV_BYTES) -> bytes:
        if not data or len(data) % 16 != 0:
            return data
        try:
            cipher = AES.new(key, AES.MODE_CBC, iv)
            decrypted = cipher.decrypt(data)
            return unpad(decrypted, AES.block_size)
        except Exception:
            return data


class PakParser:
    @staticmethod
    def parse_pak_entries(data: bytes) -> List[PakEntry]:
        """解析 PAK 结构尾部的索引信息"""
        if len(data) < 8:
            return []
        footer_offset = struct.unpack("<Q", data[:8])[0]
        if footer_offset >= len(data):
            return []

        entries = []
        pos = footer_offset
        file_count = struct.unpack_from("<I", data, pos)[0]
        pos += 4

        for _ in range(file_count):
            if pos >= len(data):
                break
            name_len = data[pos]
            pos += 1
            name = data[pos : pos + name_len].decode("utf-8", errors="ignore")
            pos += name_len
            offset, size = struct.unpack_from("<QQ", data, pos)
            pos += 16
            entries.append(PakEntry(name=name, offset=offset, size=size))

        return entries


# ==============================================================================
# 数据表解析与反序列化
# ==============================================================================
class TableDecoder:
    """Trickcal 数据表解密与反序列化解码器"""

    def __init__(self, raw: bytes):
        self.stream = io.BytesIO(raw)

    def _read_byte(self) -> int:
        b = self.stream.read(1)
        return b[0] if b else 0

    def _read_int(self, n: int, endian: str = "little") -> int:
        return int.from_bytes(self.stream.read(n), endian)

    def _read_str(self) -> str:
        ln = self._read_int(4)
        if ln <= 0:
            return ""
        return self.stream.read(ln - 1).decode("utf-8", errors="ignore")

    def _read_7bit_encoded_int32(self) -> int:
        result = 0
        shift = 0
        for _ in range(5):
            b = self.stream.read(1)
            if not b:
                break
            x = b[0]
            result |= (x & 0x7F) << shift
            if (x & 0x80) == 0:
                return result
            shift += 7
        return result

    @classmethod
    def cleanse_key(cls, k: Any) -> str:
        """清理字典键，确保可作为合法 JSON 键"""
        if isinstance(k, (bytes, bytearray)):
            try:
                return k.decode("utf-8")
            except UnicodeDecodeError:
                return k.hex()
        if isinstance(k, (tuple, list)):
            return str([cls.cleanse_key(x) for x in k])
        return str(k)

    @classmethod
    def cleanse_data(cls, obj: Any) -> Any:
        """递归清理数据，确保可以正常 JSON 序列化"""
        if isinstance(obj, (bytes, bytearray)):
            try:
                return obj.decode("utf-8")
            except UnicodeDecodeError:
                return obj.hex()

        if hasattr(msgpack, "Timestamp") and isinstance(obj, msgpack.Timestamp):
            return obj.to_unix()

        if isinstance(obj, msgpack.ExtType):
            if obj.code == -1:
                try:
                    ts = msgpack.unpackb(obj.data, raw=False, strict_map_key=False)
                    return f"Timestamp({ts})"
                except Exception:
                    pass
            return {"ExtType_code": obj.code, "ExtType_data": obj.data.hex()}

        if isinstance(obj, dict):
            return {
                cls.cleanse_key(k): cls.cleanse_data(v)
                for k, v in obj.items()
            }

        if isinstance(obj, (list, tuple)):
            return [cls.cleanse_data(x) for x in obj]

        return obj

    @classmethod
    def apply_field_map(cls, table_name: str, data: Any) -> Any:
        """
        智能自适应数据表字段映射：
        1. 支持主键字典（单主键、联合主键）与多行列表；
        2. 自适应容错：自动识别 Key 序号跳跃（如官方跳过 Key(27) 或 Key(5)）的数据行；
        3. 对行中的复合结构（如 Quest, Item, Stat, Drop 等）根据其 Schema 自动递归展开为嵌套字典；
        4. 保证层级映射稳定，彻底杜绝外层字段错误投影到子结构上导致的错位问题。
        """
        field_map = (
            TABLE_FIELD_MAPS.get(table_name)
            or TABLE_FIELD_MAPS.get(f"{table_name}Data")
            or TABLE_FIELD_MAPS.get(table_name[:-4] if table_name.endswith("Data") else table_name)
        )
        if not field_map:
            return cls.cleanse_data(data)

        max_k = max(field_map.keys()) if field_map else 0

        def is_row_candidate(lst: Any) -> bool:
            """自适应判断列表是否为当前表的单行记录数据"""
            if not isinstance(lst, (list, tuple)) or len(lst) == 0:
                return False
            # 长度与字段总数相等，或者与最大 Key 序号接近（容纳跳号或截断）
            if len(lst) == len(field_map) or abs(len(lst) - (max_k + 1)) <= 3:
                return True
            return False

        def map_row(row_list: Union[list, tuple], current_map: Dict[int, str]) -> Dict[str, Any]:
            """将单行列表按照字段映射转为字典，并对复合结构字段进行递归下探映射"""
            row_dict = {}
            for idx, val in enumerate(row_list):
                col_name = current_map.get(idx, str(idx))
                # 检查此列是否为一个已知复合结构（例如 col_name 为 'Quest', 'Item', 'Stat', 'Drop' 等）
                sub_schema = (
                    TABLE_FIELD_MAPS.get(col_name)
                    or TABLE_FIELD_MAPS.get(f"{col_name}Data")
                    or TABLE_FIELD_MAPS.get(f"TableBase{col_name}Data")
                )
                if sub_schema and isinstance(val, (list, tuple)) and (len(val) == len(sub_schema) or abs(len(val) - (max(sub_schema.keys()) + 1)) <= 2):
                    row_dict[col_name] = map_row(val, sub_schema)
                elif sub_schema and isinstance(val, (list, tuple)) and len(val) > 0 and isinstance(val[0], (list, tuple)):
                    row_dict[col_name] = [map_row(item, sub_schema) for item in val]
                elif isinstance(val, (list, tuple)):
                    row_dict[col_name] = [map_sub_value(item) for item in val]
                elif isinstance(val, dict):
                    row_dict[col_name] = {cls.cleanse_key(k): map_sub_value(v) for k, v in val.items()}
                else:
                    row_dict[col_name] = cls.cleanse_data(val)
            return row_dict

        def map_sub_value(v: Any) -> Any:
            """通用子元素清理与递归"""
            if isinstance(v, (list, tuple)):
                return [map_sub_value(x) for x in v]
            if isinstance(v, dict):
                return {cls.cleanse_key(k): map_sub_value(sub_v) for k, sub_v in v.items()}
            return cls.cleanse_data(v)

        def process_container(node: Any) -> Any:
            if isinstance(node, dict):
                new_dict = {}
                for k, v in node.items():
                    clean_k = cls.cleanse_key(k)
                    if is_row_candidate(v):
                        new_dict[clean_k] = map_row(v, field_map)
                    elif isinstance(v, (list, tuple)):
                        # 检查 v 内部的子项是否为候选行列表（如 SkillLevelNew 的 List<uzt>）
                        if len(v) > 0 and is_row_candidate(v[0]):
                            new_dict[clean_k] = [map_row(item, field_map) for item in v]
                        else:
                            new_dict[clean_k] = process_container(v)
                    else:
                        new_dict[clean_k] = process_container(v)
                return new_dict
            elif isinstance(node, (list, tuple)):
                if is_row_candidate(node):
                    return map_row(node, field_map)
                new_list = []
                for item in node:
                    if is_row_candidate(item):
                        new_list.append(map_row(item, field_map))
                    else:
                        new_list.append(process_container(item))
                return new_list
            return cls.cleanse_data(node)

        return process_container(data)

    def decode(self, hint_name: Optional[str] = None) -> Dict[str, Any]:
        """
        解码表格数据：
        - 对话表类型 (1001-1007): [TableFileType] [MessagePack Data (含 EpisodeUid, Dialogue, DialogueCharacter)]
        - 普通表类型: [TableFileType] [Header Count] [Headers...] [MessagePack Data]
        """
        try:
            table_type_val = self._read_7bit_encoded_int32()
            is_dialogue = (1001 <= table_type_val <= 1007)

            if is_dialogue:
                unpacker = msgpack.Unpacker(self.stream, raw=False, strict_map_key=False, use_list=False)
                try:
                    packet = unpacker.unpack()
                except msgpack.OutOfData:
                    return {}

                if (isinstance(packet, (list, tuple)) and len(packet) > 1 and
                    isinstance(packet[0], msgpack.ext.ExtType) and packet[0].code == 98):
                    hdr_reader = msgpack.Unpacker(io.BytesIO(packet[0].data), raw=False, strict_map_key=False)
                    sizes = list(hdr_reader)
                    dec = bytearray()
                    for i, blk in enumerate(packet[1:]):
                        if i < len(sizes):
                            dec.extend(lz4.block.decompress(blk, uncompressed_size=sizes[i]))
                    packet = msgpack.unpackb(dec, raw=False, strict_map_key=False, use_list=False)

                # 对话表完整数据格式为 (EpisodeUid, DialogueDict, DialogueCharacterDict)
                if isinstance(packet, (list, tuple)) and len(packet) >= 3:
                    ep_uid = packet[0]
                    mapped_dialogue = self.apply_field_map("Dialogue", packet[1])
                    mapped_character = self.apply_field_map("DialogueCharacter", packet[2])

                    table_key = f"Dialogue/Dialogue_{ep_uid}"
                    return {
                        table_key: {
                            "EpisodeUid": ep_uid,
                            "Dialogue": mapped_dialogue,
                            "DialogueCharacter": mapped_character,
                        }
                    }
                else:
                    # 单一结构回退
                    fallback_name = hint_name or f"Dialogue_{table_type_val}"
                    return {fallback_name: self.apply_field_map("Dialogue", packet)}
            else:
                sub_cnt = self._read_7bit_encoded_int32()
                headers = [
                    (self._read_str(), self._read_str(), self._read_int(4))
                    for _ in range(sub_cnt)
                ]

                unpacker = msgpack.Unpacker(self.stream, raw=False, strict_map_key=False, use_list=False)
                result = {}
                for name, _, _ in headers:
                    try:
                        packet = unpacker.unpack()
                    except msgpack.OutOfData:
                        continue

                    # 处理 LZ4 压缩包 (ExtType 98)
                    if (isinstance(packet, (list, tuple)) and len(packet) > 1 and
                        isinstance(packet[0], msgpack.ext.ExtType) and packet[0].code == 98):
                        hdr_reader = msgpack.Unpacker(io.BytesIO(packet[0].data), raw=False, strict_map_key=False)
                        sizes = list(hdr_reader)
                        decompressed = bytearray()
                        for i, blk in enumerate(packet[1:]):
                            if i < len(sizes):
                                decompressed.extend(lz4.block.decompress(blk, uncompressed_size=sizes[i]))
                        packet = msgpack.unpackb(decompressed, raw=False, strict_map_key=False, use_list=False)

                    result[name] = self.apply_field_map(name, packet)

                return result
        except Exception:
            return {}


# ==============================================================================
# Trickcal 资源管理器主逻辑
# ==============================================================================
class TrickcalChibiGo:
    def __init__(self, base_dir: Path, jobs: int = DEFAULT_JOBS):
        self.base_dir = base_dir.resolve()
        self.master_dir = self.base_dir / "MasterData"
        self.assets_dir = self.base_dir / "Assets"
        self.jobs = jobs
        self.session = requests.Session()
        self.session.headers.update({"User-Agent": "TrickcalChibiGo/2.0"})

    def resolve_version(self, forced_version: Optional[str] = None) -> VersionInfo:
        """解析版本号，优先使用用户传入，否则连接官方网关获取"""
        if forced_version:
            console.print(f"[*] 使用指定版本号: [bold cyan]{forced_version}[/bold cyan]")
            cdn_url = f"{DEFAULT_CDN_BASE}/Android/{forced_version}"
            return VersionInfo(
                app_version=DEFAULT_APP_VERSION,
                bundle_version=0,
                hash_str="",
                version_str=forced_version,
                cdn_url=cdn_url,
                server_version="Manual",
                table_version="Manual",
            )

        console.print("[*] 正在连接游戏网关探测最新版本号...", style="bold blue")
        client = TrickcalGatewayClient()
        try:
            info = client.fetch_version_info()
            console.print(
                f"[green]√ 网关响应成功: 版本 [bold cyan]{info.version_str}[/bold cyan] "
                f"(Server: {info.server_version}, Table: {info.table_version})[/green]"
            )
            return info
        except Exception as e:
            console.print(f"[red]× 连接官方网关失败: {e}[/red]")
            # 尝试回退到已有的本地缓存
            cache_file = self.master_dir / "Version.txt"
            if cache_file.exists():
                cached_ver = cache_file.read_text(encoding="utf-8").strip()
                console.print(f"[yellow]! 回退到本地缓存版本: {cached_ver}[/yellow]")
                return self.resolve_version(cached_ver)
            raise

    def fetch_patch_list(self, cdn_url: str) -> List[str]:
        """下载全量 PatchList.txt"""
        url = f"{cdn_url}/PatchInfo/PatchList.txt"
        console.print(f"[*] 正在获取补丁清单: {url} ...")
        for attempt in range(DEFAULT_MAX_RETRIES):
            try:
                r = self.session.get(url, timeout=DEFAULT_TIMEOUT)
                r.raise_for_status()
                lines = [line.strip() for line in r.text.splitlines() if line.strip()]
                console.print(f"[green]√ 补丁清单下载成功: 共 {len(lines)} 项资源[/green]")
                return lines
            except Exception as e:
                if attempt < DEFAULT_MAX_RETRIES - 1:
                    time.sleep(1.0)
                else:
                    raise RuntimeError(f"无法下载 PatchList.txt: {e}")
        return []

    # --------------------------------------------------------------------------
    # 子命令：status
    # --------------------------------------------------------------------------
    def run_status(self, forced_version: Optional[str] = None):
        v_info = self.resolve_version(forced_version)

        tbl = Table(title="Trickcal Revive 状态概览", show_lines=True)
        tbl.add_column("配置项", style="cyan", justify="right")
        tbl.add_column("当前数值", style="green")

        tbl.add_row("网关地址", f"{DEFAULT_GATEWAY_HOST}:{DEFAULT_GATEWAY_PORT}")
        tbl.add_row("最新完整版本", v_info.version_str)
        tbl.add_row("Bundle 版本号", str(v_info.bundle_version))
        tbl.add_row("Bundle Hash", v_info.hash_str or "N/A")
        tbl.add_row("服务端版本", v_info.server_version)
        tbl.add_row("数据表版本", v_info.table_version)
        tbl.add_row("CDN 根地址", v_info.cdn_url)

        # 本地状态统计
        local_tables = [f for f in self.master_dir.glob("*.json") if f.name != "Version.json"]
        dialogue_tables = list((self.master_dir / "Dialogue").glob("*.json")) if (self.master_dir / "Dialogue").exists() else []
        local_assets = list(self.assets_dir.rglob("*.*")) if self.assets_dir.exists() else []
        assets_size = sum(f.stat().st_size for f in local_assets) / (1024 * 1024)

        tbl.add_row(
            "本地 MasterData",
            f"{len(local_tables)} 个配置表 + {len(dialogue_tables)} 个剧情对话表 ({self.master_dir})",
        )
        tbl.add_row("本地 Assets", f"{len(local_assets)} 个文件 ({assets_size:.2f} MB)")

        console.print(tbl)

    # --------------------------------------------------------------------------
    # 子命令：version
    # --------------------------------------------------------------------------
    def run_version(self, raw: bool = False, forced_version: Optional[str] = None):
        v_info = self.resolve_version(forced_version)
        if raw:
            print(v_info.version_str)
        else:
            console.print(
                Panel.fit(
                    f"[bold green]最新版本:[/bold green] [bold cyan]{v_info.version_str}[/bold cyan]\n"
                    f"[bold green]CDN 路径:[/bold green] {v_info.cdn_url}\n"
                    f"[bold green]ServerVer:[/bold green] {v_info.server_version}\n"
                    f"[bold green]TableVer:[/bold green]  {v_info.table_version}",
                    title="Version Information",
                )
            )

    # --------------------------------------------------------------------------
    # 子命令：masterdata (别名 data)
    # --------------------------------------------------------------------------
    def run_masterdata(self, force: bool = False, forced_version: Optional[str] = None):
        v_info = self.resolve_version(forced_version)

        # 检查本地版本文件
        self.master_dir.mkdir(parents=True, exist_ok=True)
        version_json_path = self.master_dir / "Version.json"
        version_txt_path = self.master_dir / "Version.txt"

        if not force:
            is_up_to_date = False
            if version_json_path.exists():
                try:
                    cached_meta = json.loads(version_json_path.read_text(encoding="utf-8"))
                    if (
                        cached_meta.get("version_str") == v_info.version_str
                        and cached_meta.get("table_version") == v_info.table_version
                    ):
                        is_up_to_date = True
                except Exception:
                    pass
            elif version_txt_path.exists():
                txt_ver = version_txt_path.read_text(encoding="utf-8").strip()
                if txt_ver == v_info.version_str:
                    is_up_to_date = True
                    # 补齐 Version.json
                    meta = {
                        "version_str": v_info.version_str,
                        "bundle_version": v_info.bundle_version,
                        "hash_str": v_info.hash_str,
                        "server_version": v_info.server_version,
                        "table_version": v_info.table_version,
                        "updated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
                    }
                    version_json_path.write_text(json.dumps(meta, ensure_ascii=False, indent=2), encoding="utf-8")

            if is_up_to_date:
                local_tables = [f for f in self.master_dir.glob("*.json") if f.name != "Version.json"]
                dialogue_tables = list((self.master_dir / "Dialogue").glob("*.json")) if (self.master_dir / "Dialogue").exists() else []
                if len(local_tables) > 100 and len(dialogue_tables) > 100:
                    console.print(
                        f"[bold green]√ 数据表已是最新版本 [bold cyan]{v_info.version_str}[/bold cyan] "
                        f"(共 {len(local_tables)} 个配置表，{len(dialogue_tables)} 个剧情对话表)，跳过导出。[/bold green]"
                    )
                    console.print("[dim]提示: 如需强制重新导出全部数据表，请添加 --force 参数。[/dim]")
                    return

        patch_lines = self.fetch_patch_list(v_info.cdn_url)

        # 筛选数据表条目
        table_entries: Dict[int, List[FileInfo]] = {}
        for line in patch_lines:
            parts = line.split("#")
            if len(parts) < 8:
                continue
            filename = parts[0]
            if filename.startswith("table/"):
                info = FileInfo(
                    filename=filename,
                    hash_value=parts[4],
                    size=int(parts[2]),
                    offset=int(parts[3]),
                    pak_idx=int(parts[5]),
                    selective_pak_info=parts[6],
                )
                table_entries.setdefault(info.pak_idx, []).append(info)

        total_files = sum(len(x) for x in table_entries.values())
        console.print(
            f"[*] 发现 [bold cyan]{total_files}[/bold cyan] 个数据表资源，分布在 "
            f"[bold cyan]{len(table_entries)}[/bold cyan] 个 PAK 包中。"
        )

        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            TaskProgressColumn(),
            TimeElapsedColumn(),
            console=console,
        ) as progress:
            task = progress.add_task("导出数据表与剧情对话...", total=total_files)

            # 内存流式解密与多线程解析（优先读取本地 Assets 避免重复下载，无任何 .cache 缓存）
            for pak_idx, files in table_entries.items():
                missing_files = [f for f in files if not (self.assets_dir / f.filename).exists()]
                pak_bytes: Optional[bytes] = None
                pak_files: Dict[str, Tuple[int, int]] = {}

                if missing_files:
                    pak_url = f"{v_info.cdn_url}/Packages_Install/InstallPackage{pak_idx:04d}.pak"
                    try:
                        resp = self.session.get(pak_url, timeout=DEFAULT_TIMEOUT)
                        resp.raise_for_status()
                        pak_bytes = resp.content
                        entries = PakParser.parse_pak_entries(pak_bytes)
                        pak_files = {e.name: (e.offset, e.size) for e in entries}
                    except Exception as e:
                        console.print(f"[red]下载 PAK 失败 {pak_url}: {e}[/red]")
                        continue

                def process_one_table(f_info: FileInfo):
                    try:
                        local_path = self.assets_dir / f_info.filename
                        bundle_bytes: Optional[bytes] = None

                        if local_path.exists():
                            bundle_bytes = local_path.read_bytes()
                        elif pak_bytes and f_info.filename in pak_files:
                            off, sz = pak_files[f_info.filename]
                            bundle_bytes = pak_bytes[off : off + sz]

                        if not bundle_bytes:
                            return

                        # 若不是原生 UnityFS 则进行 AES 解密
                        if not bundle_bytes.startswith(b"UnityFS"):
                            dec_bundle = CryptoHelper.decrypt_aes(bundle_bytes)
                        else:
                            dec_bundle = bundle_bytes

                        # UnityPy 加载资源包
                        env = UnityPy.load(dec_bundle)
                        for obj in env.objects:
                            if obj.type.name == "TextAsset":
                                ta = obj.read()
                                script_data = getattr(ta, "m_Script", None)
                                if script_data is None:
                                    continue
                                if isinstance(script_data, str):
                                    script_bytes = script_data.encode("utf-8", "surrogateescape")
                                else:
                                    script_bytes = bytes(script_data)

                                dec_script = CryptoHelper.decrypt_aes(script_bytes)
                                decoder = TableDecoder(dec_script)
                                decoded_dict = decoder.decode(hint_name=f_info.filename)
                                if decoded_dict:
                                    for sub_name, sub_data in decoded_dict.items():
                                        self._save_table_json(sub_name, sub_data)
                    except Exception as ex:
                        console.print(f"[yellow]解析失败 {f_info.filename}: {ex}[/yellow]")
                    finally:
                        progress.advance(task)

                workers = min(self.jobs, 8)
                with ThreadPoolExecutor(max_workers=workers) as executor:
                    futures = [executor.submit(process_one_table, f) for f in files]
                    for fut in as_completed(futures):
                        fut.result()

        # 写入版本记录文件
        meta = {
            "version_str": v_info.version_str,
            "bundle_version": v_info.bundle_version,
            "hash_str": v_info.hash_str,
            "server_version": v_info.server_version,
            "table_version": v_info.table_version,
            "updated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        }
        version_json_path.write_text(json.dumps(meta, ensure_ascii=False, indent=2), encoding="utf-8")
        (self.master_dir / "Version.txt").write_text(v_info.version_str, encoding="utf-8")

        # 统计产出
        out_configs = [f for f in self.master_dir.glob("*.json") if f.name != "Version.json"]
        out_dialogues = list((self.master_dir / "Dialogue").glob("*.json")) if (self.master_dir / "Dialogue").exists() else []
        console.print(
            f"[bold green]√ 数据表与剧情导出完成: {len(out_configs)} 个配置表，"
            f"{len(out_dialogues)} 个剧情分卷表 -> {self.master_dir}[/bold green]"
        )

    def _save_table_json(self, table_name: str, data: Any):
        """将数据格式化保存为 JSON（支持子目录）"""
        clean_name = table_name.replace(".client", "").replace("table/", "")
        if not clean_name.startswith("Dialogue/"):
            clean_name = clean_name.replace("/", "_")
        out_path = self.master_dir / f"{clean_name}.json"
        out_path.parent.mkdir(parents=True, exist_ok=True)

        with out_path.open("w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

    # --------------------------------------------------------------------------
    # 子命令：assets
    # --------------------------------------------------------------------------
    def run_assets(
        self,
        only: str = "all",
        limit: int = 0,
        force: bool = False,
        forced_version: Optional[str] = None,
    ):
        v_info = self.resolve_version(forced_version)
        self.assets_dir.mkdir(parents=True, exist_ok=True)
        version_json_path = self.assets_dir / "Version.json"

        # 1. 按照官方客户端下载模型，获取指定的 PAK 包清单
        target_lists: List[Tuple[str, str]] = []
        if only.lower() in ("all", "install"):
            target_lists.append(("Packages_Install/InstallPackageInfoList.txt", "Packages_Install"))
        if only.lower() in ("all", "voice", "voiceselect_kor"):
            target_lists.append(("Packages_VoiceSelect_Kor/VoiceSelectPackage_KorInfoList.txt", "Packages_VoiceSelect_Kor"))

        # 读取本地已有版本记录
        local_packages: Dict[str, str] = {}
        if version_json_path.exists():
            try:
                local_meta = json.loads(version_json_path.read_text(encoding="utf-8"))
                local_packages = local_meta.get("packages", {})
            except Exception:
                pass

        console.print(f"[*] 正在进行热更检查 (线上版本: [bold cyan]{v_info.version_str}[/bold cyan])...")

        # 收集远端 PAK 包元数据: (pkg_name, url, size, hash, prefix_dir)
        all_remote_packages: List[Tuple[str, str, int, str, str]] = []
        for rel_list_path, prefix_dir in target_lists:
            list_url = f"{v_info.cdn_url}/{rel_list_path}"
            try:
                r = self.session.get(list_url, timeout=DEFAULT_TIMEOUT)
                if r.status_code == 200:
                    for line in r.text.splitlines():
                        line = line.strip()
                        if not line or line.startswith("#"):
                            continue
                        parts = line.split("#")
                        if len(parts) >= 2:
                            pkg_name = parts[0]
                            pkg_size = int(parts[1]) if parts[1].isdigit() else 0
                            pkg_hash = parts[2] if len(parts) > 2 else ""
                            pkg_url = f"{v_info.cdn_url}/{prefix_dir}/{pkg_name}.pak"
                            all_remote_packages.append((pkg_name, pkg_url, pkg_size, pkg_hash, prefix_dir))
            except Exception as e:
                console.print(f"[yellow]! 获取清单失败 {list_url}: {e}[/yellow]")

        if limit > 0:
            all_remote_packages = all_remote_packages[:limit]

        # 热更对比：比对包 Hash，仅筛选变动或新增的包
        packages_to_download: List[Tuple[str, str, int, str, str]] = []
        for p in all_remote_packages:
            pkg_name, _, _, pkg_hash, _ = p
            if not force and local_packages.get(pkg_name) == pkg_hash:
                continue
            packages_to_download.append(p)

        if not packages_to_download:
            console.print(
                f"[bold green]√ 游戏热更资产已是最新版本 [bold cyan]{v_info.version_str}[/bold cyan]，"
                f"经 Hash 比对无任何变动包需要更新。[/bold green]"
            )
            console.print("[dim]提示: 如需强制重新下载，请添加 --force 参数。[/dim]")
            return

        total_bytes = sum(p[2] for p in packages_to_download)
        total_size_mb = total_bytes / (1024 * 1024)
        if len(packages_to_download) < len(all_remote_packages):
            console.print(
                f"[*] 发现 [bold cyan]{len(packages_to_download)}[/bold cyan] 个变动/新增数据包需要热更 "
                f"(总计: [bold green]{total_size_mb:.2f} MB[/bold green]，跳过 {len(all_remote_packages) - len(packages_to_download)} 个未变动包)"
            )
        else:
            console.print(
                f"[*] 首次全量下载: 共 [bold cyan]{len(packages_to_download)}[/bold cyan] 个数据包 "
                f"(总计: [bold green]{total_size_mb:.2f} MB[/bold green] / [bold green]{total_size_mb/1024:.2f} GB[/bold green])"
            )

        # 2. 多维度丰富进度条（显示下载大小、传输速度、完成包数量、百分比与剩余时间）
        with Progress(
            SpinnerColumn(),
            TextColumn("[bold cyan]{task.description}"),
            BarColumn(bar_width=32),
            DownloadColumn(),
            TransferSpeedColumn(),
            TaskProgressColumn(),
            TextColumn("[yellow]({task.fields[pkg_done]}/{task.fields[pkg_total]} 包)[/yellow]"),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            main_task = progress.add_task(
                "下载与还原资产...",
                total=total_bytes,
                pkg_done=0,
                pkg_total=len(packages_to_download),
            )

            pkg_done_lock = threading.Lock()
            pkg_done_counter = 0

            def process_package(pkg_info):
                nonlocal pkg_done_counter
                pkg_name, pkg_url, expected_size, pkg_hash, prefix_dir = pkg_info
                pak_data: Optional[bytes] = None

                for attempt in range(DEFAULT_MAX_RETRIES):
                    try:
                        with self.session.get(pkg_url, stream=True, timeout=DEFAULT_TIMEOUT) as resp:
                            resp.raise_for_status()
                            chunks = bytearray()
                            for chunk in resp.iter_content(chunk_size=128 * 1024):
                                if chunk:
                                    chunks.extend(chunk)
                                    progress.update(main_task, advance=len(chunk))
                            pak_data = bytes(chunks)
                            break
                    except Exception:
                        if attempt == DEFAULT_MAX_RETRIES - 1:
                            console.print(f"[red]× 下载包失败: {pkg_url}[/red]")
                            return
                        time.sleep(1.0)

                # 即时解包还原并 AES 解密（内存流式处理，完全不保留任何 .pak 缓存目录与垃圾文件）
                if pak_data:
                    try:
                        entries = PakParser.parse_pak_entries(pak_data)
                        if entries:
                            for ent in entries:
                                ent_slice = pak_data[ent.offset : ent.offset + ent.size]
                                is_enc = (
                                    not ent_slice.startswith(b"UnityFS")
                                    and not ent_slice.startswith(b"RIFF")
                                    and not ent_slice.startswith(b"Ogg")
                                    and not ent_slice.startswith(b"FSB5")
                                )
                                out_data = CryptoHelper.decrypt_aes(ent_slice) if is_enc else ent_slice
                                ent_path = self.assets_dir / ent.name
                                ent_path.parent.mkdir(parents=True, exist_ok=True)
                                ent_path.write_bytes(out_data)
                        with pkg_done_lock:
                            local_packages[pkg_name] = pkg_hash
                    except Exception as ex:
                        console.print(f"[yellow]! 还原包失败 {pkg_name}: {ex}[/yellow]")

                with pkg_done_lock:
                    pkg_done_counter += 1
                    progress.update(main_task, pkg_done=pkg_done_counter)

            workers = min(self.jobs, 4)
            with ThreadPoolExecutor(max_workers=workers) as executor:
                futures = [executor.submit(process_package, p) for p in packages_to_download]
                for f in as_completed(futures):
                    f.result()

        # 更新并保存资产版本记录文件
        new_meta = {
            "version_str": v_info.version_str,
            "bundle_version": v_info.bundle_version,
            "packages": local_packages,
            "updated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        }
        version_json_path.write_text(json.dumps(new_meta, ensure_ascii=False, indent=2), encoding="utf-8")

        console.print(f"[bold green]√ 资产还原完成: {self.assets_dir}[/bold green]")

    # --------------------------------------------------------------------------
    # 子命令：schema
    # --------------------------------------------------------------------------
    def run_schema(self):
        console.print("[*] 正在执行 GenerateMasterMap 生成字段结构...", style="bold blue")
        import GenerateMasterMap
        ret = GenerateMasterMap.main([])
        if ret == 0:
            console.print("[bold green]√ MasterMap.py 重新生成成功！[/bold green]")
        else:
            console.print("[bold red]× MasterMap.py 生成失败！[/bold red]")


# ==============================================================================
# CLI 构建与参数解析
# ==============================================================================
def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--version", dest="forced_version", help="强制指定版本字符串 (例如 1063304-38a091c4)")
    shared.add_argument("-f", "--force", action="store_true", help="强制重新下载与导出 (忽略本地版本记录)")
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help=f"并发数 (默认: {DEFAULT_JOBS})")
    shared.add_argument("--output", type=Path, default=Path("."), help="工作区根目录 (默认: 当前目录)")

    parser = argparse.ArgumentParser(
        prog="TrickcalChibiGo.py",
        description=f"{GAME_TITLE} 综合数据与资产工具",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "常用命令示例:\n"
            "  python TrickcalChibiGo.py status         # 查询最新版本与本地对比概览\n"
            "  python TrickcalChibiGo.py version        # 仅探测并打印最新版本号及 CDN URL\n"
            "  python TrickcalChibiGo.py masterdata     # 增量热更/导出数据表到 MasterData/\n"
            "  python TrickcalChibiGo.py assets         # 增量热更/解密还原热更资源到 Assets/\n"
            "  python TrickcalChibiGo.py schema         # 从 il2cpp 转储重新生成 MasterMap.py\n"
            "  python TrickcalChibiGo.py all            # 一键执行全部更新流程\n"
        ),
    )

    sub = parser.add_subparsers(dest="cmd", required=True)

    # status
    sub.add_parser("status", parents=[shared], help="查询服务器与本地版本/资产状态")

    # version
    v_parser = sub.add_parser("version", parents=[shared], help="探测并输出线上最新版本号")
    v_parser.add_argument("--raw", action="store_true", help="仅输出裸版本号字符串 (便于脚本调用)")

    # masterdata (别名 data)
    sub.add_parser("masterdata", aliases=["data"], parents=[shared], help="下载并反序列化数据表到 MasterData/")

    # assets
    a_parser = sub.add_parser("assets", parents=[shared], help="下载解密并还原完整热更资产到 Assets/")
    a_parser.add_argument("--only", default="all", help="指定下载范围 (例如: all, install, voice, svs)")
    a_parser.add_argument("--limit", type=int, default=0, help="限制下载包数量 (调试用)")

    # schema
    sub.add_parser("schema", parents=[shared], help="从 C# il2cpp dump 生成 MasterMap.py")

    # all
    sub.add_parser("all", parents=[shared], help="一键执行版本探测、数据表导出及资产更新")

    return parser


def main(argv: Optional[List[str]] = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    app = TrickcalChibiGo(base_dir=args.output, jobs=args.jobs)

    if args.cmd == "status":
        app.run_status(forced_version=args.forced_version)
    elif args.cmd == "version":
        app.run_version(raw=args.raw, forced_version=args.forced_version)
    elif args.cmd in ("masterdata", "data"):
        app.run_masterdata(force=args.force, forced_version=args.forced_version)
    elif args.cmd == "assets":
        app.run_assets(only=args.only, limit=args.limit, force=args.force, forced_version=args.forced_version)
    elif args.cmd == "schema":
        app.run_schema()
    elif args.cmd == "all":
        console.print("[bold cyan]=== [1/3] 检测版本状态 ===[/bold cyan]")
        app.run_status(forced_version=args.forced_version)
        console.print("\n[bold cyan]=== [2/3] 导出数据表 MasterData ===[/bold cyan]")
        app.run_masterdata(force=args.force, forced_version=args.forced_version)
        console.print("\n[bold cyan]=== [3/3] 还原热更资产 Assets ===[/bold cyan]")
        app.run_assets(only="all", force=args.force, forced_version=args.forced_version)
        console.print("\n[bold green]√ 全部流程执行完毕！[/bold green]")
    else:
        parser.print_help()

    return 0


if __name__ == "__main__":
    sys.exit(main())
