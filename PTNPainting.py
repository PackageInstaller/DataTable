"""无期迷途立绘导出。

从 APK Lua 配表收集 images/paintings/{角色}/lihui_* 路径（排除 dialog），
用 ComputeFastHash + res_manifest 定位 hashed bundle，只下载相关 chunk，
UnityPy 导出 PNG 到 Painting/无期迷途_{角色名}_{皮肤或变体}.png。
跳过 600×600 截取图（战姿2、默认3、皮肤名3 等）。
"""
from __future__ import annotations

import os
import re
import struct
import zipfile
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Sequence, Tuple

import PTNConvert
import PTNDecrypt
import PTNExtract
from rich.console import Console
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
)

GAME_TITLE = "无期迷途"
PAINTING_INFIX = "images/paintings/"
SCRIPT_XOR = 0x65
WANTED_LUA = {
    "portrait_res": "@data/portrait_res.lua",
    "skin_config": "@data/skin_config.lua",
    "hero": "@data/hero.lua",
    "configtexts": "@data/lang/zh-hans/configtexts.lua",
}
VARIANT_LABELS = {
    "default": "默认",
    "zhanzi": "战姿",
    "prisonphoto": "监狱",
}
# 战姿2 / 默认3 / 皮肤名3 以及局长皮肤头像裁切，均为 600×600。
CROPPED_PIXEL_SIZE = (600, 600)
_GENDER_TAIL = re.compile(r"_(m\d*|f\d*)$", re.I)
_SKIN_CROP_VARIANT = re.compile(r"^[a-z]+3$")
_PLAYER_SKIN_CROP = re.compile(r"^zhanzi_\d+$")
FAST_HASH_M = 0x880355F21E6D1965
FAST_HASH_N = 0x2127599BF4325C37
U64 = 0xFFFFFFFFFFFFFFFF

console = Console()


def lua_intern(val: bytes) -> bytes:
    return val[:-1] if val.endswith(b"\x00") else val


def compute_fast_hash(data: bytes, seed: int) -> int:
    """libil2cpp HashUtils.ComputeFastHash（UTF-8 字节）。"""

    def mix(v1: int, v2: int) -> int:
        x = (FAST_HASH_N * (v2 ^ (v2 >> 23))) & U64
        return (FAST_HASH_M * (x ^ v1 ^ (x >> 47))) & U64

    def avalanche(h: int) -> int:
        x = (FAST_HASH_N * (h ^ (h >> 23))) & U64
        return x ^ (x >> 47)

    seed &= U64
    if not data:
        return avalanche(seed)
    h = (seed ^ (FAST_HASH_M * len(data))) & U64
    i = 0
    n = len(data)
    while i + 8 <= n:
        block = int.from_bytes(data[i : i + 8], "little")
        h = mix(h, block)
        i += 8
    if i < n:
        leftover = 0
        for k, b in enumerate(data[i:]):
            leftover |= b << (8 * k)
        h = mix(h, leftover)
    return avalanche(h)


def sanitize_filename(name: str) -> str:
    name = re.sub(r'[\\/:*?"<>|\x00-\x1f]', "_", name).strip().rstrip(".")
    return name or "unnamed"


def unpack_array(blob: bytes, fmt: str) -> Optional[Tuple[Any, ...]]:
    size = struct.calcsize("<" + fmt)
    if size <= 0 or not blob or len(blob) % size:
        return None
    n = len(blob) // size
    if n < 2:
        return None
    return struct.unpack("<" + fmt * n, blob)


# ---------------------------------------------------------------------------
# FlatBuffers: GameBundleManifest / GameBundleInfo
# ---------------------------------------------------------------------------


def _fb_offset(data: bytes, tbl: int, voff: int) -> int:
    vt = tbl - struct.unpack_from("<i", data, tbl)[0]
    vtsize = struct.unpack_from("<H", data, vt)[0]
    if voff < 0 or voff + 2 > vtsize:
        return 0
    return struct.unpack_from("<H", data, vt + voff)[0]


def _fb_string(data: bytes, addr: int) -> str:
    rel = struct.unpack_from("<I", data, addr)[0]
    saddr = addr + rel
    n = struct.unpack_from("<I", data, saddr)[0]
    raw = data[saddr + 4 : saddr + 4 + n]
    if raw.endswith(b"\x00"):
        raw = raw[:-1]
    return raw.decode("utf-8", "replace")


def _fb_vector(data: bytes, addr: int) -> Tuple[int, int]:
    rel = struct.unpack_from("<I", data, addr)[0]
    vec = addr + rel
    n = struct.unpack_from("<I", data, vec)[0]
    return vec, n


def parse_bundle_hash_map(manifest: bytes) -> Tuple[int, Dict[int, str]]:
    """asset FastHash -> GameBundleInfo.Name（/assets/xx/hash.bundle）。"""
    root = struct.unpack_from("<I", manifest, 0)[0]
    seed_off = _fb_offset(manifest, root, 4)
    seed = struct.unpack_from("<Q", manifest, root + seed_off)[0] if seed_off else 0

    infos_off = _fb_offset(manifest, root, 22)
    if not infos_off:
        return seed, {}
    vec, n = _fb_vector(manifest, root + infos_off)
    hash_to_name: Dict[int, str] = {}
    for i in range(n):
        elem = vec + 4 + 4 * i
        tbl = elem + struct.unpack_from("<i", manifest, elem)[0]
        name_off = _fb_offset(manifest, tbl, 14)
        hashes_off = _fb_offset(manifest, tbl, 20)
        if not name_off or not hashes_off:
            continue
        name = _fb_string(manifest, tbl + name_off)
        hvec, hn = _fb_vector(manifest, tbl + hashes_off)
        for j in range(hn):
            h = struct.unpack_from("<Q", manifest, hvec + 4 + 8 * j)[0]
            hash_to_name[h] = name
    return seed, hash_to_name


# ---------------------------------------------------------------------------
# APK Lua
# ---------------------------------------------------------------------------


def iter_apk_lua_protos(apk: str, wanted: Optional[Sequence[str]] = None):
    want = set(wanted) if wanted is not None else None
    found: set[str] = set()
    with zipfile.ZipFile(apk) as z:
        names = [n for n in z.namelist() if n.startswith("assets/blocks/") and n.endswith(".bundle")]
        for name in names:
            raw = z.read(name)
            pt = bytes(b ^ SCRIPT_XOR for b in raw)
            files = PTNExtract.parse_pkg(pt)
            if not files:
                continue
            for _, bc in files:
                try:
                    _, proto, _ = PTNConvert.decode_chunk(bc)
                except Exception:
                    continue
                src = (proto.source or b"").rstrip(b"\x00").decode("utf-8", "replace")
                if want is not None and src not in want:
                    continue
                yield src, proto
                if want is not None:
                    found.add(src)
                    if found >= set(want):
                        return


def load_wanted_lua(apk: str) -> Dict[str, Any]:
    by_src = {}
    want = set(WANTED_LUA.values())
    for src, proto in iter_apk_lua_protos(apk, want):
        by_src[src] = proto
        console.print(f"[green]Lua[/green] {src}")
    missing = want - set(by_src)
    if missing:
        raise FileNotFoundError(f"APK blocks 中缺少: {sorted(missing)}")
    return {key: by_src[src] for key, src in WANTED_LUA.items()}


def proto_str_constants(proto) -> List[bytes]:
    out = []
    for kind, val in proto.constants:
        if kind == "str" and val:
            out.append(lua_intern(val))
    return out


STD_LOADK = 3
STD_LOADKX = 4
STD_NEWTABLE = 19
STD_SETLIST = 78
STD_EXTRAARG = 82


def is_packed_blob(raw: bytes) -> bool:
    if len(raw) < 32:
        return False
    if raw.startswith((b"images/", b"@", b"vo_", b"bt_")):
        return False
    if raw.count(0) >= 2:
        return True
    try:
        s = raw.decode("utf-8")
    except UnicodeDecodeError:
        return True
    return not all(c.isprintable() or c in "\n\t\r" for c in s)


def proto_typed_arrays(proto, fmt: str) -> List[Tuple[int, Tuple[Any, ...]]]:
    out = []
    for i, (kind, val) in enumerate(proto.constants):
        if kind != "str" or not val:
            continue
        raw = lua_intern(val)
        if not is_packed_blob(raw):
            continue
        arr = unpack_array(raw, fmt)
        if arr:
            out.append((i, arr))
    return out


def reconstruct_lua_list(proto) -> List[Optional[bytes]]:
    """按 SETLIST 顺序还原最大 NEWTABLE 的元素（LOADK 字符串）。"""
    code = proto.code
    n = len(code) // 4
    consts = proto.constants
    best_a = None
    best_size = -1
    i = 0
    while i < n:
        ins = int.from_bytes(code[i * 4 : i * 4 + 4], "little")
        if (ins & 0x7F) == STD_NEWTABLE:
            a = (ins >> 7) & 0xFF
            k = (ins >> 15) & 1
            c = (ins >> 24) & 0xFF
            ax = 0
            if i + 1 < n:
                nxt = int.from_bytes(code[(i + 1) * 4 : (i + 1) * 4 + 4], "little")
                if (nxt & 0x7F) == STD_EXTRAARG:
                    ax = nxt >> 7
            asize = c + (ax << 8 if k else 0)
            if asize > best_size:
                best_size = asize
                best_a = a
        i += 1
    if best_a is None:
        return []

    def const_raw(idx: int) -> Optional[bytes]:
        if 0 <= idx < len(consts) and consts[idx][0] == "str" and consts[idx][1]:
            return lua_intern(consts[idx][1])
        return None

    items: List[Optional[bytes]] = []
    pending: List[Optional[bytes]] = []
    i = 0
    while i < n:
        ins = int.from_bytes(code[i * 4 : i * 4 + 4], "little")
        op = ins & 0x7F
        if op == STD_LOADK:
            pending.append(const_raw(ins >> 15))
        elif op == STD_LOADKX and i + 1 < n:
            nxt = int.from_bytes(code[(i + 1) * 4 : (i + 1) * 4 + 4], "little")
            if (nxt & 0x7F) == STD_EXTRAARG:
                pending.append(const_raw(nxt >> 7))
        elif op == STD_SETLIST:
            a = (ins >> 7) & 0xFF
            tostore = (ins >> 16) & 0x3F
            if a == best_a:
                take = tostore if tostore else len(pending)
                items.extend(pending[-take:] if take else [])
                pending = []
        i += 1
    return items


def load_configtexts_map(proto) -> Dict[int, str]:
    consts = proto.constants
    hblob = lua_intern(consts[10][1])
    iblob = lua_intern(consts[11][1])
    nh = len(hblob) // 8
    ni = len(iblob) // 4
    hashes = struct.unpack_from("<" + "q" * nh, hblob)
    idxs = struct.unpack_from("<" + "I" * ni, iblob)
    texts = []
    for kind, val in consts[12:]:
        if kind != "str" or not val:
            continue
        texts.append(lua_intern(val).decode("utf-8", "replace"))
    mapping: Dict[int, str] = {}
    for h, i in zip(hashes, idxs):
        if i and 1 <= i <= len(texts):
            mapping[int(h)] = texts[i - 1]
    return mapping


def decode_istext(arr: Sequence[int], texts: Dict[int, str]) -> List[str]:
    return [texts[x] if x and x in texts else "" for x in arr]


# ---------------------------------------------------------------------------
# 配表列
# ---------------------------------------------------------------------------


@dataclass
class PaintingAsset:
    path: str
    folder: str
    variant: str
    hero: str
    skin: str
    bundle_name: str = ""
    in_chunk: bool = False


def parse_portrait_res(proto) -> Tuple[List[int], List[str]]:
    """返回 (ID 列, Path 列)。Path dictZip 下标指向 tbProxy 列表。"""
    items = reconstruct_lua_list(proto)
    if not items:
        raise RuntimeError("portrait_res 无法还原 Lua 表")
    best_idx = None
    for _, arr in proto_typed_arrays(proto, "H"):
        mx = max(arr) if arr else 0
        if mx <= 0 or mx > len(items):
            continue
        if best_idx is None or len(arr) > len(best_idx):
            best_idx = arr
    if best_idx is None:
        raise RuntimeError("portrait_res 找不到 Path dictZip 下标")
    paths: List[str] = []
    for i in best_idx:
        if i and 1 <= i <= len(items):
            raw = items[i - 1]
            if raw and raw.startswith(b"images/"):
                paths.append(raw.decode("utf-8", "replace"))
                continue
        paths.append("")
    nrows = len(paths)
    id_arr = None
    for _, arr in proto_typed_arrays(proto, "I"):
        if len(arr) != nrows:
            continue
        if min(arr) >= 0 and max(arr) > 100:
            id_arr = list(arr)
            break
    if id_arr is None:
        raise RuntimeError(f"portrait_res 找不到长度为 {nrows} 的 ID 列")
    return id_arr, paths


def parse_hero_names(proto, texts: Dict[int, str], hero_name_json: Dict[str, Any]) -> Dict[str, str]:
    """英文目录名 / EnName -> 中文名。"""
    en_to_id = {str(k).lower(): int(v) for k, v in (hero_name_json or {}).items() if str(k) and v}
    json_ids = set(en_to_id.values())
    name_blobs = []
    for _, arr in proto_typed_arrays(proto, "q"):
        if not (50 <= len(arr) <= 5000):
            continue
        decoded = decode_istext(arr, texts)
        shorts = [t for t in decoded if 1 <= len(t) <= 12]
        cjk = [t for t in shorts if any("\u4e00" <= c <= "\u9fff" for c in t)]
        if len(cjk) >= len(arr) * 0.5:
            name_blobs.append((decoded, len(cjk)))
    name_blobs.sort(key=lambda x: -x[1])

    id_blobs = []
    for _, arr in proto_typed_arrays(proto, "I"):
        if not (50 <= len(arr) <= 5000):
            continue
        hit = sum(1 for x in arr if x in json_ids)
        id_blobs.append((arr, hit))
    id_blobs.sort(key=lambda x: -x[1])

    best_map: Dict[int, str] = {}
    for ids, id_hit in id_blobs:
        if id_hit < 10:
            continue
        for decoded, _ in name_blobs:
            if len(ids) != len(decoded):
                continue
            trial = {int(hid): name for hid, name in zip(ids, decoded) if hid and name}
            if len(trial) > len(best_map):
                best_map = trial
        if best_map:
            break
    id_to_cn = best_map

    folder_to_cn: Dict[str, str] = {}
    for en, hid in en_to_id.items():
        cn = id_to_cn.get(hid)
        if cn:
            folder_to_cn[en] = cn
    interned = []
    for raw in proto_str_constants(proto):
        try:
            s = raw.decode("utf-8")
        except UnicodeDecodeError:
            continue
        if s.isascii() and s.replace("_", "").isalnum() and s[:1].isalpha() and s.lower() == s and 2 <= len(s) <= 24:
            interned.append(s)
    for s in interned:
        if s in folder_to_cn:
            continue
        hid = en_to_id.get(s)
        if hid and hid in id_to_cn:
            folder_to_cn[s] = id_to_cn[hid]
    if "player" not in folder_to_cn:
        folder_to_cn["player"] = "局长"
    if not folder_to_cn:
        raise RuntimeError("未能从 hero.lua 解出角色中文名")
    return folder_to_cn


def parse_skin_titles(
    proto, texts: Dict[int, str], portrait_ids: Sequence[int], portrait_paths: Sequence[str]
) -> Dict[str, str]:
    """portrait Path -> 皮肤中文名（来自 SkinName / 各 PictureID）。"""
    id_to_path = {int(i): p for i, p in zip(portrait_ids, portrait_paths) if i and p}
    portrait_id_set = set(id_to_path)
    pic_cols: List[Tuple[Any, ...]] = []
    name_cols: List[List[str]] = []
    for _, arr in proto_typed_arrays(proto, "I"):
        if len(arr) < 50:
            continue
        overlap = sum(1 for x in arr if x in portrait_id_set)
        if overlap >= max(10, len(arr) // 20):
            pic_cols.append(arr)
    for _, arr in proto_typed_arrays(proto, "q"):
        decoded = decode_istext(arr, texts)
        shorts = [t for t in decoded if 1 <= len(t) <= 16]
        if len(shorts) >= len(arr) * 0.4 and len(arr) >= 50:
            name_cols.append(decoded)
    path_to_skin: Dict[str, str] = {}
    for pics in pic_cols:
        for names in name_cols:
            if len(pics) != len(names):
                continue
            for pid, title in zip(pics, names):
                path = id_to_path.get(int(pid), "")
                if path and title and path not in path_to_skin:
                    path_to_skin[path] = title
    return path_to_skin


def split_painting_path(path: str) -> Optional[Tuple[str, str]]:
    p = path.replace("\\", "/").strip()
    low = p.lower()
    if PAINTING_INFIX not in low:
        return None
    if "/dialog/" in low or low.startswith("images/paintings/dialog"):
        return None
    rel = p[low.index(PAINTING_INFIX) + len(PAINTING_INFIX) :]
    parts = [x for x in rel.split("/") if x]
    if len(parts) < 2:
        return None
    folder = parts[0]
    stem = Path(parts[-1]).stem
    prefix = f"lihui_{folder}_"
    if stem.lower().startswith(prefix.lower()):
        variant = stem[len(prefix) :]
    elif stem.lower().startswith("lihui_"):
        rest = stem[6:]
        variant = rest.split("_", 1)[-1] if "_" in rest else rest
    else:
        variant = stem
    return folder, variant


def split_variant_gender(variant: str) -> Tuple[str, str]:
    key = (variant or "").lower()
    gm = _GENDER_TAIL.search(key)
    if gm:
        return key[: gm.start()], gm.group(1).lower()
    return key, ""


def is_cropped_variant(variant: str) -> bool:
    """跳过非全身截取：战姿2、默认3、皮肤拼音3、局长皮肤 m1/m2 头像。"""
    core, gender = split_variant_gender(variant)
    if core in ("default3", "zhanzi2") or core.endswith("zhanzi2"):
        return True
    if _SKIN_CROP_VARIANT.fullmatch(core):
        return True
    if core == "zhanzi" and gender in ("m2", "f2"):
        return True
    if _PLAYER_SKIN_CROP.fullmatch(core) and gender in ("m1", "f1", "m2", "f2"):
        return True
    return False


def is_cropped_image_size(size: Any) -> bool:
    try:
        w, h = size
    except (TypeError, ValueError):
        return False
    return (int(w), int(h)) == CROPPED_PIXEL_SIZE


def png_ihdr_size(path: str) -> Optional[Tuple[int, int]]:
    try:
        with open(path, "rb") as f:
            if f.read(8) != b"\x89PNG\r\n\x1a\n":
                return None
            f.read(4)
            if f.read(4) != b"IHDR":
                return None
            w = int.from_bytes(f.read(4), "big")
            h = int.from_bytes(f.read(4), "big")
            return w, h
    except OSError:
        return None


def purge_cropped_pngs(out_dir: str) -> int:
    """删掉已导出的 600×600 截取图。"""
    if not os.path.isdir(out_dir):
        return 0
    n = 0
    for name in os.listdir(out_dir):
        if not name.lower().endswith(".png"):
            continue
        path = os.path.join(out_dir, name)
        if not os.path.isfile(path):
            continue
        if png_ihdr_size(path) == CROPPED_PIXEL_SIZE:
            os.remove(path)
            n += 1
    return n


def variant_label(variant: str, skin_title: str, hero: str) -> str:
    key = variant.lower()
    key_core, gender = split_variant_gender(variant)
    if key in VARIANT_LABELS:
        label = VARIANT_LABELS[key]
    elif key_core in VARIANT_LABELS:
        label = VARIANT_LABELS[key_core]
    else:
        title = (skin_title or "").strip()
        if title and hero and title.startswith(hero + "-"):
            title = title[len(hero) + 1 :]
        if title and title not in ("", hero, "默认", "初始"):
            label = title
        elif variant:
            label = variant
        else:
            label = "默认"
    if gender and gender not in label.lower():
        label = f"{label}_{gender}"
    return label


def build_painting_assets(
    portrait_ids: Sequence[int],
    portrait_paths: Sequence[str],
    folder_to_cn: Dict[str, str],
    path_to_skin: Dict[str, str],
) -> List[PaintingAsset]:
    assets: List[PaintingAsset] = []
    seen: set[str] = set()
    for path in portrait_paths:
        split = split_painting_path(path)
        if not split:
            continue
        folder, variant = split
        if is_cropped_variant(variant):
            continue
        key = path.replace("\\", "/").lower()
        if key in seen:
            continue
        seen.add(key)
        hero = folder_to_cn.get(folder.lower()) or folder_to_cn.get(folder) or folder
        skin = variant_label(variant, path_to_skin.get(path, ""), hero)
        assets.append(
            PaintingAsset(path=path, folder=folder, variant=variant, hero=hero, skin=skin)
        )
    return assets


# ---------------------------------------------------------------------------
# 资源定位 / 解密 / 导出
# ---------------------------------------------------------------------------


def resolve_bundles(
    assets: List[PaintingAsset], seed: int, hash_to_name: Dict[int, str]
) -> None:
    for a in assets:
        h = compute_fast_hash(a.path.encode("utf-8"), seed)
        a.bundle_name = hash_to_name.get(h, "")


def chunk_index_for_paths(
    chunk_mani: Dict[str, Any], bundle_names: Iterable[str]
) -> Tuple[Dict[str, Dict[str, Any]], List[int]]:
    wanted = {n.lstrip("/") for n in bundle_names if n}
    by_path: Dict[str, Dict[str, Any]] = {}
    chunks: set[int] = set()
    for e in chunk_mani.get("Entries") or []:
        p = str(e.get("Path") or "").lstrip("/")
        if p in wanted:
            by_path[p] = e
            chunks.add(int(e["ChunkIndex"]))
    return by_path, sorted(chunks)


def decrypt_unity_blob(data: bytes) -> bytes:
    if data.startswith(b"UnityFS"):
        return data
    entries = PTNDecrypt.walk_entries(data)
    pos, size, j = entries[0]
    pay_key = PTNDecrypt.ASSET_KEY[j] ^ PTNDecrypt.ASSET_KEY[(j + 1) % 32]
    return bytes(b ^ pay_key for b in data[pos + 50 : pos + size])


def extract_chunk_bundles(
    chunk_path: str,
    entries: List[Dict[str, Any]],
    wanted_paths: set[str],
    dest_root: str,
) -> List[str]:
    buf = open(chunk_path, "rb").read()
    walked = PTNDecrypt.walk_entries(buf)
    by_off = {e["Offset"]: e for e in entries}
    written = []
    for pos, size, j in walked:
        e = by_off.get(pos)
        if not e:
            continue
        p = str(e["Path"]).lstrip("/")
        if p not in wanted_paths:
            continue
        pay_key = PTNDecrypt.ASSET_KEY[j] ^ PTNDecrypt.ASSET_KEY[(j + 1) % 32]
        payload = bytes(b ^ pay_key for b in buf[pos + 50 : pos + 50 + int(e["Length"])])
        dest = os.path.join(dest_root, p)
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        with open(dest, "wb") as f:
            f.write(payload)
        written.append(dest)
    return written


def apk_zip_name_for_bundle(rel: str) -> str:
    rel = rel.lstrip("/")
    if rel.startswith("assets/"):
        return "assets/" + rel
    return "assets/assets/" + rel


def extract_apk_hashed_bundles(apk: str, bundle_names: Iterable[str], dest_root: str) -> List[str]:
    wanted = {n.lstrip("/") for n in bundle_names if n}
    written = []
    with zipfile.ZipFile(apk) as z:
        names = set(z.namelist())
        for rel in wanted:
            zip_name = apk_zip_name_for_bundle(rel)
            if zip_name not in names:
                continue
            raw = z.read(zip_name)
            try:
                payload = decrypt_unity_blob(raw)
            except Exception:
                continue
            dest = os.path.join(dest_root, rel.lstrip("/"))
            os.makedirs(os.path.dirname(dest), exist_ok=True)
            with open(dest, "wb") as f:
                f.write(payload)
            written.append(dest)
    return written


def is_painting_container(path: str) -> bool:
    p = path.replace("\\", "/").lower()
    if PAINTING_INFIX not in p:
        return False
    idx = p.index(PAINTING_INFIX)
    rest = p[idx + len(PAINTING_INFIX) :]
    return not rest.startswith("dialog/")


def extract_painting_images(bundle: str) -> List[Tuple[str, Any]]:
    import UnityPy

    env = UnityPy.load(bundle)
    hits: List[Tuple[str, Any]] = []
    seen: set[int] = set()

    def take(obj, container: str) -> None:
        try:
            if getattr(getattr(obj, "type", None), "name", None) != "Texture2D":
                return
            if obj.path_id in seen:
                return
            tex = obj.read()
            img = getattr(tex, "image", None)
            if img is None:
                return
            w, h = getattr(img, "size", (0, 0))
            if min(w, h) < 64 or is_cropped_image_size((w, h)):
                return
            seen.add(obj.path_id)
            hits.append((container, img))
        except Exception:
            return

    for cpath, obj in (getattr(env, "container", None) or {}).items():
        if not is_painting_container(str(cpath)):
            continue
        entries = obj if isinstance(obj, (list, tuple)) else [obj]
        for one in entries:
            take(one, str(cpath))
    if not hits:
        for obj in env.objects:
            take(obj, "")
    hits.sort(key=lambda x: (x[1].size[0] * x[1].size[1]), reverse=True)
    return hits


def painting_dest(hero: str, skin: str, used: set[str], out_dir: str) -> str:
    stem_hero = sanitize_filename(hero)
    stem_skin = sanitize_filename(skin)
    n = 1
    while True:
        name = (
            f"{GAME_TITLE}_{stem_hero}_{stem_skin}.png"
            if n == 1
            else f"{GAME_TITLE}_{stem_hero}_{stem_skin}_{n}.png"
        )
        if name not in used:
            used.add(name)
            return os.path.join(out_dir, name)
        n += 1


def export_paintings(
    assets: List[PaintingAsset],
    bundle_files: Dict[str, str],
    out_dir: str,
    force: bool,
) -> Tuple[int, int, int, int]:
    os.makedirs(out_dir, exist_ok=True)
    removed = purge_cropped_pngs(out_dir)
    if removed:
        console.print(f"[yellow]已删除 {removed} 张 600×600 截取图[/yellow]")
    used: set[str] = set()
    ok = skip = fail = missing = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出立绘", total=len(assets))
        for a in assets:
            dest = painting_dest(a.hero, a.skin, used, out_dir)
            if os.path.isfile(dest) and not force:
                skip += 1
                progress.advance(task)
                continue
            key = a.bundle_name.lstrip("/")
            src = bundle_files.get(key) or bundle_files.get("/" + key)
            if not src or not os.path.isfile(src):
                missing += 1
                progress.advance(task)
                continue
            try:
                images = extract_painting_images(src)
                if not images:
                    skip += 1
                    progress.advance(task)
                    continue
                img = images[0][1]
                if is_cropped_image_size(getattr(img, "size", (0, 0))):
                    skip += 1
                    progress.advance(task)
                    continue
                if getattr(img, "mode", "") not in ("RGB", "RGBA"):
                    img = img.convert("RGBA")
                img.save(dest, "PNG")
                ok += 1
            except Exception as e:
                fail += 1
                console.print(f"[red]失败[/red] {a.path}: {e}")
            progress.advance(task)
    return ok, skip, fail, missing


def load_res_manifest_bytes(apk: str, cfg_dir: Optional[str] = None) -> bytes:
    if cfg_dir:
        p = os.path.join(cfg_dir, "res_manifest")
        if os.path.isfile(p):
            return open(p, "rb").read()
    with zipfile.ZipFile(apk) as z:
        return z.read("assets/res_manifest")


def collect_painting_plan(
    apk: str,
    cfg_dir: str,
) -> Tuple[List[PaintingAsset], Dict[str, Any], int, Dict[int, str]]:
    import json

    lua = load_wanted_lua(apk)
    texts = load_configtexts_map(lua["configtexts"])
    console.print(f"[cyan]configtexts[/cyan] {len(texts)} 条")
    hero_json = {}
    hp = os.path.join(cfg_dir, "res_hero_name.json")
    if os.path.isfile(hp):
        with open(hp, "r", encoding="utf-8") as f:
            hero_json = json.load(f)
    ids, paths = parse_portrait_res(lua["portrait_res"])
    folder_to_cn = parse_hero_names(lua["hero"], texts, hero_json)
    path_to_skin = parse_skin_titles(lua["skin_config"], texts, ids, paths)
    n_crop = sum(
        1
        for p in paths
        if (s := split_painting_path(p)) and is_cropped_variant(s[1])
    )
    assets = build_painting_assets(ids, paths, folder_to_cn, path_to_skin)
    console.print(
        f"[cyan]立绘路径[/cyan] {len(assets)} 条（跳过截取 {n_crop}）  "
        f"角色名 {len(folder_to_cn)}  皮肤名 {len(path_to_skin)}"
    )
    sample = next((a for a in assets if a.folder.lower() == "hilda"), assets[0] if assets else None)
    if sample:
        console.print(f"  例: {sample.path} -> {GAME_TITLE}_{sample.hero}_{sample.skin}.png")

    manifest = load_res_manifest_bytes(apk, cfg_dir)
    seed, hash_to_name = parse_bundle_hash_map(manifest)
    console.print(f"[cyan]res_manifest[/cyan] hash_seed={seed} bundles={len(hash_to_name)}")
    resolve_bundles(assets, seed, hash_to_name)
    hit = sum(1 for a in assets if a.bundle_name)
    console.print(f"[cyan]哈希命中[/cyan] {hit}/{len(assets)}")
    return assets, json.load(open(os.path.join(cfg_dir, "res_chunk_manifest.json"), encoding="utf-8")), seed, hash_to_name


def painting_download_items(
    chunk_mani: Dict[str, Any],
    chunk_ids: Sequence[int],
    cdn: str,
    root: str,
) -> List[Dict[str, Any]]:
    patches = chunk_mani.get("ChunkPatches") or []
    items = []
    for idx in chunk_ids:
        if idx < 0 or idx >= len(patches):
            continue
        f = patches[idx]
        items.append(
            {
                "url": f"{cdn}/{root}/chunk/{f['Filename']}",
                "dest": os.path.join("chunk", f["Filename"]),
                "md5": f.get("FileMd5", f.get("Hash", "")),
                "size": f.get("FileSize", f.get("Size", 0)),
                "name": f["Filename"],
                "chunk_index": idx,
            }
        )
    return items


def run_painting(
    apk: str,
    cfg_dir: str,
    outdir: str,
    painting_dir: str,
    cdn: str,
    root: str,
    download_all,
    dry_run: bool = False,
    skip_download: bool = False,
    force: bool = False,
    limit: int = 0,
) -> int:
    assets, chunk_mani, _seed, _hmap = collect_painting_plan(apk, cfg_dir)
    if limit > 0:
        assets = assets[:limit]
        console.print(f"[yellow]--limit {limit}，只处理前 {len(assets)} 条[/yellow]")

    named = [a.bundle_name for a in assets if a.bundle_name]
    by_path, chunk_ids = chunk_index_for_paths(chunk_mani, named)
    missing_hash = [a for a in assets if not a.bundle_name]
    missing_chunk = [
        a for a in assets if a.bundle_name and a.bundle_name.lstrip("/") not in by_path
    ]
    for a in assets:
        a.in_chunk = a.bundle_name.lstrip("/") in by_path

    items = painting_download_items(chunk_mani, chunk_ids, cdn, root)
    total = sum(int(i.get("size", 0)) for i in items)
    console.print(
        f"[cyan]立绘 chunk[/cyan] {len(chunk_ids)} 个, {total / 1024 ** 3:.2f} GiB  "
        f"(哈希未命中 {len(missing_hash)}, 不在 chunk {len(missing_chunk)})"
    )
    if dry_run:
        for it in items:
            console.print(f"  {it['name']:48s} {int(it['size']) / 1024 ** 2:9.1f} MiB")
        return 0

    if not skip_download and items:
        download_all(items, outdir)

    decrypted_root = os.path.join(outdir, "painting_bundles")
    os.makedirs(decrypted_root, exist_ok=True)
    wanted = {a.bundle_name.lstrip("/") for a in assets if a.bundle_name}
    bundle_files: Dict[str, str] = {}

    apk_got = extract_apk_hashed_bundles(apk, wanted, decrypted_root)
    for p in apk_got:
        rel = os.path.relpath(p, decrypted_root).replace("\\", "/")
        bundle_files[rel] = p
    console.print(f"[green]APK hashed bundle[/green] {len(apk_got)} 个")

    still = wanted - set(bundle_files)
    entries_by_chunk: Dict[int, List[Dict[str, Any]]] = {}
    for e in chunk_mani.get("Entries") or []:
        if str(e.get("Path") or "").lstrip("/") in still:
            entries_by_chunk.setdefault(int(e["ChunkIndex"]), []).append(e)

    for idx in chunk_ids:
        patch = (chunk_mani.get("ChunkPatches") or [])[idx]
        chunk_path = os.path.join(outdir, "chunk", patch["Filename"])
        if not os.path.isfile(chunk_path):
            console.print(f"[yellow]缺少 chunk[/yellow] {patch['Filename']}")
            continue
        written = extract_chunk_bundles(
            chunk_path, entries_by_chunk.get(idx, []), still, decrypted_root
        )
        for p in written:
            rel = os.path.relpath(p, decrypted_root).replace("\\", "/")
            bundle_files[rel] = p
        console.print(f"[green]chunk[/green] {patch['Filename']}: {len(written)} 个立绘 bundle")

    have = sum(1 for a in assets if a.bundle_name.lstrip("/") in bundle_files)
    console.print(f"[cyan]可导出[/cyan] {have}/{len(assets)}")
    exported, skipped, failed, missing = export_paintings(assets, bundle_files, painting_dir, force)
    console.print(
        f"[bold green]Painting[/bold green] 新导出={exported} 跳过={skipped} "
        f"缺 bundle={missing} 失败={failed} → {painting_dir}"
    )
    return 0 if failed == 0 else 1
