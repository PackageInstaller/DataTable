"""
YooAsset 数据模型

定义清单文件和内置目录的结构化数据模型。
使用 dataclass + field(default_factory) 确保可变默认值安全。
"""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import List, Union



@dataclass
class PackageAsset:
    """资源包中的单个资源信息"""

    address: str = ""
    asset_path: str = ""
    asset_guid: str = ""
    asset_tags: List[str] = field(default_factory=list)
    bundle_id: int = 0
    depend_ids: List[int] = field(default_factory=list)  # 仅 v1.5.2
    depend_bundle_ids: List[int] = field(default_factory=list)  # v2.3.1+




@dataclass
class PackageBundle:
    """资源 Bundle 信息"""

    bundle_name: str = ""
    unity_crc: int = 0
    file_hash: str = ""
    file_crc: str = ""
    file_size: int = 0
    # v1.5.2 字段
    is_raw_file: bool = False
    load_method: int = 0
    reference_ids: List[int] = field(default_factory=list)
    # v2.0.0+ 字段
    encrypted: bool = False
    depend_ids: List[int] = field(default_factory=list)
    # v2.3.1+ 字段
    depend_bundle_ids: List[int] = field(default_factory=list)
    # 通用字段
    tags: List[str] = field(default_factory=list)


@dataclass
class PackageManifest:
    """资源包清单"""

    file_version: Union[str, int] = ""
    enable_addressable: bool = False
    support_extensionless: bool = False  # v2025.8.28+
    location_to_lower: bool = False
    include_asset_guid: bool = False
    replace_asset_path_with_address: bool = False  # v2025.9.30+
    output_name_style: int = 0
    build_bundle_type: int = 0  # v2.3.1+
    build_pipeline: str = ""  # v2.0.0+
    package_name: str = ""
    package_version: str = ""
    package_note: str = ""  # v2.3.1+
    asset_list: List[PackageAsset] = field(default_factory=list)
    bundle_list: List[PackageBundle] = field(default_factory=list)

@dataclass
class BuildinCatalogFileWrapper:
    """内置文件目录中的单条文件记录"""

    file_name: str = ""
    bundle_guid: str = ""


@dataclass
class BuildinCatalog:
    """内置文件目录"""

    file_version: Union[str, int] = ""
    package_name: str = ""
    package_version: str = ""
    wrappers: List[BuildinCatalogFileWrapper] = field(default_factory=list)
