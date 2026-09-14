"""立绘导出。

资产：``Card<ID>[_sp]_<stage>.aar``（``stage`` 越大包含越多阶段；``_sp`` 是同一阶段的另一套服装）
      -> 内含 ``<ID>_card_<stage>.atx``（ALTX 贴图）
数据表：``NameText.atb`` —— 资源编号就是 1 起算的 id：**第 i 行属于编号 i+1**
名字取 ``Message``（全名，如「姫山賊イメリア」），``RealName`` 是短名（「イメリア」）。
纯透明（alpha 全 0）的立绘是空图，导出时直接跳过
"""

from __future__ import annotations

import re
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from PIL import Image
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
)

import AlArchive
import AlCompress
import AlImage
import AlTable
import HotUpdate
from Config import CACHE_DIR, ROOT

GAME_TITLE = "千年戦争アイギス"
PAINTING_DIR = ROOT / "Painting"
TABLE_DIR = CACHE_DIR / "tables"

CARD_RE = re.compile(r"^Card(\d{4})(_sp)?_(\d+)\.aar$", re.IGNORECASE)
SKIN_RE = re.compile(r"^SkinCard(\d{4})(_sp)?_(\d+)\.aar$", re.IGNORECASE)
#: 阶段名（游戏里就是「第一覚醒/第二覚醒」，第三段按同样规则命名）
STAGE_NAME = {0: "通常", 1: "第一覚醒", 2: "第二覚醒", 3: "第三覚醒"}
NEEDED_TABLES = ("NameText.atb", "SkinShop.atb", "SkinPackage.atb")
_SAFE = str.maketrans({c: "＿" for c in '\\/:*?"<>|'})


# ------------------------------------------------------------------ 数据表


def _safe(text: str) -> str:
    return (text or "").translate(_SAFE).strip() or "未知"


def _load_table(path: Path) -> list[dict]:
    data = path.read_bytes()
    if data[:4] == b"ALL4":
        data = AlCompress.decode_all4(data)
    table = AlTable.parse_table(data)
    return AlTable.iter_records(data, table)


def ensure_tables(jobs: int = 8) -> tuple[list[dict], list[dict], list[dict]]:
    """保证 ``NameText``/``SkinShop``/``SkinPackage`` 在本地，返回三张表。"""
    missing = [name for name in NEEDED_TABLES if not (TABLE_DIR / name).is_file()]
    if missing:
        entries = [
            e for e in HotUpdate.load_manifest("base") if e.name in set(missing)
        ]
        print(f"[painting] 缺数据表 {missing}，先从清单下载")
        TABLE_DIR.mkdir(parents=True, exist_ok=True)
        HotUpdate.download(
            entries,
            jobs=jobs,
            on_entry=lambda e, data, cached: (TABLE_DIR / e.name).write_bytes(data),
        )
    names = _load_table(TABLE_DIR / "NameText.atb")
    shop = _load_table(TABLE_DIR / "SkinShop.atb")
    package = _load_table(TABLE_DIR / "SkinPackage.atb")
    return names, shop, package


def character_name(card_id: int, names: list[dict]) -> tuple[str, str]:
    """返回 ``(文件名用的名字, 全名)``。"""
    # 资源编号 = NameText 的 1 起算 id：编号 1 -> 行 0「主人公」，编号 185 -> 行 184「姫山賊イメリア」。
    # 不要绕 SyOfsImg 的 _CardNameID，那 5 张卡会和立绘对不上（例如 978 = 鉄泉の守護者レアン）。
    if not 1 <= card_id <= len(names):
        return f"Card{card_id:04d}", ""
    row = names[card_id - 1]
    full = (row.get("Message") or "").strip()
    return full or (row.get("RealName") or "").strip() or f"Card{card_id:04d}", full


# ------------------------------------------------------------------ 立绘资产


def plan_assets(entries: list) -> list[tuple[int, bool, int, object]]:
    """``(CardID, 是否 SP, 最高阶段, 清单条目)``，每个卡只取阶段最大的那个包。"""
    best: dict[tuple[int, bool], tuple[int, object]] = {}
    for entry in entries:
        match = CARD_RE.match(entry.name)
        if not match:
            continue
        card_id, sp, stage = int(match.group(1)), bool(match.group(2)), int(match.group(3))
        key = (card_id, sp)
        if key not in best or stage > best[key][0]:
            best[key] = (stage, entry)
    return [
        (card_id, sp, stage, entry)
        for (card_id, sp), (stage, entry) in sorted(best.items())
    ]


def extract_card(data: bytes, card_id: int, sp: bool, dest_dir: Path) -> int:
    """把一个 ``Card*.aar`` 里的所有阶段贴图导出成 PNG。"""
    if data[:4] == b"ALL4":
        data = AlCompress.decode_all4(data)
    if data[:4] != b"ALAR":
        return 0
    written = 0
    for member, blob in AlArchive.iter_members(data):
        if blob[:4] == b"ALL4":
            blob = AlCompress.decode_all4(blob)
        if blob[:4] != b"ALTX":
            continue
        try:
            atlas = AlImage.parse_atlas(blob)
        except ValueError:
            continue
        if atlas.image is None:
            continue
        target = dest_dir / f"{_safe(member.rsplit('.', 1)[0])}.png"
        atlas.image.save(target)
        written += 1
    return written


def skin_units(shop: list[dict], package: list[dict]) -> dict[int, int]:
    """``SkinCard 编号 -> 角色编号``。

    ``SkinShop.SkinId`` -> ``SkinPackage.ConfigId`` 拿到 ``IllustrationId``（= 资产编号），
    ``SkinShop.SkinCardId`` 才是角色编号。上架轮换后旧皮肤没有 SkinShop 行，就对不出来了。
    """
    by_cfg = {row["ConfigId"]: row for row in package}
    out: dict[int, int] = {}
    for row in shop:
        pack = by_cfg.get(row["SkinId"])
        if pack:
            out[int(pack["IllustrationId"])] = int(row["SkinCardId"])
    return out


def plan_skins(entries: list, shop: list[dict], package: list[dict]) -> list[tuple[int, int, bool, object]]:
    """``(角色编号或 0, SkinCard 编号, 是否 SP, 清单条目)``，每个皮肤只取阶段最大的包。"""
    units = skin_units(shop, package)
    best: dict[tuple[int, bool], tuple[int, object]] = {}
    for entry in entries:
        match = SKIN_RE.match(entry.name)
        if not match:
            continue
        skin_no, sp, stage = int(match.group(1)), bool(match.group(2)), int(match.group(3))
        key = (skin_no, sp)
        if key not in best or stage > best[key][0]:
            best[key] = (stage, entry)
    return [
        (units.get(skin_no, 0), skin_no, sp, entry)
        for (skin_no, sp), (_stage, entry) in sorted(best.items())
    ]


def export(
    *,
    jobs: int = 8,
    limit: int = 0,
    force: bool = False,
    include_sp: bool = True,
    cards: set[int] | None = None,
) -> dict:
    """下载缺失资产 -> 导出立绘到 ``Painting/``（``cards`` 只导指定 CardID）。"""
    entries = HotUpdate.load_manifest("base")
    names, shop, package = ensure_tables(jobs)

    plan = plan_assets(entries)
    if not include_sp:
        plan = [item for item in plan if not item[1]]
    if cards is not None:
        plan = [item for item in plan if item[0] in cards]
    if limit > 0:
        plan = plan[:limit]
    skin_plan = plan_skins(entries, shop, package)
    if not include_sp:
        skin_plan = [item for item in skin_plan if not item[2]]
    if not plan and not skin_plan:
        print("[painting] 清单里没有 Card*.aar")
        return {"cards": 0, "images": 0}

    PAINTING_DIR.mkdir(parents=True, exist_ok=True)
    archives = [item[3] for item in plan] + [item[3] for item in skin_plan]
    totals = sum(entry.size for entry in archives)
    print(
        f"[painting] {len(plan)} 个立绘包 + {len(skin_plan)} 个皮肤包"
        f"（{totals / 1048576:.1f} MB），开始下载/更新"
    )
    HotUpdate.download(archives, jobs=jobs)

    seen_names: set[str] = set()
    jobs_list: list[tuple[Path, str, str, int]] = []

    def card_stem(card_id: int) -> str:
        return f"{GAME_TITLE}_{_safe(character_name(card_id, names)[0])}"

    def take_stem(stem: str, note: str, tag: str) -> str:
        """同名不同卡（换装/联动）时加 ``tag`` 区分；SP 与本体算两条。"""
        key = f"{stem}_{note}" if note else stem
        if key in seen_names:
            stem = f"{stem}_{tag}"
        seen_names.add(f"{stem}_{note}" if note else stem)
        return stem

    for card_id, sp, _stage, entry in plan:
        note = "SP" if sp else ""
        stem = take_stem(card_stem(card_id), note, f"Card{card_id:04d}")
        cache_path = HotUpdate.FILE_CACHE / "files" / entry.group / entry.md5
        jobs_list.append((cache_path, stem, note, card_id))

    for unit_id, skin_no, sp, entry in skin_plan:
        note = "SP" if sp else ""
        raw = f"{card_stem(unit_id)}_衣装{skin_no:04d}" if unit_id else f"{GAME_TITLE}_衣装{skin_no:04d}"
        stem = take_stem(raw, note, f"衣装{skin_no:04d}")
        cache_path = HotUpdate.FILE_CACHE / "files" / entry.group / entry.md5
        jobs_list.append((cache_path, stem, note, skin_no))

    #: 有自己独立包的编号（卡 + 皮肤）；包里内嵌别的卡的贴图时，那种成员交给它的包去写
    owned_cards = {card_id for card_id, _sp, _stage, _e in plan}
    owned_cards |= {skin_no for _unit, skin_no, _sp, _e in skin_plan}

    written = skipped = blank = foreign = failed = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[bold blue]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
    ) as progress:
        task = progress.add_task("导出立绘", total=len(jobs_list))

        def work(item: tuple[Path, str, str, int]) -> tuple[str, int, int]:
            cache_path, stem, note, bundle_no = item
            if not force and any(PAINTING_DIR.glob(f"{stem}_*{('_' + note) if note else ''}.png")):
                return "skip", 0, 0
            count, empties, others = _extract_to(
                cache_path.read_bytes(), PAINTING_DIR, stem, note, names, bundle_no, owned_cards
            )
            if count:
                return "ok", empties, others
            return ("blank" if empties else "fail"), empties, others

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            for status, empties, others in pool.map(work, jobs_list):
                if status == "ok":
                    written += 1
                elif status == "skip":
                    skipped += 1
                else:
                    failed += 0 if status == "blank" else 1
                blank += empties
                foreign += others
                progress.advance(task)

    print(
        f"[painting] 写出 {written} / 跳过 {skipped} / 空图丢弃 {blank} / 别的卡的成员 {foreign}"
        f" / 失败 {failed} -> {PAINTING_DIR}"
    )
    return {
        "cards": len(plan),
        "images": written,
        "skipped": skipped,
        "blank": blank,
        "foreign": foreign,
        "failed": failed,
    }


def _is_blank(image: Image.Image) -> bool:
    """整张图 alpha 全 0（没有像素）——引擎里的占位空图。"""
    if "A" not in image.getbands():
        return False
    return image.getchannel("A").getbbox() is None


def _extract_to(
    data: bytes,
    dest_dir: Path,
    stem: str,
    note: str,
    names: list[dict],
    bundle_no: int,
    owned_cards: set[int],
        ) -> tuple[int, int, int]:
    """把包里的贴图写成 ``<stem>_<阶段>[_备注].png``；返回 ``(写出数, 空图数, 别的卡的成员数)``。"""
    if data[:4] == b"ALL4":
        data = AlCompress.decode_all4(data)
    if data[:4] != b"ALAR":
        return 0, 0, 0
    written = empty = foreign = 0
    for member, blob in AlArchive.iter_members(data):
        if blob[:4] == b"ALL4":
            blob = AlCompress.decode_all4(blob)
        if blob[:4] != b"ALTX":
            continue
        match = re.search(r"_card_(\d+)\.atx$", member, re.IGNORECASE)
        stage = int(match.group(1)) if match else 0
        # 少数包会内嵌「别的卡」的贴图（如 Card1386 里带 1387、Card2781 里带 2779），
        # 直接按包编号命名会把它写成别人的名字甚至互相覆盖：有自己的包就跳过，
        # 没有自己的包时用成员编号命名，保证不丢。
        owner = re.match(r"^(\d+)_card_", member)
        member_card = int(owner.group(1)) if owner else bundle_no
        if member_card != bundle_no:
            if member_card in owned_cards:
                foreign += 1
                continue
            stem = f"{GAME_TITLE}_{_safe(character_name(member_card, names)[0])}"
        try:
            atlas = AlImage.parse_atlas(blob)
        except ValueError:
            continue
        if atlas.image is None:
            continue
        if _is_blank(atlas.image):
            empty += 1
            continue
        parts = [stem, STAGE_NAME.get(stage, f"阶段{stage}")]
        if note:
            parts.append(note)
        target = dest_dir / f"{'_'.join(parts)}.png"
        atlas.image.save(target)
        written += 1
    return written, empty, foreign
