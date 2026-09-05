"""
资产提取器

提供 APK 资产和热更资产的文件提取功能。
"""

from __future__ import annotations

import logging
import os
import shutil
import struct
from pathlib import Path
from typing import Dict, List, Optional, Tuple

from .constants import MANIFEST_FILE_SIGN, BUILDIN_CATALOG_FILE_SIGN
from .deserializer import ManifestDeserializer, CatalogDeserializer
from .exporter import manifest_to_json, catalogs_to_json
from .models import BuildinCatalog, PackageBundle, PackageManifest

logger = logging.getLogger(__name__)


def find_bytes_files(root_path: Path) -> Tuple[str, List[Path]]:
    """在目录中搜索 YooAsset 的 .bytes 清单文件

    优先检测热更目录 (ManifestFiles/)，其次检测 APK 内嵌资源。

    Args:
        root_path: 搜索根目录

    Returns:
        (资产类型, 文件列表) 元组。
        资产类型为 "hotfix" / "apk" / "none"。
    """
    # 优先检测热更目录
    manifest_dirs = list(root_path.rglob("ManifestFiles"))
    if manifest_dirs:
        all_files = []
        for d in manifest_dirs:
            if d.is_dir():
                all_files.extend(d.glob("*.bytes"))
        if all_files:
            return "hotfix", all_files

    # 回退到全局搜索
    bytes_files = list(root_path.rglob("*.bytes"))
    if bytes_files:
        return "apk", bytes_files

    return "none", []


def convert_bundle_name_to_path(bundle_name: str) -> str:
    """将 Bundle 名称转换为文件系统路径

    规则: 下划线 ``_`` 替换为目录分隔符，保留最后一个 ``.`` 作为扩展名分隔。

    Args:
        bundle_name: 原始 Bundle 名称

    Returns:
        对应的文件路径字符串，空名称返回空字符串
    """
    if not bundle_name:
        return ""

    if "." in bundle_name:
        name_part, ext_part = bundle_name.rsplit(".", 1)
        return name_part.replace("_", os.sep) + "." + ext_part
    else:
        return bundle_name.replace("_", os.sep)



def process_manifest_file(
    bytes_file: Path,
    output_dir: Optional[Path] = None,
    buildin_catalogs: Optional[Dict[str, BuildinCatalog]] = None,
) -> Optional[PackageManifest]:
    """读取并反序列化单个 .bytes 文件

    自动判断文件类型（清单 / 内置目录），如果是清单则可选导出 JSON。

    Args:
        bytes_file: .bytes 文件路径
        output_dir: JSON 输出目录（为 None 时不导出）
        buildin_catalogs: BuildinCatalog 收集字典（用于后续合并导出）

    Returns:
        PackageManifest 实例；如果是 BuildinCatalog 或处理失败则返回 None
    """
    try:
        binary_data = bytes_file.read_bytes()

        if len(binary_data) < 4:
            logger.warning("跳过 %s: 文件太小", bytes_file.name)
            return None

        file_sign = struct.unpack("<I", binary_data[:4])[0]

        if file_sign == BUILDIN_CATALOG_FILE_SIGN:
            catalog = CatalogDeserializer(binary_data).deserialize()
            logger.info(
                "%s (BuildinCatalog), 版本: %s, 包名: %s, 文件数: %d",
                bytes_file.name,
                catalog.file_version,
                catalog.package_name,
                len(catalog.wrappers),
            )
            if buildin_catalogs is not None:
                buildin_catalogs[catalog.package_name] = catalog
            return None

        elif file_sign == MANIFEST_FILE_SIGN:
            manifest = ManifestDeserializer(binary_data).deserialize()
            logger.info(
                "%s, 版本: %s, 包名: %s, Bundles: %d",
                bytes_file.name,
                manifest.file_version,
                manifest.package_name,
                len(manifest.bundle_list),
            )
            if output_dir:
                json_path = output_dir / f"{bytes_file.stem}.json"
                manifest_to_json(manifest, json_path)
            return manifest

        else:
            logger.warning("跳过 %s: 未知的文件签名 0x%X", bytes_file.name, file_sign)
            return None

    except Exception as e:
        logger.error("处理 %s 时出错: %s", bytes_file.name, e)
        return None



def extract_apk_assets(
    root_path: Path,
    bytes_files: List[Path],
    output_dir: Path,
) -> int:
    """从 APK 解包目录中提取资产文件

    根据清单中的 Bundle 哈希匹配文件，并按 Bundle 名称还原目录结构。

    Args:
        root_path: APK 解包后的根目录
        bytes_files: 清单 .bytes 文件列表
        output_dir: 输出根目录（结果写入 output_dir/Apk/）

    Returns:
        成功提取的文件数量
    """
    apk_dir = output_dir / "Apk"
    apk_dir.mkdir(parents=True, exist_ok=True)

    buildin_catalogs: Dict[str, BuildinCatalog] = {}
    all_bundles: Dict[str, PackageBundle] = {}

    for bf in bytes_files:
        manifest = process_manifest_file(bf, output_dir, buildin_catalogs)
        if manifest:
            for bundle in manifest.bundle_list:
                all_bundles[bundle.file_hash] = bundle

    if buildin_catalogs:
        catalogs_to_json(buildin_catalogs, output_dir / "BuildinCatalog.json")

    files_found = 0
    for file_path in root_path.rglob("*"):
        if file_path.is_file() and file_path.stem in all_bundles:
            bundle = all_bundles[file_path.stem]
            target_rel = convert_bundle_name_to_path(bundle.bundle_name)
            if target_rel:
                target_file = apk_dir / target_rel
                target_file.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(file_path, target_file)
                files_found += 1

    logger.info("APK 提取完成，共提取 %d 个文件", files_found)
    return files_found


def extract_hotfix_assets(
    root_path: Path,
    bytes_files: List[Path],
    output_dir: Path,
) -> int:
    """从热更缓存目录中提取资产文件

    查找以哈希命名的目录下的 ``__data`` 文件，并按 Bundle 名称还原目录结构。

    Args:
        root_path: 热更缓存根目录
        bytes_files: 清单 .bytes 文件列表
        output_dir: 输出根目录（结果写入 output_dir/Update/）

    Returns:
        成功提取的文件数量
    """
    update_dir = output_dir / "Update"
    update_dir.mkdir(parents=True, exist_ok=True)

    buildin_catalogs: Dict[str, BuildinCatalog] = {}
    all_bundles: Dict[str, PackageBundle] = {}

    for bf in bytes_files:
        manifest = process_manifest_file(bf, output_dir, buildin_catalogs)
        if manifest:
            for bundle in manifest.bundle_list:
                all_bundles[bundle.file_hash] = bundle

    if buildin_catalogs:
        catalogs_to_json(buildin_catalogs, output_dir / "BuildinCatalog.json")

    if not all_bundles:
        logger.warning("所有清单均未包含任何资源包信息，提取结束")
        return 0

    files_extracted = 0
    found_hashes: set = set()

    for data_file in root_path.rglob("__data"):
        if not data_file.is_file():
            continue

        file_hash = data_file.parent.name

        if file_hash in all_bundles and file_hash not in found_hashes:
            bundle = all_bundles[file_hash]
            target_rel = convert_bundle_name_to_path(bundle.bundle_name)
            if target_rel:
                target_file = update_dir / target_rel
                target_file.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(data_file, target_file)
                files_extracted += 1
                found_hashes.add(file_hash)

    logger.info("热更提取完成，共提取 %d 个文件", files_extracted)
    return files_extracted
