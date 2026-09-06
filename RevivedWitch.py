#!/usr/bin/env python3
"""复苏的魔女：APK + NekoFS 热更还原到 Assets/，Lua 反编译到 MasterData/。

子命令（参考 DataTable: CatFantasy / NeuralCloud / EternalTree / Seer / Morimens）:
  status      查看 APK/本地/远端版本与补丁链
  assets      APK 提取 + 热更 patch 下载/解包 → Assets/
  masterdata  Lua 反编译 + cfg 等配置 → MasterData/（lua 本身即数据表，不再转 JSON）
  painting    卡面立绘 Texture2D → Painting/（复苏的魔女_角色_皮肤[_备注].png）
  all         assets + masterdata

nekodata 解包用同目录 nekoextract（C++23）；缺失则 g++ 现场编译。Lua 5.3 bytecode 走 unluac。
立绘依赖 UnityPy；角色/皮肤名从 MasterData lua（cskin → cnpcshape → cimagepath）解析。
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import shutil
import struct
import subprocess
import sys
import tempfile
import threading
import warnings
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Iterable
from urllib.parse import urljoin

import requests
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
PAINTING_DIR = ROOT / "Painting"
CACHE_DIR = ROOT / "Cache" / "patches"
MANIFEST_PATH = ASSETS_DIR / ".manifest.json"
GAME_TITLE = "复苏的魔女"
EXCELDATA = MASTER_DIR / "luacode" / "data" / "exceldata"

DEFAULT_APK = next(ROOT.glob("*.apk"), None)
CDN_FALLBACK = "http://fsdmn-oss.ymtnet.com/fhdmn_dalu_client/20251219/android/main"
APK_GAMEDATA_PREFIX = "assets/gamedata/"
RES_NAMES = ("main", "audio-zh_Hans", "audio-ja_JP", "live2d")

LUA_MAGIC = b"\x1bLua"
NEKO_MAGIC = b"pixelneko filesystem"
UNLUAC_BIN = shutil.which("unluac") or "unluac"
NEKOEXTRACT_BIN = ROOT / "NekoExtract"
NEKOEXTRACT_SRC = ROOT / "NekoExtract.cpp"
LUAJIT_DECOMPILER = shutil.which("luajit-decompiler") or shutil.which(
    "luajit-decompier"
)
DEFAULT_JOBS = max(4, (os.cpu_count() or 4))
RETRY_COUNT = 5
CHUNK_SIZE = 1 << 20
TIMEOUT = (15, 600)
UNLUAC_TIMEOUT = 180

OLD_LUA_HDR = bytes.fromhex("1B4C7561530119930D0A1A0A040408087856")
NEW_LUA_HDR = bytes.fromhex("1B4C7561530019930D0A1A0A04080408087856")

console = Console()
_tls = threading.local()


def format_size(n: int) -> str:
    size = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{n} B"


def get_session() -> requests.Session:
    sess = getattr(_tls, "session", None)
    if sess is None:
        sess = requests.Session()
        sess.headers["User-Agent"] = (
            "UnityPlayer/2019.4.40f1 (UnityWebRequest/1.0, libcurl)"
        )
        sess.headers["Accept"] = "*/*"
        _tls.session = sess
    return sess


def compile_nekoextract() -> Path:
    src = NEKOEXTRACT_SRC
    out = NEKOEXTRACT_BIN
    if not src.is_file():
        raise SystemExit(f"缺少 {src.name}，无法编译 nekoextract")
    gxx = shutil.which("g++")
    if not gxx:
        raise SystemExit("找不到 g++，无法编译 nekoextract")
    console.print(f"[cyan]编译[/] nekoextract ← {src.name}")
    proc = subprocess.run(
        [gxx, "-std=c++23", "-O2", "-o", str(out), str(src), "-lz", "-lcrypto"],
        capture_output=True,
        text=True,
        check=False,
    )
    if proc.returncode != 0 or not out.is_file():
        err = (proc.stderr or proc.stdout or "").strip()
        raise SystemExit(f"g++ 编译 nekoextract 失败:\n{err[:800]}")
    out.chmod(out.stat().st_mode | 0o111)
    return out


def resolve_nekoextract() -> str:
    """PATH / 同目录已有二进制，否则 g++ -std=c++23 编译 nekoextract.cpp。"""
    candidates = [
        shutil.which("nekoextract"),
        str(NEKOEXTRACT_BIN),
    ]
    for c in candidates:
        if not c:
            continue
        p = Path(c)
        if not (p.is_file() and os.access(p, os.X_OK)):
            continue
        # 源码更新后自动重编
        if p.resolve() == NEKOEXTRACT_BIN.resolve() and NEKOEXTRACT_SRC.is_file():
            if NEKOEXTRACT_SRC.stat().st_mtime > p.stat().st_mtime:
                return str(compile_nekoextract())
        return str(p)
    return str(compile_nekoextract())


def http_get_json(url: str) -> Any:
    r = get_session().get(url, timeout=TIMEOUT)
    r.raise_for_status()
    return r.json()


def download_file(url: str, dest: Path, force: bool = False) -> Path:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.is_file() and dest.stat().st_size > 0 and not force:
        return dest
    tmp = dest.with_suffix(dest.suffix + ".part")
    existing = tmp.stat().st_size if tmp.is_file() else 0
    headers = {}
    if existing:
        headers["Range"] = f"bytes={existing}-"
    for attempt in range(1, RETRY_COUNT + 1):
        try:
            with get_session().get(
                url, stream=True, timeout=TIMEOUT, headers=headers
            ) as resp:
                if resp.status_code == 416:
                    break
                resp.raise_for_status()
                mode = "ab" if existing and resp.status_code == 206 else "wb"
                if mode == "wb":
                    existing = 0
                total = int(resp.headers.get("Content-Length") or 0) + existing
                with Progress(
                    SpinnerColumn(),
                    TextColumn("[progress.description]{task.description}"),
                    BarColumn(),
                    DownloadColumn(),
                    TransferSpeedColumn(),
                    TimeRemainingColumn(),
                    console=console,
                ) as progress:
                    task = progress.add_task(
                        dest.name[:48], total=total or None
                    )
                    progress.update(task, completed=existing)
                    with tmp.open(mode) as fh:
                        for chunk in resp.iter_content(CHUNK_SIZE):
                            if not chunk:
                                continue
                            fh.write(chunk)
                            progress.update(task, advance=len(chunk))
            break
        except Exception as exc:
            if attempt == RETRY_COUNT:
                raise
            console.print(f"[yellow]下载重试 {attempt}/{RETRY_COUNT}[/] {exc}")
            existing = tmp.stat().st_size if tmp.is_file() else 0
            headers = {"Range": f"bytes={existing}-"} if existing else {}
    os.replace(tmp, dest)
    return dest


# ---------------------------------------------------------------------------
# version / patch meta（PixelNeko.FileSystem.Overlay）
# ---------------------------------------------------------------------------


def read_local_version_meta(assets: Path) -> dict[str, Any] | None:
    for p in (
        assets / "version.meta",
        assets / "main" / "version.meta",
        assets / ".version.meta",
    ):
        if p.is_file():
            return json.loads(p.read_text(encoding="utf-8"))
    return None


def apk_version_meta(apk: Path) -> dict[str, Any] | None:
    with zipfile.ZipFile(apk) as zf:
        name = "assets/gamedata/main/version.meta"
        if name not in zf.namelist():
            return None
        return json.loads(zf.read(name).decode("utf-8"))


def cdn_base_from_version_meta(vm: dict[str, Any]) -> str:
    servers = vm.get("versionserver") or vm.get("downloadserver") or []
    if not servers:
        return CDN_FALLBACK
    return servers[0].rstrip("/")


def build_patch_chain(
    patches: list[dict[str, Any]], from_ver: int, to_ver: int
) -> list[dict[str, Any]]:
    by_from = {int(p["from"]): p for p in patches}
    chain: list[dict[str, Any]] = []
    cur = from_ver
    while cur < to_ver:
        p = by_from.get(cur)
        if p is None:
            raise RuntimeError(f"补丁链断裂：缺少 from={cur} 的 patch")
        chain.append(p)
        cur = int(p["to"])
    return chain


# ---------------------------------------------------------------------------
# nekodata 解包（nekoextract）+ 递归嵌套
# ---------------------------------------------------------------------------


def run_nekoextract(src: Path, out_dir: Path) -> None:
    bin_path = resolve_nekoextract()
    out_dir.mkdir(parents=True, exist_ok=True)
    proc = subprocess.run(
        [bin_path, "-o", str(out_dir), str(src)],
        capture_output=True,
        text=True,
        check=False,
    )
    if proc.returncode != 0:
        err = (proc.stderr or proc.stdout or "").strip()
        raise RuntimeError(f"nekoextract 失败 {src.name}: {err[:400]}")


def merge_tree(src: Path, dest: Path) -> int:
    """把 src 下文件覆盖合并到 dest，返回文件数。"""
    n = 0
    if not src.is_dir():
        return 0
    for path in src.rglob("*"):
        if not path.is_file():
            continue
        rel = path.relative_to(src)
        target = dest / rel
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
        n += 1
    return n


def neko_stem(path: Path) -> str:
    """luacode.nekodata / foo.patch.nekodata → luacode / foo。"""
    return path.name.split(".", 1)[0]


def is_patch_nekodata(path: Path) -> bool:
    return path.name.lower().endswith(".patch.nekodata")


def unpack_nekodata(src: Path, dest: Path, *, recursive: bool = True) -> int:
    """解包 .nekodata / .patch.nekodata 到 dest。

    普通包：文件落到 dest/<stem>/（与旧 unneko wrapper 行为一致）。
    patch 包：无 stem 前缀；嵌套 .nekodata 递归展开，其余文件直接合并。
    """
    with tempfile.TemporaryDirectory(prefix="neko-") as td:
        td_path = Path(td)
        run_nekoextract(src, td_path)
        n = 0
        if recursive:
            for nest in list(td_path.rglob("*.nekodata")):
                if not nest.is_file():
                    continue
                n += unpack_nekodata(nest, dest, recursive=True)
                nest.unlink(missing_ok=True)
        if is_patch_nekodata(src):
            for path in td_path.rglob("*"):
                if not path.is_file():
                    continue
                if path.name in {"checksum.json", "patch-meta.json"}:
                    continue
                if path.name.endswith(".nekodata"):
                    continue
                rel = path.relative_to(td_path)
                target = dest / rel
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(path, target)
                n += 1
            return n
        return n + merge_tree(td_path, dest / neko_stem(src))


def is_nekodata(path: Path) -> bool:
    if not path.is_file():
        return False
    name = path.name.lower()
    return name.endswith(".nekodata")


def apply_patch_file(patch_path: Path, assets: Path) -> None:
    """解包 patch.nekodata，嵌套 nekodata 递归展开，覆盖写入 Assets。"""
    n = unpack_nekodata(patch_path, assets, recursive=True)
    console.print(f"[green]合并补丁[/] {patch_path.name} → {n} 文件")


# ---------------------------------------------------------------------------
# APK 提取
# ---------------------------------------------------------------------------


def extract_apk_gamedata(apk: Path, dest: Path, force: bool = False) -> int:
    dest.mkdir(parents=True, exist_ok=True)
    n = 0
    with zipfile.ZipFile(apk) as zf:
        members = [
            m
            for m in zf.namelist()
            if m.startswith(APK_GAMEDATA_PREFIX) and not m.endswith("/")
        ]
        for name in members:
            # assets/gamedata/main/xxx → Assets/xxx（去掉 gamedata/main 或保留 resName）
            rel = name[len(APK_GAMEDATA_PREFIX) :]
            # main/luacode.nekodata → luacode.nekodata 先落到 staging 再解包
            out = dest / rel
            if out.is_file() and not force:
                n += 1
                continue
            out.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(name) as src, out.open("wb") as dst:
                shutil.copyfileobj(src, dst)
            n += 1
    return n


def unpack_all_nekodata_under(root: Path) -> int:
    files = sorted(p for p in root.rglob("*") if is_nekodata(p))
    total = 0
    for path in files:
        console.print(f"[cyan]解包[/] {path.relative_to(root)}")
        # 解到所在目录的上级（main/luacode.nekodata → main/ 下出 luacode/）
        # 包内已含 luacode/ cfg/ 前缀，解到 Assets 根更干净：
        # 若路径含 main/，合并到 Assets/；资源在 resources/*.nekodata 同理
        unpack_nekodata(path, root, recursive=True)
        path.unlink(missing_ok=True)
        total += 1
    return total


def flatten_main_prefix(assets: Path) -> None:
    """APK 抽出后是 main/...，把 main/ 内容提升到 Assets/。"""
    main = assets / "main"
    if not main.is_dir():
        return
    for path in list(main.iterdir()):
        target = assets / path.name
        if path.is_dir() and target.is_dir():
            merge_tree(path, target)
            shutil.rmtree(path, ignore_errors=True)
        else:
            if target.exists():
                if target.is_dir():
                    shutil.rmtree(target)
                else:
                    target.unlink()
            shutil.move(str(path), str(target))
    try:
        main.rmdir()
    except OSError:
        pass


# ---------------------------------------------------------------------------
# Lua 头修复 / 反编译
# ---------------------------------------------------------------------------


def is_luac(data: bytes) -> bool:
    return len(data) >= 5 and data[:4] == LUA_MAGIC


def is_luajit(data: bytes) -> bool:
    # LuaJIT 1.x/2.x bytecode: \x1bLJ
    return len(data) >= 3 and data[:3] == b"\x1bLJ"


def normalize_luac(data: bytes) -> bytes:
    """libxlua format=1 + 省略 sizeof(size_t) → 标准 5.3 头给 unluac。"""
    if len(data) >= len(OLD_LUA_HDR) and data.startswith(OLD_LUA_HDR[:6]):
        if data[: len(OLD_LUA_HDR)] == OLD_LUA_HDR or (
            data[4] == 0x53 and data[5] == 0x01
        ):
            buf = bytearray(data)
            buf[5] = 0
            # signature(4)+ver(1)+fmt(1)+LUAC_DATA(6)=12 后插入 sizeof(size_t)=4
            # 旧头：04 04 08 08 → 插 04 后变成 04 08 04 08 08
            if len(buf) > 13 and buf[12] == 0x04 and buf[13] == 0x04:
                return bytes(buf[:13] + b"\x04" + buf[13:])
            return bytes(buf)
    if len(data) < 18 or data[:4] != LUA_MAGIC or data[4] != 0x53:
        return data
    if data[5] == 0:
        return data
    buf = bytearray(data)
    buf[5] = 0
    return bytes(buf[:13] + b"\x04" + buf[13:])


def decompile_lua(src: Path, dest: Path) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    data = src.read_bytes()
    if is_luajit(data):
        if not LUAJIT_DECOMPILER:
            dest.write_bytes(data)
            return "luajit-raw"
        proc = subprocess.run(
            [LUAJIT_DECOMPILER, str(src), str(dest)],
            capture_output=True,
            text=True,
            timeout=UNLUAC_TIMEOUT,
            check=False,
        )
        if proc.returncode != 0 or not dest.is_file():
            dest.write_bytes(data)
            return "luajit-fail"
        return "luajit"
    if not is_luac(data):
        # 明文 lua / json / 其他：直接拷
        text = data
        try:
            # 已是文本则规范化换行写出
            s = data.decode("utf-8")
            dest.write_text(s if s.endswith("\n") else s + "\n", encoding="utf-8")
        except UnicodeDecodeError:
            dest.write_bytes(data)
        return "copy"
    data = normalize_luac(data)
    with tempfile.TemporaryDirectory(prefix="luac-") as td:
        tin = Path(td) / "in.luac"
        tout = Path(td) / "out.lua"
        tin.write_bytes(data)
        proc = subprocess.run(
            [UNLUAC_BIN, "--rawstring", "--output", str(tout), str(tin)],
            capture_output=True,
            text=True,
            timeout=UNLUAC_TIMEOUT,
            check=False,
        )
        if proc.returncode != 0 or not tout.is_file():
            dest.write_bytes(src.read_bytes())
            return "unluac-fail"
        if tout.stat().st_size == 0:
            dest.write_text("return\n", encoding="utf-8")
        else:
            shutil.copy2(tout, dest)
        return "unluac"


def write_json(path: Path, data: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )


def pretty_json_file(src: Path, dest: Path) -> bool:
    try:
        data = json.loads(src.read_text(encoding="utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError):
        return False
    write_json(dest, data)
    return True


# ---------------------------------------------------------------------------
# commands
# ---------------------------------------------------------------------------


def save_manifest(data: dict[str, Any]) -> None:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    write_json(MANIFEST_PATH, data)


# ---------------------------------------------------------------------------
# 立绘 painting（CatFantasy 命名约定 + UnityPy Texture2D / container）
# ---------------------------------------------------------------------------


def parse_lua_data_table(path: Path) -> dict[int, dict[str, Any]]:
    """解析 exceldata 风格 `Xxx.Data = { [id] = { k = v, ... }, ... }`。"""
    text = path.read_text(encoding="utf-8")
    m = re.search(r"\.Data\s*=\s*\{", text) or re.search(r"=\s*\{", text)
    if not m:
        return {}
    body = text[m.end() - 1 :]
    rows: dict[int, dict[str, Any]] = {}
    for mm in re.finditer(r"\[(\d+)\]\s*=\s*\{", body):
        key = int(mm.group(1))
        start = mm.end()
        depth = 1
        i = start
        while i < len(body) and depth:
            c = body[i]
            if c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
            elif c in "\"'":
                q = c
                i += 1
                while i < len(body) and body[i] != q:
                    if body[i] == "\\":
                        i += 1
                    i += 1
            i += 1
        block = body[start : i - 1]
        row: dict[str, Any] = {"id": key}
        for km in re.finditer(
            r"(\w+)\s*=\s*(\"(?:\\.|[^\"])*\"|'(?:\\.|[^'])*'|-?\d+(?:\.\d+)?|true|false)",
            block,
        ):
            k = km.group(1)
            v: Any = km.group(2)
            if v[0] in "\"'":
                v = v[1:-1]
            elif v in ("true", "false"):
                v = v == "true"
            else:
                v = float(v) if "." in v else int(v)
            row[k] = v
        rows[key] = row
    return rows


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
    notes: Iterable[str] | None = None,
) -> str:
    """游戏名_角色名_皮肤/变体名[_备注...].png，备注可无限追加。
    玩家角色固定为 复苏的魔女_魔女.png。
    """
    if cha == "魔女":
        base = f"{GAME_TITLE}_魔女.png"
        if base not in used:
            used.add(base)
            return base
        n = 2
        while True:
            name = f"{GAME_TITLE}_魔女_{n}.png"
            if name not in used:
                used.add(name)
                return name
            n += 1
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


def _word_text(words: dict[int, dict[str, Any]], tid: Any) -> str:
    try:
        tid_i = int(tid)
    except (TypeError, ValueError):
        return ""
    return str(words.get(tid_i, {}).get("text") or "").strip()


def _role_display_name(
    role: dict[str, Any] | None, words: dict[int, dict[str, Any]]
) -> str:
    if not role:
        return "未知"
    name = str(role.get("name") or "").strip()
    if not name:
        name = _word_text(words, role.get("nameTextID"))
    # 玩家角色占位符 → 魔女
    if name.startswith("$") or "heroine" in name.lower():
        return "魔女"
    return name or "未知"


def _skin_display_name(
    skin: dict[str, Any], words: dict[int, dict[str, Any]]
) -> str:
    text = _word_text(words, skin.get("skinNameTextID"))
    # 表内「原始造型」对外统一叫「初始」
    if text in {"", "原始造型"}:
        return "初始"
    return text or str(skin.get("id") or "未知")


def _skin_prefer_score(skin: dict[str, Any]) -> int:
    """同一立绘挂多条皮肤时，优先非 Live2D 重复条目、低 skinType。"""
    score = 0
    if int(skin.get("ifLive") or 0) == 0:
        score += 10
    if int(skin.get("skinItemID") or 0) == 0:
        score += 2
    score -= int(skin.get("skinType") or 0)
    return score


def load_painting_maps() -> dict[str, Any]:
    role = parse_lua_data_table(EXCELDATA / "role" / "roleconfig.lua")
    skins = parse_lua_data_table(EXCELDATA / "role" / "cskin.lua")
    shape = parse_lua_data_table(EXCELDATA / "npc" / "cnpcshape.lua")
    image = parse_lua_data_table(EXCELDATA / "ui" / "cimagepath.lua")
    words = parse_lua_data_table(EXCELDATA / "word" / "cwordrole_ch.lua")
    if not words:
        words = parse_lua_data_table(EXCELDATA / "role" / "cwordrole_ch.lua")
    npc_hb = parse_lua_data_table(
        EXCELDATA / "handbook" / "cnpcconfig_handbook.lua"
    )

    by_ab: dict[str, list[dict[str, Any]]] = {}
    for row in image.values():
        ab = str(row.get("assetBundle") or "").replace("\\", "/").lower()
        if ab:
            by_ab.setdefault(ab, []).append(row)

    lihui_skins: dict[int, list[dict[str, Any]]] = {}
    prefab_skins: dict[str, list[dict[str, Any]]] = {}
    lihui_shapes: dict[int, list[dict[str, Any]]] = {}
    for sh in shape.values():
        lid = sh.get("lihuiID")
        if lid is not None:
            lihui_shapes.setdefault(int(lid), []).append(sh)

    for skin in skins.values():
        sh = shape.get(int(skin.get("shapeID") or -1))
        if not sh:
            continue
        lid = sh.get("lihuiID")
        if lid is not None:
            lihui_skins.setdefault(int(lid), []).append(skin)
        pref = str(sh.get("prefabName") or "").strip().lower()
        if pref:
            prefab_skins.setdefault(pref, []).append(skin)

    npc_by_shape: dict[int, dict[str, Any]] = {}
    npc_by_prefab: dict[str, dict[str, Any]] = {}
    for row in npc_hb.values():
        sid = int(row.get("shapeID") or -1)
        if sid >= 0:
            npc_by_shape.setdefault(sid, row)
        sh = shape.get(sid)
        if sh:
            pref = str(sh.get("prefabName") or "").strip().lower()
            if pref and pref not in npc_by_prefab:
                npc_by_prefab[pref] = row

    return {
        "role": role,
        "skins": skins,
        "shape": shape,
        "words": words,
        "by_ab": by_ab,
        "lihui_skins": lihui_skins,
        "lihui_shapes": lihui_shapes,
        "prefab_skins": prefab_skins,
        "npc_by_shape": npc_by_shape,
        "npc_by_prefab": npc_by_prefab,
    }


def _pick_skin(
    candidates: list[dict[str, Any]], *, prefer_break: bool | None = None
) -> dict[str, Any] | None:
    if not candidates:
        return None
    pool = candidates
    if prefer_break is True:
        br = [s for s in candidates if int(s.get("skinType") or -1) == 1]
        if br:
            pool = br
    elif prefer_break is False:
        nb = [s for s in candidates if int(s.get("skinType") or -1) != 1]
        if nb:
            pool = nb
    return max(pool, key=_skin_prefer_score)


def _parse_card_variant(name: str) -> tuple[str | None, str | None]:
    """imagesets.cards.card_037v1 / card_037b / card_001_v1 → (char_037, v1|break|None)。"""
    m = re.search(
        r"(?:^|[._])card_(\d+)(?:_|)?(b|break|v\d+)?", name, re.I
    )
    if not m:
        m = re.search(r"(char_(\d+)(?:_(break|v\d+))?)", name, re.I)
        if not m:
            return None, None
        full = m.group(1).lower()
        if "_break" in full:
            return re.sub(r"_break$", "", full), "break"
        vm = re.search(r"(char_\d+)_(v\d+)$", full)
        if vm:
            return vm.group(1), vm.group(2)
        return full, None
    num, var = m.group(1), (m.group(2) or "").lower()
    pref = f"char_{num}"
    if var in {"b", "break"}:
        return pref, "break"
    if var.startswith("v"):
        return pref, var
    return pref, None


def _variant_skin_label(var: str | None) -> str:
    if var in {None, ""}:
        return "初始"
    if var in {"b", "break"}:
        return "突破造型"
    return var


def resolve_card_bundle(
    bundle: Path, maps: dict[str, Any]
) -> tuple[str, str, list[str], bool]:
    """返回 (角色名, 皮肤名, 备注, 是否表命中)。"""
    rel = f"ui/{bundle.name}".replace("\\", "/").lower()
    notes: list[str] = []
    is_loc = "localization.role" in rel
    if is_loc:
        notes.append("本地化")

    words = maps["words"]
    role_t = maps["role"]
    by_ab = maps["by_ab"]
    lihui_skins = maps["lihui_skins"]
    lihui_shapes = maps["lihui_shapes"]
    prefab_skins = maps["prefab_skins"]
    npc_by_shape = maps["npc_by_shape"]
    npc_by_prefab = maps["npc_by_prefab"]

    skin: dict[str, Any] | None = None
    force_break_label = False
    img_rows = by_ab.get(rel, [])

    for img in img_rows:
        skin = _pick_skin(lihui_skins.get(int(img["id"]), []))
        if skin:
            break

    # localization / 缺 cskin：按 char_XXX[_break|_vN] 回退
    pref_key, variant = _parse_card_variant(bundle.name)
    if skin is None and pref_key:
        prefer_break: bool | None = True if variant == "break" else (
            False if variant else None
        )
        pref_try = (
            f"{pref_key}_{variant}"
            if variant and variant.startswith("v")
            else pref_key
        )
        skin = _pick_skin(
            prefab_skins.get(pref_try, []) or prefab_skins.get(pref_key, []),
            prefer_break=prefer_break,
        )
        if variant == "break":
            force_break_label = True

    # handbook NPC（剧情角色卡，无 cskin）
    cha = ""
    skin_name = ""
    hit = False
    if skin is not None:
        cha = _role_display_name(role_t.get(int(skin.get("roleid") or -1)), words)
        skin_name = _skin_display_name(skin, words)
        if force_break_label and skin_name == "初始":
            skin_name = "突破造型"
        hit = True
    else:
        # lihui → shape → NPC / prefab
        npc_row = None
        for img in img_rows:
            for sh in lihui_shapes.get(int(img["id"]), []):
                npc_row = npc_by_shape.get(int(sh["id"]))
                if npc_row:
                    break
                pref = str(sh.get("prefabName") or "").strip().lower()
                npc_row = npc_by_prefab.get(pref) or npc_by_prefab.get(
                    re.sub(r"_v\d+$", "", pref)
                )
                if npc_row:
                    break
            if npc_row:
                break
        if npc_row is None and pref_key:
            npc_row = npc_by_prefab.get(pref_key)
        if npc_row is not None:
            cha = str(npc_row.get("NPCName") or "").strip() or "未知"
            skin_name = _variant_skin_label(variant)
            hit = True
        elif pref_key:
            skin_name = _variant_skin_label(variant)
            cha = "未知"
            if not is_loc:
                notes.append(pref_key + (f"_{variant}" if variant else ""))
        else:
            stem = re.sub(r"\.assetbundle$", "", bundle.name, flags=re.I)
            stem = stem.replace("imagesets.cards.", "").replace(
                "imagesets.localization.role.", ""
            )
            return "未知", stem, notes, False

    return cha, skin_name, notes, hit


def iter_painting_bundles(ui_dir: Path) -> list[Path]:
    if not ui_dir.is_dir():
        return []
    out: list[Path] = []
    for p in sorted(ui_dir.iterdir()):
        if not p.is_file():
            continue
        name = p.name.lower()
        if name.startswith("imagesets.cards.") and name.endswith(".assetbundle"):
            out.append(p)
        elif name.startswith("imagesets.localization.role.") and name.endswith(
            ".card.assetbundle"
        ):
            out.append(p)
    return out


def export_texture2d_from_container(bundle: Path, dest: Path) -> None:
    """按 container 路径选取 Texture2D（localization 的 m_Name 常为 card）。"""
    import UnityPy

    env = UnityPy.load(str(bundle))
    best = None
    best_area = -1
    for _cpath, ptr in env.container.items():
        typ = getattr(getattr(ptr, "type", None), "name", None)
        if typ != "Texture2D":
            continue
        data = ptr.read()
        image = getattr(data, "image", None)
        if image is None:
            continue
        area = int(image.width) * int(image.height)
        if area > best_area:
            best_area = area
            best = image
    if best is None:
        for obj in env.objects:
            if getattr(obj.type, "name", None) != "Texture2D":
                continue
            data = obj.read()
            image = getattr(data, "image", None)
            if image is None:
                continue
            area = int(image.width) * int(image.height)
            if area > best_area:
                best_area = area
                best = image
    if best is None:
        raise RuntimeError("no Texture2D")
    dest.parent.mkdir(parents=True, exist_ok=True)
    best.save(str(dest), "PNG")


def cmd_painting(
    jobs: int,
    force: bool,
    limit: int = 0,
    out_dir: Path | None = None,
) -> int:
    warnings.filterwarnings("ignore", message="No valid Unity version found")
    try:
        import UnityPy  # noqa: F401
    except ImportError:
        console.print("[red]需要 UnityPy：pip install UnityPy[/]")
        return 1

    ui_dir = ASSETS_DIR / "ui"
    if not ui_dir.is_dir():
        console.print("[red]Assets/ui 不存在，先跑 assets[/]")
        return 1
    need = [
        EXCELDATA / "role" / "roleconfig.lua",
        EXCELDATA / "role" / "cskin.lua",
        EXCELDATA / "npc" / "cnpcshape.lua",
        EXCELDATA / "ui" / "cimagepath.lua",
    ]
    if any(not p.is_file() for p in need):
        console.print("[red]MasterData exceldata 不齐，先跑 masterdata[/]")
        return 1

    dest_root = out_dir or PAINTING_DIR
    dest_root.mkdir(parents=True, exist_ok=True)
    maps = load_painting_maps()
    bundles = iter_painting_bundles(ui_dir)
    if limit > 0:
        bundles = bundles[:limit]
        console.print(f"[yellow]--limit {limit}[/]")

    used: set[str] = set()
    jobs_list: list[tuple[Path, Path, bool]] = []
    named = 0
    for bundle in bundles:
        cha, skin, notes, hit = resolve_card_bundle(bundle, maps)
        if hit:
            named += 1
        fname = painting_filename(cha, skin, used, notes)
        jobs_list.append((bundle, dest_root / fname, hit))

    console.print(
        f"[cyan]立绘[/] 表命中 {named}/{len(jobs_list)} → {dest_root}"
    )
    if not jobs_list:
        console.print("[yellow]没有 imagesets.cards / localization.role.*.card[/]")
        return 0

    written = skipped = fail = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出立绘", total=len(jobs_list))

        def work(item: tuple[Path, Path, bool]) -> str:
            bundle, dest, _hit = item
            if dest.is_file() and not force:
                return "skip"
            try:
                export_texture2d_from_container(bundle, dest)
                return "ok"
            except Exception as exc:
                return f"fail:{exc}"

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futs = [pool.submit(work, it) for it in jobs_list]
            for fut in as_completed(futs):
                r = fut.result()
                if r == "ok":
                    written += 1
                elif r == "skip":
                    skipped += 1
                else:
                    fail += 1
                progress.advance(task)

    console.print(
        f"[bold green]立绘完成[/] 写入 {written} 跳过 {skipped} 失败 {fail}"
    )
    return 0 if fail == 0 else 1


def cmd_status(apk: Path | None) -> int:
    table: dict[str, Any] = {"game": GAME_TITLE}
    if apk and apk.is_file():
        avm = apk_version_meta(apk)
        table["apk"] = str(apk)
        table["apk_version"] = avm.get("version") if avm else None
        base = cdn_base_from_version_meta(avm) if avm else CDN_FALLBACK
    else:
        avm = None
        base = CDN_FALLBACK
        table["apk"] = None
    try:
        rvm = http_get_json(f"{base}/version.meta")
        patches = http_get_json(f"{base}/patch.meta")
        table["cdn"] = base
        table["remote_version"] = rvm.get("version")
        local = read_local_version_meta(ASSETS_DIR)
        table["local_version"] = local.get("version") if local else None
        from_ver = int(
            (local or avm or {}).get("version")
            or (avm or {}).get("version")
            or 0
        )
        to_ver = int(rvm["version"])
        if from_ver and to_ver > from_ver:
            chain = build_patch_chain(patches, from_ver, to_ver)
            table["pending_patches"] = len(chain)
            table["pending_bytes"] = sum(int(p["size"]) for p in chain)
            table["pending_human"] = format_size(table["pending_bytes"])
        else:
            table["pending_patches"] = 0
    except Exception as exc:
        table["cdn_error"] = str(exc)
    table["assets"] = str(ASSETS_DIR)
    table["assets_exists"] = ASSETS_DIR.is_dir()
    table["masterdata_exists"] = MASTER_DIR.is_dir()
    console.print_json(data=table)
    return 0


def cmd_assets(
    apk: Path | None,
    jobs: int,
    force: bool,
    skip_download: bool,
    res_names: list[str],
    skip_apk: bool = False,
) -> int:
    del jobs  # 下载可并行扩展；当前顺序链更安全
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)

    if apk and apk.is_file() and not skip_apk:
        console.print(f"[cyan]APK 提取[/] {apk.name}")
        extract_apk_gamedata(apk, ASSETS_DIR, force=force)
        flatten_main_prefix(ASSETS_DIR)
        unpack_all_nekodata_under(ASSETS_DIR)
    elif not any(ASSETS_DIR.iterdir()):
        console.print("[red]需要 --apk，或 Assets/ 已有内容[/]")
        return 1

    local_vm = read_local_version_meta(ASSETS_DIR)
    if local_vm is None and apk:
        local_vm = apk_version_meta(apk)
        if local_vm:
            write_json(ASSETS_DIR / "version.meta", local_vm)

    if not local_vm:
        console.print("[yellow]无 version.meta，跳过热更[/]")
        save_manifest({"apk": str(apk) if apk else None, "note": "no version.meta"})
        return 0

    base = cdn_base_from_version_meta(local_vm)
    if skip_download:
        console.print("[yellow]--skip-download，仅本地解包[/]")
        save_manifest({"cdn": base, "local_version": local_vm.get("version")})
        return 0

    for res in res_names:
        if res != "main":
            # 分包：从 main version.meta.subresource 取 URL
            sub = (local_vm.get("subresource") or {}).get(res)
            if not sub:
                continue
            servers = sub.get("versionserver") or []
            if not servers:
                continue
            res_base = servers[0].rstrip("/")
        else:
            res_base = base

        console.print(f"[cyan]热更[/] {res} @ {res_base}")
        try:
            remote_vm = http_get_json(f"{res_base}/version.meta")
            patches = http_get_json(f"{res_base}/patch.meta")
        except Exception as exc:
            console.print(f"[yellow]跳过 {res}[/] {exc}")
            continue

        # 本地该分包版本：main 用 version.meta；分包写在 Assets/<res>/version.meta
        if res == "main":
            from_ver = int(local_vm.get("version") or 0)
        else:
            svm = read_local_version_meta(ASSETS_DIR / res) or {}
            from_ver = int(svm.get("version") or 0)
            # 分包若本地无版本，从 0 拉全量链可能不存在；用 remote.fromversion
            if from_ver == 0:
                from_ver = int(remote_vm.get("fromversion") or 0)

        to_ver = int(remote_vm["version"])
        ver_path = (
            ASSETS_DIR / "version.meta"
            if res == "main"
            else ASSETS_DIR / res / "version.meta"
        )
        merge_root = ASSETS_DIR if res == "main" else ASSETS_DIR / res

        if from_ver >= to_ver:
            console.print(f"[green]{res} 已是最新[/] {to_ver}")
            write_json(ver_path, remote_vm)
            continue

        chain = build_patch_chain(patches, from_ver, to_ver)
        total = sum(int(p["size"]) for p in chain)
        console.print(
            f"[cyan]{res}[/] {from_ver} → {to_ver}，"
            f"{len(chain)} 个补丁 {format_size(total)}"
        )
        for p in chain:
            url = f"{res_base}/{p['name']}"
            dest = CACHE_DIR / res / p["name"]
            download_file(url, dest, force=force)
            if dest.stat().st_size != int(p["size"]):
                console.print(
                    f"[yellow]大小不符[/] {p['name']} "
                    f"{dest.stat().st_size} != {p['size']}，重下"
                )
                download_file(url, dest, force=True)
            apply_patch_file(dest, merge_root)

        write_json(ver_path, remote_vm)
        if res == "main":
            local_vm = remote_vm

    save_manifest(
        {
            "cdn": base,
            "version": local_vm.get("version"),
            "res": res_names,
        }
    )
    console.print(f"[bold green]Assets 完成[/] {ASSETS_DIR}")
    return 0


def cmd_masterdata(jobs: int, force: bool) -> int:
    luacode_src = ASSETS_DIR / "luacode"
    if not luacode_src.is_dir():
        # 兼容未 flatten
        alt = ASSETS_DIR / "main" / "luacode"
        if alt.is_dir():
            luacode_src = alt
        else:
            console.print("[red]Assets/luacode 不存在，先跑 assets[/]")
            return 1

    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    out_lua = MASTER_DIR / "luacode"
    out_lua.mkdir(parents=True, exist_ok=True)

    files = [p for p in luacode_src.rglob("*") if p.is_file()]
    console.print(f"[cyan]反编译[/] {len(files)} 个 → {out_lua}  ({jobs} 线程)")

    def one(src: Path) -> tuple[str, str]:
        rel = src.relative_to(luacode_src)
        dest = out_lua / rel
        if dest.suffix.lower() != ".lua":
            # 非 lua：原样或 json 美化
            if src.suffix.lower() == ".json":
                if pretty_json_file(src, MASTER_DIR / "luacode" / rel):
                    return str(rel), "json"
            dest.parent.mkdir(parents=True, exist_ok=True)
            if force or not dest.exists():
                shutil.copy2(src, dest)
            return str(rel), "copy"
        if dest.exists() and not force:
            return str(rel), "skip"
        try:
            return str(rel), decompile_lua(src, dest)
        except Exception as exc:
            return str(rel), f"err:{exc}"

    ok = fail = skip = 0
    with ThreadPoolExecutor(max_workers=jobs) as pool:
        futs = [pool.submit(one, p) for p in files]
        with Progress(
            SpinnerColumn(),
            TextColumn("{task.description}"),
            BarColumn(),
            TextColumn("{task.completed}/{task.total}"),
            console=console,
        ) as progress:
            task = progress.add_task("unluac", total=len(futs))
            for fut in as_completed(futs):
                _, status = fut.result()
                if status in {"unluac", "luajit", "copy", "json"}:
                    ok += 1
                elif status == "skip":
                    skip += 1
                else:
                    fail += 1
                progress.advance(task)

    console.print(f"[green]Lua[/] ok={ok} skip={skip} fail={fail}")

    # cfg / version.meta / files.meta 等重要配置（已是 JSON 的 indent=2 格式化）
    for name in ("cfg",):
        cfg_dir = ASSETS_DIR / name
        if not cfg_dir.is_dir():
            continue
        for path in cfg_dir.rglob("*"):
            if not path.is_file():
                continue
            rel = path.relative_to(ASSETS_DIR)
            dest = MASTER_DIR / rel
            if path.suffix.lower() == ".json":
                pretty_json_file(path, dest)
            else:
                dest.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(path, dest)

    for meta in ("version.meta", "files.meta"):
        src = ASSETS_DIR / meta
        if src.is_file():
            pretty_json_file(src, MASTER_DIR / meta) or shutil.copy2(
                src, MASTER_DIR / meta
            )

    console.print(f"[bold green]MasterData 完成[/] {MASTER_DIR}")
    return 0


def cmd_all(
    apk: Path | None,
    jobs: int,
    force: bool,
    skip_download: bool,
    res_names: list[str],
    skip_apk: bool = False,
) -> int:
    rc = cmd_assets(apk, jobs, force, skip_download, res_names, skip_apk=skip_apk)
    if rc != 0:
        return rc
    return cmd_masterdata(jobs, force)


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument(
        "--apk",
        type=Path,
        default=DEFAULT_APK,
        help=f"APK 路径（默认: {DEFAULT_APK}）",
    )
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    shared.add_argument("--force", action="store_true", help="强制重下/重解")
    shared.add_argument(
        "--skip-download",
        action="store_true",
        help="不拉热更，只处理本地/APK",
    )
    shared.add_argument(
        "--skip-apk",
        action="store_true",
        help="不重新从 APK 提取（Assets 已有底座时）",
    )
    shared.add_argument(
        "--res",
        nargs="+",
        default=["main"],
        choices=list(RES_NAMES),
        help="热更分包，默认只 main（不加 audio/live2d）",
    )

    p = argparse.ArgumentParser(
        description=f"{GAME_TITLE} 资产还原 / Lua 反编译 / 立绘导出",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="示例:\n"
        "  python RevivedWitch.py status\n"
        "  python RevivedWitch.py assets --apk ./xx.apk\n"
        "  python RevivedWitch.py masterdata\n"
        "  python RevivedWitch.py painting\n"
        "  python RevivedWitch.py all --res main audio-zh_Hans\n",
    )
    sub = p.add_subparsers(dest="cmd", required=True)

    sub.add_parser("status", parents=[shared], help="APK/本地/远端版本与补丁体积")
    sub.add_parser("assets", parents=[shared], help="APK+热更 → Assets/")
    sub.add_parser(
        "masterdata",
        aliases=["data", "lua"],
        parents=[shared],
        help="unluac → MasterData/luacode（lua 即数据表）+ cfg 格式化",
    )
    paint = sub.add_parser(
        "painting",
        aliases=["portrait", "lihui"],
        parents=[shared],
        help="卡面立绘 → Painting/（复苏的魔女_角色_皮肤[_备注].png）",
    )
    paint.add_argument(
        "--out",
        type=Path,
        default=None,
        help=f"输出目录（默认 {PAINTING_DIR}）",
    )
    paint.add_argument("--limit", type=int, default=0, help="只处理前 N 个 bundle")
    sub.add_parser("all", parents=[shared], help="assets + masterdata")
    return p


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    apk = args.apk.resolve() if args.apk else None
    if args.cmd == "status":
        return cmd_status(apk)
    if args.cmd == "assets":
        return cmd_assets(
            apk,
            args.jobs,
            args.force,
            args.skip_download,
            list(args.res),
            skip_apk=args.skip_apk,
        )
    if args.cmd in {"masterdata", "data", "lua"}:
        return cmd_masterdata(args.jobs, args.force)
    if args.cmd in {"painting", "portrait", "lihui"}:
        return cmd_painting(
            args.jobs,
            args.force,
            limit=int(getattr(args, "limit", 0) or 0),
            out_dir=args.out.resolve() if getattr(args, "out", None) else None,
        )
    if args.cmd == "all":
        return cmd_all(
            apk,
            args.jobs,
            args.force,
            args.skip_download,
            list(args.res),
            skip_apk=args.skip_apk,
        )
    parser.error("unknown command")
    return 2


def _self_check() -> None:
    """ponytail: 最小自检——头修复 + 阿迦娜立绘命名。"""
    fixed = normalize_luac(OLD_LUA_HDR + b"\x00" * 8)
    assert fixed[:6] == NEW_LUA_HDR[:6], fixed[:20].hex()
    assert is_luac(OLD_LUA_HDR)
    assert not is_luajit(OLD_LUA_HDR)
    if (EXCELDATA / "role" / "cskin.lua").is_file():
        maps = load_painting_maps()
        ui = ASSETS_DIR / "ui"
        expect = {
            "imagesets.cards.card_037.assetbundle": ("阿迦娜", "初始"),
            "imagesets.cards.card_037b.assetbundle": ("阿迦娜", "突破造型"),
            "imagesets.cards.card_037v1.assetbundle": ("阿迦娜", "祝福的晚宴"),
        }
        for name, (cha, skin) in expect.items():
            p = ui / name
            if not p.is_file():
                continue
            got_cha, got_skin, _notes, hit = resolve_card_bundle(p, maps)
            assert hit and got_cha == cha and got_skin == skin, (
                name,
                got_cha,
                got_skin,
            )
    print("self-check ok")


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--self-check":
        _self_check()
        raise SystemExit(0)
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/]")
        raise SystemExit(130)
