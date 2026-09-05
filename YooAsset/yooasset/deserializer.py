"""
YooAsset 反序列化器

提供清单文件 (PackageManifest) 和内置目录 (BuildinCatalog) 的二进制反序列化能力。
支持 v1.5.2 ~ v2025.9.30 (字符串版本号) 及 v3.0+ (整数版本号) 的自动检测与解析。
"""

from __future__ import annotations

import struct
import logging
from pathlib import Path
from typing import Optional, Union

from .constants import (
    MANIFEST_FILE_SIGN,
    BUILDIN_CATALOG_FILE_SIGN,
    SUPPORTED_VERSIONS,
    BUILDIN_CATALOG_VERSION,
    MANIFEST_V3_FILE_VERSION,
    BUILDIN_CATALOG_V3_FILE_VERSION,
)
from .reader import BufferReader
from .models import (
    PackageAsset,
    PackageBundle,
    PackageManifest,
    BuildinCatalog,
    BuildinCatalogFileWrapper,
)

logger = logging.getLogger(__name__)


# ═══════════════════════════════════════════════════════════
#  清单反序列化器
# ═══════════════════════════════════════════════════════════


class ManifestDeserializer:
    """YooAsset 清单文件反序列化器（支持 v1.5.2 ~ v3.0+）"""

    def __init__(self, binary_data: bytes) -> None:
        self._buffer = BufferReader(binary_data)
        self._manifest: Optional[PackageManifest] = None
        self._version: Optional[Union[str, int]] = None

    def deserialize(self) -> PackageManifest:
        """执行反序列化，返回 PackageManifest 实例

        Raises:
            ValueError: 数据无效、签名不匹配或版本不支持
        """
        if not self._buffer.is_valid:
            raise ValueError("无效的缓冲区数据")

        self._read_header()
        self._read_body()
        return self._manifest

    # ── 文件头解析 ────────────────────────────────────────

    def _read_header(self) -> None:
        """读取并验证文件头"""
        file_sign = self._buffer.read_uint32()
        if file_sign != MANIFEST_FILE_SIGN:
            raise ValueError(
                f"清单签名不匹配: 期望 0x{MANIFEST_FILE_SIGN:X}, 实际 0x{file_sign:X}"
            )

        # 探测版本号格式：v3.0+ 使用 int32，v2.x 使用 UTF-8 字符串 (uint16 长度前缀)
        # 利用 uint16 前缀区分：v3.0 的 int32=1 前两字节为 [0x01, 0x00]，
        # 而 v2.x 字符串长度前缀 (如 5="1.5.2") 不可能为 0 或 1。
        peek_data = self._buffer.read_bytes(4)
        # 按小端读取为 int32
        int_version = struct.unpack("<i", peek_data)[0]
        # 按小端读取前 2 字节为 uint16（字符串长度前缀）
        str_len_prefix = struct.unpack("<H", peek_data[:2])[0]

        if int_version == MANIFEST_V3_FILE_VERSION:
            # v3.0+ 整数版本
            self._version = int_version
            self._read_header_v3()
        elif str_len_prefix > 0:
            # v2.x 字符串版本——回退读取位置，让 read_utf8 从头读
            self._buffer._index -= 4
            file_version = self._buffer.read_utf8()
            if file_version not in SUPPORTED_VERSIONS:
                raise ValueError(f"不支持的清单版本: {file_version}")
            self._version = file_version
            self._read_header_v2()
        else:
            raise ValueError(
                f"无法识别版本号格式: 前4字节 = {peek_data.hex()}"
            )

    def _read_header_v2(self) -> None:
        """读取 v2.x 系列的文件头（条件字段）"""
        m = self._manifest = PackageManifest(file_version=self._version)

        m.enable_addressable = self._buffer.read_bool()

        # v2025.8.28+ 新增
        if self._version in ("2025.8.28", "2025.9.30"):
            m.support_extensionless = self._buffer.read_bool()

        m.location_to_lower = self._buffer.read_bool()
        m.include_asset_guid = self._buffer.read_bool()

        # v2025.9.30+ 新增
        if self._version == "2025.9.30":
            m.replace_asset_path_with_address = self._buffer.read_bool()

        m.output_name_style = self._buffer.read_int32()

        # v2.0.0+ 新增字段
        if self._version in ("2.0.0", "2.3.1", "2025.8.28", "2025.9.30"):
            if self._version in ("2.3.1", "2025.8.28", "2025.9.30"):
                m.build_bundle_type = self._buffer.read_int32()
            m.build_pipeline = self._buffer.read_utf8()

        m.package_name = self._buffer.read_utf8()
        m.package_version = self._buffer.read_utf8()

        # v2.3.1+ 新增
        if self._version in ("2.3.1", "2025.8.28", "2025.9.30"):
            m.package_note = self._buffer.read_utf8()

        self._validate_header(m)

    def _read_header_v3(self) -> None:
        """读取 v3.0+ 的文件头（所有字段始终存在，无条件分支）"""
        m = self._manifest = PackageManifest(file_version=self._version)

        m.enable_addressable = self._buffer.read_bool()
        m.support_extensionless = self._buffer.read_bool()
        m.location_to_lower = self._buffer.read_bool()
        m.include_asset_guid = self._buffer.read_bool()
        m.replace_asset_path_with_address = self._buffer.read_bool()
        m.output_name_style = self._buffer.read_int32()
        m.build_bundle_type = self._buffer.read_int32()
        m.build_pipeline = self._buffer.read_utf8()
        m.package_name = self._buffer.read_utf8()
        m.package_version = self._buffer.read_utf8()
        m.package_note = self._buffer.read_utf8()

        self._validate_header(m)

    @staticmethod
    def _validate_header(m: PackageManifest) -> None:
        """文件头一致性校验"""
        if m.enable_addressable and m.location_to_lower:
            raise ValueError("Addressable 不支持 location_to_lower 为 true")
        if not m.enable_addressable and m.replace_asset_path_with_address:
            raise ValueError("ReplaceAssetPathWithAddress 需要启用 Addressable")

    # ── 版本分发 ──────────────────────────────────────────

    def _read_body(self) -> None:
        """根据版本号分发到对应的读取流程"""
        dispatch = {
            "1.5.2": self._read_v152,
            "2.0.0": self._read_v200,
            "2.3.1": self._read_v231,
            "2025.8.28": self._read_v2025,
            "2025.9.30": self._read_v2025,
            MANIFEST_V3_FILE_VERSION: self._read_v3,
        }
        handler = dispatch.get(self._version)
        if handler is None:
            raise ValueError(f"不支持的版本: {self._version}")
        handler()

    # ── v1.5.2 ────────────────────────────────────────────

    def _read_v152(self) -> None:
        # Seer / 魔改 YooAsset 1.5.2:
        # - address / guid 按 header 标志条件写入
        # - asset 无 Tags；depend / bundle ReferenceIDs 为 uint16 计数（见 BufferReader）
        # - bundle 无 Tags
        buf = self._buffer
        m = self._manifest

        asset_count = buf.read_int32()
        for _ in range(asset_count):
            address = buf.read_utf8() if m.enable_addressable else ""
            asset_path = buf.read_utf8()
            asset_guid = buf.read_utf8() if m.include_asset_guid else ""
            asset = PackageAsset(
                address=address,
                asset_path=asset_path,
                asset_guid=asset_guid,
                asset_tags=[],
                bundle_id=buf.read_int32(),
                depend_ids=buf.read_int32_array(),
            )
            m.asset_list.append(asset)

        bundle_count = buf.read_int32()
        for _ in range(bundle_count):
            bundle = PackageBundle(
                bundle_name=buf.read_utf8(),
                unity_crc=buf.read_uint32(),
                file_hash=buf.read_utf8(),
                file_crc=buf.read_utf8(),
                file_size=buf.read_int64(),
                is_raw_file=buf.read_bool(),
                load_method=buf.read_byte(),
                tags=[],
                reference_ids=buf.read_int32_array(),
            )
            m.bundle_list.append(bundle)

    # ── v2.0.0 ────────────────────────────────────────────

    def _read_v200(self) -> None:
        buf = self._buffer
        m = self._manifest

        asset_count = buf.read_int32()
        for _ in range(asset_count):
            asset = PackageAsset(
                address=buf.read_utf8(),
                asset_path=buf.read_utf8(),
                asset_guid=buf.read_utf8(),
                asset_tags=buf.read_utf8_array(),
                bundle_id=buf.read_int32(),
                # 注意: v2.0.0 的 PackageAsset 没有 depend_ids 字段
            )
            m.asset_list.append(asset)

        bundle_count = buf.read_int32()
        for _ in range(bundle_count):
            bundle = PackageBundle(
                bundle_name=buf.read_utf8(),
                unity_crc=buf.read_uint32(),
                file_hash=buf.read_utf8(),
                file_crc=buf.read_utf8(),
                file_size=buf.read_int64(),
                encrypted=buf.read_bool(),
                tags=buf.read_utf8_array(),
                depend_ids=buf.read_int32_array(),
            )
            m.bundle_list.append(bundle)

    # ── v2.3.1 (原 v2.3.12) ──────────────────────────────

    def _read_v231(self) -> None:
        buf = self._buffer
        m = self._manifest

        asset_count = buf.read_int32()
        for _ in range(asset_count):
            asset = PackageAsset(
                address=buf.read_utf8(),
                asset_path=buf.read_utf8(),
                asset_guid=buf.read_utf8(),
                asset_tags=buf.read_utf8_array(),
                bundle_id=buf.read_int32(),
                depend_bundle_ids=buf.read_int32_array(),
            )
            m.asset_list.append(asset)

        bundle_count = buf.read_int32()
        for _ in range(bundle_count):
            bundle = PackageBundle(
                bundle_name=buf.read_utf8(),
                unity_crc=buf.read_uint32(),
                file_hash=buf.read_utf8(),
                file_crc=buf.read_utf8(),
                file_size=buf.read_int64(),
                encrypted=buf.read_bool(),
                tags=buf.read_utf8_array(),
                depend_bundle_ids=buf.read_int32_array(),
            )
            m.bundle_list.append(bundle)

    # ── v2025.8.28 / v2025.9.30 (原 v2.3.17) ─────────────

    def _read_v2025(self) -> None:
        buf = self._buffer
        m = self._manifest

        replace_asset_path = (
            m.enable_addressable and m.replace_asset_path_with_address
        )

        asset_count = buf.read_int32()
        for _ in range(asset_count):
            address = buf.read_utf8()

            if replace_asset_path:
                # 启用替换时，用 address 代替 asset_path，跳过原始数据
                asset_path = address
                buf.skip_utf8()
            else:
                asset_path = buf.read_utf8()

            asset = PackageAsset(
                address=address,
                asset_path=asset_path,
                asset_guid=buf.read_utf8(),
                asset_tags=buf.read_utf8_array(),
                bundle_id=buf.read_int32(),
                depend_bundle_ids=buf.read_int32_array(),
            )
            m.asset_list.append(asset)

        bundle_count = buf.read_int32()
        for _ in range(bundle_count):
            bundle = PackageBundle(
                bundle_name=buf.read_utf8(),
                unity_crc=buf.read_uint32(),
                file_hash=buf.read_utf8(),
                file_crc=str(buf.read_uint32()),  # v2025 起 FileCRC 为 uint32
                file_size=buf.read_int64(),
                encrypted=buf.read_bool(),
                tags=buf.read_utf8_array(),
                depend_bundle_ids=buf.read_int32_array(),
            )
            m.bundle_list.append(bundle)

    # ── v3.0+ ─────────────────────────────────────────────

    def _read_v3(self) -> None:
        """v3.0+ 的 Asset/Bundle 读取逻辑

        与 v2025.x 的二进制布局完全一致：
        - Asset: Address, AssetPath, AssetGuid, AssetTags, BundleID, DependentBundleIDs
        - Bundle: BundleName, UnityCrc, FileHash, FileCrc(uint32), FileSize, IsEncrypted, Tags, DependentBundleIDs
        """
        buf = self._buffer
        m = self._manifest

        replace_asset_path = (
            m.enable_addressable and m.replace_asset_path_with_address
        )

        # 反序列化 Asset 列表
        asset_count = buf.read_int32()
        for _ in range(asset_count):
            address = buf.read_utf8()

            if replace_asset_path:
                asset_path = address
                buf.skip_utf8()
            else:
                asset_path = buf.read_utf8()

            asset = PackageAsset(
                address=address,
                asset_path=asset_path,
                asset_guid=buf.read_utf8(),
                asset_tags=buf.read_utf8_array(),
                bundle_id=buf.read_int32(),
                depend_bundle_ids=buf.read_int32_array(),
            )
            m.asset_list.append(asset)

        # 反序列化 Bundle 列表
        bundle_count = buf.read_int32()
        for _ in range(bundle_count):
            bundle = PackageBundle(
                bundle_name=buf.read_utf8(),
                unity_crc=buf.read_uint32(),
                file_hash=buf.read_utf8(),
                file_crc=str(buf.read_uint32()),  # v3.0 FileCRC 为 uint32
                file_size=buf.read_int64(),
                encrypted=buf.read_bool(),
                tags=buf.read_utf8_array(),
                depend_bundle_ids=buf.read_int32_array(),
            )
            m.bundle_list.append(bundle)


# ═══════════════════════════════════════════════════════════
#  内置目录反序列化器
# ═══════════════════════════════════════════════════════════


class CatalogDeserializer:
    """BuildinCatalog 反序列化器（支持 v2.x 字符串版本及 v3.0+ 整数版本）"""

    def __init__(self, binary_data: bytes) -> None:
        self._buffer = BufferReader(binary_data)

    def deserialize(self) -> BuildinCatalog:
        """执行反序列化，返回 BuildinCatalog 实例

        Raises:
            ValueError: 数据无效、签名不匹配或版本不支持
        """
        buf = self._buffer
        if not buf.is_valid:
            raise ValueError("无效的缓冲区数据")

        file_sign = buf.read_uint32()
        if file_sign != BUILDIN_CATALOG_FILE_SIGN:
            raise ValueError(
                f"BuildinCatalog 签名不匹配: "
                f"期望 0x{BUILDIN_CATALOG_FILE_SIGN:X}, 实际 0x{file_sign:X}"
            )

        # 探测版本号格式：与清单相同的启发式方法
        peek_data = buf.read_bytes(4)
        int_version = struct.unpack("<i", peek_data)[0]
        str_len_prefix = struct.unpack("<H", peek_data[:2])[0]

        if int_version == BUILDIN_CATALOG_V3_FILE_VERSION:
            # v3.0+ 整数版本
            file_version = int_version
        elif str_len_prefix > 0:
            # v2.x 字符串版本——回退读取位置
            buf._index -= 4
            file_version = buf.read_utf8()
            if file_version != BUILDIN_CATALOG_VERSION:
                raise ValueError(f"不支持的 BuildinCatalog 版本: {file_version}")
        else:
            raise ValueError(
                f"无法识别 BuildinCatalog 版本号格式: 前4字节 = {peek_data.hex()}"
            )

        catalog = BuildinCatalog(
            file_version=file_version,
            package_name=buf.read_utf8(),
            package_version=buf.read_utf8(),
        )

        file_count = buf.read_int32()
        for _ in range(file_count):
            wrapper = BuildinCatalogFileWrapper(
                bundle_guid=buf.read_utf8(),
                file_name=buf.read_utf8(),
            )
            catalog.wrappers.append(wrapper)

        return catalog


# ═══════════════════════════════════════════════════════════
#  便捷函数
# ═══════════════════════════════════════════════════════════


def deserialize_from_bytes(
    data: bytes,
) -> Union[PackageManifest, BuildinCatalog]:
    """从二进制数据自动检测类型并反序列化

    Args:
        data: 原始二进制数据

    Returns:
        PackageManifest 或 BuildinCatalog 实例

    Raises:
        ValueError: 数据太小、签名未知或反序列化失败
    """
    if len(data) < 4:
        raise ValueError(f"数据太小 ({len(data)} 字节)，至少需要 4 字节")

    file_sign = struct.unpack("<I", data[:4])[0]

    if file_sign == MANIFEST_FILE_SIGN:
        return ManifestDeserializer(data).deserialize()
    elif file_sign == BUILDIN_CATALOG_FILE_SIGN:
        return CatalogDeserializer(data).deserialize()
    else:
        raise ValueError(f"未知的文件签名: 0x{file_sign:X}")


def deserialize_from_file(
    path: Union[str, Path],
) -> Union[PackageManifest, BuildinCatalog]:
    """从文件路径自动检测类型并反序列化

    Args:
        path: 文件路径

    Returns:
        PackageManifest 或 BuildinCatalog 实例

    Raises:
        FileNotFoundError: 文件不存在
        ValueError: 文件无法识别或反序列化失败
    """
    file_path = Path(path)
    if not file_path.is_file():
        raise FileNotFoundError(f"文件不存在: {file_path}")

    data = file_path.read_bytes()
    return deserialize_from_bytes(data)
