from __future__ import annotations

import argparse
import io
import json
import re
import shutil
import struct
import subprocess
import threading
import time
import warnings
import zipfile
import zlib
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Iterable
from urllib.parse import quote

import requests
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
from rich.table import Table

from FactoryBin import dump_all_factories, parse_guide_asset


GAME_TITLE = "雷索纳斯"
INDEX_URL_CN = "https://eden-index.gameduchy.com"
INDEX_URL_CN_BACKUP = "http://eden-index.soli-reso.com"
FROM_RES = "CN"
PLATFORM = "Android"
DEFAULT_APP_VERSION = "1.7.2"
INDEX_NAME = "index_Release.txt"
DESC_NAME = "desc.bin"
BUNDLE_KEY = "ResonanceRebornR"
CDN_AUTH_KEY = "aliyuncdnexp20240412"
# HotfixSetting.hashListName
HASH_LIST_NAME = "desc.bin"

APK_EXTRACT_PREFIXES = (
    "assets/Asset/",
    "assets/Config/",
    "assets/Translate/",
)

HTTP_HEADERS = {
    "User-Agent": "UnityPlayer/2021.3 (Android)",
    "Accept": "*/*",
}

RETRY_COUNT = 4
CHUNK_SIZE = 1 << 20
DEFAULT_JOBS = 8
LUA_MAGIC = b"\x1bLua"

DESC_SUFFIX = {
    1: ".asset",
    2: ".asset_manifest",
    3: ".prefab_asset",
    4: ".prefab_asset_manifest",
    5: ".manifest",
}
JAB_SUFFIX = {
    1: ".asset",
    2: ".asset.manifest",
    3: ".prefab.asset",
    4: ".prefab.asset.manifest",
    5: ".manifest",
}


SKIN_ALIAS = {
    "summer": "夏",
    "maid": "女仆",
    "jk": "JK",
    "kimono": "和服",
    "kinomo": "和服",
    "wedding": "婚礼",
    "child": "幼年",
    "xmas": "圣诞",
    "halloween": "万圣节",
    "holloween": "万圣节",
    "pajama": "睡衣",
    "student": "学生",
    "black": "黑",
    "sleep": "睡颜",
    "flower": "花",
    "ootd": "OOTD",
    "band": "乐队",
    "prot": "原型",
    "prototype": "原型",
    "old": "旧",
    "arc": "arc",
    "friend": "友人",
    "human": "人",
    "angel": "天使",
    "angel_driver": "AngelDriver",
    "azuretime": "AzureTime",
    "private_vacation": "私假",
    "freetime": "闲暇",
    "dreamcatcher": "捕梦",
    "peacefulmorning": "平和清晨",
    "wonderland": "仙境",
    "nainai": "奶奶",
    "train": "列车",
    "ride": "骑行",
    "new": "新",
    "master": "Master",
    "box": "BOX",
    "gown": "礼服",
    "star": "星",
    "bear": "熊",
    "wings": "翼",
    "tv": "TV",
    "sigma": "Sigma",
    "boy": "男",
    "girl": "女",
    "cg": "CG",
    "swimsuit": "夏",
}

STEM_ALIAS = {
    "conor": "connor",
    "mahr": "mhar",
    "olivine": "olivien",
    "summershizuru": "shizurusummerchaser",
    "dinisha": "teresa",
}

FS_BAD = str.maketrans({c: "／" for c in '\\/:*?"<>|'})

console = Console()
ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
CACHE_DIR = ROOT / "Cache"
PAINTING_DIR = ROOT / "Painting"
UNLUAC = shutil.which("unluac") or "/usr/bin/unluac"

_tls = threading.local()


def format_size(n: int) -> str:
    size = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{n} B"


def find_apk(explicit: str | None = None) -> Path:
    if explicit:
        p = Path(explicit)
        if not p.is_file():
            raise FileNotFoundError(p)
        return p
    apks = sorted(ROOT.glob("*.apk"), key=lambda x: x.stat().st_size, reverse=True)
    if not apks:
        raise FileNotFoundError("工作区里没有 .apk")
    return apks[0]


def read_apk_version(apk: Path) -> str:
    try:
        out = subprocess.check_output(
            ["aapt", "dump", "badging", str(apk)], text=True, errors="replace"
        )
        for token in out.split():
            if token.startswith("versionName="):
                return token.split("=", 1)[1].strip("'\"")
    except Exception:
        pass
    return DEFAULT_APP_VERSION


def session() -> requests.Session:
    s = getattr(_tls, "session", None)
    if s is None:
        s = requests.Session()
        s.headers.update(HTTP_HEADERS)
        _tls.session = s
    return s


def make_progress(*extra: Any) -> Progress:
    cols = [
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        *extra,
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
    ]
    return Progress(*cols, console=console)


# ---------------------------------------------------------------------------
# Eden CRC  HashTool.CreateEdenCRC @ 0x02D67704
# ---------------------------------------------------------------------------

def eden_crc(data: bytes) -> int:
    n = len(data)
    acc = 0

    def xor_u32(off: int) -> None:
        nonlocal acc
        acc ^= struct.unpack_from("<I", data, off)[0]
        acc &= 0xFFFFFFFF

    if n > 199:
        for i in range(25):
            xor_u32(i * 4)
        off = n - 100
        for i in range(25):
            xor_u32(off + i * 4)
    else:
        i = 0
        while n - i >= 4:
            xor_u32(i)
            i += 4
        if n - i > 1:
            acc ^= struct.unpack_from("<H", data, i)[0]
            acc &= 0xFFFFFFFF
            i += 2
        if n - i >= 1:
            acc ^= data[i]
            acc &= 0xFFFFFFFF
    return 1 if acc == 1 else (acc ^ 1) & 0xFFFFFFFF


def file_eden_crc(path: Path) -> int:
    return eden_crc(path.read_bytes())


# ---------------------------------------------------------------------------
# HTTP
# ---------------------------------------------------------------------------

def http_get_bytes(url: str, timeout: int = 60) -> bytes:
    last: Exception | None = None
    for attempt in range(1, RETRY_COUNT + 1):
        try:
            resp = session().get(url, timeout=timeout)
            resp.raise_for_status()
            return resp.content
        except Exception as exc:  # noqa: BLE001
            last = exc
            time.sleep(min(2 ** attempt, 8))
    raise RuntimeError(f"GET 失败 {url}: {last}")


def download_to(
    url: str,
    dest: Path,
    expected_crc: int = 0,
    expected_size: int = 0,
    on_bytes: Any | None = None,
) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_suffix(dest.suffix + ".part")
    last: Exception | None = None
    for attempt in range(1, RETRY_COUNT + 1):
        got = 0
        try:
            with session().get(url, timeout=120, stream=True) as resp:
                resp.raise_for_status()
                with tmp.open("wb") as fh:
                    for chunk in resp.iter_content(CHUNK_SIZE):
                        if not chunk:
                            continue
                        fh.write(chunk)
                        got += len(chunk)
                        if on_bytes is not None:
                            on_bytes(len(chunk))
            data = tmp.read_bytes()
            if expected_size and len(data) != expected_size:
                raise ValueError(f"size {len(data)} != {expected_size}")
            if expected_crc and eden_crc(data) != expected_crc:
                raise ValueError(f"crc {eden_crc(data):08x} != {expected_crc:08x}")
            tmp.replace(dest)
            return "ok"
        except Exception as exc:  # noqa: BLE001
            last = exc
            if on_bytes is not None and got:
                on_bytes(-got)
            tmp.unlink(missing_ok=True)
            time.sleep(min(2 ** attempt, 8))
    raise RuntimeError(f"下载失败 {url}: {last}")


def cdn_url(static_url: str, relpath: str, patch_ver: str) -> str:
    base = static_url.rstrip("/") + "/"
    rel = "/".join(
        quote(part, safe="") if part else part
        for part in relpath.replace("\\", "/").split("/")
    )
    return f"{base}{FROM_RES}/{PLATFORM}/{patch_ver}/{rel}"


# ---------------------------------------------------------------------------
# index + desc.bin
# ---------------------------------------------------------------------------

def fetch_index_text() -> str:
    last: Exception | None = None
    for root in (INDEX_URL_CN, INDEX_URL_CN_BACKUP):
        url = root.rstrip("/") + "/" + INDEX_NAME
        try:
            text = http_get_bytes(url, timeout=30).decode("utf-8", "replace")
            CACHE_DIR.mkdir(parents=True, exist_ok=True)
            (CACHE_DIR / INDEX_NAME).write_text(text, encoding="utf-8")
            return text
        except Exception as exc:  # noqa: BLE001
            last = exc
    raise RuntimeError(f"拉 index 失败: {last}")


def _field_match(pat: str, value: str) -> bool:
    pat = pat.strip()
    value = value.strip()
    return pat == "*" or pat.lower() == value.lower()


def parse_index_rows(text: str) -> list[dict[str, str]]:
    rows: list[dict[str, str]] = []
    keys = (
        "platform",
        "channel",
        "clientAppVersion",
        "clientPackageVersion",
        "serverPackageVersion",
        "serverPatchVersion",
        "serverIpPort",
        "noticeURL",
        "staticURL",
        "packageMD5",
        "patchMD5",
        "isResetApp",
        "bdhu",
    )
    for raw in text.splitlines():
        line = raw.strip()
        if not line or line.startswith("//"):
            continue
        parts = [p.strip() for p in line.split(",")]
        if len(parts) < 9:
            continue
        row = {k: (parts[i] if i < len(parts) else "") for i, k in enumerate(keys)}
        su = row["staticURL"]
        if su and not su.endswith("/"):
            row["staticURL"] = su + "/"
        rows.append(row)
    return rows


def match_index_row(rows: list[dict[str, str]], app_version: str) -> dict[str, str]:
    hits = [
        r
        for r in rows
        if _field_match(r["platform"], PLATFORM)
        and _field_match(r["channel"], FROM_RES)
        and _field_match(r["clientAppVersion"], app_version)
    ]
    if not hits:
        raise RuntimeError(f"index 没有 {PLATFORM}/{FROM_RES}/{app_version}")
    return hits[0]


def uncompress_desc(raw: bytes) -> bytes:
    buf = bytearray(raw)
    if buf and buf[0] != 0:
        buf[0] = (~buf[0]) & 0xFF
        return zlib.decompress(bytes(buf))
    return bytes(buf)


class _R:
    def __init__(self, data: bytes, i: int = 0) -> None:
        self.b = data
        self.i = i

    def u8(self) -> int:
        v = self.b[self.i]
        self.i += 1
        return v

    def u16(self) -> int:
        v = struct.unpack_from("<H", self.b, self.i)[0]
        self.i += 2
        return v

    def i32(self) -> int:
        v = struct.unpack_from("<i", self.b, self.i)[0]
        self.i += 4
        return v

    def u32(self) -> int:
        v = struct.unpack_from("<I", self.b, self.i)[0]
        self.i += 4
        return v

    def f64(self) -> float:
        v = struct.unpack_from("<d", self.b, self.i)[0]
        self.i += 8
        return v

    def take(self, n: int) -> bytes:
        v = self.b[self.i : self.i + n]
        self.i += n
        return v

    def s(self, n: int) -> str:
        return self.take(n).decode("utf-8", "replace")


def _gmf_str(r: _R) -> str:
    ln = r.u16()
    if ln == 0:
        return ""
    if ln == 0xFFFF:
        ln = r.i32()
    return r.s(ln)


def gmf_decode(r: _R) -> Any:
    t = r.u8()
    if t in (0, 8):
        return None
    if t == 1:
        return bool(r.u8())
    if t == 2:
        return r.i32()
    if t == 3:
        return r.u32()
    if t == 4:
        return r.f64()
    if t == 5:
        return _gmf_str(r)
    if t == 6:
        end = r.i + r.i32()
        arr: list[Any] = []
        while r.i < end:
            arr.append(gmf_decode(r))
        return arr
    if t == 7:
        end = r.i + r.i32()
        obj: dict[str, Any] = {}
        while r.i < end:
            key = r.s(r.u16())
            obj[key] = gmf_decode(r)
        return obj
    if t == 10:
        return r.take(r.i32())
    if t == 11:
        r.i32()
        n = r.i32()
        return [gmf_decode(r) for _ in range(n)]
    if t == 12:
        n = r.i32() // 4
        return [r.i32() for _ in range(n)]
    if t == 101:
        v = struct.unpack_from("<f", r.b, r.i)[0]
        r.i += 4
        return v
    raise ValueError(f"未知 GMF 类型 {t} @ {r.i}")


def parse_desc(raw: bytes) -> dict[str, Any]:
    data = uncompress_desc(raw)
    r = _R(data)
    r.u8()
    version = r.u8()
    if version < 3 or version > 4:
        raise ValueError(f"desc version {version}")
    jab_hint = r.i32()
    header = gmf_decode(r)
    if not isinstance(header, dict):
        header = {}
    n = r.i32()
    rolling = ""
    files: list[dict[str, Any]] = []
    for _ in range(n):
        prefix = r.u8()
        st = r.u8()
        ln = r.u16()
        rolling = rolling[:prefix] + (r.s(ln) if ln else "")
        path = rolling + DESC_SUFFIX.get(st, "")
        size = r.i32()
        crc = r.u32()
        files.append({"path": path, "size": size, "crc": crc})
    return {
        "version": version,
        "jabHint": jab_hint,
        "header": {
            k: header[k]
            for k in header
            if k != "overrideDic" and not isinstance(header[k], (bytes, bytearray))
        },
        "files": files,
    }


def load_or_fetch_desc(
    static_url: str,
    version: str,
    force: bool = False,
    cache_stem: str = "desc_patch",
) -> dict[str, Any]:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    path = CACHE_DIR / f"{cache_stem}.bin"
    json_path = CACHE_DIR / f"{cache_stem}.json"
    # 兼容旧缓存名
    if cache_stem == "desc_patch" and not path.is_file() and (CACHE_DIR / DESC_NAME).is_file():
        path = CACHE_DIR / DESC_NAME
        if not json_path.is_file() and (CACHE_DIR / "desc_files.json").is_file():
            json_path = CACHE_DIR / "desc_files.json"
    if path.is_file() and json_path.is_file() and not force:
        return json.loads(json_path.read_text(encoding="utf-8"))
    url = cdn_url(static_url, DESC_NAME, version)
    raw = http_get_bytes(url, timeout=60)
    (CACHE_DIR / f"{cache_stem}.bin").write_bytes(raw)
    desc = parse_desc(raw)
    (CACHE_DIR / f"{cache_stem}.json").write_text(
        json.dumps(desc, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    return desc


def desc_cdn_files(desc: dict[str, Any]) -> list[dict[str, Any]]:
    """desc 文件表里 ResTemp/ 是 JAB 展开项，CDN 上不存在。"""
    out: list[dict[str, Any]] = []
    for info in desc.get("files") or []:
        rel = str(info.get("path") or "").replace("\\", "/")
        if not rel or rel.startswith("ResTemp/") or "/ResTemp/" in rel:
            continue
        item = dict(info)
        item["path"] = rel
        out.append(item)
    return out


def merge_hotfix_plan(
    package_desc: dict[str, Any],
    patch_desc: dict[str, Any],
    package_ver: str,
    patch_ver: str,
) -> list[dict[str, Any]]:
    plan: dict[str, dict[str, Any]] = {}
    for info in desc_cdn_files(package_desc):
        plan[info["path"]] = {**info, "ver": package_ver, "kind": "package"}
    for info in desc_cdn_files(patch_desc):
        plan[info["path"]] = {**info, "ver": patch_ver, "kind": "patch"}
    return list(plan.values())


def desc_summary(desc: dict[str, Any]) -> tuple[int, int, str]:
    files = desc_cdn_files(desc)
    total = sum(int(f.get("size") or 0) for f in files)
    hdr = desc.get("header") or {}
    ver = str(hdr.get("patchVersion") or "")
    return len(files), total, ver


# ---------------------------------------------------------------------------
# JAB
# ---------------------------------------------------------------------------

def extract_jab(jab_path: Path, dest_root: Path) -> int:
    data = jab_path.read_bytes()
    r = io.BytesIO(data)

    def u8() -> int:
        return r.read(1)[0]

    def u16() -> int:
        return struct.unpack("<H", r.read(2))[0]

    def u32() -> int:
        return struct.unpack("<I", r.read(4))[0]

    def i32() -> int:
        return struct.unpack("<i", r.read(4))[0]

    ver = u8()
    flags = u8() if ver >= 2 else 0
    data_off = u32()
    n = u32()
    prefix = ""
    if ver >= 3:
        pl = u16()
        if pl:
            prefix = r.read(pl).decode("utf-8", "replace")
            if not prefix.endswith("/"):
                prefix += "/"
    compress = bool(flags & 1)
    last = ""
    children: list[tuple[str, int, int, int]] = []
    for _ in range(n):
        pre = u8()
        st = u8()
        ln = u16()
        part = r.read(ln).decode("utf-8", "replace") if ln else ""
        core = last[:pre] + part + JAB_SUFFIX.get(st, "")
        off = u32()
        size = i32()
        unc = i32() if compress else size
        r.read(8)
        if ver >= 4 and core.endswith(".asset"):
            r.read(4)
        last = core
        children.append((prefix + core, off, size, unc))

    written = 0
    for rel, off, size, unc in children:
        r.seek(data_off + off)
        raw = r.read(size)
        final = raw
        if compress and unc != size:
            try:
                final = zlib.decompress(raw)
            except Exception:
                blob = bytearray(raw)
                if blob:
                    blob[0] = (~blob[0]) & 0xFF
                    try:
                        final = zlib.decompress(bytes(blob))
                    except Exception:
                        final = raw
        out = dest_root / rel
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_bytes(final)
        written += 1
    return written


# ---------------------------------------------------------------------------
# APK
# ---------------------------------------------------------------------------

def extract_apk(apk: Path, force: bool = False) -> int:
    n = 0
    with zipfile.ZipFile(apk) as zf:
        infos = [
            info
            for info in zf.infolist()
            if not info.is_dir()
            and any(info.filename.startswith(p) for p in APK_EXTRACT_PREFIXES)
        ]
        with make_progress(MofNCompleteColumn()) as progress:
            task = progress.add_task("APK 提取", total=len(infos))
            for info in infos:
                rel = info.filename[len("assets/") :]
                dest = ASSETS_DIR / rel
                if dest.is_file() and not force and dest.stat().st_size == info.file_size:
                    progress.advance(task)
                    continue
                dest.parent.mkdir(parents=True, exist_ok=True)
                with zf.open(info) as src, dest.open("wb") as out:
                    shutil.copyfileobj(src, out)
                n += 1
                progress.advance(task)
    return n


# ---------------------------------------------------------------------------
# Lua
# ---------------------------------------------------------------------------

def patch_lua_header(data: bytes) -> bytes:
    if data[:4] != LUA_MAGIC or len(data) < 16:
        return data
    buf = bytearray(data)
    # \x1bLua  0x53  0x01  luac_data  04 04 08 08  → 官方 format 0 + Instruction size 4
    if buf[5] == 1 and buf[12:16] == b"\x04\x04\x08\x08":
        buf[5] = 0
        buf[14:14] = b"\x04"
    return bytes(buf)


def looks_like_lua_source(data: bytes) -> bool:
    head = data.lstrip()[:64].lower()
    return head.startswith(b"--") or head.startswith(b"local ") or head.startswith(b"function")


def run_unluac(src: Path, dest: Path) -> bool:
    if not UNLUAC or not Path(UNLUAC).exists():
        return False
    dest.parent.mkdir(parents=True, exist_ok=True)
    patched = patch_lua_header(src.read_bytes())
    tmp = dest.with_suffix(".luac.tmp")
    tmp.write_bytes(patched)
    try:
        proc = subprocess.run(
            [UNLUAC, str(tmp)], capture_output=True, timeout=120
        )
        if proc.returncode != 0 or not proc.stdout:
            return False
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(proc.stdout)
        return True
    except Exception:
        return False
    finally:
        tmp.unlink(missing_ok=True)


def convert_lua_tree(src_root: Path, dest_root: Path) -> tuple[int, int]:
    ok = fail = 0
    files = [p for p in src_root.rglob("*") if p.is_file() and p.suffix.lower() == ".lua"]
    with make_progress(MofNCompleteColumn()) as progress:
        task = progress.add_task("unluac", total=len(files))
        for path in files:
            rel = path.relative_to(src_root)
            dest = dest_root / rel
            data = path.read_bytes()
            if looks_like_lua_source(data):
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(data)
                ok += 1
            elif data.startswith(LUA_MAGIC):
                if run_unluac(path, dest):
                    ok += 1
                else:
                    dest.parent.mkdir(parents=True, exist_ok=True)
                    dest.write_bytes(data)
                    fail += 1
            else:
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(data)
                fail += 1
            progress.advance(task)
    return ok, fail


# ---------------------------------------------------------------------------
# ConfigLanguage
# ---------------------------------------------------------------------------

def _read_utf(buf: bytes, i: int) -> tuple[str, int]:
    ln = struct.unpack_from("<h", buf, i)[0]
    i += 2
    if ln <= 0:
        return "", i
    return buf[i : i + ln].decode("utf-8", "replace"), i + ln


def parse_config_language(data: bytes) -> dict[str, Any]:
    i = 1
    lang, i = _read_utf(data, i)
    i += 8
    count = struct.unpack_from("<h", data, i)[0]
    i += 2
    factories: dict[str, dict[str, dict[str, str]]] = {}
    for _ in range(count):
        name, i = _read_utf(data, i)
        size = struct.unpack_from("<i", data, i)[0]
        i += 4
        block = data[i : i + size]
        i += size
        j = 4
        gc = struct.unpack_from("<i", block, 0)[0]
        groups: dict[str, dict[str, str]] = {}
        for _g in range(gc):
            gn, j = _read_utf(block, j)
            pc = struct.unpack_from("<i", block, j)[0]
            j += 4
            d: dict[str, str] = {}
            for _p in range(pc):
                k, j = _read_utf(block, j)
                v, j = _read_utf(block, j)
                d[k] = v
            groups[gn] = d
        factories[name] = groups
    return {"languageType": lang, "factories": factories}


def dump_language_json() -> int:
    n = 0
    for path in (ASSETS_DIR / "Translate").rglob("ConfigLanguage.bin"):
        rel = path.relative_to(ASSETS_DIR / "Translate")
        out = MASTER_DIR / "Translate" / rel.with_suffix(".json")
        try:
            payload = parse_config_language(path.read_bytes())
        except Exception as exc:  # noqa: BLE001
            console.print(f"[red]语言表失败[/red] {path}: {exc}")
            continue
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
        n += 1
    return n


# ---------------------------------------------------------------------------
# 立绘名
# ---------------------------------------------------------------------------

def _safe_fs_name(s: str) -> str:
    s = (s or "").strip().translate(FS_BAD)
    s = re.sub(r"\s+", " ", s)
    return s or "未知"


def _compact(s: str) -> str:
    return re.sub(r"[\s_\-·.'’]+", "", s).lower()


def painting_filename(
    cha: str, skin: str, used: set[str], notes: Iterable[str] | None = None
) -> str:
    parts = [GAME_TITLE, _safe_fs_name(cha), _safe_fs_name(skin)]
    for note in notes or []:
        cleaned = _safe_fs_name(str(note))
        if cleaned and cleaned not in {"未知", ""}:
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


def _compact_en(s: str) -> str:
    s = re.sub(r"\bthe\b", " ", s, flags=re.I)
    return _compact(s)


def _lp_strings(blob: bytes) -> list[str]:
    out: list[str] = []
    i = 0
    n = len(blob)
    while i < n:
        ln = blob[i]
        if 2 <= ln <= 80 and i + 1 + ln <= n:
            raw = blob[i + 1 : i + 1 + ln]
            try:
                text = raw.decode("utf-8")
            except UnicodeDecodeError:
                i += 1
                continue
            if text.isprintable() and not text.startswith("http"):
                out.append(text)
                i += 1 + ln
                continue
        i += 1
    return out


def _pairs_from_unit_bin(path: Path) -> dict[str, str]:
    """UnitFactory.bin 里紧挨着的「中文名 + 英文名」，补语言包没收录的新角色。"""
    if not path.is_file():
        return {}
    strs = _lp_strings(path.read_bytes())
    cjk = re.compile(r"^[\u4e00-\u9fffA-Za-z0-9·（）()：:—\-“”■]{2,16}$")
    en = re.compile(r"^[A-Za-z][A-Za-z0-9 the'\-]{2,48}$")
    skip_en = ("star", "http", "curid", "cm")
    out: dict[str, str] = {}
    for cn, english in zip(strs, strs[1:]):
        if not cjk.match(cn) or not en.match(english):
            continue
        low = english.lower()
        if any(tok in low for tok in skip_en):
            continue
        if sum(ch.isalpha() for ch in english) < 3:
            continue
        out[_compact(english)] = cn
        out[_compact_en(english)] = cn
        out[_compact(cn)] = cn
    return out


def _remember(dst: dict[str, str], key: str, cn: str) -> None:
    compact = _compact(key)
    if compact:
        dst[compact] = cn
    compact_en = _compact_en(key)
    if compact_en:
        dst[compact_en] = cn


def _is_placeholder(s: str) -> bool:
    return (s or "").strip().lower() in {"", "placeholder"}


def load_unit_name_maps() -> tuple[dict[str, str], dict[str, str]]:
    """en_compact -> 中文名。语言包 key 是中文源串。"""
    en_to_cn: dict[str, str] = {}
    jsons = list((MASTER_DIR / "Translate").rglob("ConfigLanguage.json"))
    bins = list((ASSETS_DIR / "Translate").rglob("ConfigLanguage.bin"))
    payload: dict[str, Any] | None = None
    candidates = jsons + bins
    candidates.sort(key=lambda p: ("en" not in p.as_posix().lower(), len(p.as_posix())))
    for path in candidates:
        try:
            if path.suffix == ".json":
                payload = json.loads(path.read_text(encoding="utf-8"))
            else:
                payload = parse_config_language(path.read_bytes())
            if payload and "UnitFactory" in (payload.get("factories") or {}):
                break
        except Exception:
            payload = None
    names: dict[str, str] = {}
    if payload:
        uf = (payload.get("factories") or {}).get("UnitFactory") or {}
        names = uf.get("name") or {}
        english: dict[str, str] = uf.get("EnglishName") or {}
        for cn, en in names.items():
            _remember(en_to_cn, cn, cn)
            if not _is_placeholder(en):
                _remember(en_to_cn, en, cn)
        for en_key, en_val in english.items():
            if _is_placeholder(en_key):
                continue
            cn = en_to_cn.get(_compact(en_key)) or en_to_cn.get(_compact_en(en_key))
            if not cn and not _is_placeholder(en_val):
                cn = en_to_cn.get(_compact(en_val)) or en_to_cn.get(_compact_en(en_val))
            if not cn:
                continue
            _remember(en_to_cn, en_key, cn)
            if not _is_placeholder(en_val):
                _remember(en_to_cn, en_val, cn)
    for src in (
        MASTER_DIR / "BinaryConfig" / "UnitFactory.json",
        ASSETS_DIR / "BinaryConfig" / "UnitFactory.bin",
        MASTER_DIR / "BinaryConfig" / "UnitFactory.bin",
    ):
        if src.suffix == ".json" and src.is_file():
            try:
                payload_u = json.loads(src.read_text(encoding="utf-8"))
            except Exception:
                continue
            for rec in payload_u.get("records") or []:
                if not isinstance(rec, dict):
                    continue
                cn = str(rec.get("name") or rec.get("idCN") or "").strip()
                if not cn or "/" in cn:
                    continue
                _remember(en_to_cn, cn, cn)
                en = str(rec.get("EnglishName") or "").strip()
                if en and not _is_placeholder(en):
                    _remember(en_to_cn, en, cn)
            continue
        for key, cn in _pairs_from_unit_bin(src).items():
            en_to_cn[key] = cn
    return en_to_cn, names


def skin_from_rest(rest: str) -> tuple[str, list[str]]:
    notes: list[str] = []
    s = rest.strip("_-/ ").lower().replace("-", "_")
    if s.startswith("skin_"):
        s = s[5:]
    if not s:
        return "默认", notes
    if "hexie" in s:
        notes.append("和谐")
        s = re.sub(r"_?hexie_?", "_", s).strip("_")
    bits = [b for b in re.split(r"[/_]+", s) if b and b not in {"sp", "bot"} and not b.startswith("bot")]
    if not bits:
        return "默认", notes
    joined = "_".join(bits)
    if joined in SKIN_ALIAS:
        return SKIN_ALIAS[joined], notes
    compact_joined = _compact(joined)
    for key, val in SKIN_ALIAS.items():
        if _compact(key) == compact_joined:
            return val, notes
    mapped = []
    for b in bits:
        mapped.append(next((val for key, val in SKIN_ALIAS.items() if key == b or _compact(key) == _compact(b)), b))
    skin = "·".join(mapped)
    return skin or "默认", notes


def _title_stem(s: str) -> str:
    s = s.strip("_- ")
    if not s:
        return "未知"
    if re.search(r"[\u4e00-\u9fff]", s):
        return s
    return s[:1].upper() + s[1:]


def _peel_rest(stem: str, matched: str) -> str:
    """从原始 stem 按 compact 角色段剥掉前缀，留下带分隔符的皮肤段。"""
    s = stem.lower()
    i = j = 0
    while j < len(matched) and i < len(s):
        if s[i] in "_-/ .":
            i += 1
            continue
        if s[i] != matched[j]:
            break
        i += 1
        j += 1
    if j < len(matched):
        return ""
    return s[i:].strip("_-/ ")


def resolve_char_skin(stem: str, en_to_cn: dict[str, str]) -> tuple[str, str, list[str], bool]:
    s = stem.lower()
    s = re.sub(r"^lh_", "", s)
    s = re.sub(r"_sp$", "", s)
    notes: list[str] = []
    if "hexie" in s:
        notes.append("和谐")
        s = s.replace("_hexie", "").replace("hexie", "")
        s = s.strip("_")
    parts0 = [p for p in re.split(r"[/_]+", s) if p]
    parts0 = [STEM_ALIAS.get(p, p) for p in parts0]
    s = "_".join(parts0) if parts0 else s
    compact = _compact(s)
    compact = STEM_ALIAS.get(compact, compact)
    keys = sorted((k for k in en_to_cn if k), key=len, reverse=True)
    for en in keys:
        if compact == en:
            return en_to_cn[en], "默认", notes, True
        if len(en) < 4:
            continue
        if compact.startswith(en):
            rest = _peel_rest(s, en)
            skin, extra = skin_from_rest(rest)
            return en_to_cn[en], skin, notes + extra, True
    for pre, skin_name in (("summer", "夏"), ("maid", "女仆"), ("jk", "JK")):
        rest = compact[len(pre) :]
        if compact.startswith(pre) and rest in en_to_cn:
            return en_to_cn[rest], skin_name, notes, True
    parts = [p for p in re.split(r"[/_]+", s) if p]
    if parts and _compact(parts[0]) in en_to_cn:
        skin, extra = skin_from_rest("_".join(parts[1:]))
        return en_to_cn[_compact(parts[0])], skin, notes + extra, True
    if not parts:
        return "未知", "默认", notes, False
    cha = _title_stem(parts[0])
    skin, extra = skin_from_rest("_".join(parts[1:]))
    return cha, skin, notes + extra, False


def _read_unity_sprites(bundle: Path) -> dict[str, Any]:
    import UnityPy

    env = UnityPy.load(str(bundle))
    sprites: dict[str, Any] = {}
    for obj in env.objects:
        if getattr(obj.type, "name", None) != "Sprite":
            continue
        try:
            data = obj.read()
        except Exception:
            continue
        name = str(getattr(data, "m_Name", "") or "")
        img = getattr(data, "image", None)
        if img is None:
            continue
        sprites[name] = img
    return sprites


def _save_png(img: Any, dest: Path) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    img.save(dest, "PNG")


def _pick_named(pool: dict[str, Any], want: str) -> Any | None:
    want_l = want.lower()
    for name, img in pool.items():
        if name.lower() == want_l:
            return img
    return None


def iter_roleplus(root: Path) -> list[tuple[Path, str]]:
    out: list[tuple[Path, str]] = []
    bases: list[Path] = []
    for cand in (
        root / "Asset" / "generate_guide" / "roleplus",
        root / "generate_guide" / "roleplus",
    ):
        if cand.is_dir():
            bases.append(cand)
    seen: set[Path] = set()
    skip_parts = ("skillicon", "00gift", "emo")
    for base in bases:
        for path in sorted(base.rglob("*.asset")):
            if path in seen or not path.is_file():
                continue
            seen.add(path)
            rel = path.relative_to(base).as_posix().lower()
            parts = path.relative_to(base).with_suffix("").parts
            if "_bot" in rel or any(p.lower() in skip_parts for p in parts):
                continue
            stem = parts[0] if len(parts) == 1 else parts[0] + "_" + "_".join(parts[1:])
            out.append((path, stem))
    return out


# ---------------------------------------------------------------------------
# 子命令
# ---------------------------------------------------------------------------

def resolve_hotfix(
    args: argparse.Namespace,
) -> tuple[dict[str, str], dict[str, Any], dict[str, Any]]:
    apk = find_apk(getattr(args, "apk", None))
    app_version = getattr(args, "app_version", None) or read_apk_version(apk)
    rows = parse_index_rows(fetch_index_text())
    row = match_index_row(rows, app_version)
    force = bool(getattr(args, "force", False))
    static = row["staticURL"]
    pkg_ver = row["serverPackageVersion"]
    patch_ver = row["serverPatchVersion"]
    package_desc = load_or_fetch_desc(static, pkg_ver, force=force, cache_stem="desc_package")
    if pkg_ver == patch_ver:
        patch_desc = package_desc
    else:
        patch_desc = load_or_fetch_desc(static, patch_ver, force=force, cache_stem="desc_patch")
    return row, package_desc, patch_desc


def cmd_version(args: argparse.Namespace) -> None:
    apk = find_apk(getattr(args, "apk", None))
    app_version = getattr(args, "app_version", None) or read_apk_version(apk)
    row, package_desc, patch_desc = resolve_hotfix(args)
    table = Table(title=f"{PLATFORM} / {FROM_RES} / app {app_version}")
    table.add_column("字段")
    table.add_column("值")
    for k in (
        "clientAppVersion",
        "serverPackageVersion",
        "serverPatchVersion",
        "serverIpPort",
        "staticURL",
    ):
        table.add_row(k, row.get(k, ""))
    console.print(table)
    plan = merge_hotfix_plan(
        package_desc, patch_desc, row["serverPackageVersion"], row["serverPatchVersion"]
    )
    merged = sum(int(f.get("size") or 0) for f in plan)
    console.print(
        f"[bold green]要下[/bold green] {format_size(merged)}（{len(plan)} 个文件）"
    )


def hotfix_todo(items: list[dict[str, Any]], force: bool) -> list[dict[str, Any]]:
    todo: list[dict[str, Any]] = []
    for info in items:
        rel = str(info["path"])
        dest = ASSETS_DIR / rel
        crc = int(info.get("crc") or 0)
        size = int(info.get("size") or 0)
        ver = str(info["ver"])
        if dest.is_file() and not force:
            try:
                if dest.stat().st_size == size and (not crc or file_eden_crc(dest) == crc):
                    continue
            except Exception:
                pass
        todo.append({"rel": rel, "dest": dest, "crc": crc, "size": size, "ver": ver})
    return todo


def cmd_assets(args: argparse.Namespace) -> None:
    force = bool(getattr(args, "force", False))
    jobs = max(1, int(getattr(args, "jobs", None) or DEFAULT_JOBS))
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)

    apk = find_apk(getattr(args, "apk", None))
    if not getattr(args, "skip_apk", False):
        n = extract_apk(apk, force=force)
        console.print(f"[green]APK[/green] 写出 {n} -> {ASSETS_DIR}  ({apk.name})")
    else:
        console.print("[yellow]跳过 APK 提取[/yellow]")

    row, package_desc, patch_desc = resolve_hotfix(args)
    static = row["staticURL"]
    pkg_ver = row["serverPackageVersion"]
    patch_ver = row["serverPatchVersion"]
    plan = merge_hotfix_plan(package_desc, patch_desc, pkg_ver, patch_ver)
    pkg_items = [f for f in plan if f["kind"] == "package"]
    patch_items = [f for f in plan if f["kind"] == "patch"]
    pkg_todo = hotfix_todo(pkg_items, force)
    patch_todo = hotfix_todo(patch_items, force)
    remain = pkg_todo + patch_todo
    remain_sz = sum(int(x["size"] or 0) for x in remain)
    console.print(
        f"[cyan]热更[/cyan] 要下 {format_size(remain_sz)}（{len(remain)} 个文件）"
    )

    def download_batch(todo: list[dict[str, Any]], title: str) -> tuple[int, int]:
        written = fail = 0
        if not todo:
            console.print(f"[green]{title}[/green] 不用下")
            return written, fail
        total = sum(int(x["size"] or 0) for x in todo)
        lock = threading.Lock()
        with make_progress(DownloadColumn(), TransferSpeedColumn()) as progress:
            task = progress.add_task(title, total=total)

            def on_bytes(n: int) -> None:
                with lock:
                    progress.update(task, advance=n)

            def work(item: dict[str, Any]) -> tuple[str, str, str | None]:
                url = cdn_url(static, item["rel"], item["ver"])
                try:
                    download_to(
                        url,
                        item["dest"],
                        expected_crc=item["crc"],
                        expected_size=item["size"],
                        on_bytes=on_bytes,
                    )
                    return "ok", item["rel"], None
                except Exception as exc:  # noqa: BLE001
                    return "fail", item["rel"], str(exc)

            with ThreadPoolExecutor(max_workers=jobs) as pool:
                futs = [pool.submit(work, item) for item in todo]
                for fut in as_completed(futs):
                    status, rel, err = fut.result()
                    if status == "ok":
                        written += 1
                    else:
                        fail += 1
                        console.print(f"[red]失败[/red] {rel}: {err}")
        console.print(f"[bold green]{title}[/bold green] 写出 {written}  失败 {fail}")
        return written, fail

    def extract_jabs(paths: list[Path], title: str) -> int:
        exist = [p for p in paths if p.is_file()]
        if not exist:
            return 0
        n = 0
        with make_progress(MofNCompleteColumn()) as progress:
            task = progress.add_task(title, total=len(exist))
            for jab in exist:
                try:
                    n += extract_jab(jab, ASSETS_DIR)
                except Exception as exc:  # noqa: BLE001
                    console.print(f"[red]JAB 失败[/red] {jab}: {exc}")
                progress.advance(task)
        console.print(f"[green]{title}[/green] 抽出 {n} 文件")
        return n

    download_batch(pkg_todo, f"下载底包 {pkg_ver}")
    extract_jabs(
        [ASSETS_DIR / f["path"] for f in pkg_items if f["path"].endswith(".jab")],
        "解底包 JAB",
    )
    download_batch(patch_todo, f"下载补丁 {patch_ver}")
    extract_jabs(
        [ASSETS_DIR / f["path"] for f in patch_items if f["path"].endswith(".jab")],
        "解补丁 JAB",
    )


def cmd_masterdata(args: argparse.Namespace) -> None:
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    script_jab = ASSETS_DIR / "Script" / "script.jab"
    scripts_jab = ASSETS_DIR / "Scripts" / "scripts.jab"
    trans_jab = ASSETS_DIR / "Translate" / "translate.jab"
    bin_jab = ASSETS_DIR / "BinaryConfig" / "binaryConfig.jab"
    cfg_jab = ASSETS_DIR / "Config" / "config.jab"

    if not (ASSETS_DIR / "Script").exists() and not script_jab.is_file():
        console.print("[red]缺 Script/[/red]，先跑 assets")
        return

    for jab in (script_jab, scripts_jab, trans_jab, bin_jab, cfg_jab):
        if jab.is_file():
            n = extract_jab(jab, ASSETS_DIR)
            console.print(f"[green]JAB[/green] {jab.name} -> {n}")

    lua_files = [p for p in ASSETS_DIR.rglob("*.lua") if p.is_file()]
    if lua_files:
        ok, fail = convert_lua_tree(ASSETS_DIR, MASTER_DIR)
        console.print(
            f"[bold green]Lua[/bold green] unluac {ok}  保留字节码 {fail}  "
            f"（{len(lua_files)} 个 .lua）-> {MASTER_DIR}"
        )
    else:
        console.print("[yellow]没有 .lua[/yellow]")

    nlang = dump_language_json()
    console.print(f"[green]语言表[/green] {nlang} -> {MASTER_DIR / 'Translate'}")

    for pack_name in ("TextResPack", "SVResPack", "OriginPackTxt"):
        copied = 0
        for path in (ASSETS_DIR / "Translate").rglob(pack_name):
            if not path.is_file():
                continue
            dest = MASTER_DIR / "Translate" / path.relative_to(ASSETS_DIR / "Translate")
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(path, dest)
            copied += 1
        if copied:
            console.print(f"[green]{pack_name}[/green] {copied} -> Translate/")

    bsrc = ASSETS_DIR / "BinaryConfig"
    if bsrc.is_dir():
        bdst = MASTER_DIR / "BinaryConfig"
        bins = [p for p in bsrc.glob("*.bin") if p.is_file()]
        with make_progress(MofNCompleteColumn()) as progress:
            task = progress.add_task("解析 Factory.bin", total=len(bins))

            def on_file(path: Path, success: bool, err: str | None) -> None:
                if not success:
                    console.print(f"[red]Factory 失败[/red] {path.name}: {err}")
                progress.advance(task)

            ok, fail = dump_all_factories(bsrc, bdst, on_file=on_file)
        console.print(f"[bold green]BinaryConfig[/bold green] JSON {ok}  失败 {fail} -> {bdst}")

    guide = ASSETS_DIR / "Config" / "GuideAsset.bin"
    if guide.is_file():
        dest = MASTER_DIR / "Config" / "GuideAsset.json"
        dest.parent.mkdir(parents=True, exist_ok=True)
        try:
            dest.write_text(
                json.dumps(parse_guide_asset(guide.read_bytes()), ensure_ascii=False, indent=2),
                encoding="utf-8",
            )
            console.print(f"[green]GuideAsset[/green] {dest}")
        except Exception as exc:  # noqa: BLE001
            console.print(f"[red]GuideAsset 失败[/red] {exc}")


def cmd_painting(args: argparse.Namespace) -> None:
    warnings.filterwarnings("ignore", message="No valid Unity version found")
    force = bool(getattr(args, "force", False))
    limit = int(getattr(args, "limit", 0) or 0)
    jobs = max(1, int(getattr(args, "jobs", None) or DEFAULT_JOBS))
    root = Path(getattr(args, "path", None) or ASSETS_DIR)

    lang_ok = list((MASTER_DIR / "Translate").rglob("ConfigLanguage.json")) or list(
        (ASSETS_DIR / "Translate").rglob("ConfigLanguage.bin")
    )
    if not lang_ok:
        console.print("[red]缺语言表[/red]，先跑 assets / masterdata")
        return
    if not root.is_dir():
        console.print(f"[red]缺资源目录[/red] {root}，先跑 assets")
        return

    en_to_cn, _names = load_unit_name_maps()
    roleplus = iter_roleplus(root)
    # bundle, dest Full, dest State2_Full
    jobs_list: list[tuple[Path, Path, Path]] = []
    used: set[str] = set()
    named = total_targets = 0

    for path, stem in roleplus:
        cha, skin, notes, hit = resolve_char_skin(stem, en_to_cn)
        if hit:
            named += 1
        dest = PAINTING_DIR / painting_filename(cha, skin, used, notes)
        dest2 = PAINTING_DIR / painting_filename(cha, skin, used, list(notes) + ["State2"])
        jobs_list.append((path, dest, dest2))
        total_targets += 2

    if limit > 0:
        jobs_list = jobs_list[:limit]
        total_targets = len(jobs_list) * 2
        console.print(f"[yellow]--limit {limit}[/yellow] 立绘")

    console.print(
        f"[cyan]立绘名称[/cyan] 表命中 {named}/{len(jobs_list)} 文件  "
        f"UnitFactory {len(en_to_cn)} 键 → {PAINTING_DIR}"
    )
    if not jobs_list:
        console.print("[yellow]没有 roleplus 可导出，先跑 assets[/yellow]")
        return

    PAINTING_DIR.mkdir(parents=True, exist_ok=True)
    written = skipped = fail = 0
    with make_progress(MofNCompleteColumn()) as progress:
        task = progress.add_task("导出立绘", total=total_targets)

        def work(item: tuple[Path, Path, Path]) -> tuple[int, int, int, str, str | None]:
            bundle, dest, dest2 = item
            n_ok = n_skip = n_fail = 0
            need_full = force or not dest.is_file()
            need_s2 = force or not dest2.is_file()
            try:
                if not need_full:
                    n_skip += 1
                if not need_s2:
                    n_skip += 1
                if not need_full and not need_s2:
                    return n_ok, n_skip, n_fail, bundle.name, None
                sprites = _read_unity_sprites(bundle)
                if need_full:
                    img = _pick_named(sprites, "Full")
                    if img is None:
                        n_skip += 1
                    else:
                        _save_png(img, dest)
                        n_ok += 1
                if need_s2:
                    img = _pick_named(sprites, "State2_Full")
                    if img is None:
                        n_skip += 1
                    else:
                        _save_png(img, dest2)
                        n_ok += 1
                return n_ok, n_skip, n_fail, bundle.name, None
            except Exception as exc:  # noqa: BLE001
                dest.unlink(missing_ok=True)
                dest2.unlink(missing_ok=True)
                remain = (1 if need_full else 0) + (1 if need_s2 else 0)
                return 0, n_skip, max(remain, 1), bundle.name, str(exc)

        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(work, item) for item in jobs_list]
            for fut in as_completed(futs):
                n_ok, n_skip, n_fail, name, err = fut.result()
                written += n_ok
                skipped += n_skip
                fail += n_fail
                if err:
                    console.print(f"[red]立绘失败[/red] {name}: {err}")
                progress.advance(task, n_ok + n_skip + n_fail)

    console.print(
        f"[bold green]Painting[/bold green] 写出 {written}  跳过 {skipped}  失败 {fail} → {PAINTING_DIR}"
    )


def cmd_pipeline(args: argparse.Namespace) -> None:
    paint_jobs = getattr(args, "jobs", None) or DEFAULT_JOBS
    cmd_assets(args)
    cmd_masterdata(args)
    if not getattr(args, "skip_painting", False):
        args.jobs = paint_jobs
        cmd_painting(args)


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--apk", help="APK 路径")
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="并发线程数")
    shared.add_argument("--app-version", dest="app_version", help="应用版本，默认读 APK")
    shared.add_argument("--force", action="store_true", help="忽略已有文件强制重做")

    p = argparse.ArgumentParser(
        description="雷索纳斯 CDN 下载 / Lua 解密 / 立绘导出。不带子命令时执行全流程。",
        parents=[shared],
    )
    p.add_argument("--skip-apk", action="store_true", help="不从 APK 提取")
    p.add_argument("--skip-painting", action="store_true", help="跳过立绘导出")
    sub = p.add_subparsers(dest="command", required=False)

    sub.add_parser("version", aliases=["list"], parents=[shared], help="打印 index 匹配行与 desc 头")

    p_assets = sub.add_parser("assets", parents=[shared], help="APK 提取 + 热更到 Assets/")
    p_assets.add_argument("--skip-apk", action="store_true", help="不从 APK 提取")

    sub.add_parser(
        "masterdata",
        aliases=["data", "lua"],
        parents=[shared],
        help="全部 Lua + 语言表 + BinaryConfig JSON 到 MasterData/",
    )

    p_paint = sub.add_parser("painting", parents=[shared], help="导出立绘到 Painting/")
    p_paint.add_argument("--path", help="资源根目录，默认 Assets/")
    p_paint.add_argument("--limit", type=int, default=0, help="只导出前 N 张，调试用")
    return p


def main() -> None:
    parser = build_parser()
    args = parser.parse_args()
    if not hasattr(args, "jobs") or args.jobs is None:
        args.jobs = DEFAULT_JOBS
    cmd = getattr(args, "command", None)
    if not cmd:
        cmd_pipeline(args)
    elif cmd in ("version", "list"):
        cmd_version(args)
    elif cmd == "assets":
        cmd_assets(args)
    elif cmd in ("masterdata", "data", "lua"):
        cmd_masterdata(args)
    elif cmd == "painting":
        cmd_painting(args)
    else:
        parser.error(f"未知子命令 {cmd}")


if __name__ == "__main__":
    main()
