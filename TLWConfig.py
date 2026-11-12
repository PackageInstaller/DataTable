from __future__ import annotations

import re
from pathlib import Path

GAME_TITLE = "东方归言录"
GAME_PACKAGE = "com.gg.touhoulw"

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
CACHE_DIR = SCRIPT_DIR / "_cache"

DEFAULT_APK_GLOB = "*.apk"

CDN_HOST = "https://thcdn.gggamedownload.com"
SOURCE_BASE = f"{CDN_HOST}/source"
TEXT_BASE = f"{CDN_HOST}/text"

MASTER_VERSION = "Master_v5022"
ASSETBUNDLE_VERSION = "Assetbundle_Android_v5019"
RESOURCE_VERSION = "Resource_v5014"

CATEGORIES = {
    "master": {
        "dir_name": MASTER_VERSION,
        "desc": "MasterData 数据表",
    },
    "assetbundle": {
        "dir_name": ASSETBUNDLE_VERSION,
        "desc": "AssetBundle 资产",
    },
    "resource": {
        "dir_name": RESOURCE_VERSION,
        "desc": "Resource 资源文件",
    },
}

MANIFEST_FILE = "manifest.json"

ASSETBUNDLE_OUT_DIR = ASSETS_DIR / "assetbundle" / "android"
RESOURCE_OUT_DIR = ASSETS_DIR / "resource"
MASTER_OUT_DIR = ASSETS_DIR / "master"

MASTERDATA_TABLES_DIR = MASTER_DIR / "Tables"
MASTERDATA_CONFIG_DIR = MASTER_DIR / "Config"

STATE_DIR = CACHE_DIR / "state"
MANIFEST_CACHE_DIR = CACHE_DIR / "manifests"
DATA_CACHE_DIR = CACHE_DIR / "data"


DEFAULT_JOBS = 16
HTTP_TIMEOUT = (15, 300)
HTTP_RETRIES = 4
DOWNLOAD_CHUNK = 1 << 20
USER_AGENT = (
    "Dalvik/2.1.0 (Linux; U; Android 15; PJE110 Build/TP1A.220905.001) "
    "UnityPlayer/2021.3.3f1"
)

TEXT_CONFIGS = {
    "CN_CheckVersion.json": f"{TEXT_BASE}/CN_CheckVersion.json",
    "ServerCN_GG.json": f"{TEXT_BASE}/ServerCN_GG.json",
    "RedemptionCode.json": f"{TEXT_BASE}/RedemptionCode.json",
}


APK_ASSETBUNDLE_PREFIX = "assets/assetbundle/android/"
APK_MASTER_PREFIX = "assets/master/"
APK_RESOURCE_PREFIX = "assets/resource/"
APK_UNITY_DATA = "assets/bin/Data/data.unity3d"


def find_default_apk() -> Path | None:
    candidates = sorted(SCRIPT_DIR.glob(DEFAULT_APK_GLOB))
    return candidates[0] if candidates else None


def ensure_dirs() -> None:
    for path in (
        ASSETS_DIR,
        MASTER_DIR,
        MASTERDATA_TABLES_DIR,
        MASTERDATA_CONFIG_DIR,
        STATE_DIR,
        MANIFEST_CACHE_DIR,
        DATA_CACHE_DIR,
    ):
        path.mkdir(parents=True, exist_ok=True)


def manifest_url(category: str) -> str:
    return f"{SOURCE_BASE}/{CATEGORIES[category]['dir_name']}/{MANIFEST_FILE}"


def source_url(category: str, name: str) -> str:
    return f"{SOURCE_BASE}/{CATEGORIES[category]['dir_name']}/{name}"


def cache_slug(text: str) -> str:
    return re.sub(r"[^0-9A-Za-z_]+", "_", text).strip("_")


def relative_posix(path: Path) -> str:
    try:
        return path.relative_to(SCRIPT_DIR).as_posix()
    except ValueError:
        return path.as_posix()
