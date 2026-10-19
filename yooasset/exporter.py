"""
数据导出工具

提供将 PackageManifest / BuildinCatalog 导出为 JSON 等格式的功能。
"""

from __future__ import annotations

import json
import logging
from dataclasses import asdict
from pathlib import Path
from typing import Any, Dict

from .models import PackageManifest, BuildinCatalog

logger = logging.getLogger(__name__)


def dataclass_to_dict(obj: Any) -> Any:
    """将 dataclass 对象递归转换为纯 Python 字典

    支持嵌套 dataclass 和列表。对非 dataclass 值直接返回。
    """
    if isinstance(obj, list):
        return [dataclass_to_dict(item) for item in obj]
    elif hasattr(obj, "__dataclass_fields__"):
        result = {}
        for field_name, field_value in asdict(obj).items():
            result[field_name] = dataclass_to_dict(field_value)
        return result
    else:
        return obj


def manifest_to_json(
    manifest: PackageManifest,
    output_path: Path,
    *,
    indent: int = 4,
) -> None:
    """将 PackageManifest 导出为 JSON 文件

    Args:
        manifest: 要导出的清单对象
        output_path: 输出文件路径
        indent: JSON 缩进级别
    """
    data = dataclass_to_dict(manifest)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=indent, ensure_ascii=False)
    logger.info("已导出清单 JSON: %s", output_path.name)


def catalogs_to_json(
    catalogs: Dict[str, BuildinCatalog],
    output_path: Path,
    *,
    indent: int = 4,
) -> None:
    """将多个 BuildinCatalog 合并导出为单个 JSON 文件

    Args:
        catalogs: 包名 -> BuildinCatalog 的映射
        output_path: 输出文件路径
        indent: JSON 缩进级别
    """
    if not catalogs:
        return

    merged_data = {}
    for package_name, catalog in catalogs.items():
        merged_data[package_name] = dataclass_to_dict(catalog)

    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(merged_data, f, indent=indent, ensure_ascii=False)
    logger.info(
        "已导出合并的 BuildinCatalog JSON: %s (包含 %d 个包)",
        output_path.name,
        len(catalogs),
    )
