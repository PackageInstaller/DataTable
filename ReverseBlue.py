from __future__ import annotations

"""《反向蓝 / ReverseBlue Re-birthEnd》(jp.co.happyelements.rxr) 资源与数据表还原工具。

子命令：
    assets      APK（base + split）解包 + CDN 热更 bundle 下载/校验/解密 → Assets/
    masterdata  数据表（技能/角色/剧情等）与重要配置 → MasterData/
    painting    Unit_* bundle 里的小人(sd_*)/大立绘(stand_img) → Painting/（名称还原）
    all         assets + masterdata + painting

版本相关常量（接口路由 /api/uuid/<uuid> 与 reverse-version-key）是每个客户端版本
由后端生成并编译进 libil2cpp 的，服务端不下发；本工具**不内置**这些值：

- version-key：优先取 --version-key；否则从 APK 的 global-metadata.dat 自动提取
  （整份 metadata 里唯一的 50 位字母数字字面量，见 ReverseBlueMetadata.py）；
- 接口映射：优先取 --endpoints JSON；否则读脚本目录的 ReverseBlueEndpoints.json
  （由 ReverseBlueFrida.py frida spawn 动态抓包生成）；缺失时自动调用动态抓取
  （每版本一次，需要设备 + frida-server）；
- appVersion：优先 --version；否则 APK versionName（aapt2/aapt）；再否则用动态抓包
  得到的版本号。

动态抓包原理：spawn 游戏后 hook UnityWebRequest.set_url / SetRequestHeader /
DownloadHandler / UploadHandlerRaw，抓启动流程的真实 URL、reverse-version-key 请求头
和响应体；再按响应 msgpack 语义判定 startup/session/app_config/masterdata 四个角色，
不写死 UUID/下标/类名。

资源说明：
    - APK 内置资源（含 split_UnityDataAssetPack.apk 的本地 Addressables）解包后按
      APK 内 assets/ 的相对路径写入 Assets/；
    - CDN 热更（Aura addressables，catalog 版本取自游戏会话响应 CatalogVersion）
      按 <CDN>/assets/Android/<bundleName>_<md5>.Android.bundle 下载到 Assets/Android/；
    - 1.31.3 客户端抽查资源均为未加密 UnityFS；如后续加密由 ReverseBlueBundle.ensure_plain 处理。
"""

import argparse
import json
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, field
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
import ReverseBlueMetadata as Metadata
import ReverseBluePainting as Painting

GAME_TITLE = "反向蓝 / ReverseBlue Re-birthEnd"
GAME_PACKAGE = "jp.co.happyelements.rxr"
SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
CACHE_DIR = SCRIPT_DIR / "Cache"
PAINTING_DIR = SCRIPT_DIR / "Painting"
# 接口映射（每个客户端版本由 ReverseBlueFrida.py 动态抓包生成，可随仓库提交）
ENDPOINTS_FILE = SCRIPT_DIR / "ReverseBlueEndpoints.json"
DEFAULT_JOBS = 8
ROLE_ORDER = ("startup", "session", "app_config", "masterdata")

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
    path.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def normalize_uuid(value: str) -> str:
    value = str(value)
    if value.startswith("http"):
        marker = "/api/uuid/"
        index = value.find(marker)
        if index < 0:
            return value
        value = value[index + len(marker):]
    if value.startswith("/api/uuid/"):
        value = value[len("/api/uuid/"):]
    return value.split("?")[0].strip("/")


def read_cache() -> dict[str, Any]:
    if not ENDPOINTS_FILE.is_file():
        return {}
    try:
        data = json.loads(ENDPOINTS_FILE.read_text(encoding="utf-8"))
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]接口映射文件解析失败[/yellow] {ENDPOINTS_FILE}: {exc}")
        return {}
    return data if isinstance(data, dict) else {}


# ---------------------------------------------------------------------------
# 运行时配置：版本 / version-key / 路由候选（全部来自 APK 或动态抓包，不内置）
# ---------------------------------------------------------------------------

@dataclass
class Runtime:
    version: str = ""
    version_key: str = ""
    apks: list[Path] = field(default_factory=list)
    apk_error: str | None = None
    routes: list[str] = field(default_factory=list)
    route_uuids: list[str] = field(default_factory=list)
    literals: int = 0
    cache: dict[str, Any] = field(default_factory=dict)
    sources: dict[str, str] = field(default_factory=dict)
    resolved: dict[str, str] = field(default_factory=dict)
    session: dict[str, Any] | None = None
    startup: dict[str, Any] | None = None


def _find_apks(args: argparse.Namespace) -> tuple[list[Path], str | None]:
    try:
        return Apk.find_apks(SCRIPT_DIR, args.apk), None
    except FileNotFoundError as exc:
        return [], str(exc)


def build_runtime(args: argparse.Namespace) -> Runtime:
    apks, apk_error = _find_apks(args)
    metadata = Metadata.load_metadata(apks)
    literals = Metadata.extract_literals(metadata) if metadata else []
    routes = Metadata.find_routes(literals)
    auto_key = Metadata.find_version_key(literals)
    auto_version = Metadata.detect_app_version(apks)
    cache = read_cache()

    runtime = Runtime(
        apks=apks,
        apk_error=apk_error,
        routes=routes,
        route_uuids=[normalize_uuid(text) for text in routes],
        literals=len(literals),
        cache=cache,
    )
    runtime.version = args.version or auto_version or str(cache.get("appVersion") or "")
    runtime.version_key = args.version_key or auto_key or str(cache.get("versionKey") or "")
    runtime.sources["version"] = (
        "参数" if args.version else
        "APK(aapt)" if auto_version else
        "动态抓包" if cache.get("appVersion") else
        "未知"
    )
    runtime.sources["version_key"] = (
        "参数" if args.version_key else
        "APK metadata" if auto_key else
        "动态抓包" if cache.get("versionKey") else
        "未知"
    )
    if routes:
        console.print(f"[cyan]APK metadata[/cyan] {len(literals)} 条字面量 / {len(routes)} 条路由")
    if cache.get("uuids"):
        runtime.resolved.update({role: normalize_uuid(uuid) for role, uuid in cache["uuids"].items()})
    return runtime


def _candidate_sets(args: argparse.Namespace, runtime: Runtime) -> list[tuple[str, dict[str, str], bool]]:
    """返回 [(来源, {role: uuid}, 是否信任(不校验是否在当前版本路由块内))]，按优先级排序。"""
    sets: list[tuple[str, dict[str, str], bool]] = []
    if args.endpoints:
        path = Path(args.endpoints)
        try:
            data = json.loads(path.read_text(encoding="utf-8"))
        except Exception as exc:  # noqa: BLE001
            raise SystemExit(f"读取 --endpoints {path} 失败: {exc}")
        uuids = data.get("uuids") if isinstance(data, dict) and "uuids" in data else data
        if not isinstance(uuids, dict) or not uuids:
            raise SystemExit(f"--endpoints {path} 需要 JSON 对象（role -> uuid）")
        sets.append(("endpoints", {str(k): normalize_uuid(v) for k, v in uuids.items()}, True))
    cached = runtime.cache.get("uuids") or {}
    if isinstance(cached, dict) and cached:
        sets.append(("Cache", {str(k): normalize_uuid(v) for k, v in cached.items()}, False))
    return sets


def role_candidates(args: argparse.Namespace, runtime: Runtime, role: str) -> list[tuple[str, str]]:
    out: list[tuple[str, str]] = []
    seen: set[str] = set()
    for source, uuids, trusted in _candidate_sets(args, runtime):
        uuid = uuids.get(role)
        if not uuid or uuid in seen:
            continue
        if not trusted and runtime.route_uuids and uuid not in runtime.route_uuids:
            continue
        seen.add(uuid)
        out.append((source, uuid))
    return out


def persist_endpoints(runtime: Runtime) -> None:
    if not runtime.resolved:
        return
    ENDPOINTS_FILE.parent.mkdir(parents=True, exist_ok=True)
    data = read_cache()
    data["gamePackage"] = GAME_PACKAGE
    if runtime.version:
        data["appVersion"] = data.get("appVersion") or runtime.version
    if runtime.version_key:
        data["versionKey"] = data.get("versionKey") or runtime.version_key
    data["uuids"] = runtime.resolved
    data["sources"] = {role: runtime.sources.get(role, "") for role in runtime.resolved}
    write_json(ENDPOINTS_FILE, data)


def _mark(runtime: Runtime, role: str, source: str, uuid: str) -> None:
    runtime.resolved[role] = normalize_uuid(uuid)
    runtime.sources[role] = source
    persist_endpoints(runtime)


def _missing_roles(args: argparse.Namespace, runtime: Runtime) -> list[str]:
    return [role for role in ROLE_ORDER if not role_candidates(args, runtime, role)]


def try_auto_capture(args: argparse.Namespace) -> None:
    """本地没有可用映射时，自动 frida spawn 抓一次（每版本一次）。"""
    if getattr(args, "no_capture", False):
        return
    console.print("[yellow]本地没有可用的动态接口映射，开始 frida 动态抓取（每版本一次）...[/yellow]")
    try:
        import ReverseBlueFrida  # noqa: PLC0415

        ReverseBlueFrida.capture(quiet=True)
        console.print("[green]动态抓取完成[/green]")
    except Exception as exc:  # noqa: BLE001
        console.print(f"[yellow]自动抓取失败[/yellow]: {exc}")


def ensure_runtime(args: argparse.Namespace) -> Runtime:
    runtime = build_runtime(args)
    need = (
        not runtime.version
        or not runtime.version_key
        or bool(_missing_roles(args, runtime))
    )
    if need:
        if not getattr(args, "no_capture", False):
            try_auto_capture(args)
            runtime = build_runtime(args)
    problems: list[str] = []
    if not runtime.version:
        problems.append("客户端版本：--version，或提供 --apk 从 versionName 读取")
    if not runtime.version_key:
        problems.append("reverse-version-key：--version-key，或提供 --apk 从 global-metadata.dat 提取")
    missing_roles = _missing_roles(args, runtime)
    for role in missing_roles:
        problems.append(f"{role} 接口：--endpoints 指定，或运行 ReverseBlueFrida.py 动态抓取")
    if problems:
        raise SystemExit(
            "缺少运行所需的动态数据：\n  - " + "\n  - ".join(problems) +
            f"\n接口映射文件应为：{ENDPOINTS_FILE}"
        )
    console.print(
        f"[cyan]版本[/cyan] {runtime.version}（{runtime.sources['version']}）  "
        f"version-key 来源: {runtime.sources['version_key']}"
    )
    for role in ROLE_ORDER:
        candidates = role_candidates(args, runtime, role)
        source = candidates[0][0] if candidates else "?"
        console.print(f"  [cyan]{role}[/cyan] ← {source}")
    return runtime


# ---------------------------------------------------------------------------
# 公共 API 流程（role -> 候选接口，逐个真实请求验证，成功后写 Cache）
# ---------------------------------------------------------------------------

def resolve_session(args: argparse.Namespace, runtime: Runtime) -> dict[str, Any]:
    if runtime.session is not None:
        return runtime.session
    if args.session:
        console.print(f"[cyan]复用会话[/cyan] {args.session}")
        runtime.session = {"SessionId": args.session}
        return runtime.session
    errors: list[str] = []
    for source, uuid in role_candidates(args, runtime, "session"):
        try:
            session = Api.create_session(
                endpoint=uuid, version=runtime.version, version_key=runtime.version_key
            )
        except Exception as exc:  # noqa: BLE001
            errors.append(f"{source}:{uuid}: {exc}")
            continue
        _mark(runtime, "session", source, uuid)
        runtime.session = session
        console.print(
            f"[green]Session[/green] {session.get('SessionId')}  "
            f"CatalogVersion={session.get('CatalogVersion')}  "
            f"MasterDataModifiedTime={session.get('MasterDataModifiedTime')}  "
            f"接口来源={source}"
        )
        return session
    raise SystemExit("无法调用 session 接口：\n  " + "\n  ".join(errors))


def resolve_startup(args: argparse.Namespace, runtime: Runtime) -> dict[str, Any]:
    if runtime.startup is not None:
        return runtime.startup
    session = resolve_session(args, runtime)
    errors: list[str] = []
    for source, uuid in role_candidates(args, runtime, "startup"):
        try:
            startup = Api.get_startup_info(
                session.get("SessionId", ""),
                endpoint=uuid,
                version=runtime.version,
                version_key=runtime.version_key,
            )
        except Exception as exc:  # noqa: BLE001
            errors.append(f"{source}:{uuid}: {exc}")
            continue
        if "CatalogVersion" not in startup:
            errors.append(f"{source}:{uuid}: 响应缺少 CatalogVersion")
            continue
        _mark(runtime, "startup", source, uuid)
        runtime.startup = startup
        console.print(f"[green]启动信息[/green] 接口来源={source}")
        return startup
    raise SystemExit("无法调用 startup 接口：\n  " + "\n  ".join(errors))


def fetch_app_config(args: argparse.Namespace, runtime: Runtime) -> dict[str, Any]:
    session = resolve_session(args, runtime)
    errors: list[str] = []
    for source, uuid in role_candidates(args, runtime, "app_config"):
        try:
            config = Api.get_app_config(
                session.get("SessionId", ""),
                endpoint=uuid,
                version=runtime.version,
                version_key=runtime.version_key,
            )
        except Exception as exc:  # noqa: BLE001
            errors.append(f"{source}:{uuid}: {exc}")
            continue
        if "AnnouncementUrl" not in config and "TermsOfServiceText" not in config:
            errors.append(f"{source}:{uuid}: 响应不是 AppConfig")
            continue
        _mark(runtime, "app_config", source, uuid)
        console.print(f"[green]AppConfig[/green] 接口来源={source}")
        return config
    raise SystemExit("无法调用 app_config 接口：\n  " + "\n  ".join(errors))


def fetch_masterdata(args: argparse.Namespace, runtime: Runtime) -> bytes:
    session = resolve_session(args, runtime)
    errors: list[str] = []
    for source, uuid in role_candidates(args, runtime, "masterdata"):
        console.print(f"[cyan]拉取 master data[/cyan] 接口来源={source} (约 80MB) ...")
        try:
            payload = Api.get_masterdata(
                session.get("SessionId", ""),
                endpoint=uuid,
                version=runtime.version,
                version_key=runtime.version_key,
            )
        except Exception as exc:  # noqa: BLE001
            errors.append(f"{source}:{uuid}: {exc}")
            continue
        if len(payload) < 1024 * 1024:
            errors.append(f"{source}:{uuid}: 响应仅 {len(payload)}B，不是数据表")
            continue
        _mark(runtime, "masterdata", source, uuid)
        return payload
    raise SystemExit("无法调用 masterdata 接口：\n  " + "\n  ".join(errors))


def resolve_catalog_version(
    args: argparse.Namespace, runtime: Runtime, session: dict[str, Any]
) -> str:
    if args.catalog_version:
        return str(args.catalog_version)
    version = session.get("CatalogVersion")
    if version is None:
        version = runtime.cache.get("catalogVersion")
    if version is not None:
        return str(version)
    startup = resolve_startup(args, runtime)
    if startup.get("CatalogVersion") is not None:
        return str(startup["CatalogVersion"])
    raise SystemExit("无法获取 CatalogVersion，请用 --catalog-version 指定")


# ---------------------------------------------------------------------------
# 子命令：assets
# ---------------------------------------------------------------------------

def _extract_apks(args: argparse.Namespace, runtime: Runtime) -> None:
    if not runtime.apks:
        raise SystemExit(f"APK: {runtime.apk_error or '未找到'}")
    console.print("[cyan]APK[/cyan] " + ", ".join(path.name for path in runtime.apks))
    for apk in runtime.apks:
        entries = Apk.apk_entry_infos(apk)
        with make_progress(MofNCompleteColumn()) as progress:
            task = progress.add_task(f"拆 {apk.name}", total=len(entries))

            def on_file(label: str, name: str, wrote: bool, _task: int = task) -> None:
                progress.advance(_task)

            written, skipped, failed = Apk.extract_apk(
                apk, ASSETS_DIR, force=args.force, on_file=on_file
            )
        console.print(f"  [green]{apk.name}[/green] 写出 {written}  跳过 {skipped}  失败 {failed}")
    detected = Apk.detect_split_names(runtime.apks)
    if detected:
        console.print("[cyan]拆分识别[/cyan] " + "  ".join(f"{k}={v.name}" for k, v in detected.items()))


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
    console.print(f"[green]bundle 校验[/green] 明文 {plain}  已解密 {decrypted}  异常 {failed}")
    return plain, decrypted, failed


def cmd_assets(args: argparse.Namespace) -> int:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    console.print(f"[bold cyan]=== 整合 APK 与热更资产 → {ASSETS_DIR} ===[/bold cyan]")

    runtime = ensure_runtime(args)
    session = resolve_session(args, runtime)
    catalog_version = resolve_catalog_version(args, runtime, session)

    if not args.skip_apk:
        _extract_apks(args, runtime)
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
        "appVersion": runtime.version,
        "versionKeySource": runtime.sources.get("version_key"),
        "catalogVersion": catalog.version,
        "catalog": catalog.catalog_name,
        "catalogInfo": catalog.info,
        "bundleCount": len(catalog.bundles),
        "bundleTotalSize": catalog.total_size,
        "addressableCount": len(catalog.addressables),
        "localAddressables": local_meta.get("_meta") if local_meta else None,
        "apk": [str(path) for path in runtime.apks],
        "apiEndpoints": runtime.resolved,
        "downloaded": ok,
        "skipped": skip,
        "failed": fail,
        "badBundles": bad_bundles,
    }
    write_json(ASSETS_DIR / "Catalog" / "manifest.json", manifest)
    console.print("[green]manifest[/green] Assets/Catalog/manifest.json")
    return 0 if bad_bundles == 0 and fail == 0 else 1


# ---------------------------------------------------------------------------
# 子命令：masterdata
# ---------------------------------------------------------------------------

def _fetch_masterdata_payload(
    args: argparse.Namespace, runtime: Runtime, catalog_version: str
) -> bytes:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    raw_path = CACHE_DIR / f"masterdata_{catalog_version}.bin"
    if raw_path.is_file() and not args.force:
        console.print(f"[cyan]使用缓存[/cyan] {raw_path}")
        return raw_path.read_bytes()
    payload = fetch_masterdata(args, runtime)
    raw_path.write_bytes(payload)
    console.print(f"[green]master data[/green] {format_size(len(payload))} → {raw_path}")
    return payload


def _write_api_configs(args: argparse.Namespace, runtime: Runtime, catalog_version: str) -> int:
    config_dir = MASTER_DIR / "Config"
    config_dir.mkdir(parents=True, exist_ok=True)
    written = 0
    try:
        write_json(config_dir / "AppConfig.json", fetch_app_config(args, runtime))
        written += 1
    except SystemExit as exc:
        console.print(f"[yellow]AppConfig 获取失败[/yellow]: {exc}")
    try:
        write_json(config_dir / "StartupInfo.json", resolve_startup(args, runtime))
        written += 1
    except SystemExit as exc:
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

    runtime = ensure_runtime(args)
    session = resolve_session(args, runtime)
    catalog_version = resolve_catalog_version(args, runtime, session)
    payload = _fetch_masterdata_payload(args, runtime, catalog_version)

    data = MasterData.unpack(payload)
    tables, scalars = MasterData.split_tables(data)
    console.print(f"[green]数据表[/green] {len(tables)} 张 / 标量 {len(scalars)} 项")

    with make_progress(MofNCompleteColumn()) as progress:
        task = progress.add_task("写出数据表", total=len(tables))

        def on_table(name: str, dest: Path, rows: int) -> None:
            progress.advance(task)

        written = MasterData.write_tables(tables, MASTER_DIR, on_table=on_table)
    MasterData.write_scalars(scalars, MASTER_DIR / "_scalars.json")
    MasterData.write_catalog(tables, MASTER_DIR / "_catalog.json")
    MasterData.write_meta(scalars, MASTER_DIR / "_meta.json")
    console.print(f"[bold green]数据表[/bold green] {written} 张 → {MASTER_DIR}")

    configs = _write_api_configs(args, runtime, catalog_version)
    copied = MasterData.copy_configs(ASSETS_DIR, MASTER_DIR)
    catalog_copied = MasterData.copy_catalog_artifacts(ASSETS_DIR, MASTER_DIR)
    console.print(
        f"[green]配置[/green] API {configs} 个 / 本地 {copied} 个 / catalog {catalog_copied} 个 "
        f"→ MasterData/Config"
    )
    return 0


# ---------------------------------------------------------------------------
# 子命令：painting
# ---------------------------------------------------------------------------

def cmd_painting(args: argparse.Namespace, limit: int | None = None) -> int:
    console.print(f"[bold cyan]=== 导出小人/大立绘 → {PAINTING_DIR} ===[/bold cyan]")
    result = Painting.export_all(
        assets_dir=Path(getattr(args, "assets_dir", ASSETS_DIR)),
        master_dir=Path(getattr(args, "master_dir", MASTER_DIR)),
        painting_dir=Path(getattr(args, "painting_dir", PAINTING_DIR)),
        jobs=getattr(args, "jobs", DEFAULT_JOBS),
        limit=getattr(args, "limit", 0) if limit is None else limit,
        force=getattr(args, "force", False),
        download=not getattr(args, "no_download", False),
    )
    return 0 if result["failed"] == 0 else 1


# ---------------------------------------------------------------------------
# 子命令：all
# ---------------------------------------------------------------------------

def cmd_all(args: argparse.Namespace) -> int:
    rc = cmd_assets(args)
    rc2 = cmd_masterdata(args)
    rc3 = 0
    if not getattr(args, "skip_painting", False):
        rc3 = cmd_painting(args, limit=0)
    return 0 if rc == 0 and rc2 == 0 and rc3 == 0 else 1


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
    parser.add_argument(
        "--version",
        default="",
        help="客户端版本号（默认从 APK versionName 或动态抓包结果自动识别）",
    )
    parser.add_argument(
        "--version-key",
        default="",
        help="reverse-version-key（默认从 APK global-metadata.dat 或动态抓包结果提取）",
    )
    parser.add_argument(
        "--endpoints",
        default="",
        help="接口映射 JSON（{\"startup\":uuid,\"session\":uuid,\"app_config\":uuid,\"masterdata\":uuid}）",
    )
    parser.add_argument("--catalog-version", default="", help="catalog 版本（默认取会话响应的 CatalogVersion）")
    parser.add_argument(
        "--no-capture",
        action="store_true",
        help="缺少接口映射时不自动 frida 抓取，直接报错",
    )


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=f"《{GAME_TITLE}》资源整合与数据表导出工具")
    sub = parser.add_subparsers(dest="command", required=True)

    p_assets = sub.add_parser("assets", help="APK + CDN 热更资产整合还原到 Assets/")
    _add_common_args(p_assets)
    p_assets.add_argument("--skip-apk", action="store_true", help="跳过 APK 解包")
    p_assets.add_argument("--list-only", action="store_true", help="只解析 catalog 并生成下载链接，不下载 bundle")
    p_assets.add_argument("--limit", type=int, default=0, help="最多下载多少个 bundle（0 为不限制）")
    p_assets.add_argument("--with-resources", action="store_true", help="catalog JSON 附带地址able → bundle 映射")

    p_master = sub.add_parser("masterdata", help="数据表（技能/角色/剧情等）与重要配置 → MasterData/")
    _add_common_args(p_master)

    p_paint = sub.add_parser("painting", help="导出 Unit 小人(sd_*)/大立绘(stand_img) → Painting/")
    p_paint.add_argument("--assets-dir", default=str(ASSETS_DIR), help="Assets 目录")
    p_paint.add_argument("--master-dir", default=str(MASTER_DIR), help="MasterData 目录")
    p_paint.add_argument("--painting-dir", default=str(PAINTING_DIR), help="立绘输出目录")
    p_paint.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help=f"并发线程数，默认 {DEFAULT_JOBS}")
    p_paint.add_argument("--force", action="store_true", help="覆盖已有立绘")
    p_paint.add_argument("--limit", type=int, default=0, help="只导出前 N 个 Unit bundle（0 为全部）")
    p_paint.add_argument("--no-download", action="store_true", help="缺少 Unit bundle 时不自动下载")

    p_all = sub.add_parser("all", help="依次执行 assets、masterdata、painting")
    _add_common_args(p_all)
    p_all.add_argument("--skip-apk", action="store_true", help="跳过 APK 解包")
    p_all.add_argument("--skip-painting", action="store_true", help="all 时跳过立绘导出")
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
    if command == "painting":
        return cmd_painting(args)
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
