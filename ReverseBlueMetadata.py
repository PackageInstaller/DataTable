from __future__ import annotations

"""反向蓝客户端版本信息自动提取。

游戏把「接口路由表」和「reverse-version-key」都作为字符串字面量编译进
global-metadata.dat；服务端不下发这些值，所以它们是**每个客户端版本硬编码**的。
本模块从 APK 的 assets/bin/Data/Managed/Metadata/global-metadata.dat 里动态读取：

- 439 条 /api/uuid/<uuid> 路由字面量（连续排布，随版本重新生成）
- 唯一的 50 位字母数字 literal 即 reverse-version-key（随版本更换）
- APK versionName（aapt2/aapt）
- 没有 APK 时，从 Play Store 读取版本号（google_play_scraper，带 6 小时缓存）
"""

import glob as globmod
import hashlib
import json
import re
import shutil
import struct
import subprocess
import time
from pathlib import Path
from typing import Sequence

import ReverseBlueApk as Apk

STORE_PACKAGE = "jp.co.happyelements.rxr"
STORE_CACHE_TTL = 6 * 3600
METADATA_ENTRY = "assets/bin/Data/Managed/Metadata/global-metadata.dat"
METADATA_SANITY = 0xFAB11BAF
ROUTE_PREFIX = "/api/uuid/"
VERSION_KEY_RE = re.compile(r"^[A-Za-z0-9]{50}$")
VERSION_NAME_RE = re.compile(r"versionName='([^']+)'")


def load_metadata(apks: Sequence[Path]) -> bytes | None:
    for apk in apks:
        data = Apk.read_apk_entry(apk, METADATA_ENTRY)
        if data:
            return data
    return None


def extract_literals(metadata: bytes) -> list[str]:
    """解析 global-metadata.dat 的 Il2CppStringLiteral 表（v24+ 布局）。"""
    if not metadata or len(metadata) < 64:
        return []
    sanity, _version = struct.unpack_from("<Ii", metadata, 0)
    if sanity & 0xFFFFFFFF != METADATA_SANITY:
        return []
    try:
        literal_offset, literal_count, data_offset, data_count = struct.unpack_from("<4i", metadata, 8)
    except struct.error:
        return []
    if literal_offset <= 0 or data_offset <= 0 or data_count <= 0:
        return []
    if literal_count * 8 > data_offset - literal_offset:
        literal_count //= 8
    if literal_count <= 0:
        return []
    literals: list[str] = []
    for index in range(literal_count):
        try:
            length, data_index = struct.unpack_from("<ii", metadata, literal_offset + index * 8)
        except struct.error:
            break
        if length <= 0 or length > 1_000_000 or data_index < 0 or data_index + length > data_count:
            continue
        raw = metadata[data_offset + data_index : data_offset + data_index + length]
        literals.append(raw.decode("utf-8", "replace"))
    return literals


def find_routes(literals: Sequence[str]) -> list[str]:
    return [text for text in literals if text.startswith(ROUTE_PREFIX)]


def find_version_key(literals: Sequence[str]) -> str | None:
    """reverse-version-key：整份 metadata 里唯一的 50 位字母数字字面量。"""
    candidates = [text for text in literals if VERSION_KEY_RE.match(text)]
    return candidates[0] if len(candidates) == 1 else None


def route_fingerprint(routes: Sequence[str]) -> str:
    return hashlib.md5("\n".join(routes).encode("utf-8")).hexdigest()


def _aapt_candidates() -> list[str]:
    found: list[str] = []
    for name in ("aapt2", "aapt"):
        path = shutil.which(name)
        if path:
            found.append(path)
    for env in ("ANDROID_HOME", "ANDROID_SDK_ROOT"):
        import os

        sdk = os.environ.get(env)
        if sdk:
            found.extend(sorted(globmod.glob(f"{sdk}/build-tools/*/aapt2")))
            found.extend(sorted(globmod.glob(f"{sdk}/build-tools/*/aapt")))
    found.extend(sorted(globmod.glob("/opt/android-sdk/build-tools/*/aapt2")))
    found.extend(sorted(globmod.glob("/opt/android-sdk/build-tools/*/aapt")))
    return found


def detect_app_version(apks: Sequence[Path]) -> str | None:
    """用 aapt2/aapt badging 读取 versionName；不可用时返回 None。"""
    if not apks:
        return None
    for tool in _aapt_candidates():
        for apk in apks:
            try:
                output = subprocess.run(
                    [tool, "dump", "badging", str(apk)],
                    capture_output=True,
                    timeout=60,
                )
            except (OSError, subprocess.SubprocessError):
                continue
            text = output.stdout.decode("utf-8", "replace")
            match = VERSION_NAME_RE.search(text)
            if match:
                return match.group(1)
    return None


def detect_store_version(cache_file: Path | None = None, ttl_seconds: int = STORE_CACHE_TTL) -> str | None:
    """从 Play Store 读取 versionName；缓存有效期内直接复用，网络失败退回旧缓存。"""
    cached_version: str | None = None
    if cache_file is not None and cache_file.is_file():
        try:
            data = json.loads(cache_file.read_text(encoding="utf-8"))
            cached_version = str(data.get("version") or "").strip() or None
            fetched_at = float(data.get("fetchedAt") or 0)
            if cached_version and time.time() - fetched_at < ttl_seconds:
                return cached_version
        except Exception:  # noqa: BLE001
            cached_version = None
    try:
        from google_play_scraper import app as playstore_app
    except ImportError:
        return cached_version
    try:
        result = playstore_app(app_id=STORE_PACKAGE, lang="en", country="jp")
        version = str(result.get("version") or "").strip()
    except Exception:  # noqa: BLE001
        return cached_version
    if not version:
        return cached_version
    if cache_file is not None:
        try:
            cache_file.parent.mkdir(parents=True, exist_ok=True)
            cache_file.write_text(
                json.dumps({"version": version, "fetchedAt": time.time(), "source": "google_play_scraper"}, ensure_ascii=False),
                encoding="utf-8",
            )
        except Exception:  # noqa: BLE001
            pass
    return version
