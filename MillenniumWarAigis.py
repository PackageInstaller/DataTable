from __future__ import annotations

import argparse
import sys
from pathlib import Path

import Config


def cmd_assets(args: argparse.Namespace) -> None:
    """下载/更新资产并提取；给了目录就只解析本地目录。"""
    import AssetPipeline

    if args.directory:
        stats = AssetPipeline.process_tree(
            Path(args.directory),
            Config.ASSETS_DIR,
            jobs=args.jobs,
            verbose=args.verbose,
        )
        print(f"[assets] {args.directory} -> {stats}")
        return

    import HotUpdate

    entries = HotUpdate.load_manifest(args.name, refresh=args.refresh)
    HotUpdate.download(
        entries,
        jobs=args.jobs,
        on_entry=lambda entry, data, cached: AssetPipeline.process_bytes(
            entry.name, data, root=Config.ASSETS_DIR, rel=Path(entry.name)
        ),
    )


def cmd_painting(args: argparse.Namespace) -> None:
    """导出角色立绘：表/资产不在本地会先按清单下载。"""
    import Painting

    Painting.export(
        jobs=args.jobs,
        limit=args.limit,
        force=args.force,
        include_sp=not args.no_sp,
    )


def cmd_masterdata(args: argparse.Namespace) -> None:
    """只拉数据表（atb/ard）并转成 indent=2 的 JSON；给了目录就用本地文件。"""
    import MasterData

    if args.directory:
        MasterData.convert([Path(args.directory)], out_dir=Config.MASTER_DIR)
        return

    import AlManifest
    import HotUpdate

    entries = AlManifest.filter_entries(
        HotUpdate.load_manifest(args.name, refresh=args.refresh), suffixes=("atb", "ard")
    )
    tables_dir = Config.CACHE_DIR / "tables"
    HotUpdate.download(
        entries,
        jobs=args.jobs,
        on_entry=lambda entry, data, cached: _write_table(tables_dir, entry.name, data),
    )
    MasterData.convert([tables_dir], out_dir=Config.MASTER_DIR)


def _write_table(root: Path, name: str, data: bytes) -> None:
    target = root / name
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)


def build_parser() -> argparse.ArgumentParser:
    common = argparse.ArgumentParser(add_help=False)
    common.add_argument("--jobs", type=int, default=8, help="下载并发（默认 8）")
    common.add_argument(
        "--name", choices=("base", "full"), default="base", help="清单版本（默认 base）"
    )
    common.add_argument("--refresh", action="store_true", help="强制重新下载清单")
    common.add_argument("-v", "--verbose", action="store_true")
    common.add_argument("--limit", type=int, default=0, help="最多导出多少个立绘包（调试用）")
    common.add_argument("--force", action="store_true", help="已存在的立绘也重新导出")
    common.add_argument("--no-sp", action="store_true", help="不导出 SP（另一套服装）立绘")

    parser = argparse.ArgumentParser(
        description="千年戦争アイギスR 资源 / 数据表还原", parents=[common]
    )
    sub = parser.add_subparsers(dest="command")
    for name, help_text in (
        ("assets", "下载/更新资产并提取（给目录则解析本地目录）"),
        ("masterdata", "只拉数据表并转 JSON（给目录则用本地文件）"),
        ("painting", "导出角色立绘到 Painting/（缺表/缺资产会先下载）"),
    ):
        child = sub.add_parser(name, parents=[common], help=help_text)
        child.add_argument("directory", nargs="?", help="本地目录（可选）")
    return parser


HANDLERS = {
    "assets": cmd_assets,
    "masterdata": cmd_masterdata,
    "painting": cmd_painting,
}


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    Config.ensure_dirs()
    command = args.command or "assets"
    print(f"[aigis] Assets={Config.ASSETS_DIR}  MasterData={Config.MASTER_DIR}")
    HANDLERS[command](args)
    return 0


if __name__ == "__main__":
    sys.exit(main())
