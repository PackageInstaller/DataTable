from __future__ import annotations

"""《反向蓝 / ReverseBlue Re-birthEnd》(jp.co.happyelements.rxr) 资源与数据表还原工具。

子命令：
    assets      APK（base + split）解包 + CDN 热更 bundle 下载/校验/解密 → Assets/
    masterdata  数据表（技能/角色/剧情等）与重要配置 → MasterData/
    all         assets + masterdata

资源说明：
    - APK 内置资源（含 split_UnityDataAssetPack.apk 的本地 Addressables）解包后按
      APK 内 assets/ 的相对路径写入 Assets/；
    - CDN 热更（Aura addressables，catalog 版本取自游戏会话响应 CatalogVersion）
      按 <CDN>/assets/Android/<bundleName>_<md5>.Android.bundle 下载到 Assets/Android/；
    - 1.31.3 客户端资源均为未加密 UnityFS；如后续加密由 ReverseBlueBundle.ensure_plain 处理。
"""

import argparse
import json
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any

from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

import ReverseBlueApi as Api
import ReverseBlueApk as Apk
import ReverseBlueBundle as Bundle
import ReverseBlueCatalog as Catalog
import ReverseBlueMasterData as MasterData

GAME_TITLE = "反向蓝 / ReverseBlue Re-birthEnd"
SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
CACHE_DIR = SCRIPT_DIR / "Cache"
DEFAULT_JOBS = 8
CHUNK = 1 << 20

console = Console()


def format_size(size: float) -> str:
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{size:.0f} B"


def make_progress(*extra: Any) -> Progress:
    return Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        *extra,
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
    )


def write_json(path: Path, obj: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(obj, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


# ---------------------------------------------------------------------------
# 公共流程
# ---------------------------------------------------------------------------

def resolve_session(args: argparse.Namespace) -> dict[str, Any]:
    if getattr(args, "session", "") and args.session:
        console.print(f"[cyan]复用会话[/cyan] {args.session}")
        return {"SessionId": args.session}
    console.print("[cyan]创建游客会话[/cyan] ...")
    session = Api.create_session(version=args.version, version_key=args.version_key)
    console.print(
        f"[green]Session[/green] {session.get('SessionId')}  "
        f"CatalogVersion={session.get('CatalogVersion')}  "
        f"MasterDataModifiedTime={session.get('MasterDataModifiedTime')}"
    )
    return session


def resolve_catalog_version(args: argparse.Namespace, session: dict[str, Any]) -> str:
    if getattr(args, "catalog_version", ""):
        return str(args.catalog_version)
    version = session.get("CatalogVersion")
    if version is None:
        raise SystemExit("无法从会话响应获取 CatalogVersion，请用 --catalog-version 指定")
    return str(version)


# ---------------------------------------------------------------------------
# 子命令：assets
# ---------------------------------------------------------------------------

def _extract_apks(args: argparse.Namespace) -> list[Path]:
    apks = Apk.find_apks(SCRIPT_DIR, args.apk)
    console.print("[cyan]APK[/cyan] " + ", ".join(p.name for p in apks))
    for apk in apks:
        entries = Apk.apk_entry_infos(apk)
        with make_progress(MofNCompleteColumn()) as progress:
            task = progress.add_task(f"拆 {apk.name}", total=len(entries))

            def on_file(label: str, name: str, wrote: bool, _task: int = task) -> None:
                progress.advance(_task)

            written, skipped, failed = Apk.extract_apk(
                apk, ASSETS_DIR, force=args.force, on_file=on_file
            )
        console.print(
            f"  [green]{apk.name}[/green] 写出 {written}  跳过 {skipped}  失败 {failed}"
        )
    detected = Apk.detect_split_names(apks)
    if detected:
        console.print("[cyan]拆分识别[/cyan] " + "  ".join(f"{k}={v.name}" for k, v in detected.items()))
    return apks


def _write_local_catalog() -> dict[str, Any]:
    data = Catalog.write_local_addressables(
        ASSETS_DIR, ASSETS_DIR / "Catalog" / "local_addressables.json"
    )
    if data:
        meta = data["_meta"]
        console.print(
            f"[green]本地 Addressables[/green] {meta['bundleCount']} 个 bundle / "
            f"{format_size(meta['bundleBytes'])} → Assets/aa/Android"
        )
    return data


def _bundle_todo(catalog: Catalog.AuraCatalog, force: bool) -> list[Catalog.BundleInfo]:
    todo: list[Catalog.BundleInfo] = []
    for bundle in catalog.bundles.values():
        dest = ASSETS_DIR / bundle.relative_path
        if not force and dest.is_file() and dest.stat().st_size == bundle.size:
            continue
        todo.append(bundle)
    return todo


def _download_bundles(catalog: Catalog.AuraCatalog, args: argparse.Namespace) -> tuple[int, int, int]:
    todo = _bundle_todo(catalog, force=args.force)
    if args.limit:
        todo = todo[: args.limit]
    total = sum(bundle.size for bundle in todo)
    console.print(
        f"[cyan]热更[/cyan] catalog v{catalog.version}  "
        f"bundle {len(catalog.bundles)} 个 / {format_size(catalog.total_size)}  "
        f"待下 {len(todo)} 个 / {format_size(total)}"
    )
    if getattr(args, "list_only", False):
        url_file = ASSETS_DIR / "Catalog" / "download_urls.txt"
        url_file.parent.mkdir(parents=True, exist_ok=True)
        url_file.write_text("\n".join(b.url for b in catalog.bundles.values()) + "\n", encoding="utf-8")
        console.print(f"[green]下载链接[/green] {len(catalog.bundles)} 条 → {url_file}")
        return 0, 0, 0
    if not todo:
        return 0, 0, 0

    ok = skip = fail = 0
    with make_progress(DownloadColumn(), TransferSpeedColumn()) as progress:
        task = progress.add_task("下载 bundle", total=total)

        def work(bundle: Catalog.BundleInfo) -> tuple[bool, str, str | None]:
            dest = ASSETS_DIR / bundle.relative_path
            try:
                status = Bundle.download(
                    bundle.url,
                    dest,
                    expected_size=bundle.size,
                    force=args.force,
                    on_bytes=lambda n: progress.update(task, advance=n),
                )
                return status == "ok", bundle.name, None
            except Exception as exc:  # noqa: BLE001
                return False, bundle.name, str(exc)

        with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
            futures = [pool.submit(work, bundle) for bundle in todo]
            for future in as_completed(futures):
                did, name, error = future.result()
                if error is not None:
                    fail += 1
                    console.print(f"[red]失败[/red] {name}: {error}")
                elif did:
                    ok += 1
                else:
                    skip += 1
    console.print(f"[bold green]热更[/bold green] 下载 {ok}  跳过 {skip}  失败 {fail}")
    return ok, skip, fail


def _verify_bundles() -> tuple[int, int, int]:
    plain = decrypted = failed = 0
    for path in ASSETS_DIR.rglob("*.bundle"):
        status = Bundle.ensure_plain(path, console)
        if status == "plain":
            plain += 1
        elif status == "decrypted":
            decrypted += 1
        else:
            failed += 1
    console.print(
        f"[green]bundle 校验[/green] 明文 {plain}  已解密 {decrypted}  异常 {failed}"
    )
    return plain, decrypted, failed


def cmd_assets(args: argparse.Namespace) -> int:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    console.print(f"[bold cyan]=== 整合 APK 与热更资产 → {ASSETS_DIR} ===[/bold cyan]")

    session = resolve_session(args)
    catalog_version = resolve_catalog_version(args, session)

    apks: list[Path] = []
    if not args.skip_apk:
        try:
            apks = _extract_apks(args)
        except FileNotFoundError as exc:
            console.print(f"[red]APK[/red] {exc}")
            return 1
    else:
        console.print("[yellow]跳过 APK 解包[/yellow]")

    local_meta = _write_local_catalog()

    catalog = Catalog.fetch_catalog(CACHE_DIR, catalog_version, force=args.force)
    readable = Catalog.write_readable(
        catalog,
        ASSETS_DIR / "Catalog" / f"{catalog.catalog_name}.json",
        with_resources=args.with_resources,
    )
    console.print(
        f"[green]catalog[/green] {len(catalog.bundles)} 个 bundle / "
        f"{format_size(catalog.total_size)} → {readable}"
    )

    ok, skip, fail = _download_bundles(catalog, args)
    _, _, bad_bundles = _verify_bundles()

    manifest = {
        "game": GAME_TITLE,
        "platform": Api.PLATFORM,
        "appVersion": args.version,
        "catalogVersion": catalog.version,
        "catalog": catalog.catalog_name,
        "catalogInfo": catalog.info,
        "bundleCount": len(catalog.bundles),
        "bundleTotalSize": catalog.total_size,
        "addressableCount": len(catalog.addressables),
        "localAddressables": local_meta.get("_meta") if local_meta else None,
        "apk": [str(path) for path in apks],
        "downloaded": ok,
        "skipped": skip,
        "failed": fail,
        "badBundles": bad_bundles,
    }
    write_json(ASSETS_DIR / "Catalog" / "manifest.json", manifest)
    console.print(f"[green]manifest[/green] Assets/Catalog/manifest.json")
    return 0 if bad_bundles == 0 and fail == 0 else 1


# ---------------------------------------------------------------------------
# 子命令：masterdata
# ---------------------------------------------------------------------------

def _fetch_masterdata_payload(
    args: argparse.Namespace, session: dict[str, Any], catalog_version: str
) -> bytes:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    raw_path = CACHE_DIR / f"masterdata_{catalog_version}.bin"
    if raw_path.is_file() and not args.force:
        console.print(f"[cyan]使用缓存[/cyan] {raw_path}")
        return raw_path.read_bytes()
    console.print("[cyan]拉取 master data[/cyan] (约 80MB) ...")
    payload = Api.get_masterdata(
        session.get("SessionId", ""),
        version=args.version,
        version_key=args.version_key,
    )
    raw_path.write_bytes(payload)
    console.print(f"[green]master data[/green] {format_size(len(payload))} → {raw_path}")
    return payload


def _write_api_configs(
    args: argparse.Namespace, session: dict[str, Any], catalog_version: str
) -> int:
    config_dir = MASTER_DIR / "Config"
    config_dir.mkdir(parents=True, exist_ok=True)
    written = 0
    try:
        app_config = Api.get_app_config(
            session.get("SessionId", ""),
            version=args.version,
            version_key=args.version_key,
        )
        write_json(config_dir / "AppConfig.json", app_config)
        written += 1
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]AppConfig 获取失败[/yellow]: {exc}")
    try:
        startup = Api.get_startup_info(
            session.get("SessionId", ""),
            version=args.version,
            version_key=args.version_key,
        )
        write_json(config_dir / "StartupInfo.json", startup)
        written += 1
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]StartupInfo 获取失败[/yellow]: {exc}")
    try:
        info = Catalog.fetch_catalog_info(CACHE_DIR, catalog_version, force=args.force)
        write_json(config_dir / "CatalogInfo.json", info)
        written += 1
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]CatalogInfo 获取失败[/yellow]: {exc}")
    return written


def cmd_masterdata(args: argparse.Namespace) -> int:
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    console.print(f"[bold cyan]=== 导出数据表与配置 → {MASTER_DIR} ===[/bold cyan]")

    session = resolve_session(args)
    catalog_version = resolve_catalog_version(args, session)
    payload = _fetch_masterdata_payload(args, session, catalog_version)

    data = MasterData.unpack(payload)
    tables, scalars = MasterData.split_tables(data)
    console.print(
        f"[green]数据表[/green] {len(tables)} 张 / 标量 {len(scalars)} 项"
    )

    with make_progress(MofNCompleteColumn()) as progress:
        task = progress.add_task("写出数据表", total=len(tables))

        def on_table(name: str, dest: Path, rows: int) -> None:
            progress.advance(task)

        written = MasterData.write_tables(tables, MASTER_DIR, on_table=on_table)
    MasterData.write_scalars(scalars, MASTER_DIR / "_scalars.json")
    MasterData.write_catalog(tables, MASTER_DIR / "_catalog.json")
    MasterData.write_meta(scalars, MASTER_DIR / "_meta.json")
    console.print(f"[bold green]数据表[/bold green] {written} 张 → {MASTER_DIR}")

    configs = _write_api_configs(args, session, catalog_version)
    copied = MasterData.copy_configs(ASSETS_DIR, MASTER_DIR)
    catalog_copied = MasterData.copy_catalog_artifacts(ASSETS_DIR, MASTER_DIR)
    console.print(
        f"[green]配置[/green] API {configs} 个 / 本地 {copied} 个 / catalog {catalog_copied} 个 "
        f"→ MasterData/Config"
    )
    return 0


# ---------------------------------------------------------------------------
# 子命令：all
# ---------------------------------------------------------------------------

def cmd_all(args: argparse.Namespace) -> int:
    rc = cmd_assets(args)
    rc2 = cmd_masterdata(args)
    return 0 if rc == 0 and rc2 == 0 else 1


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def _add_common_args(parser: argparse.ArgumentParser) -> None:
    parser.add_argument(
        "--apk",
        nargs="*",
        default=None,
        help="APK / 拆分 APK 路径（可多个；默认自动搜索脚本目录下的 .apk/.apks）",
    )
    parser.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help=f"并发下载线程数，默认 {DEFAULT_JOBS}")
    parser.add_argument("--force", action="store_true", help="忽略本地已有文件，强制重新处理")
    parser.add_argument("--session", default="", help="复用已有 X-Session（默认自动创建游客会话）")
    parser.add_argument("--version", default=Api.APP_VERSION, help=f"客户端版本号（默认 {Api.APP_VERSION}）")
    parser.add_argument("--version-key", default=Api.VERSION_KEY, help="reverse-version-key（默认内置 1.31.3 的值）")
    parser.add_argument("--catalog-version", default="", help="catalog 版本（默认取会话响应的 CatalogVersion）")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=f"《{GAME_TITLE}》资源整合与数据表导出工具",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p_assets = sub.add_parser("assets", help="APK + CDN 热更资产整合还原到 Assets/")
    _add_common_args(p_assets)
    p_assets.add_argument("--skip-apk", action="store_true", help="跳过 APK 解包")
    p_assets.add_argument("--list-only", action="store_true", help="只解析 catalog 并生成下载链接，不下载 bundle")
    p_assets.add_argument("--limit", type=int, default=0, help="最多下载多少个 bundle（0 为不限制）")
    p_assets.add_argument("--with-resources", action="store_true", help="catalog JSON 附带地址able → bundle 映射")

    p_master = sub.add_parser("masterdata", help="数据表（技能/角色/剧情等）与重要配置 → MasterData/")
    _add_common_args(p_master)

    p_all = sub.add_parser("all", help="依次执行 assets、masterdata")
    _add_common_args(p_all)
    p_all.add_argument("--skip-apk", action="store_true", help="跳过 APK 解包")
    p_all.add_argument("--limit", type=int, default=0, help="最多下载多少个 bundle（0 为不限制）")
    p_all.add_argument("--with-resources", action="store_true", help="catalog JSON 附带地址able → bundle 映射")

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    command = args.command
    if command == "assets":
        return cmd_assets(args)
    if command == "masterdata":
        return cmd_masterdata(args)
    if command == "all":
        return cmd_all(args)
    parser.error(f"未知的子命令: {command}")
    return 2


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        raise SystemExit(130)
