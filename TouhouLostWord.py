from __future__ import annotations

import argparse
import json
import os
import time
import zipfile
from pathlib import Path
from typing import Any

from rich.console import Console
from rich.markup import escape
from rich.table import Table

import TLWConfig as C

GAME_TITLE = C.GAME_TITLE

console = Console()


APK_BUILTIN_PREFIXES: tuple[tuple[str, str], ...] = (
    (C.APK_ASSETBUNDLE_PREFIX, "assetbundle"),
    (C.APK_MASTER_PREFIX, "master"),
    (C.APK_RESOURCE_PREFIX, "resource"),
)


_STAT_LABELS: dict[str, str] = {
    "total": "总计",
    "ok": "成功",
    "done": "完成",
    "skip": "跳过",
    "skipped": "跳过",
    "fail": "失败",
    "failed": "失败",
    "error": "错误",
    "errors": "错误",
    "bytes": "写入字节",
    "size": "大小",
    "total_size": "总大小",
    "count": "数量",
    "files": "文件",
    "written": "写入",
    "downloaded": "下载",
    "extracted": "提取",
    "updated": "更新",
    "deleted": "删除",
    "apk": "APK",
    "cdn": "CDN",
    "resource": "Resource",
    "assetbundle": "AssetBundle",
    "master": "Master",
    "masterdata": "MasterData",
    "tables": "数据表",
    "bundles": "资源包",
    "elapsed": "耗时(秒)",
    "apk_reused": "APK复用",
    "apk_stale": "APK过期",
    "empty": "空表",
    "rows": "行数",
    "tables_written": "已写表",
    "manifest": "清单文件",
    "failures": "失败明细",
}

_BYTE_KEYS = {"bytes", "size", "total_size", "written_bytes", "downloaded_bytes"}
_FAIL_KEYS = {"fail", "failed", "fails", "error", "errors"}



def human_size(size: Any) -> str:
    try:
        value = float(size)
    except (TypeError, ValueError):
        return str(size)
    for unit in ("B", "KiB", "MiB", "GiB", "TiB"):
        if abs(value) < 1024 or unit == "TiB":
            if unit == "B":
                return f"{value:.0f} B"
            return f"{value:.2f} {unit}"
        value /= 1024
    return f"{value:.2f} TiB"


def _stat_label(key: str) -> str:
    return _STAT_LABELS.get(key, key)


def _format_stat(key: str, value: Any) -> str:
    if value is None:
        return "-"
    if isinstance(value, bool):
        return "是" if value else "否"
    if isinstance(value, (int, float)):
        if key in _BYTE_KEYS:
            return human_size(value)
        if isinstance(value, float):
            return f"{value:.2f}"
        return f"{value:,}"
    if isinstance(value, (list, tuple)):
        if not value:
            return "无"
        shown = ", ".join(str(item)[:60] for item in list(value)[:3])
        suffix = f" ...（共 {len(value)} 项）" if len(value) > 3 else ""
        text = f"{shown}{suffix}"
        return text if len(text) <= 160 else text[:157] + "..."
    if isinstance(value, dict):
        return json.dumps(value, ensure_ascii=False)[:120]
    return str(value)


def _flat_stats_line(stats: dict[str, Any]) -> str:
    parts: list[str] = []
    for key, value in stats.items():
        if isinstance(value, dict):
            continue
        if isinstance(value, (list, tuple)):
            if value:
                parts.append(f"{_stat_label(key)} {len(value)} 项")
            continue
        if value is None:
            continue
        parts.append(f"{_stat_label(key)} {_format_stat(key, value)}")
    return "  ".join(parts) if parts else "无可展示字段"


def _stage_line(stats: dict[str, Any]) -> str:
    parts: list[str] = []
    for key, value in stats.items():
        if isinstance(value, dict):
            continue
        if isinstance(value, (list, tuple)):
            if value:
                parts.append(f"{_stat_label(key)} {len(value)} 项")
            continue
        if value is None:
            continue
        parts.append(f"{_stat_label(key)} {_format_stat(key, value)}")
    return "  ".join(parts) if parts else "无统计字段"


def print_stats(title: str, stats: Any) -> None:
    if stats is None:
        console.print(f"[dim]{title}: 模块未返回统计信息[/dim]")
        return
    if not isinstance(stats, dict):
        console.print(f"[bold cyan]{title}:[/bold cyan] {escape(str(stats))}")
        return

    nested = [(key, value) for key, value in stats.items() if isinstance(value, dict)]
    scalars = {key: value for key, value in stats.items() if not isinstance(value, dict)}

    if not nested:
        console.print(f"[bold cyan]{title}:[/bold cyan] {escape(_flat_stats_line(stats))}")
        return

    columns: list[str] = []
    for _, sub in nested:
        for key in sub:
            if key not in columns:
                columns.append(key)


    if len(nested) <= 8 and len(columns) <= 10:
        table = Table(title=title, header_style="bold cyan", show_lines=False)
        table.add_column("阶段", style="cyan")
        for key in columns:
            table.add_column(_stat_label(key), justify="right")
        for name, sub in nested:
            table.add_row(_stat_label(name), *[_format_stat(key, sub.get(key)) for key in columns])
        console.print(table)
    else:
        console.print(f"[bold cyan]{title}:[/bold cyan]")
        for name, sub in nested:
            console.print(f"  [cyan]{_stat_label(name)}[/cyan]  {escape(_stage_line(sub))}")
    if scalars:
        console.print("  " + escape(_flat_stats_line(scalars)))


def _has_failures(stats: Any) -> bool:
    if not isinstance(stats, dict):
        return False
    for key, value in stats.items():
        lowered = key.lower()
        if lowered in _FAIL_KEYS:
            if isinstance(value, bool):
                if value:
                    return True
            elif isinstance(value, (int, float)):
                if value > 0:
                    return True
            elif isinstance(value, (list, tuple, set)):
                if value:
                    return True
            elif isinstance(value, dict):
                if _has_failures(value):
                    return True
        elif isinstance(value, dict) and _has_failures(value):
            return True
    return False


def _exit_code(stats: Any) -> int:
    return 1 if _has_failures(stats) else 0



def resolve_apk(args: argparse.Namespace) -> Path | None:
    raw = getattr(args, "apk", None)
    if raw:
        return Path(raw).expanduser()
    return C.find_default_apk()


def dir_stats(path: Path) -> tuple[int, int]:
    files = 0
    total = 0
    stack: list[Path] = [path]
    while stack:
        current = stack.pop()
        try:
            with os.scandir(current) as entries:
                for entry in entries:
                    try:
                        if entry.is_dir(follow_symlinks=False):
                            stack.append(Path(entry.path))
                        elif entry.is_file(follow_symlinks=False):
                            files += 1
                            total += entry.stat(follow_symlinks=False).st_size
                    except OSError:
                        continue
        except OSError:
            continue
    return files, total


def apk_builtin_counts(apk: Path) -> dict[str, int]:
    counts = {label: 0 for _, label in APK_BUILTIN_PREFIXES}
    counts["entries"] = 0
    counts["data_unity3d"] = 0
    with zipfile.ZipFile(apk) as archive:
        for info in archive.infolist():
            counts["entries"] += 1
            if info.is_dir():
                continue
            name = info.filename
            for prefix, label in APK_BUILTIN_PREFIXES:
                if name.startswith(prefix):
                    counts[label] += 1
                    break
            if name == C.APK_UNITY_DATA:
                counts["data_unity3d"] = 1
    return counts


def _local_dirs() -> list[tuple[str, Path]]:
    return [
        ("Assets（总计）", C.ASSETS_DIR),
        ("  assetbundle/android", C.ASSETBUNDLE_OUT_DIR),
        ("  resource", C.RESOURCE_OUT_DIR),
        ("  master", C.MASTER_OUT_DIR),
        ("MasterData（总计）", C.MASTER_DIR),
        ("  Tables", C.MASTERDATA_TABLES_DIR),
        ("  Config", C.MASTERDATA_CONFIG_DIR),
        ("_cache（缓存）", C.CACHE_DIR),
    ]




def cmd_status(args: argparse.Namespace) -> int:
    console.print(f"[bold cyan]=== 《{GAME_TITLE}》本地与远端状态 ===[/bold cyan]\n")
    rc = 0

    apk = resolve_apk(args)
    if apk is None:
        console.print("[yellow]! 未找到本地 APK：当前目录没有匹配的 *.apk，可用 --apk 指定[/yellow]")
    elif not apk.is_file():
        console.print(f"[red]APK 不存在:[/red] {escape(str(apk))}")
        rc = 1
    else:
        try:
            stat = apk.stat()
            counts = apk_builtin_counts(apk)
        except Exception as ex:  # noqa: BLE001
            console.print(f"[red]读取 APK 失败:[/red] {type(ex).__name__}: {escape(str(ex))}")
            rc = 1
        else:
            table = Table(title="APK 与内置资源", header_style="bold cyan")
            table.add_column("项目", style="cyan")
            table.add_column("值", justify="right")
            table.add_row("文件", escape(apk.name))
            table.add_row("路径", escape(str(apk)))
            table.add_row("大小", human_size(stat.st_size))
            table.add_row(
                "修改时间",
                time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(stat.st_mtime)),
            )
            table.add_row("zip 条目数", f"{counts['entries']:,}")
            table.add_row("内置 assetbundle", f"{counts['assetbundle']:,}")
            table.add_row("内置 master", f"{counts['master']:,}")
            table.add_row("内置 resource", f"{counts['resource']:,}")
            table.add_row("data.unity3d", "有" if counts["data_unity3d"] else "无")
            console.print(table)

    console.print()
    manifest_table = Table(title="CDN 热更清单", header_style="bold cyan")
    manifest_table.add_column("类别", style="cyan")
    manifest_table.add_column("版本目录")
    manifest_table.add_column("缓存状态")
    manifest_table.add_column("条目数", justify="right")
    manifest_table.add_column("总大小", justify="right")
    manifest_table.add_column("清单地址")
    missing_manifest = False
    for category, meta in C.CATEGORIES.items():
        cache = C.MANIFEST_CACHE_DIR / f"{category}.json"
        manifest: dict | None = None
        cache_desc = "[yellow]未缓存[/yellow]"
        if getattr(args, "refresh", False):
            try:
                import TLWHotUpdate

                manifest = TLWHotUpdate.load_manifest(category, refresh=True)
                cache_desc = "[green]已刷新[/green]"
            except Exception as ex:  # noqa: BLE001
                console.print(
                    f"[red]刷新 {category} 清单失败:[/red] "
                    f"{type(ex).__name__}: {escape(str(ex))}"
                )
                rc = 1
                cache_desc = "[red]刷新失败[/red]"
        elif cache.is_file():
            try:
                manifest = json.loads(cache.read_bytes())
                cache_desc = "[green]已缓存[/green] " + time.strftime(
                    "%m-%d %H:%M", time.localtime(cache.stat().st_mtime)
                )
            except Exception as ex:  # noqa: BLE001
                cache_desc = "[red]缓存损坏[/red]"
                console.print(
                    f"[yellow]清单缓存无法解析 {escape(str(cache))}:[/yellow] "
                    f"{type(ex).__name__}: {escape(str(ex))}"
                )
        if manifest is None:
            missing_manifest = True
            manifest_table.add_row(
                meta["desc"],
                meta["dir_name"],
                cache_desc,
                "-",
                "-",
                escape(C.manifest_url(category)),
            )
            continue
        entries = manifest.get("AssetInfos") or []
        total_size = sum(int(entry.get("Size") or 0) for entry in entries)
        manifest_table.add_row(
            meta["desc"],
            meta["dir_name"],
            cache_desc,
            f"{len(entries):,}",
            human_size(total_size),
            escape(C.manifest_url(category)),
        )
    console.print(manifest_table)
    if missing_manifest and not getattr(args, "refresh", False):
        console.print(
            "[dim]提示: 运行 python3 TouhouLostWord.py status --refresh "
            "可下载 / 刷新三份 CDN 清单[/dim]"
        )

    console.print()
    local_table = Table(title="本地导出统计", header_style="bold cyan")
    local_table.add_column("输出目录", style="cyan")
    local_table.add_column("文件数", justify="right")
    local_table.add_column("总大小", justify="right")
    local_table.add_column("路径")
    for label, path in _local_dirs():
        files, total = dir_stats(path)
        suffix = "" if path.is_dir() else " [yellow](不存在)[/yellow]"
        local_table.add_row(label, f"{files:,}", human_size(total), escape(str(path)) + suffix)
    console.print(local_table)
    return rc




def cmd_assets(args: argparse.Namespace) -> int:
    apk = resolve_apk(args)
    jobs = getattr(args, "jobs", C.DEFAULT_JOBS)
    force = getattr(args, "force", False)
    refresh = getattr(args, "refresh", False)
    limit = getattr(args, "limit", 0)
    skip_apk = getattr(args, "skip_apk", False)
    skip_cdn = getattr(args, "skip_cdn", False)
    skip_resource = getattr(args, "skip_resource", False)

    console.print(f"[bold cyan]=== 导出资产到 {escape(str(C.ASSETS_DIR))} ===[/bold cyan]")
    if apk is not None:
        console.print(f"[cyan]APK:[/cyan] {escape(str(apk))}")
    elif not skip_apk:
        console.print(
            "[yellow]! 未找到本地 APK，将跳过 APK 预热只从 CDN 下载 "
            "（可用 --apk 指定，或加 --skip-apk 显式跳过）[/yellow]"
        )
    console.print(
        f"[cyan]并发:[/cyan] {jobs}  [cyan]限制:[/cyan] {limit or '无'}  "
        f"[cyan]强制:[/cyan] {'是' if force else '否'}  "
        f"[cyan]刷新清单:[/cyan] {'是' if refresh else '否'}"
    )

    try:
        import TLWAsset
    except Exception as ex:  # noqa: BLE001
        console.print(f"[red]导入 TLWAsset 失败:[/red] {type(ex).__name__}: {escape(str(ex))}")
        return 1

    started = time.monotonic()
    try:
        stats = TLWAsset.export_assets(
            apk=apk,
            jobs=jobs,
            force=force,
            refresh=refresh,
            limit=limit,
            skip_apk=skip_apk,
            skip_cdn=skip_cdn,
            skip_resource=skip_resource,
        )
    except KeyboardInterrupt:
        raise
    except Exception as ex:  # noqa: BLE001
        console.print(f"[red]资产导出失败:[/red] {type(ex).__name__}: {escape(str(ex))}")
        return 1

    print_stats("资产导出统计", stats)
    code = _exit_code(stats)
    console.print(
        f"[green]assets 完成，耗时 {time.monotonic() - started:.1f}s，退出码 {code}[/green]"
    )
    return code


def cmd_masterdata(args: argparse.Namespace) -> int:
    jobs = getattr(args, "jobs", C.DEFAULT_JOBS)
    force = getattr(args, "force", False)
    refresh = getattr(args, "refresh", False)
    limit = getattr(args, "limit", 0)

    console.print(f"[bold cyan]=== 导出 MasterData 到 {escape(str(C.MASTER_DIR))} ===[/bold cyan]")
    console.print(
        f"[cyan]并发:[/cyan] {jobs}  [cyan]限制:[/cyan] {limit or '无'}  "
        f"[cyan]强制:[/cyan] {'是' if force else '否'}  "
        f"[cyan]刷新清单:[/cyan] {'是' if refresh else '否'}"
    )

    try:
        import TLWMasterData
    except Exception as ex:  # noqa: BLE001
        console.print(
            f"[red]导入 TLWMasterData 失败:[/red] {type(ex).__name__}: {escape(str(ex))}"
        )
        return 1

    started = time.monotonic()
    try:
        stats = TLWMasterData.export_masterdata(
            jobs=jobs,
            force=force,
            refresh=refresh,
            limit=limit,
        )
    except KeyboardInterrupt:
        raise
    except Exception as ex:  # noqa: BLE001
        console.print(f"[red]MasterData 导出失败:[/red] {type(ex).__name__}: {escape(str(ex))}")
        return 1

    print_stats("MasterData 导出统计", stats)
    code = _exit_code(stats)
    console.print(
        f"[green]masterdata 完成，耗时 {time.monotonic() - started:.1f}s，退出码 {code}[/green]"
    )
    return code


def cmd_all(args: argparse.Namespace) -> int:
    started = time.monotonic()
    console.print(f"[bold green]=== 《{GAME_TITLE}》全量导出：资产 → 数据表 ===[/bold green]")
    steps: tuple[tuple[str, str, Any], ...] = (
        ("assets", "资产（APK 内置 + CDN 热更）", cmd_assets),
        ("masterdata", "MasterData 数据表", cmd_masterdata)
    )
    results: list[tuple[str, int]] = []
    for index, (_, label, handler) in enumerate(steps, 1):
        console.print(f"\n[bold cyan]━━━ [{index}/{len(steps)}] {label} ━━━[/bold cyan]")
        try:
            rc = handler(args)
        except KeyboardInterrupt:
            raise
        except Exception as ex:  # noqa: BLE001
            console.print(f"[red]{label} 异常:[/red] {type(ex).__name__}: {escape(str(ex))}")
            rc = 1
        results.append((label, rc))
        if rc != 0:
            console.print(f"[yellow]! {label} 失败（退出码 {rc}），继续执行后续阶段[/yellow]")

    console.print()
    table = Table(title="全量导出结果", header_style="bold cyan")
    table.add_column("阶段", style="cyan")
    table.add_column("结果", justify="right")
    for label, rc in results:
        table.add_row(label, "[green]成功[/green]" if rc == 0 else f"[red]失败（退出码 {rc}）[/red]")
    table.add_row("总耗时", f"{time.monotonic() - started:.1f}s")
    console.print(table)
    return 0 if all(rc == 0 for _, rc in results) else 1


HANDLERS = {
    "status": cmd_status,
    "assets": cmd_assets,
    "masterdata": cmd_masterdata,
    "all": cmd_all,
}




def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument(
        "--apk",
        default=argparse.SUPPRESS,
        help="APK 文件路径，省略时自动匹配当前目录下的 *.apk",
    )
    shared.add_argument(
        "--jobs",
        type=int,
        default=argparse.SUPPRESS,
        help=f"并发处理线程数（默认 {C.DEFAULT_JOBS}）",
    )
    shared.add_argument(
        "--force",
        action="store_true",
        default=argparse.SUPPRESS,
        help="忽略本地已有文件，强制重新处理",
    )
    shared.add_argument(
        "--refresh",
        action="store_true",
        default=argparse.SUPPRESS,
        help="强制重新下载 CDN 清单 / 远端元数据",
    )
    shared.add_argument(
        "--limit",
        type=int,
        default=argparse.SUPPRESS,
        help="最多处理多少个条目，用于小样本调试（0 为不限制）",
    )

    parser = argparse.ArgumentParser(
        description=f"《{GAME_TITLE}》资源 / 数据表 一键导出工具",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        parents=[shared],
    )
    sub = parser.add_subparsers(dest="command", metavar="<子命令>", title="子命令")

    sub.add_parser("status", parents=[shared], help="查看 APK、CDN 清单与本地导出统计")

    p_assets = sub.add_parser(
        "assets", parents=[shared], help="提取 APK 内置资产并同步 CDN 热更资源到 Assets/"
    )
    p_assets.add_argument("--skip-apk", action="store_true", help="跳过 APK 内置资产预热")
    p_assets.add_argument("--skip-cdn", action="store_true", help="跳过 CDN 热更下载，只处理 APK 内置资产")
    p_assets.add_argument("--skip-resource", action="store_true", help="跳过 Resource 资源，只处理 assetbundle")

    sub.add_parser(
        "masterdata", parents=[shared], help="下载并解密 MasterData，转成 JSON 输出到 MasterData/Tables/"
    )
    p_all = sub.add_parser("all", parents=[shared], help="依次执行 assets、masterdata")
    p_all.add_argument("--skip-apk", action="store_true", help="assets 阶段：跳过 APK 内置资产预热")
    p_all.add_argument("--skip-cdn", action="store_true", help="assets 阶段：跳过 CDN 热更下载")
    p_all.add_argument("--skip-resource", action="store_true", help="assets 阶段：跳过 Resource 资源")

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    command = getattr(args, "command", None)
    if not command:
        parser.print_help()
        return 0

    handler = HANDLERS.get(command)
    if handler is None:
        parser.error(f"未知子命令: {command}")
        return 2

    if command != "status":
        C.ensure_dirs()

    try:
        return handler(args)
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        return 130
    except Exception as ex:  # noqa: BLE001
        console.print(f"[red]执行失败:[/red] {type(ex).__name__}: {escape(str(ex))}")
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
