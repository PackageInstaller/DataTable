from __future__ import annotations

"""反向蓝 APK / 拆分 APK 的枚举与解包。

支持 base.apk + split_config.arm64_v8a.apk + split_UnityDataAssetPack.apk
以及 .apks/.xapk/.apkm 打包格式；默认提取 assets/ 与 lib/ 前缀，并把
assets/ 前缀去掉后写到 Assets/（与 Assets/Android/*.bundle 热更目录同级）。
"""

import glob as globmod
import io
import re
import shutil
import zipfile
from pathlib import Path
from typing import Any, Iterable, Iterator, Sequence

DEFAULT_PREFIXES = ("assets/", "lib/")
ARCHIVE_SUFFIXES = (".apks", ".xapk", ".apkm")


def find_apks(root: Path, explicit: Sequence[str] | None = None) -> list[Path]:
    if explicit:
        paths: list[Path] = []
        for item in explicit:
            path = Path(item)
            if path.is_dir():
                paths.extend(sorted(p for p in path.iterdir() if _is_apk_like(p) and p.is_file()))
            elif any(ch in item for ch in "*?["):
                paths.extend(sorted(Path(match) for match in globmod.glob(item)))
            elif path.is_file():
                paths.append(path)
            else:
                raise FileNotFoundError(f"APK 不存在: {item}")
        if not paths:
            raise FileNotFoundError("--apk 未匹配到任何 APK")
        return paths
    found = sorted(p for p in root.iterdir() if p.is_file() and p.suffix.lower() == ".apk")
    if not found:
        found = sorted(p for p in root.iterdir() if p.is_file() and p.suffix.lower() in ARCHIVE_SUFFIXES)
    if not found:
        raise FileNotFoundError(f"{root} 下没有 .apk / .apks / .xapk")
    return found


def _is_apk_like(path: Path) -> bool:
    return path.suffix.lower() in (".apk",) or path.suffix.lower() in ARCHIVE_SUFFIXES


def iter_apk_sources(archive: Path) -> Iterator[tuple[str, zipfile.ZipFile]]:
    """展开 .apks/.xapk；普通 .apk 直接作为一个来源。"""
    if archive.suffix.lower() in ARCHIVE_SUFFIXES:
        with zipfile.ZipFile(archive) as outer:
            inner_names = [n for n in outer.namelist() if n.lower().endswith(".apk")]
            if inner_names:
                for name in inner_names:
                    data = outer.read(name)
                    yield f"{archive.name}:{name}", zipfile.ZipFile(io.BytesIO(data))
                return
        # 没有内层 apk，退回当普通 zip 处理
        yield archive.name, zipfile.ZipFile(archive)
        return
    yield archive.name, zipfile.ZipFile(archive)


def has_prefix(name: str, prefixes: Iterable[str]) -> bool:
    return any(name.startswith(prefix) for prefix in prefixes)


def apk_entry_infos(archive: Path, prefixes: Iterable[str] = DEFAULT_PREFIXES) -> list[tuple[str, str, int]]:
    """返回 [(来源标签, APK 内路径, 解压后大小)]。"""
    prefixes = tuple(prefixes)
    out: list[tuple[str, str, int]] = []
    for label, zf in iter_apk_sources(archive):
        with zf:
            for info in zf.infolist():
                if info.is_dir() or not has_prefix(info.filename, prefixes):
                    continue
                out.append((label, info.filename, info.file_size))
    return out


def output_name(name: str, strip_assets: bool = True) -> str:
    if strip_assets and name.startswith("assets/"):
        return name[len("assets/") :]
    return name


def extract_apk(
    archive: Path,
    out_dir: Path,
    *,
    prefixes: Iterable[str] = DEFAULT_PREFIXES,
    strip_assets: bool = True,
    force: bool = False,
    on_file: Any | None = None,
) -> tuple[int, int, int]:
    """把 APK 条目写到 out_dir。返回 (written, skipped, failed)。"""
    prefixes = tuple(prefixes)
    written = skipped = failed = 0
    for label, zf in iter_apk_sources(archive):
        with zf:
            for info in zf.infolist():
                if info.is_dir() or not has_prefix(info.filename, prefixes):
                    continue
                dest = out_dir / output_name(info.filename, strip_assets)
                if dest.is_file() and not force:
                    if dest.stat().st_size == info.file_size:
                        skipped += 1
                        if on_file is not None:
                            on_file(label, info.filename, False)
                        continue
                try:
                    dest.parent.mkdir(parents=True, exist_ok=True)
                    with zf.open(info) as src, dest.open("wb") as out:
                        shutil.copyfileobj(src, out)
                    written += 1
                    if on_file is not None:
                        on_file(label, info.filename, True)
                except Exception:  # noqa: BLE001
                    failed += 1
    return written, skipped, failed


def read_apk_entry(archive: Path, name: str) -> bytes | None:
    for _label, zf in iter_apk_sources(archive):
        with zf:
            try:
                return zf.read(name)
            except KeyError:
                continue
    return None


def unity_version_from_apks(apks: Sequence[Path]) -> str | None:
    """从 globalgamemanagers 里读出 Unity 版本号。"""
    for apk in apks:
        data = read_apk_entry(apk, "assets/bin/Data/globalgamemanagers")
        if not data:
            continue
        match = re.search(rb"(20\d\d\.\d+\.\d+[a-z]\d+)", data)
        if match:
            return match.group(1).decode("ascii")
    return None


def detect_split_names(apks: Sequence[Path]) -> dict[str, Path]:
    """按 APK 文件名识别 base / config / assetpack 拆分。"""
    result: dict[str, Path] = {}
    for apk in apks:
        name = apk.name.lower()
        if "unitydataassetpack" in name:
            result["assetpack"] = apk
        elif "config" in name:
            result.setdefault("config", apk)
        elif name.startswith("base") or "base-" in name:
            result["base"] = apk
    return result
