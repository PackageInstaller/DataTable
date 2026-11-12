from __future__ import annotations

import argparse
import subprocess
import tempfile
import zipfile
from pathlib import Path
from typing import Any

import requests
from rich.console import Console
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn
)
from rich.table import Table

from StellaArchive import StellaArchive
from StellaAsset import StellaAssetManager
from StellaCrypto import (
    REGION_CONFIGS,
    decrypt_aes_meta,
    depad_asset_data,
    get_cdn_url,
    md5_bytes,
    md5_file,
    parse_meta_manifest,
)
from StellaLua import export_lua_all
from StellaTable import export_tables_all, parse_table_defines_from_lua, write_language_tables
from StellaDHE import decompile_dll_to_csharp, rebuild_dhe_dll
from StellaPainting import export_paintings_all

GAME_TITLE = "星塔旅人"
SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
DEFAULT_JOBS = 16
DEFAULT_LANGUAGE = "zh_cn"
ALL_LANGUAGES = ("zh_cn", "zh_tw", "ja_jp", "ko_kr", "en_us")
REGION_CACHE_DIR = SCRIPT_DIR / ".cache" / "regions"
CORE_ARCHIVE_NAMES = ("data.arcx", "lua.arcx", "hotfix.arch")

console = Console()


def find_default_apk() -> Path | None:
    for candidate in SCRIPT_DIR.glob("*.apk"):
        return candidate
    return None


def cmd_status(args: argparse.Namespace) -> int:
    console.print(f"[bold cyan]=== 《{GAME_TITLE}》客户端与远端状态 ===[/bold cyan]\n")

    apk_path = Path(args.apk) if args.apk else find_default_apk()
    if apk_path and apk_path.exists():
        apk_size_mb = apk_path.stat().st_size / (1024 * 1024)
        with zipfile.ZipFile(apk_path, "r") as z:
            builtin_assets = [
                n for n in z.namelist() if n.startswith("assets/InstallResource/") and not n.endswith("/")
            ]
        console.print(f"[green]✓ 本地 APK:[/green] {apk_path.name} ({apk_size_mb:.1f} MB, 内置资产 {len(builtin_assets)} 个)")
    else:
        console.print("[yellow]! 本地 APK: 未找到[/yellow]")

    region = getattr(args, "region", "cn")
    reg_info = REGION_CONFIGS.get(region, REGION_CONFIGS["cn"])
    console.print(f"[bold cyan]当前选定区服:[/bold cyan] {reg_info['desc']} ({reg_info['cdn_host']})")

    if not reg_info.get("meta_key"):
        console.print(f"[yellow]提示: {reg_info['desc']} 尚未配置解密密钥 (serverMetaKey)。[/yellow]")
        console.print(f"[dim]该区服 CDN 服务真实存活，提供对应服的客户端 APK/data.unity3d 即可提取密钥并导出对应语言数据表。[/dim]")
    else:
        console.print(f"[cyan]正在获取 {reg_info['desc']} CDN 服务端清单...[/cyan]")
        try:
            meta_url = f"{reg_info['cdn_host']}/meta/and.html"
            resp = requests.get(meta_url, timeout=(10, 30))
            resp.raise_for_status()
            decrypted = decrypt_aes_meta(resp.content, reg_info["meta_key"])
            manifest = parse_meta_manifest(decrypted)
            console.print(f"[green]✓ CDN 索引:[/green] 获取成功，总计收录 [bold]{len(manifest)}[/bold] 个远端资产")

            table = Table(title=f"核心数据归档信息 ({reg_info['desc']})")
            table.add_column("归档文件", style="cyan")
            table.add_column("版本号", style="magenta")
            table.add_column("MD5", style="green")
            table.add_column("CDN 下载路径", style="white")

            for key in ["data.arcx", "lua.arcx", "hotfix.arch", "ss_and_add.mani", "ss_and.mani"]:
                if key in manifest:
                    it = manifest[key]
                    url = get_cdn_url(key, manifest, host=reg_info["cdn_host"])
                    table.add_row(key, str(it["ver"]), it["md5"], url or "N/A")

            console.print(table)
        except Exception as ex:
            console.print(f"[red]获取 CDN 远端信息失败:[/red] {ex}")
            return 1

    assets_count = len(list(ASSETS_DIR.glob("*"))) if ASSETS_DIR.exists() else 0
    tables_count = len(list((MASTER_DIR / "Tables").glob("*.json"))) if (MASTER_DIR / "Tables").exists() else 0
    lua_count = len(list((MASTER_DIR / "Lua").rglob("*.lua"))) if (MASTER_DIR / "Lua").exists() else 0

    painting_count = len(list((SCRIPT_DIR / "Painting").rglob("*.png"))) if (SCRIPT_DIR / "Painting").exists() else 0
    languages = sorted(p.name for p in (MASTER_DIR / "Language").iterdir()) if (MASTER_DIR / "Language").exists() else []

    console.print(f"\n[green]✓ 本地 Assets 目录:[/green] {assets_count} 个文件 -> {ASSETS_DIR}")
    console.print(f"[green]✓ 本地 MasterData 表格:[/green] {tables_count} 个 JSON -> {MASTER_DIR / 'Tables'}")
    console.print(f"[green]✓ 本地 MasterData Lua:[/green] {lua_count} 个源码脚本 -> {MASTER_DIR / 'Lua'}")
    console.print(f"[green]✓ 本地 MasterData 语言表:[/green] {len(languages)} 种 ({', '.join(languages) or '无'}) -> {MASTER_DIR / 'Language'}")
    console.print(f"[green]✓ 本地 Painting 立绘:[/green] {painting_count} 张 -> {SCRIPT_DIR / 'Painting'}")
    return 0


def cmd_assets(args: argparse.Namespace) -> int:
    apk_path = Path(args.apk) if args.apk else find_default_apk()
    jobs = getattr(args, "jobs", DEFAULT_JOBS)
    force = getattr(args, "force", False)
    skip_apk = getattr(args, "skip_apk", False)
    skip_cdn = getattr(args, "skip_cdn", False)
    limit = getattr(args, "limit", 0)
    region = getattr(args, "region", "cn")
    reg_info = REGION_CONFIGS.get(region, REGION_CONFIGS["cn"])

    console.print(f"[bold cyan]=== 开始整合并还原资产到 {ASSETS_DIR} ({reg_info['desc']}) ===[/bold cyan]")
    manager = StellaAssetManager(
        assets_dir=ASSETS_DIR,
        apk_path=apk_path,
        console=console,
        cdn_host=reg_info["cdn_host"],
        meta_key=reg_info["meta_key"],
    )

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        if not skip_apk and apk_path and apk_path.exists():
            apk_ok, apk_skip, apk_fail = manager.extract_from_apk(force=force, progress=progress)
            console.print(
                f"[bold green]APK 资产提取完成:[/bold green] 写入 {apk_ok}  跳过 {apk_skip}  失败 {apk_fail}"
            )
        dl_ok = dl_skip = dl_fail = 0
        if not skip_cdn:
            console.print("[cyan]正在获取最新热更资源清单...[/cyan]")
            manifest = manager.fetch_remote_manifest()
            dl_ok, dl_skip, dl_fail = manager.download_and_sync(
                manifest=manifest, jobs=jobs, force=force, limit=limit, progress=progress
            )
            console.print(
                f"[bold green]CDN 热更同步完成:[/bold green] 下载 {dl_ok}  跳过 {dl_skip}  失败 {dl_fail}"
            )

    return 0 if (not skip_apk and apk_path and apk_path.exists()) or dl_ok > 0 or dl_skip > 0 else 1


def _download_core_archive(url: str, dest: Path, expected_md5: str, attempts: int = 5) -> Path:
    tmp_path = dest.with_name(dest.name + ".part")
    last_error: Exception | None = None
    for attempt in range(1, attempts + 1):
        try:
            start = tmp_path.stat().st_size if tmp_path.exists() else 0
            headers = {"Range": f"bytes={start}-"} if start > 0 else {}
            resp = requests.get(url, headers=headers, timeout=(15, 600), stream=True)
            if resp.status_code == 416:
                tmp_path.unlink(missing_ok=True)
                raise ValueError("HTTP 416，重置下载")
            if resp.status_code == 200 and start > 0:
                start = 0
            resp.raise_for_status()
            with open(tmp_path, "ab" if start > 0 else "wb") as f:
                for chunk in resp.iter_content(chunk_size=1024 * 1024):
                    if chunk:
                        f.write(chunk)
            payload = depad_asset_data(tmp_path.read_bytes())
            if expected_md5 and md5_bytes(payload).lower() != expected_md5:
                tmp_path.unlink(missing_ok=True)
                raise ValueError("MD5 校验失败")
            dest.write_bytes(payload)
            tmp_path.unlink(missing_ok=True)
            return dest
        except Exception as ex:
            last_error = ex
            if console is not None:
                console.print(
                    f"[yellow]{dest.name} 下载中断 ({attempt}/{attempts})，重试...[/yellow] "
                    f"{type(ex).__name__}: {ex}"
                )
    raise RuntimeError(f"{dest.name} 下载失败: {last_error}")


def _ensure_region_archives(
    region: str,
    names: tuple[str, ...] = CORE_ARCHIVE_NAMES,
) -> dict[str, Path]:
    reg_info = REGION_CONFIGS.get(region, REGION_CONFIGS["cn"])
    cache_dir = REGION_CACHE_DIR / region
    cache_dir.mkdir(parents=True, exist_ok=True)

    manager = StellaAssetManager(
        assets_dir=cache_dir,
        console=console,
        cdn_host=reg_info["cdn_host"],
        meta_key=reg_info["meta_key"],
    )
    manifest = manager.fetch_remote_manifest()

    result: dict[str, Path] = {}
    for filename in names:
        entry = manifest.get(filename) or {}
        expected_md5 = (entry.get("md5") or "").lower()

        found: Path | None = None
        for candidate in (cache_dir / filename, ASSETS_DIR / filename):
            if not candidate.is_file():
                continue
            if expected_md5:
                if md5_file(candidate).lower() == expected_md5:
                    found = candidate
                    break
            else:
                found = candidate
                break

        if found is None:
            url = get_cdn_url(filename, manifest, host=reg_info["cdn_host"])
            if not url:
                raise FileNotFoundError(f"无法在 CDN 清单中解析 {region}/{filename} 下载地址")
            console.print(f"[cyan]正在从 {reg_info['desc']} CDN 下载 {filename}...[/cyan]")
            found = _download_core_archive(url, cache_dir / filename, expected_md5)

        result[filename] = found

    missing = [name for name in names if name not in result]
    if missing:
        raise FileNotFoundError(f"{region}: 缺少核心归档 {missing}")
    return result


def cmd_masterdata(args: argparse.Namespace) -> int:
    jobs = getattr(args, "jobs", DEFAULT_JOBS)
    force = getattr(args, "force", False)
    lang_arg = getattr(args, "lang", "all")
    region = getattr(args, "region", "cn")
    reg_info = REGION_CONFIGS.get(region, REGION_CONFIGS["cn"])
    export_all_languages = lang_arg == "all"

    console.print(f"[bold cyan]=== 开始解析并导出数据表与 Lua 到 {MASTER_DIR} ({reg_info['desc']}) ===[/bold cyan]")
    if export_all_languages:
        console.print("[cyan]语言:[/cyan] all（自动下载各区服 data.arcx 并导出全部语言表）")
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)

    try:
        primary_archives = _ensure_region_archives(region)
        data_path = primary_archives["data.arcx"]
        lua_path = primary_archives["lua.arcx"]
        hotfix_path = primary_archives.get("hotfix.arch")
    except Exception as ex:
        console.print(f"[yellow]从 CDN 获取 {reg_info['desc']} 归档失败 ({ex})，尝试使用本地已有归档[/yellow]")
        data_path = ASSETS_DIR / "data.arcx"
        lua_path = ASSETS_DIR / "lua.arcx"
        hotfix_path = ASSETS_DIR / "hotfix.arch"
        if not data_path.exists() and Path("/tmp/data.arcx").exists():
            data_path = Path("/tmp/data.arcx")
        if not lua_path.exists() and Path("/tmp/lua.arcx").exists():
            lua_path = Path("/tmp/lua.arcx")
        if not hotfix_path.exists() and Path("/tmp/hotfix.arch").exists():
            hotfix_path = Path("/tmp/hotfix.arch")

    if not data_path.exists() or not lua_path.exists():
        console.print("[red]错误: 缺少 data.arcx 或 lua.arcx，无法导出数据表[/red]")
        return 1

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        console.print("[cyan]正在加载 lua.arcx 归档...[/cyan]")
        lua_archive = StellaArchive.from_file(lua_path)
        lua_dir = MASTER_DIR / "Lua"

        lua_ok, lua_skip, lua_fail = export_lua_all(
            archive=lua_archive,
            output_dir=lua_dir,
            jobs=jobs,
            force=force,
            console=console,
            progress=progress,
        )
        console.print(
            f"[bold green]Lua 导出与反编译完成:[/bold green] 成功 {lua_ok}  跳过 {lua_skip}  失败 {lua_fail} → {lua_dir}"
        )
        pb_file = MASTER_DIR / "table.pb"
        if not pb_file.exists():
            pb_bytes = lua_archive.read_file("Game/CodeGen/table.pb")
            if pb_bytes:
                pb_file.write_bytes(pb_bytes)
        pb_bytes = pb_file.read_bytes()

        define_file = lua_dir / "Game" / "CodeGen" / "GAME_TABLE_DEFINE.lua"
        if define_file.exists():
            lua_define_text = define_file.read_text(encoding="utf-8")
        elif Path("/tmp/GAME_TABLE_DEFINE.lua").exists():
            lua_define_text = Path("/tmp/GAME_TABLE_DEFINE.lua").read_text(encoding="utf-8")
        else:
            define_bytes = lua_archive.read_file("Game/CodeGen/GAME_TABLE_DEFINE.lua")
            if not define_bytes:
                raise FileNotFoundError("无法提取 GAME_TABLE_DEFINE.lua")
            tmp_c = Path(tempfile.gettempdir()) / "tmp_def.luac"
            tmp_c.write_bytes(define_bytes)
            res = subprocess.run(["unluac", str(tmp_c)], capture_output=True, text=True, check=True)
            lua_define_text = res.stdout
            tmp_c.unlink(missing_ok=True)

        table_defines = parse_table_defines_from_lua(lua_define_text)
        console.print("[cyan]正在加载 data.arcx 归档...[/cyan]")
        data_archive = StellaArchive.from_file(data_path)
        primary_language = reg_info["default_lang"]
        language_archive = None

        if export_all_languages:
            language_sources: list[tuple[str, Path]] = []
            seen_languages: set[str] = set()
            for lang_region, lang_reg_info in REGION_CONFIGS.items():
                lang = lang_reg_info["default_lang"]
                if lang in seen_languages:
                    continue
                seen_languages.add(lang)
                try:
                    if lang_region == region:
                        lang_data_path = data_path
                    else:
                        lang_data_path = _ensure_region_archives(
                            lang_region, names=("data.arcx",)
                        )["data.arcx"]
                    language_sources.append((lang, lang_data_path))
                except Exception as ex:
                    console.print(f"[yellow]跳过 {lang_reg_info['desc']} 语言表 ({ex})[/yellow]")

            console.print(f"[cyan]正在导出全部语言表 ({len(language_sources)} 种)...[/cyan]")
            for lang, lang_data_path in language_sources:
                lang_archive = StellaArchive.from_file(lang_data_path)
                lang_ok, lang_skip, lang_fail = write_language_tables(
                    data_archive=lang_archive,
                    table_defines=table_defines,
                    language=lang,
                    output_dir=MASTER_DIR,
                    force=force,
                    console=console,
                )
                console.print(
                    f"  语言表 [bold]{lang}[/bold]: 写入 {lang_ok}  跳过 {lang_skip}  失败 {lang_fail}"
                )
        else:
            if lang_arg != primary_language:
                for lang_region, lang_reg_info in REGION_CONFIGS.items():
                    if lang_reg_info["default_lang"] != lang_arg:
                        continue
                    try:
                        language_archive = StellaArchive.from_file(
                            _ensure_region_archives(lang_region, names=("data.arcx",))["data.arcx"]
                        )
                    except Exception as ex:
                        console.print(f"[yellow]获取 {lang_arg} 语言表失败 ({ex})[/yellow]")
                    break

        tbl_ok, tbl_skip, tbl_fail = export_tables_all(
            data_archive=data_archive,
            pb_bytes=pb_bytes,
            table_defines=table_defines,
            output_dir=MASTER_DIR,
            language=primary_language if export_all_languages else lang_arg,
            force=force,
            console=console,
            progress=progress,
            language_archive=language_archive,
        )
        console.print(
            f"[bold green]数据表导出 JSON 完成:[/bold green] 成功 {tbl_ok}  跳过 {tbl_skip}  失败 {tbl_fail} → {MASTER_DIR / 'Tables'}"
        )

        so_arg = getattr(args, "so", None)
        if hotfix_path and hotfix_path.exists():
            try:
                with zipfile.ZipFile(hotfix_path, "r") as z:
                    for zname in z.namelist():
                        if zname.endswith(".dll"):
                            out_dll = MASTER_DIR / zname
                            raw_dll = z.read(zname)
                            if raw_dll.startswith(b"CDPH"):
                                console.print(f"[bold cyan]正在解密还原 DHE 热更 DLL:[/bold cyan] {zname}...")
                                try:
                                    raw_dll = rebuild_dhe_dll(raw_dll, so_path=so_arg)
                                    console.print(f"[bold green]热更 DLL 重建成功 (PE/CLI):[/bold green] {out_dll} ({len(raw_dll)} 字节)")
                                except Exception as err:
                                    console.print(f"[bold red]热更 DLL 重建异常，保留原始容器:[/bold red] {err}")
                            out_dll.write_bytes(raw_dll)
            except Exception as ex:
                console.print(f"[yellow]提取 hotfix.arch 失败:[/yellow] {ex}")
        elif (MASTER_DIR / "Hotfix.dll").exists():
            existing_dll = MASTER_DIR / "Hotfix.dll"
            data = existing_dll.read_bytes()
            if data.startswith(b"CDPH"):
                console.print(f"[bold cyan]检测到本地未解密的 Hotfix.dll (CDPH)，正在还原...[/bold cyan]")
                try:
                    rebuilt = rebuild_dhe_dll(data, so_path=so_arg)
                    existing_dll.write_bytes(rebuilt)
                    console.print(f"[bold green]热更 DLL 重建成功 (PE/CLI):[/bold green] {existing_dll} ({len(rebuilt)} 字节)")
                except Exception as err:
                    console.print(f"[bold red]热更 DLL 重建异常:[/bold red] {err}")

        hotfix_dll_file = MASTER_DIR / "Hotfix.dll"
        if hotfix_dll_file.exists():
            dll_ref_dir = SCRIPT_DIR / "dll"
            decompile_dll_to_csharp(
                dll_path=hotfix_dll_file,
                output_dir=MASTER_DIR / "Hotfix",
                ref_dir=dll_ref_dir,
                force=args.force,
                console=console,
            )

    return 0


def cmd_painting(args: argparse.Namespace) -> int:
    jobs = getattr(args, "jobs", DEFAULT_JOBS)
    force = getattr(args, "force", False)
    region = getattr(args, "region", "cn")
    reg_info = REGION_CONFIGS.get(region, REGION_CONFIGS["cn"])
    painting_dir = SCRIPT_DIR / "Painting"

    console.print(f"[bold cyan]=== 开始导出角色立绘到 {painting_dir} ({reg_info['desc']}) ===[/bold cyan]")
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    char2d_dir = ASSETS_DIR / "char" / "2d"

    try:
        manager = StellaAssetManager(
            assets_dir=ASSETS_DIR,
            console=console,
            cdn_host=reg_info["cdn_host"],
            meta_key=reg_info["meta_key"],
        )
        manifest = manager.fetch_remote_manifest()
        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            MofNCompleteColumn(),
            TimeElapsedColumn(),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            dl_ok, dl_skip, dl_fail = manager.download_and_sync(
                manifest=manifest,
                jobs=jobs,
                force=force,
                progress=progress,
                filter_fn=lambda name: name.startswith("char_2d_") and name.endswith(".unity3d"),
            )
        console.print(
            f"[bold green]角色 2D 资源同步完成:[/bold green] 下载 {dl_ok}  跳过 {dl_skip}  失败 {dl_fail}"
        )
    except Exception as ex:
        console.print(f"[yellow]从 CDN 同步角色 2D 资源失败 ({ex})，使用本地已有资产[/yellow]")

    if not char2d_dir.is_dir() or not any(char2d_dir.glob("*.unity3d")):
        console.print(f"[red]错误: 缺少角色 2D 资产 {char2d_dir}，请先执行 assets 或检查区服/CDN[/red]")
        return 1

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        ok, skip, fail = export_paintings_all(
            char2d_dir=char2d_dir,
            output_dir=painting_dir,
            tables_dir=MASTER_DIR / "Tables",
            force=force,
            jobs=jobs,
            console=console,
            progress=progress,
        )
    console.print(
        f"[bold green]立绘导出完成:[/bold green] 成功 {ok}  跳过 {skip}  失败 {fail} → {painting_dir}"
    )
    return 0 if fail == 0 else 1


def cmd_all(args: argparse.Namespace) -> int:
    console.print(f"[bold green]=== 执行全量导出流程 ===[/bold green]")
    rc_assets = cmd_assets(args)
    rc_master = cmd_masterdata(args)
    return 0 if (rc_assets == 0 and rc_master == 0) else 1


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--apk", help="APK 文件路径，默认自动在当前目录匹配")
    shared.add_argument("--so", help="libil2cpp.so 镜像文件路径，默认自动匹配当前目录下的 libil2cpp.so")
    shared.add_argument(
        "--region",
        choices=list(REGION_CONFIGS.keys()),
        default="cn",
        help="指定区服环境 (cn, tw, jp, kr, en)，默认 cn",
    )
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help=f"并发处理线程数，默认 {DEFAULT_JOBS}")
    shared.add_argument("--force", action="store_true", help="忽略本地已有文件强制重新处理")

    parser = argparse.ArgumentParser(
        description=f"《{GAME_TITLE}》资源整合与数据表导出工具链",
        parents=[shared],
    )
    sub = parser.add_subparsers(dest="command", required=False)
    sub.add_parser("status", parents=[shared], help="查看版本、清单及核心文件状态")
    p_assets = sub.add_parser("assets", parents=[shared], help="整合 APK 内置资产与 CDN 热更资产到 Assets/")
    p_assets.add_argument("--skip-apk", action="store_true", help="跳过 APK 资产提取")
    p_assets.add_argument("--skip-cdn", action="store_true", help="跳过 CDN 远端热更下载，仅提取本地 APK 资产")
    p_assets.add_argument("--limit", type=int, default=0, help="限制 CDN 下载文件数（0 为不限制）")

    p_master = sub.add_parser(
        "masterdata",
        parents=[shared],
        help="导出反编译 Lua 源码与转换为 JSON 的数据表至 MasterData/",
    )
    p_master.add_argument(
        "--lang",
        default="all",
        help="语言代码 (zh_cn/zh_tw/ja_jp/ko_kr/en_us) 或 all；默认 all 一次性导出全部区服语言表",
    )

    sub.add_parser(
        "painting",
        parents=[shared],
        help="导出角色立绘（立绘素体 001 + 面部差分 002 合成）到 Painting/",
    )

    p_all = sub.add_parser("all", parents=[shared], help="顺序执行 assets 与 masterdata 全流程")
    p_all.add_argument("--skip-apk", action="store_true", help="跳过 APK 资产提取")
    p_all.add_argument("--skip-cdn", action="store_true", help="跳过 CDN 远端热更下载")
    p_all.add_argument("--limit", type=int, default=0, help="限制 CDN 下载文件数")
    p_all.add_argument(
        "--lang",
        default="all",
        help="语言代码 (zh_cn/zh_tw/ja_jp/ko_kr/en_us) 或 all；默认 all 一次性导出全部区服语言表",
    )

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    cmd = getattr(args, "command", None)
    if not cmd or cmd == "all":
        return cmd_all(args)
    elif cmd == "status":
        return cmd_status(args)
    elif cmd == "assets":
        return cmd_assets(args)
    elif cmd == "masterdata":
        return cmd_masterdata(args)
    elif cmd == "painting":
        return cmd_painting(args)
    else:
        parser.error(f"未知的子命令: {cmd}")
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
