from __future__ import annotations

import shutil
import zipfile
from pathlib import Path
from typing import Any, Iterable, Sequence

DEFAULT_PREFIXES = (
    "assets/",
    "lib/",
)


def find_apks(root: Path, explicit: Sequence[str] | None = None) -> list[Path]:
    if explicit:
        paths = [Path(p) for p in explicit]
        missing = [p for p in paths if not p.is_file()]
        if missing:
            raise FileNotFoundError(", ".join(str(p) for p in missing))
        return paths
    found = sorted(root.glob("*.apk"))
    if not found:
        found = sorted(root.glob("*.apks"))
    if not found:
        raise FileNotFoundError("工作区里没有 .apk / .apks")
    return found


def extract_apk(
    apk: Path,
    out_dir: Path,
    *,
    prefixes: Iterable[str] = DEFAULT_PREFIXES,
    force: bool = False,
    strip_assets: bool = True,
    on_file: Any | None = None,
) -> int:
    written = 0
    prefixes = tuple(prefixes)
    with zipfile.ZipFile(apk) as zf:
        infos = [
            info
            for info in zf.infolist()
            if not info.is_dir() and info.filename.startswith(prefixes)
        ]
        for info in infos:
            name = info.filename
            if strip_assets and name.startswith("assets/"):
                name = name[len("assets/"):]
            dest = out_dir / name
            if dest.is_file() and not force:
                if dest.stat().st_size == info.file_size:
                    if on_file is not None:
                        on_file(apk, info.filename, False)
                    continue
                if dest.suffix == ".bundle":
                    with dest.open("rb") as handle:
                        if handle.read(8).startswith(b"UnityFS"):
                            if on_file is not None:
                                on_file(apk, info.filename, False)
                            continue
            dest.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(info) as src, dest.open("wb") as out:
                shutil.copyfileobj(src, out)
            written += 1
            if on_file is not None:
                on_file(apk, info.filename, True)
    return written


def apk_entries(apk: Path, prefixes: Iterable[str] = DEFAULT_PREFIXES) -> list[str]:
    prefixes = tuple(prefixes)
    with zipfile.ZipFile(apk) as zf:
        return [
            info.filename
            for info in zf.infolist()
            if not info.is_dir() and info.filename.startswith(prefixes)
        ]


def read_apk_file(apk: Path, name: str) -> bytes | None:
    with zipfile.ZipFile(apk) as zf:
        try:
            return zf.read(name)
        except KeyError:
            return None


def unity_version_from_apks(apks: Sequence[Path]) -> str | None:
    """从 globalgamemanagers / 任意 bundle 里读出 Unity 版本号。"""
    import re

    for apk in apks:
        data = read_apk_file(apk, "assets/bin/Data/globalgamemanagers")
        if not data:
            continue
        match = re.search(rb"(20\d\d\.\d+\.\d+[a-z]\d+)", data)
        if match:
            return match.group(1).decode("ascii")
    return None
