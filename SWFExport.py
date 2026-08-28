from __future__ import annotations

import shutil
import subprocess
from pathlib import Path

from Config import GAME_SWFS, SWF_DIR, resolve_assets


def find_ffdec() -> str:
    exe = shutil.which("ffdec") or shutil.which("ffdec.sh")
    if not exe:
        raise FileNotFoundError("未找到 ffdec，请确认已安装 JPEXS Free Flash Decompiler")
    return exe


def export_swf(assets: Path | None = None, dest: Path | None = None) -> None:
    assets = assets or resolve_assets()
    dest = dest or SWF_DIR
    dest.mkdir(parents=True, exist_ok=True)
    ffdec = find_ffdec()
    for rel in GAME_SWFS:
        src = assets / rel
        if not src.exists():
            print(f"[swf] 缺失 {rel}")
            continue
        out = dest / src.stem
        out.mkdir(parents=True, exist_ok=True)
        print(f"[swf] ffdec 导出 {rel} -> {out}")
        cmd = [
            ffdec,
            "-exportTimeout",
            "60",
            "-export",
            "script,binaryData,symbolClass,image",
            str(out),
            str(src),
        ]
        proc = subprocess.run(cmd, check=False)
        if proc.returncode != 0:
            print(f"[swf] {rel} 导出返回码 {proc.returncode}")
