"""
YooAsset — YooAsset 资产清单解析与提取工具库

快速开始::

    from yooasset import deserialize_from_file

    result = deserialize_from_file("path/to/manifest.bytes")
    print(result.package_name, len(result.bundle_list))

提取资产::

    from yooasset import find_bytes_files, extract_apk_assets
    from pathlib import Path

    asset_type, files = find_bytes_files(Path("./unpacked_apk"))
    if asset_type == "apk":
        extract_apk_assets(Path("./unpacked_apk"), files, Path("./output"))
"""

__version__ = "1.3.0"

# 数据模型
from .models import (
    PackageAsset,
    PackageBundle,
    PackageManifest,
    BuildinCatalog,
    BuildinCatalogFileWrapper,
)

# 反序列化器
from .deserializer import (
    ManifestDeserializer,
    CatalogDeserializer,
    deserialize_from_file,
    deserialize_from_bytes,
)

# 提取与导出
from .extractor import (
    find_bytes_files,
    extract_apk_assets,
    extract_hotfix_assets,
    convert_bundle_name_to_path,
)
from .exporter import (
    manifest_to_json,
    catalogs_to_json,
    dataclass_to_dict,
)

# 底层工具
from .reader import BufferReader
from .constants import (
    MANIFEST_FILE_SIGN,
    BUILDIN_CATALOG_FILE_SIGN,
    SUPPORTED_VERSIONS,
    MANIFEST_V3_FILE_VERSION,
)

__all__ = [
    # 模型
    "PackageAsset",
    "PackageBundle",
    "PackageManifest",
    "BuildinCatalog",
    "BuildinCatalogFileWrapper",
    # 反序列化
    "ManifestDeserializer",
    "CatalogDeserializer",
    "deserialize_from_file",
    "deserialize_from_bytes",
    # 提取
    "find_bytes_files",
    "extract_apk_assets",
    "extract_hotfix_assets",
    "convert_bundle_name_to_path",
    # 导出
    "manifest_to_json",
    "catalogs_to_json",
    "dataclass_to_dict",
    # 底层
    "BufferReader",
    "MANIFEST_FILE_SIGN",
    "BUILDIN_CATALOG_FILE_SIGN",
    "SUPPORTED_VERSIONS",
    "MANIFEST_V3_FILE_VERSION",
]
