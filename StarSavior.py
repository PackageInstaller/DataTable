from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
import warnings
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Tuple

SCRIPT_DIR = Path(__file__).resolve().parent
PAINTING_DIR = SCRIPT_DIR / "Painting"
ILLUST_BUNDLE_DIR = SCRIPT_DIR / "IllustBundle"
GAME_TITLE = "星之救援者"
START_PARAM_URL = "https://star-cdn.sbside.com/Review/StartParam.json"
PLATFORM_MAP = {
    "aos": ("AOS", "Android"),
    "ios": ("IOS", "iOS"),
    "pc": ("PC", "Windows"),
}
TABLE_MAGIC = b"\x02\xde\x21\x2b"
LZ4_MAGIC = b"\x04\x22\x4d\x18"
TABLE_SKIP = 4
UNITYFS = bytes.fromhex("556E69747946530000000008352E782E")
XORED_HDR = bytes.fromhex("FFD5C3CFD3FDF9BBAABBAAB39F95D295")
HDR_KEY = bytes.fromhex("AABB")
XOR_LEN = 100 * 1024

_missing = []
try:
    import lz4.frame
    import lz4.block
except ImportError:
    _missing.append("lz4")
try:
    import bson
except ImportError:
    _missing.append("bson")
try:
    import requests
except ImportError:
    _missing.append("requests")
try:
    import UnityPy

    warnings.filterwarnings("ignore", message=".*Unity.*version.*")
    UnityPy.config.FALLBACK_UNITY_VERSION = "6000.0.61f1"
except ImportError:
    _missing.append("UnityPy")
try:
    from rich.console import Console
    from rich.progress import (
        Progress,
        BarColumn,
        MofNCompleteColumn,
        TextColumn,
        TimeElapsedColumn,
        TimeRemainingColumn,
    )
except ImportError:
    _missing.append("rich")

if _missing:
    print("缺少依赖:", ", ".join(_missing))
    print("  pip install", " ".join(_missing))
    sys.exit(1)

from itertools import cycle
from threading import Lock

console = Console()

try:
    from UnityCatalogReader import UnityCatalogReader
except ImportError:
    UnityCatalogReader = None  # type: ignore


def _xor(data: bytes, key: bytes) -> bytes:
    return bytes(i ^ j for i, j in zip(data, cycle(key)))


def decrypt_unityfs(data: bytes) -> Optional[bytes]:
    if data[:8] == UNITYFS[:8]:
        return data
    bundle_key = _xor(data[:16], XORED_HDR)
    buff = _xor(data[:XOR_LEN], bundle_key)
    if buff[16:18] != bytes.fromhex("D2BB"):
        return None
    header = _xor(buff[:XOR_LEN], HDR_KEY)
    blockinfo_len = int.from_bytes(header[32:36], "big")
    off = 48 + blockinfo_len
    single = b"0.0" in data[off : off + 64]
    single_h = b"0.0" in header[off : off + 64]
    if single:
        return header[:128] + data[128:]
    if single_h:
        return header + data[XOR_LEN:]
    return header[:128] + buff[128:] + data[XOR_LEN:]


class FileNameMasking:
    def __init__(self, filename: str):
        if not filename.endswith(".bytes"):
            filename = filename + ".bytes"
        md5_hash = hashlib.md5(filename.encode("utf-8")).digest()
        self.mask_bytes = bytearray(md5_hash)
        self.mask_longs = [
            int.from_bytes(md5_hash[0:8], "little", signed=False),
            int.from_bytes(md5_hash[8:16], "little", signed=False),
        ]

    def decrypt(self, buffer: bytearray, offset: int, size: int, file_position: int, skip_bytes: int = 0):
        pos = 0
        while pos < size:
            bi = offset + pos
            cfp = file_position + pos
            if cfp < skip_bytes:
                pos += 1
                continue
            kp = cfp - skip_bytes
            if kp % 8 == 0 and size - pos >= 8 and bi % 8 == 0:
                mask = self.mask_longs[(kp // 8) % len(self.mask_longs)]
                value = int.from_bytes(buffer[bi : bi + 8], "little", signed=False) ^ mask
                buffer[bi : bi + 8] = value.to_bytes(8, "little", signed=False)
                pos += 8
            else:
                buffer[bi] ^= self.mask_bytes[kp % len(self.mask_bytes)]
                pos += 1


def decrypt_table_file(content: bytes, filename: str) -> bytes:
    base = os.path.splitext(filename)[0]
    buf = bytearray(content)
    if buf:
        FileNameMasking(base).decrypt(buf, 0, len(buf), 0, skip_bytes=TABLE_SKIP)
    return bytes(buf)


def lz4_decompress(data: bytes) -> bytes:
    try:
        return lz4.frame.decompress(data)
    except Exception:
        pass
    if data[:4] != LZ4_MAGIC:
        raise ValueError("不是 LZ4 frame")
    flg, bd = data[4], data[5]
    pos = 6
    if flg & 0x08:
        pos += 8
    if flg & 0x01:
        pos += 4
    pos += 1
    max_block = {4: 64 << 10, 5: 256 << 10, 6: 1 << 20, 7: 4 << 20}.get((bd >> 4) & 7, 4 << 20)
    out = bytearray()
    while pos + 4 <= len(data):
        bsize = int.from_bytes(data[pos : pos + 4], "little")
        pos += 4
        if bsize == 0:
            break
        unc = bool(bsize & 0x80000000)
        bsize &= 0x7FFFFFFF
        block = data[pos : pos + bsize]
        pos += bsize
        if flg & 0x10:
            pos += 4
        if unc:
            out.extend(block)
            continue
        done = False
        for dest in (max_block, max_block * 2, 16 << 20):
            try:
                out.extend(lz4.block.decompress(block, uncompressed_size=dest))
                done = True
                break
            except Exception:
                continue
        if not done:
            out.extend(lz4.block.decompress(block))
    return bytes(out)


def process_table_data(content: bytes, filename: str) -> Tuple[str, bool]:
    if content[:4] == TABLE_MAGIC:
        content = decrypt_table_file(content, filename)
    if len(content) >= 4 and content[1:4] == b"\xde\x21\x2b":
        decomp = lz4_decompress(content[4:])
    elif content[:4] == LZ4_MAGIC:
        decomp = lz4_decompress(content)
    else:
        text = content.decode("utf-8-sig", errors="replace")
        return text, "-->" in text[:64]
    try:
        text = json.dumps(bson.decode_all(decomp), indent=4, ensure_ascii=False)
        return text, False
    except Exception:
        text = decomp.decode("utf-8-sig", errors="replace")
        return text, "-->" in text[:64]


def _selfcheck() -> None:
    name = "SELFCHECK_TABLE"
    plain = TABLE_MAGIC + LZ4_MAGIC + b"\x40\x40" + b"\x00" * 10
    assert decrypt_table_file(decrypt_table_file(plain, name), name) == plain


def export_textassets(bundle_data: bytes) -> List[Tuple[bytes, str]]:
    env = UnityPy.load(bundle_data)
    out = []
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        ta = obj.read()
        script = getattr(ta, "m_Script", None)
        if script is None:
            continue
        if isinstance(script, str):
            payload = script.encode("utf-8", "surrogateescape")
        else:
            payload = bytes(script)
        out.append((payload, getattr(ta, "m_Name", "") or ""))
    return out


# ── Catalog（哈希 container → 表名）──────────────────────────────────────────
def fetch_catalog(platform: str, server: str, start_param_url: str):
    if UnityCatalogReader is None:
        raise RuntimeError("需要 UnityCatalogReader.py")
    sp = requests.get(start_param_url, timeout=10)
    sp.raise_for_status()
    start = sp.json()
    base = start.get("AssetBasePath", "")
    cat_name = start.get("AssetCatalogFileName", "catalog_test.json")
    vk, url_path = PLATFORM_MAP[platform.lower()]
    bundle = None
    for m in start.get("VersionMapping", {}).get(vk, []):
        if m.get("ServerList") == server:
            bundle = m.get("Bundle")
            break
    if not bundle:
        raise RuntimeError("未找到 Bundle")
    url = f"{base}/{url_path}/{bundle}/{cat_name}"
    r = requests.get(url, timeout=30)
    r.raise_for_status()
    assets = UnityCatalogReader(r.content).get_asset_list()
    return f"{base}/{url_path}/{bundle}", assets


def classify_table_bundles(assets: list) -> Tuple[Dict[str, dict], Dict[str, List[str]]]:
    """primary .bytes → dependency_key 哈希 bundle；返回 (bundle_asset_by_key, catalog_map)."""
    addr = "{Bs.Addressable.NKCAddressable.AddressablePath}/"
    table_deps = set()
    catalog_map: Dict[str, List[str]] = {}
    for a in assets:
        pk = a.get("primary_key") or ""
        if pk.endswith((".bytes", ".txt_KOR", ".txt_JPN")):
            dep = a.get("dependency_key")
            if isinstance(dep, str) and dep.endswith(".bundle"):
                table_deps.add(dep)
                catalog_map.setdefault(dep, []).append(pk)
    bundle_assets = {}
    for a in assets:
        pk = a.get("primary_key") or ""
        if (
            pk in table_deps
            and pk.endswith(".bundle")
            and addr in (a.get("internal_id") or "")
            and "AssetBundleProvider" in (a.get("provider_id") or "")
        ):
            bundle_assets[pk] = a
    # 兜底：只要是 table dep 就收
    for a in assets:
        pk = a.get("primary_key") or ""
        if pk in table_deps and pk not in bundle_assets:
            bundle_assets[pk] = a
    return bundle_assets, catalog_map


# ── 下载（多线程 + Range 断点续传 + manifest）────────────────────────────────
def _progress() -> Progress:
    return Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
        transient=False,
    )


def download_file(
    url: str,
    path: Path,
    expected_size: int = 0,
    retries: int = 4,
    timeout: int = 60,
) -> bool:
    """完整则跳过；否则 Range 续传，416 则重下。"""
    if path.exists() and expected_size > 0 and path.stat().st_size == expected_size:
        return True
    path.parent.mkdir(parents=True, exist_ok=True)

    for attempt in range(retries):
        try:
            headers = {}
            mode = "wb"
            if path.exists():
                cur = path.stat().st_size
                if expected_size > 0 and cur == expected_size:
                    return True
                if cur > 0 and (expected_size <= 0 or cur < expected_size):
                    headers["Range"] = f"bytes={cur}-"
                    mode = "ab"
                elif expected_size > 0 and cur > expected_size:
                    path.unlink(missing_ok=True)
                    mode = "wb"

            with requests.get(url, headers=headers, stream=True, timeout=timeout) as resp:
                if resp.status_code == 416:
                    path.unlink(missing_ok=True)
                    with requests.get(url, stream=True, timeout=timeout) as resp2:
                        resp2.raise_for_status()
                        with open(path, "wb") as f:
                            for chunk in resp2.iter_content(8192):
                                if chunk:
                                    f.write(chunk)
                else:
                    resp.raise_for_status()
                    # 服务器不支持 Range 时可能仍 200，需整文件重写
                    if headers.get("Range") and resp.status_code == 200:
                        mode = "wb"
                    with open(path, mode) as f:
                        for chunk in resp.iter_content(8192):
                            if chunk:
                                f.write(chunk)

            if expected_size > 0 and path.stat().st_size != expected_size:
                # 未下完，下次续传
                if attempt + 1 < retries:
                    continue
                return False
            return True
        except Exception:
            if attempt + 1 >= retries:
                return False
    return False


def load_manifest(path: Path) -> Dict[str, int]:
    if not path.exists():
        return {}
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        return {}


def save_manifest(path: Path, data: Dict[str, int]) -> None:
    path.write_text(json.dumps(data, indent=2), encoding="utf-8")


# ── commands ─────────────────────────────────────────────────────────────────
def _download_ns(args, out_root: Path) -> argparse.Namespace:
    return argparse.Namespace(
        out=str(out_root),
        jobs=getattr(args, "jobs", 16),
        retries=getattr(args, "retries", 4),
        platform=getattr(args, "platform", "aos"),
        server=getattr(args, "server", "Live"),
        start_param=getattr(args, "start_param", START_PARAM_URL),
    )


def _process_one_bundle(
    bp: Path, out: Path, write_decrypted: bool
) -> Tuple[str, int, int, List[str], Optional[str]]:
    """返回 (bundle名, ok, fail, extracted_names, error)."""
    data = bp.read_bytes()
    dec = decrypt_unityfs(data)
    if dec is None:
        return bp.name, 0, 1, [], "bundle 解密失败"
    if dec is not data and write_decrypted:
        bp.write_bytes(dec)
    try:
        assets = export_textassets(dec)
    except Exception as e:
        return bp.name, 0, 1, [], f"加载失败: {e}"
    ok = fail = 0
    extracted: List[str] = []
    for content, name in assets:
        if not name:
            continue
        try:
            text, is_sub = process_table_data(content, name)
            ext = ".srt" if is_sub else ".json"
            (out / f"{name}{ext}").write_text(text, encoding="utf-8-sig")
            ok += 1
            extracted.append(name)
        except Exception:
            fail += 1
    return bp.name, ok, fail, extracted, None


def cmd_tables(args) -> int:
    _selfcheck()
    src = Path(args.table_bundle)
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    bundles = sorted(src.glob("*.bundle"))
    if not bundles:
        console.print(f"[yellow]本地无 bundle（{src}），开始下载…[/yellow]")
        rc = cmd_download(_download_ns(args, src.parent))
        if rc:
            return rc
        bundles = sorted(src.glob("*.bundle"))
        if not bundles:
            console.print(f"[red]下载后仍无 bundle: {src}[/red]")
            return 1

    ok = fail = 0
    name_map: Dict[str, List[str]] = {}
    jobs = max(1, getattr(args, "jobs", 8))

    with _progress() as progress:
        task = progress.add_task("[cyan]导出数据表", total=len(bundles))
        with ThreadPoolExecutor(max_workers=jobs) as ex:
            futs = {
                ex.submit(_process_one_bundle, bp, out, args.write_decrypted): bp
                for bp in bundles
            }
            for fut in as_completed(futs):
                bname, o, f, extracted, err = fut.result()
                ok += o
                fail += f
                if extracted:
                    name_map[bname] = extracted
                if err:
                    console.print(f"[red]✗ {bname}: {err}[/red]")
                progress.advance(task)

    map_path = Path(args.map_out) if args.map_out else src.parent / "table_bundle_map.json"
    prev = {}
    if map_path.exists():
        try:
            prev = json.loads(map_path.read_text(encoding="utf-8"))
        except Exception:
            prev = {}
    prev["from_extract"] = name_map
    map_path.write_text(json.dumps(prev, indent=2, ensure_ascii=False), encoding="utf-8")
    console.print(f"[green]完成[/green] ok={ok} fail={fail} 映射={map_path}")
    return 0 if fail == 0 else 2


def cmd_download(args) -> int:
    base_url, assets = fetch_catalog(args.platform, args.server, args.start_param)
    bundle_assets, catalog_map = classify_table_bundles(assets)
    out = Path(args.out) / "TableBundle"
    out.mkdir(parents=True, exist_ok=True)
    manifest_path = Path(args.out) / "asset_manifest.json"
    manifest = load_manifest(manifest_path)
    lock = Lock()

    tasks = []
    skipped = 0
    for pk, a in bundle_assets.items():
        size = int(a.get("bundle_size") or 0)
        path = out / pk
        if path.exists() and size > 0 and path.stat().st_size == size:
            if manifest.get(pk) != size:
                with lock:
                    manifest[pk] = size
            skipped += 1
            continue
        if path.exists() and size > 0 and path.stat().st_size > size:
            path.unlink(missing_ok=True)
        tasks.append((pk, size))

    total_bytes = sum(s for _, s in tasks)
    console.print(
        f"[cyan]数据表 Bundle[/cyan] 共 {len(bundle_assets)} 个，"
        f"跳过 {skipped}，待下 {len(tasks)}"
        + (f"（约 {total_bytes / (1024 * 1024):.1f} MB）" if total_bytes else "")
    )

    if not tasks:
        console.print("[green]全部已是最新[/green]")
    else:
        ok = fail = 0
        with _progress() as progress:
            task_id = progress.add_task("[cyan]下载 TableBundle", total=len(tasks))

            def one(pk: str, size: int) -> Tuple[str, bool]:
                url = f"{base_url}/{pk}"
                path = out / pk
                ok_dl = download_file(url, path, expected_size=size, retries=args.retries)
                if ok_dl:
                    with lock:
                        manifest[pk] = path.stat().st_size if path.exists() else size
                return pk, ok_dl

            with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as ex:
                futs = [ex.submit(one, pk, size) for pk, size in tasks]
                for fut in as_completed(futs):
                    pk, success = fut.result()
                    if success:
                        ok += 1
                    else:
                        fail += 1
                        console.print(f"[red]✗ {pk}[/red]")
                    progress.advance(task_id)

        save_manifest(manifest_path, manifest)
        console.print(f"[green]下载完成[/green] ok={ok} fail={fail} skip={skipped}")
        if fail:
            return 1

    save_manifest(manifest_path, manifest)
    map_path = Path(args.out) / "table_bundle_map.json"
    prev = {}
    if map_path.exists():
        try:
            prev = json.loads(map_path.read_text(encoding="utf-8"))
        except Exception:
            prev = {}
    prev["from_catalog"] = catalog_map
    map_path.write_text(json.dumps(prev, indent=2, ensure_ascii=False), encoding="utf-8")
    console.print(f"映射条目 {len(catalog_map)} → {map_path}")
    return 0


def cmd_update(args) -> int:
    rc = cmd_download(args)
    if rc:
        return rc
    tb = argparse.Namespace(
        table_bundle=str(Path(args.out) / "TableBundle"),
        out=str(Path(args.out) / "MasterData"),
        write_decrypted=True,
        map_out=str(Path(args.out) / "table_bundle_map.json"),
        jobs=args.jobs,
        retries=args.retries,
        platform=args.platform,
        server=args.server,
        start_param=args.start_param,
    )
    return cmd_tables(tb)


# ── 立绘（painting）──────────────────────────────────────────────────────────
_RE_ILLUST_FULL = re.compile(r"^NKM_UNIT_.+_ILLUST\.png$", re.IGNORECASE)
_RE_ILLUST_UI = re.compile(r"^NKM_UNIT_.+_ILLUST_UI\.png$", re.IGNORECASE)


def load_json_loose(path: Path):
    text = path.read_text(encoding="utf-8-sig")
    try:
        return json.loads(text)
    except json.JSONDecodeError:
        text = re.sub(r",\s*([}\]])", r"\1", text)
        return json.loads(text)


def _walk_unit_rows(obj, acc: list) -> None:
    if isinstance(obj, dict):
        if "m_UnitStrID" in obj or "m_IllustName" in obj:
            acc.append(obj)
        for v in obj.values():
            _walk_unit_rows(v, acc)
    elif isinstance(obj, list):
        for i in obj:
            _walk_unit_rows(i, acc)


def load_string_map(master: Path, lang: str) -> Dict[str, str]:
    path = master / "STRING_COMMON.json"
    if not path.is_file():
        return {}
    data = load_json_loose(path)
    rows = data.get("Data") if isinstance(data, dict) else data
    field = {
        "kor": "Value",
        "chn": "Value_CHN",
        "twn": "Value_TWN",
        "jpn": "Value_JPN",
        "eng": "Value_ENG",
    }.get(lang.lower(), "Value_CHN")
    out: Dict[str, str] = {}
    for row in rows or []:
        if not isinstance(row, dict):
            continue
        key = row.get("Key")
        if not key:
            continue
        val = (row.get(field) or row.get("Value_CHN") or row.get("Value") or "").strip()
        if val:
            out[key] = val
    return out


def _safe_fs_name(text: str) -> str:
    table = str.maketrans(
        {
            "/": "／",
            "\\": "＼",
            ":": "：",
            "*": "＊",
            "?": "？",
            '"': "'",
            "<": "＜",
            ">": "＞",
            "|": "｜",
            "\n": "",
            "\r": "",
            "\t": " ",
        }
    )
    out = text.translate(table).strip()
    return out or "未知"


def painting_filename(
    cha: str,
    skin: str,
    used: set[str],
    notes: Optional[Iterable[str]] = None,
) -> str:
    """游戏名_角色名_皮肤名[_备注...].png（CatFantasy 同款）。"""
    parts = [GAME_TITLE, _safe_fs_name(cha), _safe_fs_name(skin)]
    for note in notes or []:
        cleaned = _safe_fs_name(str(note))
        if cleaned and cleaned != "未知":
            parts.append(cleaned)
    base = "_".join(parts) + ".png"
    if base not in used:
        used.add(base)
        return base
    n = 2
    while True:
        name = "_".join(parts + [str(n)]) + ".png"
        if name not in used:
            used.add(name)
            return name
        n += 1


def _unit_row_score(row: dict) -> int:
    sid = row.get("m_UnitStrID") or ""
    score = 0
    if "TUTORIAL" not in sid:
        score += 50
    if "_SKIN_" not in sid:
        score += 5
    if sid.startswith("NKM_UNIT_S_"):
        score += 10
    return score


def build_illust_name_index(
    master: Path, lang: str
) -> Dict[str, Tuple[str, str, List[str]]]:
    """primary_key → (角色, 皮肤, notes)。"""
    strings = load_string_map(master, lang)

    def tr(key: str, fallback: str = "") -> str:
        if not key:
            return fallback
        return strings.get(key, fallback or key)

    unit_rows: list = []
    for p in master.glob("CLIENT_UNIT_TEMPLET*.json"):
        _walk_unit_rows(load_json_loose(p), unit_rows)

    unit_by_id: Dict[int, dict] = {}
    for row in unit_rows:
        uid = row.get("m_UnitID")
        if uid is None:
            continue
        prev = unit_by_id.get(uid)
        if prev is None or _unit_row_score(row) > _unit_row_score(prev):
            unit_by_id[int(uid)] = row

    # pk → best (score, cha, skin, notes)
    best: Dict[str, Tuple[int, str, str, List[str]]] = {}

    def consider(pk: str, cha: str, skin: str, notes: List[str], score: int):
        if not pk:
            return
        cur = best.get(pk)
        if cur is None or score > cur[0]:
            best[pk] = (score, cha, skin, notes)

    for row in unit_rows:
        cha = tr(row.get("m_UnitNameString") or "", "未知")
        skin = tr(row.get("m_UnitTitleString") or "", "默认") or "默认"
        score = _unit_row_score(row)
        notes: List[str] = []
        consider(row.get("m_IllustName") or "", cha, skin, notes, score)
        consider(row.get("m_IllustNameUI") or "", cha, skin, notes + ["UI"], score)

    skin_path = master / "CLIENT_SKIN_TEMPLET.json"
    if skin_path.is_file():
        skin_data = load_json_loose(skin_path)
        for row in skin_data.get("Data") or []:
            uid = row.get("m_UnitID")
            base = unit_by_id.get(int(uid)) if uid is not None else None
            cha = tr((base or {}).get("m_UnitNameString") or "", "未知")
            skin = tr(row.get("SkinName") or "", "皮肤") or "皮肤"
            consider(row.get("m_IllustName") or "", cha, skin, [], 80)
            consider(row.get("m_IllustNameUI") or "", cha, skin, ["UI"], 80)

    return {pk: (cha, skin, notes) for pk, (_, cha, skin, notes) in best.items()}


def _illust_fallback_name(pk: str) -> Tuple[str, str, List[str]]:
    notes: List[str] = []
    stem = pk[:-4] if pk.lower().endswith(".png") else pk
    if stem.upper().endswith("_ILLUST_UI"):
        notes.append("UI")
        stem = stem[: -len("_ILLUST_UI")]
    elif stem.upper().endswith("_ILLUST"):
        stem = stem[: -len("_ILLUST")]
    code = re.sub(r"^NKM_UNIT_", "", stem, flags=re.I)
    return code or "未知", "默认", notes


def select_illust_assets(assets: list, mode: str) -> Dict[str, dict]:
    """mode: all | full | ui"""
    selected: Dict[str, dict] = {}
    for a in assets:
        pk = a.get("primary_key") or ""
        if not isinstance(pk, str):
            continue
        ok = False
        if mode in ("all", "full") and _RE_ILLUST_FULL.match(pk):
            ok = True
        if mode in ("all", "ui") and _RE_ILLUST_UI.match(pk):
            ok = True
        if ok and pk not in selected:
            selected[pk] = a
    return selected


def export_texture_from_bundle(
    bundle_path: Path, want_basenames: set[str], name_map: Dict[str, str], out_dir: Path, force: bool
) -> Tuple[int, int]:
    """want_basenames: catalog primary_key 集合；name_map: pk → 输出文件名。返回 (写,跳过)。"""
    written = skipped = 0
    data = bundle_path.read_bytes()
    dec = decrypt_unityfs(data)
    if dec is None:
        raise RuntimeError("UnityFS 解密失败")
    if dec is not data:
        bundle_path.write_bytes(dec)
        data = dec
    env = UnityPy.load(data)
    want_lower = {k.lower(): k for k in want_basenames}
    for obj in env.objects:
        if obj.type.name not in ("Texture2D", "Sprite"):
            continue
        tex = obj.read()
        name = getattr(tex, "m_Name", "") or ""
        candidates = {f"{name}.png", name}
        if name.lower().endswith(".png"):
            candidates.add(name)
        hit = None
        for c in candidates:
            if c.lower() in want_lower:
                hit = want_lower[c.lower()]
                break
        if hit is None:
            # 模糊：texture 名是 stem
            for pk, orig in want_lower.items():
                stem = pk[:-4] if pk.endswith(".png") else pk
                if name.lower() == stem or name.lower() == pk:
                    hit = orig
                    break
        if hit is None:
            continue
        try:
            img = tex.image
        except Exception:
            continue
        if img is None:
            continue
        out_name = name_map.get(hit) or hit
        dest = out_dir / out_name
        if dest.exists() and not force:
            skipped += 1
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        img.save(str(dest))
        written += 1
    return written, skipped


def cmd_painting(args) -> int:
    """Catalog 拉 NKM_UNIT_*_ILLUST(.png|_UI.png)，按表还原中文名导出。"""
    master = Path(args.master)
    if not (master / "STRING_COMMON.json").is_file():
        console.print("[yellow]缺 MasterData/STRING_COMMON，先跑 tables…[/yellow]")
        rc = cmd_tables(
            argparse.Namespace(
                table_bundle=str(SCRIPT_DIR / "TableBundle"),
                out=str(master),
                write_decrypted=True,
                map_out="",
                jobs=args.jobs,
                retries=args.retries,
                platform=args.platform,
                server=args.server,
                start_param=args.start_param,
            )
        )
        if rc and not (master / "STRING_COMMON.json").is_file():
            return rc

    base_url, assets = fetch_catalog(args.platform, args.server, args.start_param)
    selected = select_illust_assets(assets, args.mode)
    console.print(
        f"[cyan]立绘资产[/cyan] mode={args.mode} 唯一 {len(selected)} 个"
        f"（旧脚本仅 _ILLUST.png ≈ 69；现含 _ILLUST_UI）"
    )
    if not selected:
        console.print("[red]Catalog 中未找到立绘[/red]")
        return 1
    if args.limit > 0:
        selected = dict(list(selected.items())[: args.limit])
        console.print(f"[yellow]--limit {args.limit}[/yellow]")

    name_index = build_illust_name_index(master, args.lang)
    used: set[str] = set()
    pk_to_outfile: Dict[str, str] = {}
    named = 0
    for pk in selected:
        if pk in name_index:
            cha, skin, notes = name_index[pk]
            named += 1
        else:
            cha, skin, notes = _illust_fallback_name(pk)
            if pk.upper().endswith("_ILLUST_UI.PNG") and "UI" not in notes:
                notes = list(notes) + ["UI"]
        pk_to_outfile[pk] = painting_filename(cha, skin, used, notes)
    console.print(f"[cyan]命名命中表[/cyan] {named}/{len(selected)}")

    # dependency bundles
    bundles: Dict[str, List[str]] = {}
    for pk, a in selected.items():
        dep = a.get("dependency_key") or ""
        if isinstance(dep, str) and dep.endswith(".bundle"):
            bundles.setdefault(dep, []).append(pk)
        else:
            console.print(f"[yellow]无 dependency_key[/yellow] {pk}")

    out_bundles = Path(args.bundles_dir)
    out_bundles.mkdir(parents=True, exist_ok=True)
    # 顺便从 catalog 取 bundle 大小（同 primary_key 的 bundle 条目）
    size_by_bundle: Dict[str, int] = {}
    for a in assets:
        pk = a.get("primary_key") or ""
        if pk in bundles:
            size_by_bundle[pk] = int(a.get("bundle_size") or 0)

    dl_tasks = []
    skipped_dl = 0
    for bname in bundles:
        path = out_bundles / bname
        size = size_by_bundle.get(bname, 0)
        if path.exists() and size > 0 and path.stat().st_size == size:
            skipped_dl += 1
            continue
        dl_tasks.append((bname, size))

    console.print(
        f"[cyan]立绘 Bundle[/cyan] {len(bundles)} 个，跳过 {skipped_dl}，待下 {len(dl_tasks)}"
    )
    if dl_tasks:
        ok = fail = 0
        with _progress() as progress:
            tid = progress.add_task("[cyan]下载立绘 Bundle", total=len(dl_tasks))
            def one(bname: str, size: int) -> bool:
                return download_file(
                    f"{base_url}/{bname}",
                    out_bundles / bname,
                    expected_size=size,
                    retries=args.retries,
                )
            with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as ex:
                futs = {ex.submit(one, b, s): b for b, s in dl_tasks}
                for fut in as_completed(futs):
                    if fut.result():
                        ok += 1
                    else:
                        fail += 1
                        console.print(f"[red]✗ {futs[fut]}[/red]")
                    progress.advance(tid)
        console.print(f"[green]下载[/green] ok={ok} fail={fail}")
        if fail:
            return 1

    painting_out = Path(args.out)
    painting_out.mkdir(parents=True, exist_ok=True)
    written = skipped = fail = 0
    with _progress() as progress:
        tid = progress.add_task("[cyan]导出立绘", total=len(bundles))
        def work(bname: str) -> Tuple[int, int, Optional[str]]:
            path = out_bundles / bname
            if not path.is_file():
                return 0, 0, f"缺失 {bname}"
            pks = set(bundles[bname])
            local_map = {pk: pk_to_outfile[pk] for pk in pks if pk in pk_to_outfile}
            try:
                w, s = export_texture_from_bundle(
                    path, pks, local_map, painting_out, args.force
                )
                return w, s, None
            except Exception as e:
                return 0, 0, f"{bname}: {e}"

        with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as ex:
            futs = [ex.submit(work, b) for b in bundles]
            for fut in as_completed(futs):
                w, s, err = fut.result()
                written += w
                skipped += s
                if err:
                    fail += 1
                    console.print(f"[red]{err}[/red]")
                progress.advance(tid)

    console.print(
        f"[bold green]Painting[/bold green] 写出 {written} 跳过 {skipped} 失败bundle {fail} "
        f"→ {painting_out}（目标资产 {len(selected)}）"
    )
    return 0 if fail == 0 else 2


def cmd_status(args) -> int:
    root = Path(args.out)
    for name in ("TableBundle", "MasterData", "IllustBundle", "Painting", "asset_manifest.json"):
        p = root / name
        if not p.exists():
            console.print(f"{name}: (无)")
            continue
        if p.is_dir():
            n = sum(1 for f in p.rglob("*") if f.is_file())
            console.print(f"{name}: {n} 文件")
        else:
            console.print(f"{name}: {p.stat().st_size} 字节")
    mp = root / "table_bundle_map.json"
    if mp.exists():
        data = json.loads(mp.read_text(encoding="utf-8"))
        console.print(
            f"map catalog={len(data.get('from_catalog') or {})} "
            f"extract={len(data.get('from_extract') or {})}"
        )
    return 0


def _add_net_args(p: argparse.ArgumentParser) -> None:
    p.add_argument("--jobs", type=int, default=16, help="并行线程数")
    p.add_argument("--retries", type=int, default=4, help="单文件重试次数")
    p.add_argument("--platform", default="aos", choices=("aos", "ios", "pc"))
    p.add_argument("--server", default="Live")
    p.add_argument("--start-param", default=START_PARAM_URL)


def main() -> int:
    parser = argparse.ArgumentParser(description="StarSavior 数据表下载/导出/立绘")
    sub = parser.add_subparsers(dest="command")

    p_tb = sub.add_parser("tables", help="TableBundle → MasterData（无本地则先下载）")
    p_tb.add_argument(
        "--table-bundle",
        default=str(SCRIPT_DIR / "TableBundle"),
        help="哈希 .bundle 目录",
    )
    p_tb.add_argument("--out", default=str(SCRIPT_DIR / "MasterData"))
    p_tb.add_argument("--write-decrypted", action="store_true", help="原地写回解密后的 AB")
    p_tb.add_argument("--map-out", default="", help="table_bundle_map.json 路径")
    _add_net_args(p_tb)

    p_dl = sub.add_parser("download", help="按 Catalog 下载表 Bundle")
    p_dl.add_argument("--out", default=str(SCRIPT_DIR))
    _add_net_args(p_dl)

    p_up = sub.add_parser("update", help="下载 + 导出 MasterData")
    p_up.add_argument("--out", default=str(SCRIPT_DIR))
    _add_net_args(p_up)

    p_pt = sub.add_parser(
        "painting",
        help="导出立绘到 Painting/（默认 ILLUST+ILLUST_UI，旧脚本只有 69 张 full）",
    )
    p_pt.add_argument("--out", default=str(PAINTING_DIR), help="输出目录")
    p_pt.add_argument("--bundles-dir", default=str(ILLUST_BUNDLE_DIR))
    p_pt.add_argument("--master", default=str(SCRIPT_DIR / "MasterData"))
    p_pt.add_argument(
        "--mode",
        choices=("all", "full", "ui"),
        default="all",
        help="all=ILLUST+UI；full=仅 *_ILLUST.png；ui=仅 *_ILLUST_UI.png",
    )
    p_pt.add_argument("--lang", default="chn", help="STRING 语言: chn/twn/jpn/eng/kor")
    p_pt.add_argument("--force", action="store_true", help="覆盖已存在立绘")
    p_pt.add_argument("--limit", type=int, default=0, help="只处理前 N 个（调试）")
    _add_net_args(p_pt)

    p_st = sub.add_parser("status", help="目录统计")
    p_st.add_argument("--out", default=str(SCRIPT_DIR))

    args = parser.parse_args()
    if not args.command:
        args = parser.parse_args(["tables"])
    return {
        "tables": cmd_tables,
        "download": cmd_download,
        "update": cmd_update,
        "painting": cmd_painting,
        "status": cmd_status,
    }[args.command](args)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        raise SystemExit(130)
