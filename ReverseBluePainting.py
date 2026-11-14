from __future__ import annotations

"""反向蓝 / ReverseBlue 立绘导出（小人与大立绘）。

资产：Unit_<assetId>_<hash>.Android.bundle（CDN 热更，共 203 个），UnityPy 加载后：
      - Texture2D 名称 stand_img：大立绘（通常 4096x4096）
      - Texture2D 名称 sd_*（sd_normal / sd_stun）：小人立绘
数据表：Units.json / Characters.json / UnitAwakes.json 用于名称还原：
      UnitAwakes.UnitImageAssetId -> UnitId -> Units.CharacterId + Units.CostumeName
      -> Characters.FullName（全名，例如「雨兎堂 熾識」）
同一 UnitId 往往有两张立绘资源（UnitAwakes.AwakeCount 1-6 / 7-13 两套），
文件名用 Awake1-6 / Awake7-13 区分，避免同名覆盖。

参考分支：BanGDreamOurNotes（painting 子命令 + 名称还原 + _safe 文件名）、
StellaSora（Painting 模块 + ThreadPool + 重命名去重）、IronSaga/Painting.py、
MillenniumWarAigis/Painting.py、PathToNowhere/PTNPainting.py、AzurLane/AzurLanePainting.py。
"""

import json
import re
import threading
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any

import UnityPy
from PIL import Image
from rich.console import Console
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
)

import ReverseBlueBundle as Bundle

GAME_TITLE = "反向蓝"
SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
PAINTING_DIR = SCRIPT_DIR / "Painting"
UNIT_DIR_NAME = "Stand"
CHIBI_DIR_NAME = "Chibi"

STAND_TEXTURE = "stand_img"
CHIBI_PREFIX = "sd_"
BUNDLE_DIR = "Android"
UNIT_BUNDLE_RE = re.compile(r"^Unit_(?P<asset>.+?)_(?P<hash>[0-9a-f]{32})\.Android\.bundle$")
RICH_TAG_RE = re.compile(r"<[^>]+>")
_SAFE = str.maketrans({c: "＿" for c in '\\/:*?"<>|'})
CATALOG_GLOB = "master.Android.v*.catalog.json"

console = Console()


def _safe(text: str) -> str:
    return (text or "").translate(_SAFE).strip() or "未知"


def _strip_rich(text: str) -> str:
    return RICH_TAG_RE.sub("", text or "").strip()


def _load_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception:  # noqa: BLE001
        return None


def _is_blank(image: Image.Image) -> bool:
    """整张图 alpha 全 0 —— 引擎占位空图，直接丢弃。"""
    if "A" not in image.getbands():
        return False
    return image.getchannel("A").getbbox() is None


class UnitNames:
    """UnitImageAssetId -> 角色/衣装名，并区分同一 UnitId 的多套立绘（Awake 区间）。"""

    def __init__(self, master_dir: Path):
        units = _load_json(master_dir / "Units.json") or []
        chars = _load_json(master_dir / "Characters.json") or []
        awakes = _load_json(master_dir / "UnitAwakes.json") or []
        self.units = {row["Id"]: row for row in units if isinstance(row, dict) and "Id" in row}
        self.chars = {row["Id"]: row for row in chars if isinstance(row, dict) and "Id" in row}
        self.asset_ranges: dict[str, dict[str, Any]] = {}
        for row in awakes:
            if not isinstance(row, dict):
                continue
            asset = row.get("UnitImageAssetId")
            if not asset:
                continue
            item = self.asset_ranges.setdefault(
                asset, {"unit": row.get("UnitId"), "min": None, "max": None}
            )
            count = row.get("AwakeCount")
            if isinstance(count, int):
                item["min"] = count if item["min"] is None else min(item["min"], count)
                item["max"] = count if item["max"] is None else max(item["max"], count)
        self.unit_assets: dict[Any, list[str]] = {}
        for asset, info in self.asset_ranges.items():
            self.unit_assets.setdefault(info["unit"], []).append(asset)
        self.char_by_token: dict[str, dict[str, Any]] = {}
        for row in self.chars.values():
            for key in (row.get("EnglishCodeName"), row.get("CodeName"), row.get("KanaName")):
                if key:
                    self.char_by_token.setdefault(str(key).lower(), row)

    def _character_for(self, asset: str) -> tuple[dict[str, Any] | None, dict[str, Any] | None]:
        info = self.asset_ranges.get(asset)
        if info:
            unit = self.units.get(info["unit"])
            if unit:
                char = self.chars.get(unit.get("CharacterId"))
                if char:
                    return unit, char
        token = asset.split("_")[0].lower()
        char = self.char_by_token.get(token)
        if char:
            return None, char
        return None, None

    def stem(self, asset: str) -> tuple[str, str]:
        """返回 (文件名主干, 变体备注)；无法还原时用 asset id 本身。"""
        unit, char = self._character_for(asset)
        parts: list[str] = [GAME_TITLE]
        note = ""
        if char:
            name = _strip_rich(char.get("FullName") or "") or str(char.get("CodeName") or "")
            if name:
                parts.append(_safe(name))
        if unit:
            costume = _strip_rich(unit.get("CostumeName") or "")
            if costume:
                parts.append(_safe(costume))
        if unit and len(self.unit_assets.get(unit.get("Id"), [])) > 1:
            info = self.asset_ranges.get(asset) or {}
            low, high = info.get("min"), info.get("max")
            if low is not None and high is not None:
                note = f"Awake{low}-{high}" if low != high else f"Awake{low}"
                parts.append(note)
        if not char:
            parts.append(_safe(asset))
        elif not unit:
            # 角色名能对上但没进 UnitAwakes：用 asset id 尾段（如 1_0/1_1）区分
            tail = "_".join(asset.split("_")[-2:])
            if tail:
                note = note or tail
                parts.append(_safe(tail))
        return "_".join(part for part in parts if part), note


def iter_local_unit_bundles(assets_dir: Path) -> list[tuple[str, Path]]:
    result: list[tuple[str, Path]] = []
    for path in sorted((assets_dir / BUNDLE_DIR).glob("Unit_*.bundle")):
        match = UNIT_BUNDLE_RE.match(path.name)
        if not match:
            continue
        result.append((match.group("asset"), path))
    return result


def _load_catalog_bundles(assets_dir: Path) -> list[dict[str, Any]]:
    catalog_dir = assets_dir / "Catalog"
    for path in sorted(catalog_dir.glob(CATALOG_GLOB)):
        data = _load_json(path)
        if isinstance(data, dict) and isinstance(data.get("bundles"), list):
            return [
                entry
                for entry in data["bundles"]
                if isinstance(entry, dict)
                and str(entry.get("name") or "").startswith("Unit_")
                and entry.get("url")
            ]
    return []


def ensure_unit_bundles(
    assets_dir: Path,
    *,
    jobs: int = 8,
    download: bool = True,
) -> list[tuple[str, Path]]:
    """本地 Unit_* bundle 缺失时，按 Assets/Catalog 的可读 catalog 从 CDN 补齐。"""
    local = iter_local_unit_bundles(assets_dir)
    have = {asset for asset, _path in local}
    entries = _load_catalog_bundles(assets_dir)
    if not entries:
        if not local:
            raise SystemExit(
                f"没有 Unit_* bundle：{assets_dir / BUNDLE_DIR}\n先运行 python3 ReverseBlue.py assets 下载资产"
            )
        return local
    missing = [entry for entry in entries if not _has_local_asset(str(entry["name"]), have)]
    if not missing:
        return local
    total = sum(int(entry.get("size") or 0) for entry in missing)
    console.print(
        f"[cyan]补充下载[/cyan] 缺少 {len(missing)} 个 Unit bundle / "
        f"{total / 1048576:.1f} MB ..."
    )
    if not download:
        console.print("[yellow]已跳过下载（--no-download）[/yellow]")
        return local
    dest_dir = assets_dir / BUNDLE_DIR
    dest_dir.mkdir(parents=True, exist_ok=True)
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
    ) as progress:
        task = progress.add_task("下载 Unit bundle", total=total)

        def work(entry: dict[str, Any]) -> None:
            name = str(entry["name"])
            hash_value = str(entry.get("hash") or "")
            dest = dest_dir / f"{name}_{hash_value}.Android.bundle"
            Bundle.download(
                str(entry["url"]),
                dest,
                expected_size=int(entry.get("size") or 0),
                force=False,
                on_bytes=lambda count: progress.update(task, advance=count),
            )

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futures = [pool.submit(work, entry) for entry in missing]
            for future in as_completed(futures):
                try:
                    future.result()
                except Exception as exc:  # noqa: BLE001
                    console.print(f"[red]下载失败[/red] {exc}")
    return iter_local_unit_bundles(assets_dir)


def _has_local_asset(bundle_name: str, assets: set[str]) -> bool:
    asset = bundle_name[len("Unit_"):] if bundle_name.startswith("Unit_") else bundle_name
    return asset in assets


def _export_bundle(
    bundle_path: Path,
    names: UnitNames,
    asset: str,
    painting_dir: Path,
    *,
    force: bool,
) -> dict[str, Any]:
    stem, _note = names.stem(asset)
    stand_dir = painting_dir / UNIT_DIR_NAME
    chibi_dir = painting_dir / CHIBI_DIR_NAME
    stats = {"stand": 0, "chibi": 0, "skipped": 0, "blank": 0, "failed": 0}
    try:
        env = UnityPy.load(str(bundle_path))
    except Exception as exc:  # noqa: BLE001
        stats["failed"] += 1
        return {"stats": stats, "error": f"{asset}: {exc}"}
    targets: list[tuple[str, Image.Image]] = []
    try:
        for obj in env.objects:
            if getattr(obj.type, "name", None) != "Texture2D":
                continue
            try:
                data = obj.read()
            except Exception:  # noqa: BLE001
                continue
            name = str(data.m_Name or "")
            if name != STAND_TEXTURE and not name.startswith(CHIBI_PREFIX):
                continue
            image = data.image
            if image is None:
                continue
            targets.append((name, image))
    except Exception as exc:  # noqa: BLE001
        stats["failed"] += 1
        return {"stats": stats, "error": f"{asset}: {exc}"}
    for name, image in targets:
        kind = "stand" if name == STAND_TEXTURE else "chibi"
        out_dir = stand_dir if kind == "stand" else chibi_dir
        out_dir.mkdir(parents=True, exist_ok=True)
        target = out_dir / f"{stem}_{_safe(name)}.png"
        if target.is_file() and not force:
            stats["skipped"] += 1
            continue
        try:
            if _is_blank(image):
                stats["blank"] += 1
                continue
            image.save(target, "PNG")
            stats[kind] += 1
        except Exception as exc:  # noqa: BLE001
            stats["failed"] += 1
            return {"stats": stats, "error": f"{asset} {name}: {exc}"}
    return {"stats": stats, "error": None}


def export_all(
    *,
    assets_dir: Path = ASSETS_DIR,
    master_dir: Path = MASTER_DIR,
    painting_dir: Path = PAINTING_DIR,
    jobs: int = 8,
    limit: int = 0,
    force: bool = False,
    download: bool = True,
) -> dict[str, Any]:
    if not (master_dir / "Units.json").is_file():
        raise SystemExit(f"缺少 {master_dir / 'Units.json'}：先运行 python3 ReverseBlue.py masterdata")
    names = UnitNames(master_dir)
    bundles = ensure_unit_bundles(assets_dir, jobs=jobs, download=download)
    # --limit 时优先导出能还原出名字的立绘包（其余多为敌人/NPC 的贴图包）
    bundles.sort(key=lambda item: (item[0] not in names.asset_ranges, item[0]))
    if limit:
        bundles = bundles[:limit]
    if not bundles:
        raise SystemExit("没有可导出的 Unit_* bundle")

    painting_dir.mkdir(parents=True, exist_ok=True)
    # 同名主干串联去重（同一角色/衣装的不同变体一般已由 Awake 区间区分）
    used: set[str] = set()
    lock = threading.Lock()
    plans: list[tuple[Path, str]] = []
    for asset, path in bundles:
        stem, _note = names.stem(asset)
        with lock:
            if stem in used:
                suffix = "_".join(asset.split("_")[-2:]) or "dup"
                stem = f"{stem}_{_safe(suffix)}"
            used.add(stem)
        plans.append((path, asset))

    total_stand = total_chibi = skipped = blank = failed = 0
    errors: list[str] = []
    with Progress(
        SpinnerColumn(),
        TextColumn("[bold blue]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
    ) as progress:
        task = progress.add_task("导出小人/大立绘", total=len(plans))

        def work(item: tuple[Path, str]) -> dict[str, Any]:
            path, asset = item
            return _export_bundle(path, names, asset, painting_dir, force=force)

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futures = [pool.submit(work, item) for item in plans]
            for future in as_completed(futures):
                data = future.result()
                stats = data["stats"]
                total_stand += stats["stand"]
                total_chibi += stats["chibi"]
                skipped += stats["skipped"]
                blank += stats["blank"]
                failed += stats["failed"]
                if data["error"]:
                    errors.append(data["error"])
                    console.print(f"[yellow]导出失败[/yellow] {data['error']}")
                progress.advance(task)

    console.print(
        f"[green]立绘[/green] 大立绘 {total_stand} / 小人 {total_chibi} / 跳过 {skipped} / "
        f"空图 {blank} / 失败 {failed} → {painting_dir}"
    )
    if errors:
        console.print(f"[yellow]失败 {len(errors)} 例[/yellow]")
    return {
        "bundles": len(plans),
        "stand": total_stand,
        "chibi": total_chibi,
        "skipped": skipped,
        "blank": blank,
        "failed": failed,
        "dir": str(painting_dir),
    }
