from __future__ import annotations

import json
import os
import re
from concurrent.futures import ProcessPoolExecutor, ThreadPoolExecutor, as_completed
from pathlib import Path

from AMF3 import AMF3Decoder
from CompressUtil import lzma_decompress, maybe_zlib
from Config import CACHE_DIR, MASTER_DIR, PAINTING_DIR, resolve_assets
from Decode import IronSaga
from DescAtlas import composite_face, crop_sprite, layout_payload, parse_desc
from HttpUtil import http_download
from Packed import parse_factory_objects, parse_factory_pack
from PIL import Image

GAME_PREFIX = "机动战队大作战"
INVALID_FS = re.compile(r'[\\/:*?"<>|]')
OFFSET_RE = re.compile(r"^-?\d+,-?\d+(?:,[\d.]+)?$")
DATE_RE = re.compile(r"^\d{4}[-/]\d{1,2}[-/]\d{1,2}")
PATH_RE = re.compile(r"^(driver|dynamic|map)Asset/")

STEM_TAGS: tuple[tuple[str, str], ...] = (
    ("wanshengjie", "万圣节"),
    ("ertongjie", "儿童节"),
    ("yongzhuang", "泳装"),
    ("chunjie", "春节"),
    ("zhounian", "周年"),
    ("qingdian", "庆典"),
    ("shengdan", "圣诞"),
    ("huajia", "花嫁"),
    ("hunsha", "婚纱"),
    ("haibao", "海豹"),
    ("younian", "幼年"),
    ("zhanshi", "战士"),
    ("heiying", "黑影"),
    ("kuanggong", "矿工"),
    ("nongzhuang", "农装"),
    ("hushi", "护士"),
    ("yongzhuang", "泳装"),
)

VARIANT_RANK = {
    "黑影": 0,
    "黑影1": 0,
    "黑": 0,
    "默认": 1,
    "皮肤1": 1,
}

MECHA_UNIT_TYPES = ("机甲", "坦克", "战机", "Boss", "建筑", "母舰")
DRIVER_ID_MIN, DRIVER_ID_MAX = 520000, 529999
SHADOW_TEXT = re.compile(r"黑影|半黑")
SHADOW_STEM = re.compile(r"nanhei|nvhei|heiying|banhei", re.I)
NPC_TEXT = re.compile(r"过场NPC|支线NPC|挑战NPC|合众国NPC|联邦NPC|日之丸NPC|^NPC-\d")
MECHA_ART = re.compile(r"机甲|机体|单头|红莲螺岩")
# 立绘名/分组名里的怪物；不要用「兽|怪」子串，否则会误伤「少女与野兽」
MONSTER_ART = re.compile(r"触手|蜂群|霸主树|^霸主$|北境兽|裂隙兽|魔兽|小怪兽|未知怪兽|^怪兽$|兽\d+$|怪$|原种")
LEADING_CODE = re.compile(r"^\d+|^(TY|LY)")
NAME_SUFFIX = re.compile(r"(青年|超银河|BOSS用|幼年|觉醒皮)$")
GENERIC_UNIT_LABELS = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "骑士",
    "兽",
    "怪",
    "机甲",
    "青年",
    "皮肤",
    "默认",
    "黑影",
    "BOSS",
    "boss",
}
GENERIC_CHARS = {
    "士兵",
    "特战队员",
    "少女",
    "污染者",
    "机长",
    "老人",
    "路人",
    "群众",
    "女人",
    "男人",
    "怪兽",
    "未知怪兽",
}
GENERIC_ALIASES = {
    "表情",
    "觉醒",
    "礼服",
    "联动",
    "皮肤",
    "皮肤1",
    "默认",
    "默认皮肤",
    "无",
    "男",
    "女",
    "2",
    "3",
    "黑",
    "NPC",
    "超银河",
    "青年",
    "幼年",
    "无限",
    "母亲",
    "父亲",
}
ROLE_SUFFIX = ("士兵", "队员")


def _driver_aliases(name: str) -> list[str]:
    if not name:
        return []
    out = [name]
    stripped = LEADING_CODE.sub("", name)
    if stripped and stripped != name:
        out.append(stripped)
    trimmed = NAME_SUFFIX.sub("", stripped or name)
    if trimmed and trimmed not in out:
        out.append(trimmed)
    if "·" in name:
        out.append(name.split("·", 1)[0])
    if "-" in name:
        tail = name.rsplit("-", 1)[-1]
        if tail:
            out.append(tail)
    extra = []
    for n in out:
        if "丝" in n:
            extra.append(n.replace("丝", "斯"))
        if "斯" in n:
            extra.append(n.replace("斯", "丝"))
    out.extend(extra)
    return [n for n in out if n and n not in GENERIC_ALIASES]


def _load_factory_blob(assets: Path, name: str) -> bytes:
    local = MASTER_DIR / "database" / f"{name}.bin"
    if local.exists():
        return local.read_bytes()
    all_bin = assets / "bin" / "all.bin"
    data = maybe_zlib(all_bin.read_bytes())
    for item in parse_factory_pack(data):
        if item["name"] == name:
            return data[item["offset"] : item["offset"] + item["size"]]
    raise FileNotFoundError(f"未找到 {name}")


def _load_skin_blob(assets: Path) -> bytes:
    return _load_factory_blob(assets, "driverSkinFactory")


def _significant_unit_name(name: str) -> bool:
    """机体表里大量变体名叫「2」「骑士」，不能当分类键。"""
    if not name or name in GENERIC_UNIT_LABELS or name.isdigit():
        return False
    if len(name) < 2 or name.isascii():
        return False
    return True


def _build_kind_index(assets: Path) -> dict:
    _, drivers = parse_factory_objects(_load_factory_blob(assets, "driverFactory"))
    _, units = parse_factory_objects(_load_factory_blob(assets, "unitFactory"))
    _, skins = parse_factory_objects(_load_skin_blob(assets))
    sex_by_name: dict[str, set[str]] = {}
    sex_by_id: dict[int, str] = {}
    name_by_id: dict[int, str] = {}
    for it in drivers:
        fields = it.get("fields") or {}
        sex = fields.get(8) or ""
        sex_by_id[it["id"]] = sex
        name_by_id[it["id"]] = it["name"]
        for raw in (it["name"], fields.get(4)):
            for alias in _driver_aliases(raw or ""):
                sex_by_name.setdefault(alias, set()).add(sex)
    mecha_units: set[str] = set()
    for it in units:
        kind = (it.get("fields") or {}).get(0) or ""
        if any(tag in kind for tag in MECHA_UNIT_TYPES) and _significant_unit_name(it["name"]):
            mecha_units.add(it["name"])
    # 皮肤表 @4 只是分组名。分组里只要有一条挂到男/女驾驶员，该分组就是机师图册。
    # 艾比的驾驶员名叫「800鵸」，立绘分组却写「艾比」。
    pilot_groups: set[str] = set()
    for skin in skins:
        fields = skin.get("fields") or {}
        char = fields.get(4) or ""
        if not char or char in GENERIC_CHARS or SHADOW_TEXT.search(char):
            continue
        if char in mecha_units or MONSTER_ART.search(char):
            continue
        sexes = {
            sex_by_id.get(did, "")
            for did in (skin.get("ints") or {}).values()
            if DRIVER_ID_MIN <= did <= DRIVER_ID_MAX
        }
        drv_names = {
            name_by_id.get(did, "")
            for did in (skin.get("ints") or {}).values()
            if DRIVER_ID_MIN <= did <= DRIVER_ID_MAX
        }
        if any(SHADOW_TEXT.search(n or "") for n in drv_names):
            continue
        if not (sexes & {"男", "女"}):
            continue
        pilot_groups.add(char)
        for alias in _driver_aliases(char):
            sex_by_name.setdefault(alias, set()).update(sexes & {"男", "女"})
    person_names = {
        n
        for n, sexes in sex_by_name.items()
        if sexes & {"男", "女"} and n not in GENERIC_ALIASES and n not in GENERIC_CHARS and len(n) >= 2
    }
    person_names_by_len = sorted(person_names, key=len, reverse=True)
    return {
        "sex_by_name": sex_by_name,
        "sex_by_id": sex_by_id,
        "name_by_id": name_by_id,
        "mecha_units": mecha_units,
        "pilot_groups": pilot_groups,
        "person_names": person_names_by_len,
    }


def _sexes_of(name: str, kinds: dict) -> set[str]:
    if not name:
        return set()
    found: set[str] = set()
    table = kinds["sex_by_name"]
    for alias in _driver_aliases(name):
        found |= table.get(alias, set())
    return found


def _text_has_person(text: str, kinds: dict) -> bool:
    for name in kinds["person_names"]:
        if name in text:
            return True
    return False


def _is_mecha_gallery(char: str, kinds: dict) -> bool:
    """分组名本身是机体，而不是机师。可唐=简单机甲，但桶里塞了西蒙/优子等机师图。"""
    if not char:
        return False
    if char in kinds["pilot_groups"]:
        return False
    units = kinds["mecha_units"]
    if char in units:
        return True
    if _text_has_person(char, kinds):
        return False
    return any(u.startswith(char) and len(u) > len(char) for u in units if len(char) >= 2)


def _linked_driver_ids(item: dict) -> list[int]:
    return [
        v
        for v in (item.get("ints") or {}).values()
        if DRIVER_ID_MIN <= v <= DRIVER_ID_MAX
    ]


def _is_pilot_sex(sexes: set[str]) -> bool:
    return bool(sexes & {"男", "女"})


def _is_monster_or_mecha_art(char: str, name: str, stem: str) -> bool:
    if MECHA_ART.search(name or "") or MECHA_ART.search(char or "") or MECHA_ART.search(stem or ""):
        return True
    if MONSTER_ART.search(name or "") or MONSTER_ART.search(char or ""):
        return True
    low = (stem or "").lower()
    if "jiti" in low or "jijia" in low:
        return True
    return False


def _linked_is_shadow(item: dict, kinds: dict) -> bool:
    names = kinds.get("name_by_id") or {}
    return any(SHADOW_TEXT.search(names.get(did, "") or "") for did in _linked_driver_ids(item))


def _exclude_reason(item: dict, stem: str, char: str, kinds: dict, bucket_counts: dict[str, int]) -> str | None:
    """不是机师立绘则返回原因。机师=驾驶员表性别为男/女的角色。"""
    del bucket_counts
    name = item["name"]
    fields = item.get("fields") or {}
    if char == "黑影" or char.endswith("黑影"):
        return "黑影"
    if SHADOW_STEM.search(stem) or SHADOW_TEXT.search(char) or SHADOW_TEXT.search(name):
        return "黑影"
    if _linked_is_shadow(item, kinds):
        return "黑影"
    if char in GENERIC_CHARS or any(char.endswith(sfx) for sfx in ROLE_SUFFIX):
        return "NPC"
    if NPC_TEXT.search(name) and not _text_has_person(name, kinds):
        return "NPC"
    if stem.lower().startswith("npc") and (
        char in GENERIC_CHARS or len(char) <= 2 or any(char.endswith(sfx) for sfx in ROLE_SUFFIX)
    ):
        return "NPC"
    if _is_monster_or_mecha_art(char, name, stem):
        return "怪物/机甲"

    sexes = _sexes_of(char, kinds)
    for did in _linked_driver_ids(item):
        sexes |= {kinds["sex_by_id"].get(did, "")}
    if fields.get(8) in {"男", "女"}:
        sexes.add(fields[8])
    # 性别「其它」= 机体/怪物桩（巴尔、艾希X），不能因为皮肤名叫「皮肤1」就留下
    if sexes and sexes <= {"其它"}:
        return "机甲/怪物"
    is_pilot = (
        _is_pilot_sex(sexes)
        or char in kinds["pilot_groups"]
        or _text_has_person(name, kinds)
        or char in {n for n in kinds["person_names"] if n == char}
    )
    if _is_mecha_gallery(char, kinds):
        if _text_has_person(name, kinds):
            return None
        return "机甲"
    if not is_pilot:
        return "非机师"
    return None


def _visual_reject_reason(src: Path | str | Image.Image) -> str | None:
    """按像素去掉黑影剪影、底边被齐切的半身。"""
    im = src.convert("RGBA") if isinstance(src, Image.Image) else Image.open(src).convert("RGBA")
    orig_w, orig_h = im.size
    max_side = 160
    if max(orig_w, orig_h) > max_side:
        scale = max_side / max(orig_w, orig_h)
        im = im.resize(
            (max(1, round(orig_w * scale)), max(1, round(orig_h * scale))),
            Image.BILINEAR,
        )
    width, height = im.size
    pix = im.load()
    visible: list[tuple[int, int, int]] = []
    opaque = [[False] * width for _ in range(height)]
    xs: list[int] = []
    for y in range(height):
        for x in range(width):
            r, g, b, a = pix[x, y]
            if a <= 16:
                continue
            opaque[y][x] = True
            xs.append(x)
            visible.append((r, g, b))
    if len(visible) < 60:
        return "空图"
    n = len(visible)
    black = 0
    chroma_sum = 0.0
    for r, g, b in visible:
        mx, mn = max(r, g, b), min(r, g, b)
        chroma = mx - mn
        chroma_sum += chroma
        if (r + g + b) / 3 < 40 and chroma < 20:
            black += 1
    if black / n >= 0.92 and chroma_sum / n < 12:
        return "黑影"

    def longest_run(seq: list[bool]) -> int:
        best = cur = 0
        for bit in seq:
            if bit:
                cur += 1
                best = max(best, cur)
            else:
                cur = 0
        return best

    left = [opaque[y][0] for y in range(height)]
    right = [opaque[y][width - 1] for y in range(height)]
    if sum(left) / height > 0.72 and sum(right) / height > 0.72:
        return None
    x0, x1 = min(xs), max(xs)
    span = max(1, x1 - x0 + 1)
    bottom = opaque[height - 1]
    fill_b = sum(bottom[x0 : x1 + 1]) / span
    run_b = longest_run(bottom) / width
    occs = [sum(opaque[y][x0 : x1 + 1]) / span for y in range(max(0, height - 4), height)]
    mean = sum(occs) / len(occs)
    var = sum((o - mean) ** 2 for o in occs) / len(occs)
    straight = var < 0.012 and mean >= 0.45
    if orig_h <= 780 and fill_b >= 0.48 and run_b >= 0.22 and straight:
        return "半身"
    return None


def _purge_visual(dest: Path, records: list[dict]) -> int:
    removed = 0
    for rec in records:
        kept: list[dict] = []
        files = rec.get("_files") or [{"file": rec["filename"], "expression": None}]
        for item in files:
            path = dest / item["file"]
            if not path.exists():
                continue
            why = _visual_reject_reason(path)
            if why:
                path.unlink()
                removed += 1
                continue
            kept.append(item)
        rec["_files"] = kept
    return removed


def _sanitize(part: str) -> str:
    part = INVALID_FS.sub("＿", part.strip())
    part = part.replace("\n", " ").replace("\r", "")
    return part.strip(" ._")


def _stem_tag(stem: str) -> str | None:
    low = stem.lower()
    for key, label in STEM_TAGS:
        if low.endswith(key):
            return label
    return None


def _is_note_candidate(text: str) -> bool:
    if not text or text in {"无", "女", "男"}:
        return False
    if PATH_RE.match(text) or DATE_RE.match(text) or OFFSET_RE.match(text):
        return False
    if len(text) > 40:
        return False
    return True


def _variant_name(index_name: str, char: str, stem: str) -> str:
    name = (index_name or "").strip()
    tag = _stem_tag(stem)
    if char and char in name:
        _, _, right = name.partition(char)
        name = re.sub(r"^[-－—_\s]+", "", right) or name
    elif char:
        short = char.split("·")[0]
        if short and short in name:
            _, _, right = name.partition(short)
            name = re.sub(r"^[-－—_\s]+", "", right) or name
    if not name or name in {"皮肤1", "默认皮肤", "默认"}:
        return tag or "默认"
    if name.isdigit():
        return tag or f"皮肤{name}"
    if tag == "圣诞" and name in {"诞节", "诞"}:
        return "圣诞节"
    if name.endswith("皮肤1") and (len(name) <= 10 or name.startswith("LY") or "-" not in name[:4]):
        return tag or "默认"
    return name


def _notes(fields: dict[int, str], variant: str) -> list[str]:
    notes: list[str] = []
    artist = fields.get(60, "")
    if _is_note_candidate(artist) and "限定" not in artist and artist != variant:
        notes.append(artist)
    extra = fields.get(56, "")
    if extra and "限定" in extra and len(extra) <= 24 and extra not in notes:
        notes.append(extra)
    return notes


def painting_filename(char: str, variant: str, notes: list[str]) -> str:
    parts = [GAME_PREFIX, _sanitize(char) or "未知", _sanitize(variant) or "默认"]
    for note in notes:
        cleaned = _sanitize(note)
        if cleaned and cleaned not in parts:
            parts.append(cleaned)
    name = "_".join(parts) + ".png"
    if len(name) > 240:
        name = "_".join(parts[:4]) + ".png"
    return name


def _unique_filename(filename: str, used: set[str], extra: str = "") -> str:
    fn = filename
    if fn in used and extra:
        alt = filename[:-4] + f"_{extra}.png"
        if alt not in used:
            fn = alt
    n = 2
    stem_fn = fn
    while fn in used:
        fn = stem_fn[:-4] + f"_{n}.png"
        n += 1
    used.add(fn)
    return fn


def _rank(variant: str) -> int:
    return VARIANT_RANK.get(variant, 10)


def collect_paintings(skin_blob: bytes, kinds: dict | None = None, include_other: bool = False) -> list[dict]:
    _cls, items = parse_factory_objects(skin_blob)
    bucket_counts: dict[str, int] = {}
    parsed: list[tuple[dict, str, str, dict]] = []
    for item in items:
        fields: dict[int, str] = item.get("fields") or {}
        image = next(
            (
                v
                for v in fields.values()
                if v.startswith("driverAsset/ex.image.") and "spine" not in v
            ),
            None,
        )
        if not image:
            continue
        stem = image.rsplit(".", 1)[-1]
        if stem.startswith("ex.image."):
            stem = stem[len("ex.image.") :]
        char = fields.get(4) or "未知"
        parsed.append((item, stem, char, fields))
        bucket_counts[char] = bucket_counts.get(char, 0) + 1

    by_stem: dict[str, dict] = {}
    skipped = 0
    for item, stem, char, fields in parsed:
        if kinds and not include_other:
            why = _exclude_reason(item, stem, char, kinds, bucket_counts)
            if why:
                skipped += 1
                continue
        variant = _variant_name(item["name"], char, stem)
        notes = _notes(fields, variant)
        image = next(
            (
                v
                for v in fields.values()
                if v.startswith("driverAsset/ex.image.") and "spine" not in v
            ),
            "",
        )
        rec = {
            "stem": stem,
            "char": char,
            "variant": variant,
            "notes": notes,
            "image": image,
            "skin": item["name"],
            "filename": painting_filename(char, variant, notes),
        }
        old = by_stem.get(stem)
        if old is None or _rank(variant) > _rank(old["variant"]):
            if old and old["notes"]:
                merged = rec["notes"]
                for n in old["notes"]:
                    if n not in merged:
                        merged.append(n)
                rec["notes"] = merged
                rec["filename"] = painting_filename(char, rec["variant"], rec["notes"])
            by_stem[stem] = rec
    used: set[str] = set()
    for rec in by_stem.values():
        rec["filename"] = _unique_filename(rec["filename"], used, rec["stem"])
    if kinds and not include_other:
        recs = list(by_stem.values())
        print(f"[paint] 过滤非机师 {skipped}，保留 {len(recs)}")
        return recs
    return list(by_stem.values())


def _find_desc(assets: Path) -> Path:
    for cand in (assets / "desc" / "desc.txt", assets / "texture" / "desc.txt"):
        if cand.exists():
            return cand
    raise FileNotFoundError("未找到 desc.txt")


def _gp_desc(cdn: str) -> tuple[list[dict], list]:
    path = CACHE_DIR / "asset_apk_gp_desc"
    url = f"{cdn.rstrip('/')}/asset_apk/gp/desc"
    http_download(url, path)
    obj = AMF3Decoder(lzma_decompress(path.read_bytes())).read_element()
    return obj[0], obj[1]


def _archive_ranges(archives: list) -> list[tuple[str, int, int, int]]:
    prev = 0
    rows = []
    for ar in archives:
        end = int(ar[2])
        rows.append((str(ar[0]), int(ar[1]), prev, end))
        prev = end
    return rows


def _cdn_base() -> str:
    from HotUpdate import parse_client_version, parse_game_setting, fetch_index, match_index, parse_index, fetch_info, normalize_url

    assets = resolve_assets()
    setting = parse_game_setting(assets)
    version = parse_client_version(assets)
    row = match_index(parse_index(fetch_index()), setting.get("platform", "oc"), setting.get("channelId", "taptap"), version)
    info = fetch_info(row["server"], setting.get("platform", "oc"), version, setting.get("channelId", "taptap"), version)
    return normalize_url(str(info.get("static_url") or row["static"]))


def _local_image(assets: Path, stem: str) -> Path | None:
    name_enc = f"ex.image.{stem}.enc"
    name_cet = f"ex.image.{stem}.cet"
    for folder in (
        assets / "texture" / "bigMapEncEtc",
        assets / "texture" / "bigMapComEtc",
        assets / "texture",
    ):
        if not folder.exists():
            continue
        for name in (name_enc, name_cet):
            p = folder / name
            if p.exists():
                return p
    hits = list(assets.rglob(name_enc)) + list(assets.rglob(name_cet))
    return hits[0] if hits else None


def _needed_archives(file_list: list[dict], ranges: list[tuple[str, int, int, int]], stems: set[str]) -> dict[str, list[dict]]:
    wanted = {f"ex.image.{s}.cet" for s in stems} | {f"ex.image.{s}.enc" for s in stems}
    grouped: dict[str, list[dict]] = {}
    for i, item in enumerate(file_list):
        name = str(item.get("name") or "")
        path = str(item.get("path") or "")
        if name not in wanted and not any(path.endswith(w) for w in wanted):
            continue
        if "spine" in path:
            continue
        for ar_name, _size, start, end in ranges:
            if start <= i < end:
                grouped.setdefault(ar_name, []).append(item)
                break
    return grouped


def _extract_from_archive(pack: Path, files: list[dict], dest_dir: Path) -> int:
    data = pack.read_bytes()
    n = 0
    for item in files:
        pos = int(item.get("position") or 0)
        size = int(item.get("size") or 0)
        chunk = data[pos : pos + size]
        if item.get("compress"):
            chunk = lzma_decompress(chunk)
        name = str(item.get("name") or Path(str(item.get("path"))).name)
        out = dest_dir / name
        if not (out.exists() and out.stat().st_size == len(chunk)):
            out.write_bytes(chunk)
        n += 1
    return n


def _expand_outputs(rec: dict, layout: dict | None, dest: Path, used: set[str]) -> list[dict]:
    outputs = [{"dest": str(dest / rec["filename"]), "face": None}]
    rec["_files"] = [{"file": rec["filename"], "expression": None}]
    if not layout:
        return outputs
    for face in layout.get("faces") or []:
        label = str(face.get("label") or "表情")
        fn = _unique_filename(
            painting_filename(rec["char"], rec["variant"], rec["notes"] + [label]),
            used,
            rec["stem"],
        )
        outputs.append({"dest": str(dest / fn), "face": face})
        rec["_files"].append({"file": fn, "expression": label})
    return outputs


def _make_job(
    rec: dict,
    src: Path,
    dest: Path,
    layout: dict | None,
    used: set[str],
    check_visual: bool = True,
) -> dict:
    has_faces = bool(layout and layout.get("faces"))
    return {
        "src": str(src),
        "sizes": rec["_sizes"],
        "layout": layout,
        "outputs": _expand_outputs(rec, layout, dest, used),
        "force": has_faces,
        "check_visual": check_visual,
    }


def _decode_one(job: dict) -> tuple[str, str]:
    src = job["src"]
    sizes = job["sizes"]
    outputs: list[dict] = job["outputs"]
    layout = job.get("layout")
    force = bool(job.get("force"))
    check_visual = bool(job.get("check_visual"))
    try:
        if (
            not force
            and outputs
            and all(Path(o["dest"]).exists() and Path(o["dest"]).stat().st_size > 0 for o in outputs)
        ):
            return ("skip", outputs[0]["dest"])
        atlas = IronSaga.DecodeImage(Path(src), sizes)
        if layout and layout.get("body"):
            base = crop_sprite(atlas, layout["body"])
        else:
            base = atlas.convert("RGBA")
        Path(outputs[0]["dest"]).parent.mkdir(parents=True, exist_ok=True)
        wrote = 0
        rejected = 0
        for out in outputs:
            face = out.get("face")
            img = composite_face(base, layout["body"], face, atlas) if face and layout else base
            if check_visual and _visual_reject_reason(img):
                rejected += 1
                continue
            img.save(out["dest"])
            wrote += 1
        if wrote == 0 and rejected:
            return ("reject", outputs[0]["dest"])
        return ("ok", f"{outputs[0]['dest']} x{wrote}")
    except Exception as exc:
        return ("err", f"{src}: {exc}")


def export_paintings(
    assets: Path | None = None,
    dest: Path | None = None,
    workers: int | None = None,
    download: bool = True,
    include_other: bool = False,
) -> None:
    assets = assets or resolve_assets()
    dest = dest or PAINTING_DIR
    dest.mkdir(parents=True, exist_ok=True)
    workers = workers or os.cpu_count() or 4
    cache_portraits = CACHE_DIR / "portraits"
    cache_portraits.mkdir(parents=True, exist_ok=True)

    print("[paint] 解析机师皮肤表")
    kinds = None if include_other else _build_kind_index(assets)
    records = collect_paintings(_load_skin_blob(assets), kinds=kinds, include_other=include_other)
    print(f"[paint] {len(records)} 张立绘")
    desc_path = _find_desc(assets)
    sizes = IronSaga.GetTexSize(desc_path)
    atlas_map = parse_desc(desc_path)
    used_names = {r["filename"] for r in records}

    missing: list[dict] = []
    jobs: list[dict] = []
    skipped_size = 0

    def _src_for(rec: dict) -> Path | None:
        local = _local_image(assets, rec["stem"])
        if local:
            return local
        cached = cache_portraits / f"ex.image.{rec['stem']}.cet"
        return cached if cached.exists() else None

    def _layout_for(rec: dict) -> dict | None:
        sec = atlas_map.get(f"ex.image.{rec['stem']}")
        return layout_payload(sec) if sec else None

    for rec in records:
        section = f"ex.image.{rec['stem']}"
        sz = sizes.get(section)
        if not sz:
            skipped_size += 1
            continue
        rec["_sizes"] = sz
        src = _src_for(rec)
        if src:
            jobs.append(_make_job(rec, src, dest, _layout_for(rec), used_names, check_visual=not include_other))
        else:
            missing.append(rec)

    expr_jobs = sum(1 for j in jobs if j.get("force"))
    expr_files = sum(len(j["outputs"]) - 1 for j in jobs if j.get("force"))
    print(f"[paint] 本地/缓存 {len(jobs)}，待下载 {len(missing)}，无尺寸 {skipped_size}")
    if expr_jobs:
        print(f"[paint] 表情图集 {expr_jobs}，差分 {expr_files} 张")

    if missing and download:
        cdn = _cdn_base()
        print(f"[paint] CDN {cdn}")
        file_list, archives = _gp_desc(cdn)
        ranges = _archive_ranges(archives)
        grouped = _needed_archives(file_list, ranges, {r["stem"] for r in missing})
        print(f"[paint] 需下载 {len(grouped)} 个 gp 分包")

        def _dl(name: str, size: int) -> Path:
            url = f"{cdn.rstrip('/')}/asset_apk/gp/{name}"
            pack = CACHE_DIR / "asset_apk" / name
            print(f"[paint] 下载 {name} ({size} 字节)")
            return http_download(url, pack, timeout=600, expected_size=size)

        size_by_name = {ar[0]: int(ar[1]) for ar in archives}
        with ThreadPoolExecutor(max_workers=min(6, max(1, len(grouped)))) as pool:
            futs = {pool.submit(_dl, name, size_by_name[name]): name for name in grouped}
            for fut in as_completed(futs):
                name = futs[fut]
                pack = fut.result()
                n = _extract_from_archive(pack, grouped[name], cache_portraits)
                print(f"[paint] {name} 抽出 {n} 张立绘")

        still = []
        for rec in missing:
            cached = cache_portraits / f"ex.image.{rec['stem']}.cet"
            enc = cache_portraits / f"ex.image.{rec['stem']}.enc"
            src = cached if cached.exists() else (enc if enc.exists() else None)
            if src:
                jobs.append(_make_job(rec, src, dest, _layout_for(rec), used_names, check_visual=not include_other))
            else:
                still.append(rec["stem"])
        if still:
            print(f"[paint] 仍缺 {len(still)} 张，例如 {still[:8]}")

    print(f"[paint] 解密 {len(jobs)} 张，进程数 {workers}")
    ok = skip = err = reject = 0
    with ProcessPoolExecutor(max_workers=workers) as pool:
        futs = [pool.submit(_decode_one, job) for job in jobs]
        done = 0
        total = len(futs)
        for fut in as_completed(futs):
            status, msg = fut.result()
            done += 1
            if status == "ok":
                ok += 1
            elif status == "skip":
                skip += 1
            elif status == "reject":
                reject += 1
            else:
                err += 1
                print(f"[paint] 失败 {msg}")
            if done % 100 == 0 or done == total:
                print(f"[paint] {done}/{total} 成功 {ok} 跳过 {skip} 过滤 {reject} 失败 {err}")

    vis = 0
    if not include_other:
        vis = _purge_visual(dest, records)
        if vis:
            print(f"[paint] 像素过滤黑影/半身 {vis}")

    index_rows = []
    for rec in records:
        files = rec.get("_files") or [{"file": rec["filename"], "expression": None}]
        if not files:
            continue
        for item in files:
            notes = list(rec["notes"])
            if item.get("expression"):
                notes.append(item["expression"])
            index_rows.append(
                {
                    "stem": rec["stem"],
                    "file": item["file"],
                    "char": rec["char"],
                    "variant": rec["variant"],
                    "notes": notes,
                    "expression": item.get("expression"),
                }
            )
    (dest / "index.json").write_text(
        json.dumps(index_rows, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    keep_files = {row["file"] for row in index_rows}
    removed = 0
    for png in dest.glob("*.png"):
        if png.name not in keep_files:
            png.unlink()
            removed += 1
    if removed:
        print(f"[paint] 删除过期立绘 {removed}")
    print(f"[paint] Painting -> {dest} （成功 {ok}，已存在 {skip}，失败 {err}）")
