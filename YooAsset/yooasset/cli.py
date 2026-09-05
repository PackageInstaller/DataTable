"""
YooAsset 命令行入口
"""

from __future__ import annotations

import argparse
import logging
import sys
from pathlib import Path

from .deserializer import deserialize_from_file
from .exporter import manifest_to_json, catalogs_to_json
from .extractor import (
    find_bytes_files,
    extract_apk_assets,
    extract_hotfix_assets,
)

logger = logging.getLogger("yooasset")


def _setup_logging(verbose: bool = False) -> None:
    """配置日志格式和级别"""
    level = logging.DEBUG if verbose else logging.INFO
    logging.basicConfig(
        level=level,
        format="%(levelname)s: %(message)s",
        handlers=[logging.StreamHandler(sys.stdout)],
    )


def main(argv: list[str] | None = None) -> None:
    """CLI"""
    if argv is None:
        argv = sys.argv[1:]

    if argv and argv[0] in ("extract", "parse"):
        cmd, rest = argv[0], argv[1:]
    else:
        # 旧版兼容：直接给输入目录时执行 extract
        cmd, rest = "extract", argv

    if cmd == "parse":
        _run_parse(rest)
    else:
        _run_extract(rest)


def _run_parse(argv: list[str]) -> None:
    parser = argparse.ArgumentParser(
        prog="yooasset parse",
        description="解析 YooAsset 二进制清单（YOO 魔数）并输出解析结果",
    )
    parser.add_argument(
        "manifest",
        type=Path,
        help="YOO 二进制清单文件（PackageManifest 或 BuildinCatalog）",
    )
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=None,
        help="解析结果 JSON 输出路径（默认只打印摘要）",
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="显示详细调试信息",
    )
    args = parser.parse_args(argv)
    _setup_logging(args.verbose)

    result = deserialize_from_file(args.manifest)
    if hasattr(result, "package_name"):
        # PackageManifest
        logger.info(
            "清单: 版本 %s | 包 %s %s | 资产 %d | bundle %d",
            result.file_version,
            result.package_name,
            result.package_version,
            len(result.asset_list),
            len(result.bundle_list),
        )
        if args.output:
            manifest_to_json(result, args.output)
    else:
        # BuildinCatalog
        logger.info(
            "内置目录: 版本 %s | 包 %s %s | 文件 %d",
            result.file_version,
            result.package_name,
            result.package_version,
            len(result.wrappers),
        )
        if args.output:
            catalogs_to_json({result.package_name: result}, args.output)


def _run_extract(argv: list[str]) -> None:
    parser = argparse.ArgumentParser(
        prog="yooasset extract",
        description="YooAsset 资产提取工具 — 解析清单文件并还原资产目录结构",
    )
    parser.add_argument(
        "input_dir",
        type=Path,
        help="包含 .bytes 清单文件的输入目录（APK 解包目录或热更缓存目录）",
    )
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=None,
        help="输出目录（默认: 当前脚本所在目录）",
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="显示详细调试信息",
    )

    args = parser.parse_args(argv)
    _setup_logging(args.verbose)

    input_path: Path = args.input_dir
    if not input_path.exists() or not input_path.is_dir():
        logger.error("输入目录 '%s' 不存在或不是目录", input_path)
        sys.exit(1)

    asset_type, bytes_files = find_bytes_files(input_path)

    if asset_type == "none":
        logger.error("未找到 .bytes 文件")
        sys.exit(1)

    # 确定输出目录
    output_dir: Path = args.output or Path(__file__).resolve().parent.parent

    if asset_type == "apk":
        logger.info("检测到: APK 资产 (%d 个清单文件)", len(bytes_files))
        extract_apk_assets(input_path, bytes_files, output_dir)
    elif asset_type == "hotfix":
        logger.info("检测到: 热更资产 (%d 个清单文件)", len(bytes_files))
        extract_hotfix_assets(input_path, bytes_files, output_dir)


if __name__ == "__main__":
    main()
