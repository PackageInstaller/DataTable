from __future__ import annotations

import argparse
import base64
import hashlib
import json
import re
import shutil
import struct
import subprocess
import sys
import threading
import time
import warnings
import zipfile
from collections.abc import Iterable, Sequence
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

SCRIPT_DIR = Path(__file__).resolve().parent

GAME_TITLE = "弹力果冻"
PROJECT_CODE = "ElasticJelly"
DEFAULT_ENV = "live"
DEFAULT_PLATFORM = "android"
DEFAULT_CATALOG = "catalog_ElasticJelly"
DEFAULT_ILSPYCMD = "ilspycmd"

PLATFORM_BUNDLE_DIR = {"android": "bundle-android", "ios": "bundle-ios"}
PLATFORM_DLL_DIR = {"android": "dll-android", "ios": "dll-ios"}

APK_BUNDLE_PREFIX = "assets/Bundle/"
APK_DATA_PREFIX = "assets/bin/Data/"
APK_AOTDLL_PREFIX = "assets/AOTDLL/"

BUNDLE_PATH_MARK = "\\Bundle\\"
REMOTE_PATH_MARK = "{AddressableManager.RemotePath}"

TABLE_ROW_SEP = "[|]"
TABLE_KV_SEP = "[`]"

HOT_DLL_NAME = "Assembly-CSharp.dll"


APK_DEFAULT_SKIP = ("lib/", "res/", "META-INF/", "classes.dex", "assets/bundle/")
APK_META_PATTERNS = ("Catalog", "aa/", "bin/Data/", "AOTDLL", "Shader")

_missing: list[str] = []
try:
    import requests
except ImportError:  # pragma: no cover
    _missing.append("requests")
try:
    import UnityPy

    warnings.filterwarnings("ignore", message=".*Unity.*version.*")
    UnityPy.config.FALLBACK_UNITY_VERSION = "2020.3.22f1c1"
except ImportError:  # pragma: no cover
    _missing.append("UnityPy")
try:
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
    from rich.table import Table
except ImportError:  # pragma: no cover
    _missing.append("rich")

if _missing:
    print("缺少依赖:", ", ".join(_missing))
    print("  pip install", " ".join(_missing))
    sys.exit(1)

console = Console()
sys.path.insert(0, str(SCRIPT_DIR))



# --------------------------------------------------------------------------- #
# 工作目录
# --------------------------------------------------------------------------- #
class Workspace:
    """所有输出目录都挂在 --root（默认脚本所在目录）下。"""

    def __init__(self, root: Path) -> None:
        self.root = root
        self.apk_dir = root / "Apk"
        self.bundle_dir = root / "Bundles"
        self.hot_bundle_dir = self.bundle_dir / "Hot"
        self.local_bundle_dir = self.bundle_dir / "Local"
        self.assets_dir = root / "Assets"
        self.master_dir = root / "MasterData"
        self.hot_dll_dir = root / "HotDll"
        self.cs_dir = root / "Cs"
        self.cache_dir = root / "Cache"
        self.state_path = root / "StarHealer.state.json"


WORK = Workspace(SCRIPT_DIR)


def format_size(n: int) -> str:
    units = ("B", "KiB", "MiB", "GiB", "TiB")
    value = float(n)
    for unit in units:
        if value < 1024 or unit == units[-1]:
            return f"{value:.2f} {unit}" if unit != "B" else f"{int(value)} B"
        value /= 1024
    return f"{n} B"


def md5_bytes(data: bytes) -> str:
    return hashlib.md5(data).hexdigest()


def md5_file(path: Path, chunk_size: int = 1 << 20) -> str:
    h = hashlib.md5()
    with path.open("rb") as fh:
        for block in iter(lambda: fh.read(chunk_size), b""):
            h.update(block)
    return h.hexdigest()


def write_json(path: Path, obj: Any, indent: int = 2) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(path.suffix + ".tmp")
    tmp.write_text(
        json.dumps(obj, ensure_ascii=False, indent=indent, default=str) + "\n",
        encoding="utf-8",
    )
    tmp.replace(path)


def load_json(path: Path, default: Any = None) -> Any:
    if not path.is_file():
        return default
    try:
        return json.loads(path.read_text(encoding="utf-8-sig"))
    except Exception:  # noqa: BLE001
        return default


def load_state() -> dict[str, Any]:
    state = load_json(WORK.state_path, {})
    return state if isinstance(state, dict) else {}


def save_state(state: dict[str, Any]) -> None:
    write_json(WORK.state_path, state)


def textasset_bytes(obj: Any) -> tuple[str, bytes]:
    """UnityPy TextAsset → (名字, 原始字节)。"""
    data = obj.read()
    script = getattr(data, "m_Script", None)
    if script is None:
        script = getattr(data, "script", b"")
    if isinstance(script, str):
        raw = script.encode("utf-8", "surrogateescape")
    else:
        raw = bytes(script)
    return getattr(data, "m_Name", "") or "", raw


# --------------------------------------------------------------------------- #
# 网络
# --------------------------------------------------------------------------- #
_tls = threading.local()


def get_session() -> requests.Session:
    session = getattr(_tls, "session", None)
    if session is None:
        session = requests.Session()
        session.headers.update({"User-Agent": "UnityPlayer/2020.3.22f1c1 (UnityWebRequest/1.0)"})
        _tls.session = session
    return session


def http_get_bytes(url: str, timeout: int = 60) -> bytes:
    resp = get_session().get(url, timeout=timeout)
    resp.raise_for_status()
    return resp.content


def download_file(
    url: str,
    dest: Path,
    size: int = 0,
    force: bool = False,
    retries: int = 4,
    timeout: int = 120,
) -> str:
    """下载到 dest（.part → 校验 → 改名）。返回 ok / skip。"""
    if not force and dest.is_file() and (not size or dest.stat().st_size == size):
        return "skip"
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_suffix(dest.suffix + ".part")
    last_err: Exception | None = None
    for attempt in range(1, max(1, retries) + 1):
        try:
            resp = get_session().get(url, timeout=timeout, stream=True)
            resp.raise_for_status()
            written = 0
            with tmp.open("wb") as fh:
                for chunk in resp.iter_content(1 << 16):
                    if chunk:
                        fh.write(chunk)
                        written += len(chunk)
            if size and written != size:
                raise ValueError(f"大小不符 {written} != {size}")
            tmp.replace(dest)
            return "ok"
        except Exception as exc:  # noqa: BLE001
            last_err = exc
            if tmp.exists():
                tmp.unlink()
            time.sleep(min(6, attempt))
    raise RuntimeError(f"下载失败 {url}: {last_err}")


# --------------------------------------------------------------------------- #
# APK
# --------------------------------------------------------------------------- #
def find_apk(explicit: str | None = None) -> Path | None:
    if explicit:
        path = Path(explicit)
        return path if path.is_file() else None
    apks = sorted(SCRIPT_DIR.glob("*.apk")) + sorted(SCRIPT_DIR.glob("*.apks"))
    if not apks:
        return None
    return max(apks, key=lambda p: p.stat().st_size)


class Apk:
    """APK 只读访问（线程内共享 ZipFile，zipfile 自带共享文件锁）。"""

    def __init__(self, path: Path) -> None:
        self.path = path
        self.zip = zipfile.ZipFile(path)
        self._names = set(self.zip.namelist())

    def close(self) -> None:
        self.zip.close()

    def has(self, name: str) -> bool:
        return name in self._names

    def read(self, name: str) -> bytes:
        return self.zip.read(name)

    def read_opt(self, name: str) -> bytes | None:
        if not self.has(name):
            return None
        return self.zip.read(name)

    def bundle_names(self) -> list[str]:
        return [
            n[len(APK_BUNDLE_PREFIX) :]
            for n in self._names
            if n.startswith(APK_BUNDLE_PREFIX) and n.endswith(".bundle")
        ]

    def infos(self, prefix: str) -> list[zipfile.ZipInfo]:
        return [
            info
            for info in self.zip.infolist()
            if info.filename.startswith(prefix) and not info.is_dir()
        ]

    def resource_textasset(
        self, asset_name: str, marker: bytes | None = None, max_size: int = 8 << 20
    ) -> str | None:
        """在 assets/bin/Data 的哈希资源文件里找一个 TextAsset（如 luncher-manifest）。"""
        needle = marker or asset_name.encode("utf-8")
        for info in self.infos(APK_DATA_PREFIX):
            if info.filename.endswith(".resource"):
                continue
            if not info.file_size or info.file_size > max_size:
                continue
            try:
                raw = self.read(info.filename)
            except Exception:  # noqa: BLE001, S112
                continue
            if needle not in raw:
                continue
            try:
                env = UnityPy.load(raw)
            except Exception:  # noqa: BLE001, S112
                continue
            for obj in env.objects:
                if str(obj.type.name) != "TextAsset":
                    continue
                try:
                    name, data = textasset_bytes(obj)
                except Exception:  # noqa: BLE001, S112
                    continue
                if name == asset_name:
                    return data.decode("utf-8-sig", "replace")
        return None


def extract_apk(apk: Apk, dest: Path, only: Any, force: bool) -> dict[str, int]:
    """解包 APK。only 为空时跳过 APK_DEFAULT_SKIP 下的文件。"""
    stats = {"written": 0, "skipped": 0}
    if isinstance(only, str):
        only = [only]
    patterns = [str(p).strip().lower() for p in (only or []) if str(p).strip()]
    for info in apk.zip.infolist():
        if info.is_dir():
            continue
        name = info.filename
        low = name.lower()
        if patterns:
            if not any(p in low for p in patterns):
                continue
        elif low.startswith(APK_DEFAULT_SKIP):
            continue
        target = dest / name
        if target.is_file() and not force and target.stat().st_size == info.file_size:
            stats["skipped"] += 1
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        with apk.zip.open(info) as src, target.open("wb") as dst:
            shutil.copyfileobj(src, dst, 1 << 20)
        stats["written"] += 1
    return stats


# --------------------------------------------------------------------------- #
# 渠道 / 版本
# --------------------------------------------------------------------------- #
@dataclass
class Channel:
    name: str
    cdn: str
    origin: str
    servers: dict[str, Any] = field(default_factory=dict)


def read_luncher_manifest(apk: Apk | None, override: Path | None = None) -> dict[str, Any]:
    if override and override.is_file():
        raw = override.read_text(encoding="utf-8-sig")
    else:
        raw = cached_textasset(apk, "luncher-manifest", b'"env.list"', "luncher-manifest.txt")
    if not raw:
        return {}
    try:
        data = json.loads(raw)
    except Exception:  # noqa: BLE001
        return {}
    return data if isinstance(data, dict) else {}


def cached_textasset(
    apk: Apk | None, asset_name: str, marker: bytes, cache_name: str
) -> str | None:
    """APK 内 Resources TextAsset：按 APK mtime 缓存，避免每次全盘扫描 bin/Data。"""
    if apk is None:
        return None
    cache = WORK.cache_dir / cache_name
    try:
        if cache.is_file() and cache.stat().st_mtime >= apk.path.stat().st_mtime:
            return cache.read_text(encoding="utf-8-sig")
    except OSError:
        pass
    raw = apk.resource_textasset(asset_name, marker)
    if raw:
        cache.parent.mkdir(parents=True, exist_ok=True)
        cache.write_text(raw, encoding="utf-8")
    return raw


def resolve_channel(manifest: dict[str, Any], env: str, cdn: str = "", origin: str = "") -> Channel:
    name = env or manifest.get("env.default") or DEFAULT_ENV
    cdn = cdn or manifest.get(f"{name}.remoteResCdn") or "http://gamesource.ginicat.com"
    origin = origin or manifest.get(f"{name}.remoteResOrigin") or "http://gini.oss-cn-hangzhou.aliyuncs.com"
    servers = manifest.get(f"{name}.server") or {}
    return Channel(name=name, cdn=cdn.rstrip("/"), origin=origin.rstrip("/"), servers=servers)


def env_list(manifest: dict[str, Any]) -> list[str]:
    raw = manifest.get("env.list") or ""
    return [x.strip() for x in str(raw).split(",") if x.strip()]


def apk_aa_settings(apk: Apk | None, root: Path) -> dict[str, Any]:
    """读 Addressables settings.json（APK 内或已解包目录）。"""
    for candidate in (root / "Apk" / "assets" / "aa" / "settings.json",):
        data = load_json(candidate)
        if isinstance(data, dict) and data:
            return data
    if apk:
        raw = apk.read_opt("assets/aa/settings.json")
        if raw:
            try:
                return json.loads(raw.decode("utf-8-sig"))
            except Exception:  # noqa: BLE001
                return {}
    return {}


def catalog_name_from_settings(settings: dict[str, Any]) -> str:
    for loc in settings.get("m_CatalogLocations") or []:
        internal = str(loc.get("m_InternalId") or "")
        m = re.search(r"/Catalog/([^/]+?)(?:\.hash|\.json)?$", internal)
        if m:
            return m.group(1)
    return DEFAULT_CATALOG


def fetch_remote_config(channel: Channel, timeout: int = 60) -> dict[str, Any]:
    url = f"{channel.origin}/remoteConfig.json"
    data = http_get_bytes(url, timeout=timeout)
    return json.loads(data.decode("utf-8-sig"))


def fetch_catalog_bytes(
    channel: Channel, platform: str, bundle_version: str, catalog: str, timeout: int = 180
) -> tuple[bytes, str]:
    base = f"{channel.cdn}/{PLATFORM_BUNDLE_DIR[platform]}/{bundle_version}/Catalog"
    catalog_bytes = http_get_bytes(f"{base}/{catalog}.json", timeout=timeout)
    try:
        hash_text = http_get_bytes(f"{base}/{catalog}.hash", timeout=timeout).decode(
            "utf-8", "replace"
        ).strip()
    except Exception:  # noqa: BLE001
        hash_text = ""
    return catalog_bytes, hash_text


def bundle_url(channel: Channel, platform: str, bundle_version: str, name: str) -> str:
    return f"{channel.cdn}/{PLATFORM_BUNDLE_DIR[platform]}/{bundle_version}/Bundle/{name}"


def dll_url(channel: Channel, platform: str, dll_version: str) -> str:
    return f"{channel.origin}/{PLATFORM_DLL_DIR[platform]}/{dll_version}/hotfix.bytes.zip"


def static_data_url(channel: Channel, data_version: str) -> str:
    return f"{channel.origin}/staticData/{data_version}/old.zip"


# --------------------------------------------------------------------------- #
# Addressables catalog
# --------------------------------------------------------------------------- #
class _Bin:
    def __init__(self, buf: bytes) -> None:
        self.buf = buf
        self.pos = 0

    def u8(self) -> int:
        v = self.buf[self.pos]
        self.pos += 1
        return v

    def u32(self) -> int:
        v = struct.unpack_from("<I", self.buf, self.pos)[0]
        self.pos += 4
        return v

    def i32(self) -> int:
        v = struct.unpack_from("<i", self.buf, self.pos)[0]
        self.pos += 4
        return v

    def string(self, length: int) -> str:
        return self.buf[self.pos : self.pos + length].decode("utf-8", "replace")


@dataclass
class CatEntry:
    """Addressables 里的一个逻辑资产（internal_id 即原始工程路径）。"""

    internal_id: str
    primary_key: str
    class_name: str
    provider: str
    bundles: list[str] = field(default_factory=list)
    crc: str = ""
    size: int = 0
    hash: str = ""

    @property
    def bundle(self) -> str:
        return self.bundles[0] if self.bundles else ""


@dataclass
class CatBundle:
    name: str
    size: int = 0
    crc: str = ""
    hash: str = ""

    @property
    def key(self) -> str:
        base = self.name
        for suffix in (".bundle",):
            base = base.removesuffix(suffix)
        while "_" in base and re.fullmatch(r"[0-9a-f]{32}", base.rsplit("_", 1)[1]):
            base = base.rsplit("_", 1)[0]
        return base


class Catalog:
    """Addressables JSON catalog（m_KeyData/m_Bucket/m_Entry 三段式）。"""

    def __init__(self, raw: bytes) -> None:
        if raw.lstrip()[:1] != b"{":
            magic = struct.unpack_from("<I", raw, 0)[0]
            if magic in (0x0DE38942, 0x4289E30D):
                raise ValueError("二进制 catalog 暂不支持，请提供 JSON 版")
            raise ValueError("不是有效的 Addressables JSON catalog")
        self.raw = json.loads(raw.decode("utf-8-sig"))
        self.locator_id = self.raw.get("m_LocatorId", "")
        self.build_hash = self.raw.get("m_BuildResultHash", "")
        self.entries: list[CatEntry] = []
        self.bundles: dict[str, CatBundle] = {}
        self._parse()

    # -- 解析 -------------------------------------------------------------
    def _parse(self) -> None:
        raw = self.raw
        keys = self._parse_keys()
        buckets = self._parse_buckets()
        internal_ids = raw.get("m_InternalIds") or []
        prefixes = raw.get("m_InternalIdPrefixes") or []
        provider_ids = raw.get("m_ProviderIds") or []
        resource_types = [
            str(t.get("m_ClassName") or "") for t in (raw.get("m_resourceTypes") or [])
        ]
        extra = _Bin(base64.b64decode(raw["m_ExtraDataString"]))
        ents = _Bin(base64.b64decode(raw["m_EntryDataString"]))

        locations: list[dict[str, Any]] = []
        count = ents.u32()
        for _ in range(count):
            ii = ents.i32()
            pi = ents.i32()
            dki = ents.i32()
            _dh = ents.i32()
            di = ents.i32()
            pk = ents.i32()
            rt = ents.i32()

            data: dict[str, Any] = {}
            if di >= 0:
                extra.pos = di
                if extra.u8() == 7:  # JSON object
                    asm_len = extra.u8()  # 1 字节长度 + 内容
                    extra.pos += asm_len
                    cls_len = extra.u8()
                    extra.pos += cls_len
                    length = extra.i32()
                    candidates = []
                    if length >= 0:
                        candidates.append(extra.buf[extra.pos : extra.pos + length])
                        candidates.append(extra.buf[extra.pos : extra.pos + length * 2])
                    for blob in candidates:
                        try:
                            data = json.loads(blob.decode("utf-16le"))
                            break
                        except Exception:  # noqa: BLE001
                            data = {}

            internal_id = internal_ids[ii] if 0 <= ii < len(internal_ids) else ""
            if "#" in internal_id and prefixes:
                head, _, tail = internal_id.partition("#")
                try:
                    idx = int(head)
                    if 0 <= idx < len(prefixes):
                        internal_id = prefixes[idx] + tail
                except ValueError:
                    pass
            locations.append(
                {
                    "internal_id": internal_id,
                    "provider": provider_ids[pi] if 0 <= pi < len(provider_ids) else "",
                    "dep_key": dki,
                    "primary_key": keys[pk] if 0 <= pk < len(keys) else "",
                    "class_name": resource_types[rt] if 0 <= rt < len(resource_types) else "",
                    "data": data,
                }
            )

        # bundle 位置
        for loc in locations:
            data = loc["data"] or {}
            name = self._bundle_name(loc["internal_id"])
            if not name:
                continue
            bundle = self.bundles.get(name)
            if bundle is None:
                bundle = CatBundle(name=name)
                self.bundles[name] = bundle
            bundle.size = int(data.get("m_BundleSize") or bundle.size or 0)
            bundle.crc = f"0x{int(data.get('m_Crc') or 0):08x}" if data else bundle.crc
            bundle.hash = str(data.get("m_Hash") or bundle.hash or "")

        # 资产条目（同一路径可能有多条 key，按路径去重）
        seen_paths: dict[str, CatEntry] = {}
        for loc in locations:
            internal_id = loc["internal_id"]
            if not internal_id.startswith("Assets/"):
                continue
            dep_key = loc["dep_key"]
            names: list[str] = []
            if 0 <= dep_key < len(buckets):
                for entry_idx in buckets[dep_key][1]:
                    if 0 <= entry_idx < len(locations):
                        name = self._bundle_name(locations[entry_idx]["internal_id"])
                        if name and name not in names:
                            names.append(name)
            entry = CatEntry(
                internal_id=internal_id,
                primary_key=loc["primary_key"],
                class_name=loc["class_name"],
                provider=loc["provider"],
                bundles=names,
            )
            exist = seen_paths.get(internal_id)
            if exist is None:
                seen_paths[internal_id] = entry
            else:
                for name in names:
                    if name not in exist.bundles:
                        exist.bundles.append(name)
        self.entries = list(seen_paths.values())

    def _parse_keys(self) -> list[Any]:
        kd = _Bin(base64.b64decode(self.raw["m_KeyDataString"]))
        buckets = self._parse_buckets()
        count = kd.u32()
        keys: list[Any] = []
        for i in range(count):
            if i < len(buckets):
                kd.pos = buckets[i][0]
            kind = kd.u8()
            if kind == 0:
                keys.append(kd.string(kd.u32()))
            elif kind == 1:
                length = kd.u32()
                keys.append(kd.buf[kd.pos : kd.pos + length * 2].decode("utf-16le", "replace"))
                kd.pos += length * 2
            elif kind in (2, 3):
                keys.append(kd.u32())
            elif kind == 4:
                keys.append(kd.i32())
            else:
                keys.append(None)
        return keys

    def _parse_buckets(self) -> list[tuple[int, list[int]]]:
        bd = _Bin(base64.b64decode(self.raw["m_BucketDataString"]))
        count = bd.u32()
        out: list[tuple[int, list[int]]] = []
        for _ in range(count):
            offset = bd.i32()
            entries = [bd.i32() for _ in range(bd.i32())]
            out.append((offset, entries))
        return out

    @staticmethod
    def _bundle_name(internal_id: str) -> str:
        if BUNDLE_PATH_MARK not in internal_id:
            return ""
        return internal_id.split(BUNDLE_PATH_MARK, 1)[1].replace("/", "\\").split("\\")[-1]

    # -- 查询 -------------------------------------------------------------
    def bundle_names(self) -> list[str]:
        return sorted(self.bundles)

    def entry_index(self) -> dict[str, CatEntry]:
        return {e.internal_id: e for e in self.entries}

    def find_entry(self, suffix: str) -> CatEntry | None:
        target = suffix.replace("\\", "/").lower()
        for entry in self.entries:
            if entry.internal_id.lower().endswith(target):
                return entry
        return None

    def stats(self) -> dict[str, Any]:
        total = sum(b.size for b in self.bundles.values())
        return {
            "locator_id": self.locator_id,
            "build_result_hash": self.build_hash,
            "assets": len(self.entries),
            "bundles": len(self.bundles),
            "bundle_bytes": total,
        }


# --------------------------------------------------------------------------- #
# Bundle 仓库（APK 本地 + 热更下载）
# --------------------------------------------------------------------------- #
class BundleStore:
    def __init__(
        self,
        apk: Apk | None,
        hot_dir: Path,
        local_dir: Path,
        apk_dir: Path | None = None,
    ) -> None:
        self.apk = apk
        self.hot_dir = hot_dir
        self.local_dir = local_dir
        self.apk_dir = apk_dir

    def hot_path(self, name: str) -> Path:
        return self.hot_dir / name

    def local_path(self, name: str) -> Path | None:
        if self.local_dir:
            candidate = self.local_dir / name
            if candidate.is_file():
                return candidate
        if self.apk_dir:
            candidate = self.apk_dir / name
            if candidate.is_file():
                return candidate
        return None

    def exists(self, name: str) -> bool:
        if self.hot_path(name).is_file():
            return True
        if self.local_path(name):
            return True
        return bool(self.apk and self.apk.has(APK_BUNDLE_PREFIX + name))

    def source_of(self, name: str) -> str:
        if self.hot_path(name).is_file():
            return "hot"
        if self.local_path(name):
            return "local"
        if self.apk and self.apk.has(APK_BUNDLE_PREFIX + name):
            return "apk"
        return ""

    def read(self, name: str) -> bytes | None:
        hot = self.hot_path(name)
        if hot.is_file():
            return hot.read_bytes()
        local = self.local_path(name)
        if local:
            return local.read_bytes()
        if self.apk:
            raw = self.apk.read_opt(APK_BUNDLE_PREFIX + name)
            if raw is not None:
                return raw
        return None


def download_bundles(
    store: BundleStore,
    catalog: Catalog,
    names: Sequence[str],
    channel: Channel,
    platform: str,
    bundle_version: str,
    jobs: int,
    retries: int,
    force: bool,
) -> tuple[list[str], list[tuple[str, str]]]:
    todo = [n for n in names if force or not store.hot_path(n).is_file()]
    done: list[str] = []
    failed: list[tuple[str, str]] = []

    def one(name: str) -> tuple[str, str]:
        info = catalog.bundles.get(name)
        size = info.size if info else 0
        try:
            download_file(
                bundle_url(channel, platform, bundle_version, name),
                store.hot_path(name),
                size=size,
                force=force,
                retries=retries,
            )
            return name, ""
        except Exception as exc:  # noqa: BLE001
            return name, str(exc)

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("下载热更 Bundle", total=max(len(todo), 1))
        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futs = [pool.submit(one, name) for name in todo]
            for fut in as_completed(futs):
                name, err = fut.result()
                if err:
                    failed.append((name, err))
                else:
                    done.append(name)
                progress.advance(task)
    return done, failed


# --------------------------------------------------------------------------- #
# Bundle → Assets 还原
# --------------------------------------------------------------------------- #
TEXT_TYPES = {"TextAsset"}
IMAGE_TYPES = {"Texture2D", "Sprite"}
AUDIO_TYPES = {"AudioClip"}
FONT_TYPES = {"Font"}
PMESH_HINT = {"Mesh": ".obj"}

TYPE_ALIASES = {
    "text": TEXT_TYPES,
    "texture": IMAGE_TYPES,
    "audio": AUDIO_TYPES,
    "font": FONT_TYPES,
    "prefab": {"GameObject"},
    "material": {"Material"},
    "mono": {"MonoBehaviour", "ScriptableObject"},
    "anim": {"AnimationClip"},
    "shader": {"Shader", "ShaderVariantCollection"},
}


def _safe_component(text: str) -> str:
    text = re.sub(r"[\\/:*?\"<>|\s]+", "_", text).strip("._")
    return text or "x"


def container_map(env: Any) -> dict[str, list[Any]]:
    """bundle 的 AssetBundle.m_Container → {原始工程路径: [ObjectReader]}。"""
    mapping: dict[str, list[Any]] = {}
    for obj in env.objects:
        if str(obj.type.name) != "AssetBundle":
            continue
        try:
            data = obj.read()
        except Exception:  # noqa: BLE001, S112
            continue
        items = getattr(data, "m_Container", None) or []
        if hasattr(items, "items"):
            items = list(items.items())
        for path, info in items:
            try:
                reader = getattr(info, "asset", None)
                if reader is None or int(getattr(reader, "m_PathID", 0)) == 0:
                    continue
                _ = reader.type  # 触达一次，过滤悬空 PPtr
            except Exception:  # noqa: BLE001, S112
                continue
            mapping.setdefault(str(path), []).append(reader)
    return mapping


def _object_type_name(obj: Any) -> str:
    try:
        return str(obj.type.name)
    except Exception:  # noqa: BLE001
        return ""


def _write_typetree(obj: Any, dest: Path) -> str:
    tree = obj.read_typetree()
    write_json(dest, tree)
    return "json"


def _write_text(obj: Any, dest: Path) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(textasset_bytes(obj)[1])
    return "text"


def _write_texture(obj: Any, dest: Path) -> str:
    data = obj.read()
    image = data.image
    dest.parent.mkdir(parents=True, exist_ok=True)
    target = dest if dest.suffix.lower() in (".png", ".jpg", ".jpeg", ".tga") else dest.with_suffix(".png")
    if target.suffix.lower() in (".jpg", ".jpeg") and image.mode not in ("RGB", "L", "CMYK"):
        target = target.with_suffix(".png")
    image.save(target)
    return "image"


def _write_audio(obj: Any, dest: Path) -> str:
    data = obj.read()
    samples = getattr(data, "samples", None)
    if isinstance(samples, dict) and samples:
        wrote = ""
        for name, blob in samples.items():
            if not isinstance(blob, bytes):
                continue
            suffix = Path(name).suffix or ".wav"
            target = dest if len(samples) == 1 else dest.with_name(dest.stem + suffix)
            if target.suffix.lower() not in (".wav", ".mp3", ".ogg", ".fsb"):
                target = target.with_suffix(suffix)
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(blob)
            wrote = str(target)
        if wrote:
            return "audio"
    raw = getattr(data, "m_AudioData", None) or getattr(data, "m_RawData", None)
    if raw:
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(bytes(raw))
        return "audio"
    raise ValueError("AudioClip 无可用数据")


def _write_font(obj: Any, dest: Path) -> str:
    data = obj.read()
    raw = getattr(data, "m_FontData", None)
    if not raw:
        raise ValueError("Font 无 m_FontData")
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(bytes(raw))
    return "font"


WRITERS = {
    "TextAsset": _write_text,
    "Texture2D": _write_texture,
    "Sprite": _write_texture,
    "AudioClip": _write_audio,
    "Font": _write_font,
}


def _type_matches(alias: str, class_name: str) -> bool:
    targets = TYPE_ALIASES.get(alias, set())
    if not targets:
        return True
    short = class_name.split(".")[-1].strip()
    return short in targets


def restore_loose_objects(
    env: Any, dest_dir: Path, complex_mode: str, force: bool
) -> dict[str, int]:
    """streamed scene 这类没有 container 指向的包：按对象逐个落到同名目录。"""
    stats = {"files": 0, "skipped": 0}
    index = 0
    for obj in env.objects:
        type_name = _object_type_name(obj)
        if not type_name or type_name == "AssetBundle":
            continue
        index += 1
        try:
            data = obj.read()
            name = _safe_component(str(getattr(data, "m_Name", "") or ""))
        except Exception:  # noqa: BLE001
            name = ""
        label = f"{type_name}_{name or f'{index:05d}'}"
        if type_name in IMAGE_TYPES:
            dest = dest_dir / f"{label}.png"
            writer = _write_texture
        elif type_name in AUDIO_TYPES:
            dest = dest_dir / f"{label}.wav"
            writer = _write_audio
        elif type_name in FONT_TYPES:
            dest = dest_dir / f"{label}.ttf"
            writer = _write_font
        elif type_name in TEXT_TYPES:
            dest = dest_dir / f"{label}.txt"
            writer = _write_text
        elif complex_mode == "json":
            dest = dest_dir / f"{label}.json"
            writer = _write_typetree
        else:
            stats["skipped"] += 1
            continue
        if dest.is_file() and not force and dest.stat().st_size > 0:
            stats["skipped"] += 1
            continue
        try:
            dest.parent.mkdir(parents=True, exist_ok=True)
            writer(obj, dest)
            stats["files"] += 1
        except Exception:  # noqa: BLE001
            stats["skipped"] += 1
    return stats


def restore_bundle(
    store: BundleStore,
    name: str,
    entries: Sequence[CatEntry],
    out_root: Path,
    complex_mode: str,
    force: bool,
) -> dict[str, Any]:
    """把一个 bundle 里的资产按原始工程路径写回 Assets/。"""
    raw = store.read(name)
    if raw is None:
        return {"error": "bundle 缺失", "files": 0}
    try:
        env = UnityPy.load(raw)
        mapping = container_map(env)
    except Exception as exc:  # noqa: BLE001
        return {"error": f"解析失败 {exc}", "files": 0}

    stats = {"files": 0, "skipped": 0}
    for entry in entries:
        rel = entry.internal_id
        dest_base = out_root / rel
        objects = list(mapping.get(rel) or [])
        if not objects and not mapping and entry.class_name.endswith("SceneInstance"):
            # streamed scene：整包按对象导出到 <场景路径>/ 目录
            loose = restore_loose_objects(env, dest_base, complex_mode, force)
            stats["files"] += loose["files"]
            stats["skipped"] += loose["skipped"]
            continue
        if not objects:
            # 回退：按对象名匹配文件名
            stem = Path(rel).stem.lower()
            for path, readers in mapping.items():
                if Path(path).stem.lower() == stem:
                    objects.extend(readers)
        if not objects:
            stats["skipped"] += 1
            continue

        want = entry.class_name.split(".")[-1].strip()
        objects = [o for o in objects if _object_type_name(o)]
        if not objects:
            stats["skipped"] += 1
            continue
        objects.sort(key=lambda o: 0 if _object_type_name(o) == want else 1)
        used: set[str] = set()
        for index, obj in enumerate(objects):
            type_name = _object_type_name(obj)
            if not type_name:
                stats["skipped"] += 1
                continue
            dest = dest_base
            if index:
                try:
                    obj_name = getattr(obj.read(), "m_Name", "") or obj.path_id
                except Exception:  # noqa: BLE001
                    obj_name = obj.path_id
                if str(obj_name).lower() == dest_base.stem.lower():
                    # 与主对象同名（如 Texture2D + Sprite 同图），不重复落盘
                    continue
                suffix = dest.suffix
                dest = dest.with_name(f"{dest.stem}.{_safe_component(str(obj_name))}{suffix}")
            key = str(dest).lower()
            if key in used:
                continue
            used.add(key)
            writer = WRITERS.get(type_name)
            target = dest
            if writer is None:
                if complex_mode != "json":
                    stats["skipped"] += 1
                    continue
                target = dest.with_name(dest.name + ".json")
                writer = _write_typetree
            if target.is_file() and not force and target.stat().st_size > 0:
                stats["skipped"] += 1
                continue
            try:
                writer(obj, target)
                stats["files"] += 1
            except Exception:  # noqa: BLE001
                stats["skipped"] += 1
    return stats


def group_entries_by_bundle(entries: Iterable[CatEntry]) -> dict[str, list[CatEntry]]:
    grouped: dict[str, list[CatEntry]] = {}
    for entry in entries:
        if not entry.bundle:
            continue
        grouped.setdefault(entry.bundle, []).append(entry)
    return grouped


def restore_assets(
    store: BundleStore,
    grouped: dict[str, list[CatEntry]],
    out_root: Path,
    jobs: int,
    complex_mode: str,
    force: bool,
) -> dict[str, Any]:
    totals = {"files": 0, "skipped": 0, "bundles_ok": 0}
    errors: list[tuple[str, str]] = []
    lock = threading.Lock()

    def one(name: str) -> tuple[str, dict[str, Any]]:
        try:
            return name, restore_bundle(store, name, grouped[name], out_root, complex_mode, force)
        except Exception as exc:  # noqa: BLE001
            return name, {"error": f"{type(exc).__name__}: {exc}", "files": 0}

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("还原 Assets", total=max(len(grouped), 1))
        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futs = [pool.submit(one, name) for name in grouped]
            for fut in as_completed(futs):
                name, stat = fut.result()
                with lock:
                    if stat.get("error"):
                        errors.append((name, str(stat["error"])))
                    else:
                        totals["bundles_ok"] += 1
                    totals["files"] += int(stat.get("files", 0))
                    totals["skipped"] += int(stat.get("skipped", 0))
                progress.advance(task)

    totals["errors"] = errors
    return totals


# --------------------------------------------------------------------------- #
# 数据表
# --------------------------------------------------------------------------- #
def parse_table_text(text: str) -> dict[str, Any]:
    """`key[`]json[|]key[`]json` → {key: row}。"""
    rows: dict[str, Any] = {}
    for record in text.split(TABLE_ROW_SEP):
        if TABLE_KV_SEP not in record:
            continue
        key, _, blob = record.partition(TABLE_KV_SEP)
        key = key.strip().lstrip("\ufeff")
        blob = blob.strip()
        if not key or not blob:
            continue
        try:
            rows[key] = json.loads(blob)
        except Exception:  # noqa: BLE001
            rows[key] = blob
    return rows


def parse_table_from_bytes(raw: bytes) -> dict[str, Any]:
    for encoding in ("utf-8-sig", "utf-16", "gbk"):
        try:
            return parse_table_text(raw.decode(encoding))
        except UnicodeDecodeError:
            continue
    return parse_table_text(raw.decode("utf-8", "replace"))


def pretty_json_file(src: Path, dest: Path) -> bool:
    data = load_json(src)
    if data is None:
        return False
    write_json(dest, data)
    return True


def _paint_stem(path: Path) -> str:
    return path.stem


_PAINT_KEY_RE = re.compile(r"^([A-Za-z]+)_(\d+)(?:_(\d+))?(.*)$")


def _paint_key(stem: str) -> str:
    """LH_85_01 / LH_85_1 / Pskill_58_6 这类数字补零差异归一化。"""
    match = _PAINT_KEY_RE.match(stem or "")
    if not match:
        return ""
    prefix, code, sub, rest = match.groups()
    return f"{prefix.lower()}_{int(code)}_{int(sub) if sub else 0}{rest.lower()}"


def _digits(text: str) -> int:
    match = re.search(r"\d+", text or "")
    return int(match.group()) if match else 0


def _table_rows(obj: Any) -> list[dict[str, Any]]:
    """{表名: [行]} / [行] 两种结构都能取到行。"""
    if isinstance(obj, list):
        return [r for r in obj if isinstance(r, dict)]
    if isinstance(obj, dict):
        for value in obj.values():
            if isinstance(value, list):
                return [r for r in value if isinstance(r, dict)]
    return []


def _load_translate_table() -> dict[str, str]:
    raw = load_json(WORK.master_dir / "StaticData" / "translate_server.json", {})
    out: dict[str, str] = {}
    for row in _table_rows(raw):
        key = str(row.get("key") or "").strip()
        text = str(row.get("cn") or "").strip()
        if key and text and key not in out:
            out[key] = text
    return out


def _painting_sources(kind: str) -> list[tuple[str, Path]]:
    """kind → [(unit|pet, 目录)]，目录下每个 */*_LH 是立绘。"""
    bases = {
        "unit": WORK.root / "Assets" / "BundledAssets" / "Character" / "Unit",
        "pet": WORK.root / "Assets" / "BundledAssets" / "Character" / "Pet",
    }
    if kind == "all":
        return [("unit", bases["unit"]), ("pet", bases["pet"])]
    return [(kind, bases[kind])]


def iter_painting_files(kind: str, extra_src: str = "") -> list[Path]:
    files: list[Path] = []
    sources = _painting_sources(kind)
    if extra_src:
        sources = [("unit", Path(extra_src).expanduser())]
    for _k, base in sources:
        if not base.is_dir():
            continue
        for path in sorted(base.glob("*/*_LH/*")):
            if path.is_file() and path.suffix.lower() in (".png", ".jpg", ".jpeg", ".tga", ".bmp"):
                files.append(path)
    return files


def build_painting_index() -> dict[str, Any]:
    """从 MasterData 里建 文件 →(角色名, 立绘名, 备注) 的索引。"""
    heroes = _table_rows(load_json(WORK.master_dir / "StaticData" / "Hero.json", {}))
    pets = _table_rows(load_json(WORK.master_dir / "StaticData" / "Pet.json", {}))
    skins = _table_rows(load_json(WORK.master_dir / "StaticData" / "skin.json", {}))
    tr = _load_translate_table()

    by_file: dict[str, tuple[str, str, list[str]]] = {}
    by_key: dict[str, tuple[str, str, list[str]]] = {}
    unit_by_code: dict[int, str] = {}
    pet_by_code: dict[int, str] = {}

    def put(name: str, cha: str, skin: str, notes: Sequence[str]) -> None:
        key = str(name or "").strip().lower()
        if not key:
            return
        value = (cha, skin or name, list(notes))
        by_file.setdefault(key, value)
        if key.endswith(".png"):
            by_file.setdefault(key[:-4], value)
        else:
            by_file.setdefault(key + ".png", value)
        norm = _paint_key(Path(key).stem)
        if norm:
            by_key.setdefault(norm, value)

    for row in heroes:
        hid = int(row.get("Id") or 0)
        if not hid:
            continue
        code = hid % 100000
        cha = (
            tr.get(f"excel_PersonalityUnit_nickname_{hid}")
            or tr.get(f"excel_Hero_StarName1_{hid}")
            or f"Unit{code}"
        )
        unit_by_code[code] = cha
        stars = [tr.get(f"excel_Hero_StarName{i}_{hid}", "") for i in range(1, 8)]
        lh_list = [f for f in (row.get("HeroLH") or []) if f]
        for i, name in enumerate(row.get("HeroLH") or [], start=1):
            if not name:
                continue
            notes = [f"{i}星"] if len(lh_list) > 1 else []
            put(name, cha, stars[i - 1] or f"{i}星", notes)
        if row.get("WinLH"):
            put(row["WinLH"], cha, "胜利", [])
        if row.get("FailLH"):
            put(row["FailLH"], cha, "失败", [])
        if row.get("WinLH7"):
            put(row["WinLH7"], cha, "胜利", ["七星"])
        if row.get("FailLH7"):
            put(row["FailLH7"], cha, "失败", ["七星"])

    for row in pets:
        pid = int(row.get("Id") or 0)
        if not pid:
            continue
        cha = (
            tr.get(f"excel_PersonalityUnit_nickname_{pid}")
            or tr.get(f"excel_Pet_StarName1_{pid}")
            or f"Pet{pid % 1000:02d}"
        )
        for key in ("PetLH", "PetLH7"):
            name = row.get(key) or ""
            if not name:
                continue
            notes = ["七星"] if key.endswith("7") else []
            if "lost" in str(name).lower():
                notes.append("LOST")
            put(name, cha, "立绘", notes)
            code = _digits(str(name))
            if code and code not in pet_by_code:
                pet_by_code[code] = cha
        base_code = pid - 120000
        if 0 < base_code < 100000 and base_code not in pet_by_code:
            pet_by_code[base_code] = cha

    for row in skins:
        pic = str(row.get("Picture") or "").strip()
        if not pic:
            continue
        cha = str(row.get("RoleName") or "").strip() or "未知"
        skin = str(row.get("Name") or "").strip() or pic
        notes = []
        series = str(row.get("SeriesName") or "").strip()
        if series and series != skin:
            notes.append(series)
        put(pic, cha, skin, notes)

    return {
        "by_file": by_file,
        "by_key": by_key,
        "unit_by_code": unit_by_code,
        "pet_by_code": pet_by_code,
    }


def resolve_painting_name(
    path: Path, index: dict[str, Any]
) -> tuple[str, str, list[str], bool]:
    by_file: dict[str, tuple[str, str, list[str]]] = index["by_file"]
    stem = _paint_stem(path)
    hit = by_file.get(stem.lower()) or by_file.get(f"{stem.lower()}.png")
    if not hit:
        hit = index["by_key"].get(_paint_key(stem))
    if hit:
        return hit[0], hit[1], list(hit[2]), True
    parent = path.parent.parent.name
    kind = "pet" if parent.lower().startswith("pet") else "unit"
    table = index["pet_by_code"] if kind == "pet" else index["unit_by_code"]
    cha = table.get(_digits(parent)) or parent
    return cha, stem, ["未收录"], False


def _safe_fs_name(text: str) -> str:
    """文件名安全化：非法字符换全角，保留中文名原貌（CatFantasy 写法）。"""
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
    return text.translate(table).strip() or "未知"


def painting_filename(
    cha: str,
    skin: str,
    used: set[str],
    notes: Iterable[str] | None = None,
) -> str:
    """游戏名_角色名_立绘名[_备注1_备注2...].png，重名自动追加序号。"""
    parts = [GAME_TITLE, _safe_fs_name(cha), _safe_fs_name(skin)]
    for note in notes or []:
        cleaned = _safe_fs_name(str(note))
        if cleaned and cleaned not in ("未知", parts[1], parts[2]):
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


def cmd_painting(args: argparse.Namespace) -> int:
    index = build_painting_index()
    if not index["by_file"]:
        console.print(
            f"[red]缺表[/] {WORK.master_dir / 'StaticData'} 里没有 Hero.json / Pet.json，先跑 masterdata"
        )
        return 1

    kind = getattr(args, "kind", "all") or "all"
    files = iter_painting_files(kind, getattr(args, "src", "") or "")
    if not files:
        console.print("[red]没有找到 *_LH 立绘目录，先跑 assets[/]")
        return 1
    limit = int(getattr(args, "limit", 0) or 0)
    if limit > 0:
        files = files[:limit]
        console.print(f"[yellow]--limit {limit}[/yellow] 立绘")

    force = bool(getattr(args, "force", False))
    jobs = max(1, int(getattr(args, "jobs", 8) or 8))
    inplace = bool(getattr(args, "inplace", False))
    out_arg = getattr(args, "painting_out", "") or getattr(args, "out", "")
    out_dir = Path(out_arg).expanduser().resolve() if out_arg else WORK.root / "Painting"
    if not inplace:
        out_dir.mkdir(parents=True, exist_ok=True)

    used: set[str] = set()
    jobs_list: list[tuple[Path, Path]] = []
    named = 0
    mapping: dict[str, str] = {}

    def rel(path: Path) -> str:
        try:
            return str(path.relative_to(WORK.root))
        except ValueError:
            return str(path)

    for src in files:
        cha, skin, notes, hit = resolve_painting_name(src, index)
        if hit:
            named += 1
        fname = painting_filename(cha, skin, used, notes)
        dest = src.parent / fname if inplace else out_dir / fname
        jobs_list.append((src, dest))
        mapping[rel(src)] = rel(dest)

    console.print(
        f"[cyan]立绘[/cyan] 命中数据表 {named}/{len(jobs_list)}"
        f"（Hero/Pet/skin 索引 {len(index['by_file'])} 条）→ {out_dir if not inplace else '原地重命名'}"
    )
    if getattr(args, "list_only", False):
        for src, dest in jobs_list[:40]:
            console.print(f"  {src.name} [dim]→[/] {dest.name}")
        return 0

    written = skipped = fail = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("重命名立绘", total=max(len(jobs_list), 1))

        def work(item: tuple[Path, Path]) -> str:
            src, dest = item
            try:
                if src == dest:
                    return "skip"
                if dest.exists() and not force:
                    return "skip"
                dest.parent.mkdir(parents=True, exist_ok=True)
                if inplace:
                    shutil.move(str(src), str(dest))
                else:
                    shutil.copy2(src, dest)
                return "ok"
            except Exception as exc:  # noqa: BLE001
                console.print(f"[red]立绘失败[/red] {src.name}: {exc}")
                return "fail"

        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(work, item) for item in jobs_list]
            for fut in as_completed(futs):
                status = fut.result()
                if status == "ok":
                    written += 1
                elif status == "skip":
                    skipped += 1
                else:
                    fail += 1
                progress.advance(task)

    console.print(
        f"[bold green]Painting[/] 写出 {written}  跳过 {skipped}  失败 {fail}"
        f"（未收录 {len(jobs_list) - named}）→ {out_dir if not inplace else '原地'}"
    )

    if not inplace:
        write_json(out_dir / "_index.json", mapping)
    state = load_state()
    state["painting"] = {
        "out": str(out_dir),
        "files": len(jobs_list),
        "named": named,
        "inplace": inplace,
        "updated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
    }
    save_state(state)
    return 1 if fail else 0


# --------------------------------------------------------------------------- #
# 热更 DLL
# --------------------------------------------------------------------------- #
def looks_like_pe(data: bytes) -> bool:
    return len(data) > 0x40 and data[:2] == b"MZ" and data[0x3C:0x40] != b"\x00" * 4


def try_unwrap_bytes(data: bytes) -> bytes | None:
    """zip / gzip / zlib / 单字节 XOR 还原（保守尝试）。"""
    if looks_like_pe(data):
        return data
    import gzip
    import io
    import zlib

    for opener in (
        lambda d: zipfile.ZipFile(io.BytesIO(d)).read(
            min(zipfile.ZipFile(io.BytesIO(d)).namelist())
        )
        if zipfile.is_zipfile(io.BytesIO(d))
        else None,
        lambda d: gzip.decompress(d) if d[:2] == b"\x1f\x8b" else None,
        lambda d: zlib.decompress(d) if d[:1] == b"\x78" else None,
    ):
        try:
            out = opener(data)
        except Exception:  # noqa: BLE001
            out = None
        if out and looks_like_pe(out):
            return out
    head = data[:64]
    for key in range(1, 256):
        if bytes(b ^ key for b in head[:2]) == b"MZ":
            return bytes(b ^ key for b in data)
    return None


def decrypt_dll(
    data: bytes,
    xor_key: str = "",
    aes_key: str = "",
    aes_iv: str = "",
) -> tuple[bytes, str]:
    """热更 DLL 解密：明文 / 压缩 / XOR / AES-CBC。返回 (数据, 说明)。"""
    if looks_like_pe(data):
        return data, "明文 PE"
    if xor_key:
        key = bytes.fromhex(xor_key) if re.fullmatch(r"[0-9a-fA-F]+", xor_key) else xor_key.encode()
        out = bytes(b ^ key[i % len(key)] for i, b in enumerate(data))
        if looks_like_pe(out):
            return out, "XOR"
    if aes_key:
        from Cryptodome.Cipher import AES  # type: ignore

        key = bytes.fromhex(aes_key)
        iv = bytes.fromhex(aes_iv) if aes_iv else b"\x00" * 16
        out = AES.new(key, AES.MODE_CBC, iv).decrypt(data)
        if looks_like_pe(out):
            return out, "AES-256-CBC"
        raise ValueError("AES 解密后仍不是 PE")
    unwrapped = try_unwrap_bytes(data)
    if unwrapped:
        return unwrapped, "自动识别（zip/gzip/zlib/单字节 XOR）"
    raise ValueError("未知的 DLL 加密格式（可尝试 --dll-xor / --aes-key）")


def run_ilspycmd(
    dll: Path,
    out_dir: Path,
    ilspycmd: str,
    force: bool,
    single_file: bool,
    timeout: int = 3600,
) -> tuple[bool, str]:
    if out_dir.is_dir() and not force:
        ncs = sum(1 for _ in out_dir.rglob("*.cs"))
        if ncs:
            return True, f"跳过（已有 {ncs} 个 .cs）"
    out_dir.mkdir(parents=True, exist_ok=True)
    cmd = [ilspycmd, "-o", str(out_dir)]
    if not single_file:
        cmd += ["-p", "--nested-directories"]
    cmd.append(str(dll))
    try:
        proc = subprocess.run(
            cmd, capture_output=True, text=True, timeout=timeout, check=False
        )
    except FileNotFoundError:
        return False, f"未找到 {ilspycmd}（dotnet tool install -g ilspycmd）"
    except subprocess.TimeoutExpired:
        return False, "反编译超时"
    ncs = sum(1 for _ in out_dir.rglob("*.cs"))
    if proc.returncode != 0 and ncs == 0:
        err = (proc.stderr or proc.stdout or "").strip().splitlines()
        return False, err[-1] if err else f"exit {proc.returncode}"
    return True, f"{ncs} 个 .cs"


# --------------------------------------------------------------------------- #
# 公共：定位 APK / 远端配置
# --------------------------------------------------------------------------- #
@dataclass
class RemoteContext:
    apk: Apk | None
    manifest: dict[str, Any]
    channel: Channel
    remote_config: dict[str, Any]
    platform: str
    catalog_name: str
    bundle_version: str
    dll_version: str
    static_version: str


def build_context(args: argparse.Namespace, need_remote: bool = True) -> RemoteContext:
    apk = None
    apk_path = find_apk(getattr(args, "apk", None))
    if apk_path:
        apk = Apk(apk_path)
        console.print(f"[cyan]APK[/] {apk_path.name} ({format_size(apk_path.stat().st_size)})")
    elif need_remote:
        console.print("[yellow]未找到 APK，仅使用远端数据[/]")

    manifest_override = getattr(args, "luncher_manifest", None)
    manifest = read_luncher_manifest(
        apk, Path(manifest_override) if manifest_override else None
    )
    channel = resolve_channel(
        manifest,
        getattr(args, "env", DEFAULT_ENV) or DEFAULT_ENV,
        getattr(args, "cdn", "") or "",
        getattr(args, "origin", "") or "",
    )

    remote_config: dict[str, Any] = {}
    if need_remote:
        try:
            remote_config = fetch_remote_config(channel, timeout=getattr(args, "timeout", 60))
        except Exception as exc:  # noqa: BLE001
            console.print(f"[yellow]remoteConfig.json 获取失败：{exc}[/]")

    platform = getattr(args, "platform", DEFAULT_PLATFORM) or DEFAULT_PLATFORM
    settings = apk_aa_settings(apk, WORK.root)
    catalog_name = getattr(args, "catalog", "") or catalog_name_from_settings(settings)
    bundle_version = str(
        getattr(args, "bundle_version", "") or remote_config.get(PLATFORM_BUNDLE_DIR[platform], "")
    )
    dll_version = str(
        getattr(args, "dll_version", "") or remote_config.get(PLATFORM_DLL_DIR[platform], "")
    )
    static_version = str(
        getattr(args, "static_version", "") or remote_config.get("staticDataVersion", "")
    )
    return RemoteContext(
        apk=apk,
        manifest=manifest,
        channel=channel,
        remote_config=remote_config,
        platform=platform,
        catalog_name=catalog_name,
        bundle_version=bundle_version,
        dll_version=dll_version,
        static_version=static_version,
    )


def load_catalog(ctx: RemoteContext, args: argparse.Namespace) -> tuple[Catalog, str]:
    """远端 catalog（默认）或 APK 内 catalog；返回 (Catalog, hash)。"""
    cache = WORK.cache_dir / f"{ctx.catalog_name}-{ctx.bundle_version}.json"
    hash_cache = WORK.cache_dir / f"{ctx.catalog_name}-{ctx.bundle_version}.hash"
    use_local = getattr(args, "local_catalog", False)

    if use_local and ctx.apk:
        raw = ctx.apk.read_opt(f"assets/Catalog/{ctx.catalog_name}.json")
        if raw:
            return Catalog(raw), ""

    if cache.is_file() and not getattr(args, "refresh", False):
        console.print(f"[cyan]Catalog[/] 缓存 {cache.name} ({format_size(cache.stat().st_size)})")
        cached_hash = ""
        if hash_cache.is_file():
            cached_hash = hash_cache.read_text(encoding="utf-8").strip()
        return Catalog(cache.read_bytes()), cached_hash

    if not ctx.bundle_version:
        if ctx.apk:
            raw = ctx.apk.read_opt(f"assets/Catalog/{ctx.catalog_name}.json")
            if raw:
                console.print("[yellow]无远端版本号，回退 APK 内 catalog[/]")
                return Catalog(raw), ""
        raise SystemExit("缺少 bundle 版本号：请检查网络或使用 --bundle-version")

    raw, hash_text = fetch_catalog_bytes(
        ctx.channel, ctx.platform, ctx.bundle_version, ctx.catalog_name
    )
    cache.parent.mkdir(parents=True, exist_ok=True)
    cache.write_bytes(raw)
    if hash_text:
        hash_cache.write_text(hash_text, encoding="utf-8")
    return Catalog(raw), hash_text


def build_store(ctx: RemoteContext) -> BundleStore:
    apk_dir = WORK.apk_dir / "assets" / "Bundle"
    return BundleStore(
        apk=ctx.apk,
        hot_dir=WORK.hot_bundle_dir,
        local_dir=WORK.local_bundle_dir,
        apk_dir=apk_dir if apk_dir.is_dir() else None,
    )


def local_bundle_names(ctx: RemoteContext) -> set:
    """APK 内 LocalBundleList.json（Addressables 本地包清单）。"""
    raw = cached_textasset(ctx.apk, "LocalBundleList", b"localBundleList", "LocalBundleList.json")
    if not raw:
        for candidate in (WORK.apk_dir / "assets" / "bin" / "Data").glob("*"):
            if not candidate.is_file() or candidate.suffix == ".resource":
                continue
            if b"localBundleList" not in candidate.read_bytes():
                continue
            try:
                env = UnityPy.load(str(candidate))
            except Exception:  # noqa: BLE001, S112
                continue
            for obj in env.objects:
                if str(obj.type.name) != "TextAsset":
                    continue
                name, data = textasset_bytes(obj)
                if name == "LocalBundleList":
                    raw = data.decode("utf-8-sig", "replace")
                    break
            if raw:
                break
    if not raw:
        return set()
    try:
        data = json.loads(raw)
    except Exception:  # noqa: BLE001
        return set()
    return {str(x) for x in (data.get("localBundleList") or [])}


# --------------------------------------------------------------------------- #
# 子命令
# --------------------------------------------------------------------------- #
def cmd_status(args: argparse.Namespace) -> int:
    ctx = build_context(args)
    table = Table(title=f"{GAME_TITLE} / {PROJECT_CODE} 状态")
    table.add_column("项目", style="cyan")
    table.add_column("值")

    table.add_row("工作目录", str(WORK.root))
    if ctx.apk:
        table.add_row("APK", f"{ctx.apk.path.name}  {format_size(ctx.apk.path.stat().st_size)}")
    table.add_row("渠道 env", ctx.channel.name)
    table.add_row("remoteResCdn", ctx.channel.cdn)
    table.add_row("remoteResOrigin", ctx.channel.origin)
    envs = env_list(ctx.manifest)
    if envs:
        table.add_row("env.list", ", ".join(envs))
    rc = ctx.remote_config
    if rc:
        table.add_row("bundle 版本", ctx.bundle_version or "-")
        table.add_row("dll 版本", ctx.dll_version or "-")
        table.add_row("staticData", ctx.static_version or "-")
        table.add_row("allowedVersion", ", ".join(rc.get("allowedVersion") or []))
        table.add_row("是否开放", str(rc.get("isOpen")))
    table.add_row("catalog", ctx.catalog_name)
    console.print(table)

    state = load_state()
    local = local_bundle_names(ctx)
    console.print(f"[cyan]APK 内本地 Bundle[/] {len(local)} 个（LocalBundleList.json）")

    if rc:
        try:
            catalog, hash_text = load_catalog(ctx, args)
            stats = catalog.stats()
            console.print(
                f"[cyan]Catalog[/] 资产 {stats['assets']} / Bundle {stats['bundles']}"
                f" / 总量 {format_size(stats['bundle_bytes'])}  构建哈希 {stats['build_result_hash']}"
            )
            if hash_text:
                console.print(f"[dim]远端 catalog hash: {hash_text}[/]")
            if state.get("catalog", {}).get("build_result_hash") not in (None, stats["build_result_hash"]):
                console.print(
                    f"[yellow]catalog 已变化：{state['catalog'].get('build_result_hash')} → {stats['build_result_hash']}[/]"
                )
        except Exception as exc:  # noqa: BLE001
            console.print(f"[yellow]Catalog 读取失败：{exc}[/]")

    def dir_stat(path: Path, pattern: str = "*") -> str:
        if not path.is_dir():
            return "未生成"
        files = [p for p in path.rglob(pattern) if p.is_file()]
        total = sum(p.stat().st_size for p in files)
        return f"{len(files)} 个文件 / {format_size(total)}"

    console.print(f"[cyan]Assets[/]      {dir_stat(WORK.assets_dir)}")
    console.print(f"[cyan]Bundles[/]     {dir_stat(WORK.hot_bundle_dir)} (Hot)")
    console.print(f"[cyan]MasterData[/]  {dir_stat(WORK.master_dir)}")
    console.print(f"[cyan]Painting[/]    {dir_stat(WORK.root / 'Painting')}")
    console.print(f"[cyan]HotDll[/]      {dir_stat(WORK.hot_dll_dir)}")
    console.print(f"[cyan]Cs[/]          {dir_stat(WORK.cs_dir)}")
    if state:
        cat = state.get("catalog") or {}
        if cat:
            console.print(
                f"[dim]state.catalog: {cat.get('name')} v{cat.get('bundle_version')} "
                f"build={cat.get('build_result_hash')} @{cat.get('updated_at')}[/]"
            )
        md = state.get("masterdata") or {}
        if md:
            console.print(
                f"[dim]state.masterdata: 客户端表 {md.get('client_tables')} / "
                f"staticData {md.get('static_version')} @{md.get('updated_at')}[/]"
            )
        dll = state.get("dll") or {}
        if dll:
            console.print(
                f"[dim]state.dll: v{dll.get('version')} "
                f"sha256={str(dll.get('sha256'))[:16]}… @{dll.get('updated_at')}[/]"
            )
        pt = state.get("painting") or {}
        if pt:
            console.print(
                f"[dim]state.painting: {pt.get('files')} 张（命中 {pt.get('named')}）"
                f" @{pt.get('updated_at')}[/]"
            )
    return 0


def cmd_apk(args: argparse.Namespace) -> int:
    apk_path = find_apk(args.apk)
    if not apk_path:
        console.print("[red]未找到 APK（可用 --apk 指定）[/]")
        return 1
    apk = Apk(apk_path)
    out = Path(args.out) if args.out else WORK.apk_dir
    console.print(f"[cyan]解包[/] {apk_path.name} → {out}")
    only = getattr(args, "apk_only", None)
    if only is None:
        only = getattr(args, "only", [])
    stats = extract_apk(apk, out, only, args.force)
    console.print(
        f"[green]APK 解包完成[/] 写入 {stats['written']}，跳过 {stats['skipped']} → {out}"
    )
    manifest = read_luncher_manifest(apk)
    if manifest:
        write_json(WORK.cache_dir / "luncher-manifest.json", manifest)
        console.print(f"[dim]luncher-manifest: env.default={manifest.get('env.default')}[/]")
    return 0


def _select_entries(catalog: Catalog, args: argparse.Namespace) -> list[CatEntry]:
    entries = catalog.entries
    only = getattr(args, "only", "") or ""
    exclude = getattr(args, "exclude", "") or ""
    types = [t.strip().lower() for t in (getattr(args, "types", "") or "").split(",") if t.strip()]
    if only:
        pattern = re.compile(only, re.IGNORECASE)
        entries = [e for e in entries if pattern.search(e.internal_id)]
    if exclude:
        pattern = re.compile(exclude, re.IGNORECASE)
        entries = [e for e in entries if not pattern.search(e.internal_id)]
    if types:
        entries = [e for e in entries if any(_type_matches(t, e.class_name) for t in types)]
    limit = getattr(args, "limit", 0) or 0
    if limit > 0:
        entries = entries[:limit]
    return entries


def cmd_assets(args: argparse.Namespace) -> int:
    ctx = build_context(args)
    store = build_store(ctx)
    catalog, hash_text = load_catalog(ctx, args)
    cat_stats = catalog.stats()
    console.print(
        f"[cyan]Catalog[/] 资产 {cat_stats['assets']} / Bundle {cat_stats['bundles']}"
        f" / 总量 {format_size(cat_stats['bundle_bytes'])}"
    )

    entries = _select_entries(catalog, args)
    grouped = group_entries_by_bundle(entries)
    names = sorted(grouped)
    missing = [n for n in names if not store.exists(n)]
    need_bytes = sum((catalog.bundles.get(n).size if catalog.bundles.get(n) else 0) for n in missing)
    console.print(
        f"[cyan]选中资产[/] {len(entries)} → Bundle {len(names)}"
        f"（本地已有 {len(names) - len(missing)}，需下载 {len(missing)} / {format_size(need_bytes)}）"
    )
    if args.list_only:
        for name in names[:50]:
            console.print(f"  [dim]{store.source_of(name) or '需下载'}[/] {name}")
        return 0

    failed: list[tuple[str, str]] = []
    if missing:
        if args.no_download:
            console.print(f"[yellow]--no-download：跳过 {len(missing)} 个缺失 Bundle[/]")
        else:
            _, failed = download_bundles(
                store,
                catalog,
                missing,
                ctx.channel,
                ctx.platform,
                ctx.bundle_version,
                args.jobs,
                args.retries,
                args.force,
            )
            if failed:
                console.print(f"[yellow]下载失败 {len(failed)} 个 Bundle[/]")
                for name, err in failed[:5]:
                    console.print(f"  [red]{name}[/] {err}")

    if args.download_only:
        return 1 if failed else 0

    available = {name: entries for name, entries in grouped.items() if store.exists(name)}
    skipped_bundles = len(grouped) - len(available)
    if skipped_bundles:
        console.print(f"[yellow]跳过 {skipped_bundles} 个缺失 Bundle[/]")

    out_root = getattr(args, "assets_out", "") or args.out
    result = restore_assets(
        store,
        available,
        Path(out_root).expanduser().resolve() if out_root else WORK.root,
        args.jobs,
        args.complex,
        args.force,
    )
    console.print(
        f"[green]Assets 还原完成[/] 写出 {result['files']}，跳过 {result['skipped']}，"
        f"Bundle 成功 {result['bundles_ok']}/{len(available)}"
    )
    for name, err in result["errors"][:5]:
        console.print(f"  [red]{name}[/] {err}")

    state = load_state()
    state["catalog"] = {
        "name": ctx.catalog_name,
        "hash": hash_text,
        "bundle_version": ctx.bundle_version,
        "build_result_hash": catalog.build_hash,
        "entries": len(entries),
        "bundles": len(catalog.bundles),
        "updated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
    }
    state.setdefault("assets", {}).update(
        {
            "files": result["files"],
            "bundles": len(available),
            "failed_downloads": len(failed),
            "updated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        }
    )
    save_state(state)
    return 1 if (failed or result["errors"]) else 0


def _client_config_bundles(catalog: Catalog) -> list[str]:
    names: list[str] = []
    needles = ("clientconfigres_", "clientconfigjson_")
    for bundle in catalog.bundles:
        low = bundle.lower()
        if any(n in low for n in needles):
            names.append(bundle)
    if not names:
        for suffix in ("$clientConfigRes/meta.txt", "$clientConfigJson/cardlhpos.json"):
            entry = catalog.find_entry(suffix)
            if entry and entry.bundle:
                names.append(entry.bundle)
    return sorted(set(names))


def export_client_tables(store: BundleStore, bundles: Sequence[str], out_dir: Path) -> dict[str, int]:
    counts = {"tables": 0, "json": 0, "skipped": 0}
    res_dir = out_dir / "ClientConfig"
    json_dir = out_dir / "ClientConfigJson"
    for name in bundles:
        raw = store.read(name)
        if raw is None:
            console.print(f"[yellow]缺少客户端表 Bundle[/] {name}")
            continue
        env = UnityPy.load(raw)
        for obj in env.objects:
            if str(obj.type.name) != "TextAsset":
                continue
            asset_name, data = textasset_bytes(obj)
            if not asset_name:
                continue
            text = data.decode("utf-8-sig", "replace")
            if asset_name.endswith(".json") or text.lstrip()[:1] in "{[":
                try:
                    payload = json.loads(text)
                except Exception:  # noqa: BLE001
                    payload = None
                if payload is not None:
                    write_json(json_dir / f"{asset_name}.json", payload)
                    counts["json"] += 1
                    continue
            rows = parse_table_from_bytes(data)
            if not rows:
                counts["skipped"] += 1
                continue
            write_json(res_dir / f"{asset_name}.json", rows)
            counts["tables"] += 1
    return counts


def export_static_data(zip_path: Path, out_dir: Path) -> dict[str, int]:
    counts = {"files": 0, "skipped": 0}
    with zipfile.ZipFile(zip_path) as zf:
        for info in zf.infolist():
            if info.is_dir():
                continue
            name = Path(info.filename).name
            if not name.lower().endswith(".json"):
                continue
            dest = out_dir / name
            raw = zf.read(info)
            try:
                payload = json.loads(raw.decode("utf-8-sig"))
            except Exception:  # noqa: BLE001
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(raw)
                counts["skipped"] += 1
                continue
            write_json(dest, payload)
            counts["files"] += 1
    return counts


def export_configs(ctx: RemoteContext, args: argparse.Namespace, out_dir: Path) -> dict[str, Any]:
    summary: dict[str, Any] = {}
    cfg_dir = out_dir / "Config"
    if ctx.remote_config:
        write_json(cfg_dir / "remoteConfig.json", ctx.remote_config)
        summary["remote_config"] = f"{ctx.channel.origin}/remoteConfig.json"
    if ctx.manifest:
        write_json(cfg_dir / "luncher-manifest.json", ctx.manifest)
    if ctx.apk:
        for asset_name, marker, file_name in (
            ("LocalBundleList", b"localBundleList", "LocalBundleList.json"),
            ("AAConfig", b"_BundleVersion", "AAConfig.json"),
        ):
            raw = ctx.apk.resource_textasset(asset_name, marker)
            if not raw:
                continue
            try:
                write_json(cfg_dir / file_name, json.loads(raw))
            except Exception:  # noqa: BLE001
                (cfg_dir / file_name).write_text(raw, encoding="utf-8")
        settings_raw = ctx.apk.read_opt("assets/aa/settings.json")
        if settings_raw:
            try:
                write_json(cfg_dir / "aa-settings.json", json.loads(settings_raw.decode("utf-8-sig")))
            except Exception:  # noqa: BLE001, S110
                pass
        hash_raw = ctx.apk.read_opt("assets/Catalog/catalog_ElasticJelly.hash")
        if hash_raw:
            (cfg_dir / "local-catalog.hash").write_text(
                hash_raw.decode("utf-8", "replace").strip(), encoding="utf-8"
            )
    return summary


def cmd_masterdata(args: argparse.Namespace) -> int:
    ctx = build_context(args)
    store = build_store(ctx)
    out_dir = Path(args.out) if args.out else WORK.master_dir
    out_dir.mkdir(parents=True, exist_ok=True)
    catalog: Catalog | None = None
    index: dict[str, Any] = {"game": GAME_TITLE, "project": PROJECT_CODE}

    if not args.no_client:
        catalog, _hash = load_catalog(ctx, args)
        bundles = _client_config_bundles(catalog)
        if not bundles:
            console.print("[yellow]catalog 中没有 ClientConfig Bundle[/]")
        else:
            missing = [n for n in bundles if not store.exists(n)]
            if missing and not args.no_download:
                download_bundles(
                    store,
                    catalog,
                    missing,
                    ctx.channel,
                    ctx.platform,
                    ctx.bundle_version,
                    args.jobs,
                    args.retries,
                    args.force,
                )
            counts = export_client_tables(store, bundles, out_dir)
            console.print(
                f"[green]ClientConfig[/] 表 {counts['tables']}，JSON {counts['json']}，"
                f"跳过 {counts['skipped']} → {out_dir}"
            )
            index["client_config"] = counts
            index["client_bundles"] = list(bundles)
            index["catalog"] = catalog.stats()

    if not args.no_static:
        version = ctx.static_version or args.static_version
        if not version:
            console.print("[yellow]没有 staticData 版本号，跳过（可用 --static-version）[/]")
        else:
            url = static_data_url(ctx.channel, version)
            cache = WORK.cache_dir / f"staticData-{version}-old.zip"
            try:
                status = download_file(url, cache, force=args.force, retries=args.retries)
                console.print(
                    f"[cyan]staticData[/] {version} {'命中缓存' if status == 'skip' else '已下载'} "
                    f"({format_size(cache.stat().st_size)})"
                )
                counts = export_static_data(cache, out_dir / "StaticData")
                console.print(
                    f"[green]StaticData[/] 表 {counts['files']}，原样保留 {counts['skipped']} → {out_dir / 'StaticData'}"
                )
                index["static_data"] = {"version": version, "url": url, **counts}
            except Exception as exc:  # noqa: BLE001
                console.print(f"[red]staticData 处理失败：{exc}[/]")

    index["config"] = export_configs(ctx, args, out_dir)
    index["generated_at"] = time.strftime("%Y-%m-%d %H:%M:%S")
    write_json(out_dir / "_index.json", index)

    state = load_state()
    state["masterdata"] = {
        "out": str(out_dir),
        "client_tables": (index.get("client_config") or {}).get("tables", 0),
        "static_version": (index.get("static_data") or {}).get("version", ""),
        "static_tables": (index.get("static_data") or {}).get("files", 0),
        "updated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
    }
    save_state(state)
    console.print(f"[bold green]MasterData 完成[/] → {out_dir}")
    return 0


def cmd_dll(args: argparse.Namespace) -> int:
    ctx = build_context(args)
    WORK.hot_dll_dir.mkdir(parents=True, exist_ok=True)
    out_dir = Path(args.out) if args.out else WORK.hot_dll_dir
    version = ctx.dll_version or "local"
    console.print(f"[cyan]热更 DLL[/] 版本 {version} / 平台 {ctx.platform}")

    dll_bytes: bytes | None = None
    source = ""
    if args.local and ctx.apk:
        dll_bytes = ctx.apk.read_opt(APK_AOTDLL_PREFIX + "hotfix.bytes")
        source = "APK assets/AOTDLL/hotfix.bytes"
    if dll_bytes is None and version != "local":
        cache = WORK.cache_dir / f"hotfix-{version}.bytes.zip"
        url = dll_url(ctx.channel, ctx.platform, version)
        try:
            download_file(url, cache, force=args.force, retries=args.retries)
            source = url
            with zipfile.ZipFile(cache) as zf:
                members = [m for m in zf.namelist() if m.lower().endswith(".dll")]
                if not members:
                    raise ValueError("zip 内没有 .dll")
                dll_bytes = zf.read(members[0])
                console.print(f"[dim]hotfix.bytes.zip 内：{members[0]}[/]")
        except Exception as exc:  # noqa: BLE001
            console.print(f"[yellow]远端热更 DLL 获取失败：{exc}[/]")
    if dll_bytes is None and ctx.apk:
        dll_bytes = ctx.apk.read_opt(APK_AOTDLL_PREFIX + "hotfix.bytes")
        source = "APK assets/AOTDLL/hotfix.bytes"
    if dll_bytes is None:
        console.print("[red]未能获取热更 DLL[/]")
        return 1

    assert dll_bytes is not None
    try:
        plain, how = decrypt_dll(
            dll_bytes,
            xor_key=args.dll_xor or "",
            aes_key=args.aes_key or "",
            aes_iv=args.aes_iv or "",
        )
    except Exception as exc:  # noqa: BLE001
        raw_path = out_dir / f"{HOT_DLL_NAME}.{version}.encrypted"
        raw_path.write_bytes(dll_bytes)
        console.print(f"[red]热更 DLL 解密失败[/] {exc}（原始数据保留在 {raw_path}）")
        return 1

    dll_path = out_dir / HOT_DLL_NAME
    dll_path.write_bytes(plain)
    console.print(
        f"[green]热更 DLL[/] {source} → {dll_path} ({format_size(len(plain))}, {how})"
    )

    if args.with_aot and ctx.apk:
        aot_dir = out_dir / "Aot"
        aot_dir.mkdir(parents=True, exist_ok=True)
        for info in ctx.apk.infos(APK_AOTDLL_PREFIX):
            if not info.filename.endswith(".dll.bytes"):
                continue
            target = aot_dir / Path(info.filename).name[: -len(".bytes")]
            if target.is_file() and not args.force:
                continue
            target.write_bytes(ctx.apk.read(info.filename))
        console.print(f"[cyan]AOT DLL[/] → {aot_dir}")

    rc = 0
    if not args.no_decompile:
        targets = [dll_path]
        if args.with_aot:
            targets += sorted((out_dir / "Aot").glob("*.dll"))
        for target in targets:
            ok, msg = run_ilspycmd(
                target,
                WORK.cs_dir / target.stem,
                args.ilspycmd,
                args.force,
                args.single_file,
            )
            style = "green" if ok else "red"
            console.print(f"[{style}]ilspycmd {target.name}[/] {msg}")
            if not ok:
                rc = 1

    state = load_state()
    state["dll"] = {
        "version": version,
        "platform": ctx.platform,
        "source": source,
        "sha256": hashlib.sha256(plain).hexdigest(),
        "size": len(plain),
        "updated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
    }
    save_state(state)
    return rc


def cmd_all(args: argparse.Namespace) -> int:
    rc = 0
    if not args.no_apk:
        args.apk_only = list(APK_META_PATTERNS)
        rc |= cmd_apk(args)
    # assets / masterdata / dll 共用一个 --out，拆开避免互相覆盖
    args.assets_out = getattr(args, "out", "")
    args.out = ""
    rc |= cmd_assets(args)
    rc |= cmd_masterdata(args)
    if not getattr(args, "no_painting", False):
        args.painting_out = getattr(args, "painting_out", "") or ""
        rc |= cmd_painting(args)
    rc |= cmd_dll(args)
    if rc:
        console.print("[yellow]pipeline 有失败项，见上方日志[/]")
    else:
        console.print("[bold green]pipeline 全部完成[/]")
    return rc


# --------------------------------------------------------------------------- #
# 命令行
# --------------------------------------------------------------------------- #
def add_common(p: argparse.ArgumentParser) -> None:
    p.add_argument("--root", default=str(SCRIPT_DIR), help="工作目录（默认脚本目录）")
    p.add_argument("--apk", default=None, help="APK 路径（默认自动查找目录下最大的 .apk）")
    p.add_argument("--env", default=DEFAULT_ENV, help="渠道 env（luncher-manifest 的 env.list）")
    p.add_argument("--platform", default=DEFAULT_PLATFORM, choices=("android", "ios"))
    p.add_argument("--cdn", default="", help="覆盖 remoteResCdn")
    p.add_argument("--origin", default="", help="覆盖 remoteResOrigin（OSS）")
    p.add_argument("--luncher-manifest", default="", help="离线 luncher-manifest.json")
    p.add_argument("--jobs", type=int, default=8, help="并行线程数")
    p.add_argument("--retries", type=int, default=4, help="单文件重试次数")
    p.add_argument("--timeout", type=int, default=120, help="HTTP 超时（秒）")
    p.add_argument("--force", action="store_true", help="忽略缓存/已存在文件")


def add_catalog_args(p: argparse.ArgumentParser) -> None:
    p.add_argument("--catalog", default="", help=f"catalog 名（默认从 aa/settings.json 推断：{DEFAULT_CATALOG}）")
    p.add_argument("--bundle-version", default="", help="覆盖 bundle 版本（默认 remoteConfig.json）")
    p.add_argument("--local-catalog", action="store_true", help="使用 APK 内置 catalog（不联网）")
    p.add_argument("--refresh", action="store_true", help="强制重新下载 catalog")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=f"{GAME_TITLE}（{PROJECT_CODE}）APK + 热更资产整合、数据表导出与热更 DLL 反编译",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "示例：\n"
            "  python3 StarHealer.py status\n"
            "  python3 StarHealer.py apk --only Catalog --only aa\n"
            "  python3 StarHealer.py assets --only 'ClientConfig|DialogVoice' --limit 50\n"
            "  python3 StarHealer.py assets --types texture --list-only\n"
            "  python3 StarHealer.py masterdata\n"
            "  python3 StarHealer.py dll --with-aot\n"
            "  python3 StarHealer.py painting --kind pet --list-only\n"
            "  python3 StarHealer.py all\n"
        ),
    )
    sub = parser.add_subparsers(dest="command")

    p_st = sub.add_parser("status", help="远端 / 本地状态")
    add_common(p_st)
    add_catalog_args(p_st)

    p_apk = sub.add_parser("apk", help="解包 APK")
    add_common(p_apk)
    p_apk.add_argument("--out", default="", help="输出目录（默认 <root>/Apk）")
    p_apk.add_argument("--only", action="append", default=[], help="只解名字含该子串的条目，可重复")

    p_as = sub.add_parser("assets", help="下载热更 Bundle 并还原逻辑资产到 Assets/")
    add_common(p_as)
    add_catalog_args(p_as)
    p_as.add_argument(
        "--out",
        default="",
        help="还原根目录（默认 <root>，资产按原始工程路径落在 <root>/Assets/…）",
    )
    p_as.add_argument("--only", default="", help="正则：只还原匹配的资产路径")
    p_as.add_argument("--exclude", default="", help="正则：排除匹配的资产路径")
    p_as.add_argument("--types", default="", help="类型过滤：" + "/".join(sorted(TYPE_ALIASES)))
    p_as.add_argument("--limit", type=int, default=0, help="只处理前 N 个资产（调试）")
    p_as.add_argument(
        "--complex",
        choices=("json", "skip"),
        default="json",
        help="Prefab/Material/MonoBehaviour 等复杂对象：json=类型树导出；skip=跳过",
    )
    p_as.add_argument("--list-only", action="store_true", help="只打印下载/还原计划")
    p_as.add_argument("--download-only", action="store_true", help="只下载 Bundle，不还原")
    p_as.add_argument("--no-download", action="store_true", help="只用本地 APK/已下载 Bundle")

    p_md = sub.add_parser("masterdata", help="导出数据表与重要配置到 MasterData/")
    add_common(p_md)
    add_catalog_args(p_md)
    p_md.add_argument("--out", default="", help="输出目录（默认 <root>/MasterData）")
    p_md.add_argument("--static-version", default="", help="服务端 staticData 版本")
    p_md.add_argument("--no-static", action="store_true", help="跳过服务端 staticData")
    p_md.add_argument("--no-client", action="store_true", help="跳过客户端 ClientConfig")
    p_md.add_argument("--no-download", action="store_true", help="缺表时不再下载 Bundle")

    p_dll = sub.add_parser("dll", help="热更 DLL 解密 + ilspycmd 反编译")
    add_common(p_dll)
    p_dll.add_argument("--dll-version", default="", help="覆盖 dll 版本（默认 remoteConfig.json）")
    p_dll.add_argument("--out", default="", help="DLL 输出目录（默认 <root>/HotDll）")
    p_dll.add_argument("--local", action="store_true", help="只用 APK 内 hotfix.bytes")
    p_dll.add_argument("--dll-xor", default="", help="XOR 密钥（hex 或字符串）")
    p_dll.add_argument("--aes-key", default="", help="AES 密钥（hex，16/24/32 字节）")
    p_dll.add_argument("--aes-iv", default="", help="AES IV（hex）")
    p_dll.add_argument("--with-aot", action="store_true", help="同时导出并反编译 AOTDLL")
    p_dll.add_argument("--no-decompile", action="store_true", help="只解密不反编译")
    p_dll.add_argument("--single-file", action="store_true", help="ilspycmd 单文件模式")
    p_dll.add_argument("--ilspycmd", default=DEFAULT_ILSPYCMD, help="ilspycmd 路径")

    p_pt = sub.add_parser(
        "painting", help="Character/**/$*_LH 立绘按数据表重命名 → Painting/"
    )
    add_common(p_pt)
    p_pt.add_argument(
        "--out", default="", help="输出目录（默认 <root>/Painting，格式 游戏名_角色名_立绘名.png）"
    )
    p_pt.add_argument("--kind", choices=("all", "unit", "pet"), default="all", help="只处理角色 / 宠物")
    p_pt.add_argument("--src", default="", help="自定义立绘根目录（覆盖默认的两处 *_LH）")
    p_pt.add_argument("--limit", type=int, default=0, help="只处理前 N 张（调试）")
    p_pt.add_argument("--list-only", action="store_true", help="只打印重命名结果预览")
    p_pt.add_argument("--inplace", action="store_true", help="直接在 *_LH 目录里改名（默认复制到 Painting/）")

    p_all = sub.add_parser("all", help="apk → assets → masterdata → dll → painting")
    add_common(p_all)
    add_catalog_args(p_all)
    p_all.add_argument("--no-apk", action="store_true", help="跳过 APK 解包")
    p_all.add_argument("--only", default="", help="assets 阶段的正则过滤")
    p_all.add_argument("--exclude", default="", help="assets 阶段的正则排除")
    p_all.add_argument("--types", default="", help="assets 阶段的类型过滤")
    p_all.add_argument("--limit", type=int, default=0, help="assets 阶段条数上限")
    p_all.add_argument("--complex", choices=("json", "skip"), default="json")
    p_all.add_argument("--list-only", action="store_true")
    p_all.add_argument("--download-only", action="store_true")
    p_all.add_argument("--no-download", action="store_true")
    p_all.add_argument("--out", default="", help="assets 输出目录")
    p_all.add_argument("--static-version", default="")
    p_all.add_argument("--no-static", action="store_true")
    p_all.add_argument("--no-client", action="store_true")
    p_all.add_argument("--dll-version", default="")
    p_all.add_argument("--local", action="store_true")
    p_all.add_argument("--with-aot", action="store_true")
    p_all.add_argument("--no-decompile", action="store_true")
    p_all.add_argument("--single-file", action="store_true")
    p_all.add_argument("--ilspycmd", default=DEFAULT_ILSPYCMD)
    p_all.add_argument("--dll-xor", default="")
    p_all.add_argument("--aes-key", default="")
    p_all.add_argument("--aes-iv", default="")
    p_all.add_argument("--no-painting", action="store_true", help="跳过立绘重命名")
    p_all.add_argument("--kind", choices=("all", "unit", "pet"), default="all")
    p_all.add_argument("--painting-out", default="", help="立绘输出目录（默认 <root>/Painting）")
    p_all.add_argument("--src", default="")
    p_all.add_argument("--inplace", action="store_true")
    return parser


def main(argv: list[str] | None = None) -> int:
    global WORK
    parser = build_parser()
    args = parser.parse_args(argv)
    if not getattr(args, "command", None):
        args = parser.parse_args(["status"])
    WORK = Workspace(Path(args.root).expanduser().resolve())
    WORK.root.mkdir(parents=True, exist_ok=True)
    handlers = {
        "status": cmd_status,
        "apk": cmd_apk,
        "assets": cmd_assets,
        "masterdata": cmd_masterdata,
        "dll": cmd_dll,
        "painting": cmd_painting,
        "all": cmd_all,
    }
    try:
        return handlers[args.command](args)
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/]")
        return 130


if __name__ == "__main__":
    raise SystemExit(main())
