from __future__ import annotations

import argparse
import hashlib
import json
import os
import subprocess
import sys
import threading
import time
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Tuple

import requests
from rich.console import Console
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
)
import PathToNowhereDecrypt
import PathToNowhereConvert
import PathToNowhereExtract

PLATFORM = "android"
RETRY_COUNT = 5
CHUNK_SIZE = 1024 * 1024
HERE = os.path.dirname(os.path.abspath(__file__))
UNLUAC_JAR = os.path.join(HERE, "unluac", "unluac-ptn.jar")

HARDCODED_CDN = [
    "https://xoneoversea-hotupdatecdn.shziyi.com",
    "https://xoneoversea-hotupdatecdn-backup.shziyi.com",
]

console = Console()
_ptn = None


def md5_file(path: str, chunk_size: int = 1 << 20) -> str:
    h = hashlib.md5()
    with open(path, "rb") as f:
        while True:
            b = f.read(chunk_size)
            if not b:
                break
            h.update(b)
    return h.hexdigest()


def load_json(path: str) -> Any:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def fetch_cdn_candidates(app_config: Dict[str, Any]) -> List[str]:
    url = app_config.get("SdkApiUrl", "").rstrip("/") + "/v1/kvgameconfigone"
    client_key = app_config.get("ClientKey", "")
    client_id = app_config.get("ClientId", "")
    ts = str(int(time.time()))
    params = {
        "key": app_config.get("CmsGameSetting", "cfg_game_settings_gl"),
        "timestamp": ts,
        "clientid": client_id,
        "sig": hashlib.md5((client_key + ts).encode()).hexdigest(),
        "lang": "zh",
    }
    try:
        r = requests.post(url, data=params, timeout=20)
        r.raise_for_status()
        body = r.json()
        if body.get("ret") != 0:
            console.print(f"[yellow][!] CMS ret={body.get('ret')}, 使用内置 CDN[/yellow]")
            return list(HARDCODED_CDN)
        settings = json.loads(body["value"]["value"])
        candidates = settings.get("CdnAddressCandidates") or []
        if candidates:
            return [str(c) for c in candidates]
    except Exception as e:
        console.print(f"[yellow][!] CMS 获取失败: {e}, 使用内置 CDN[/yellow]")
    return list(HARDCODED_CDN)


def build_root_path(app_config: Dict[str, Any], app_version: Dict[str, Any]) -> str:
    stream = app_config.get("Stream", "release-gl")
    tag = app_config.get("Tag", "major")
    ver = f"{app_version.get('Major', 1)}.{app_version.get('Minor', 9)}"
    return f"{stream}/{PLATFORM}/tags/{tag}/{ver}"


def build_ptn_items(
    cfg_dir: str,
    app_config: Dict[str, Any],
    app_version: Dict[str, Any],
    cdn: str,
    category: str,
) -> List[Dict[str, Any]]:
    root = build_root_path(app_config, app_version)
    items: List[Dict[str, Any]] = []

    def add(files: Iterable[Dict[str, Any]], subdir: str, url_path: Optional[str] = None):
        for f in files:
            rel = url_path or f"{subdir}/{f['Filename']}"
            items.append(
                {
                    "url": f"{cdn}/{root}/{rel}",
                    "dest": os.path.join(subdir, f["Filename"]),
                    "md5": f.get("FileMd5", f.get("Hash", "")),
                    "size": f.get("FileSize", f.get("Size", 0)),
                    "name": f["Filename"],
                }
            )

    if category in ("all", "chunk"):
        mani = load_json(os.path.join(cfg_dir, "res_chunk_manifest.json"))
        add(mani.get("ChunkPatches", []), "chunk")
    if category in ("all", "base"):
        base = load_json(os.path.join(cfg_dir, "res_base.json"))
        add(base, "base")
    if category in ("all", "classify"):
        classify = load_json(os.path.join(cfg_dir, "res_base_classify_chunk.json"))
        for key in ("BaseArtChunks", "BaseAudioChunks", "ExtraArtChunks", "ExtraAudioChunks"):
            for f in classify.get(key, []):
                rel = f"classify/{f.get('Version', 0)}/classify/{f['Filename']}"
                items.append(
                    {
                        "url": f"{cdn}/{root}/{rel}",
                        "dest": os.path.join("classify", f["Filename"]),
                        "md5": f.get("FileMd5", ""),
                        "size": f.get("FileSize", 0),
                        "name": f["Filename"],
                    }
                )
    return items


class AssetDownloader:
    def __init__(self, threads: int = 8, verify: bool = True, retries: int = RETRY_COUNT):
        self.threads = max(1, threads)
        self.verify = verify
        self.retries = retries
        self.session = requests.Session()
        self.session.headers.update(
            {
                "User-Agent": "UnityPlayer/2022.3.62f3 (UnityWebRequest/1.0, libcurl/7.84.0-DEV)",
                "X-Unity-Version": "2022.3.62f3",
            }
        )
        self._lock = threading.Lock()

    def download_all(self, items: List[Dict[str, Any]], outdir: str) -> Tuple[int, int]:
        os.makedirs(outdir, exist_ok=True)
        total_size = sum(int(i.get("size", 0)) for i in items)
        progress = Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.1f}%",
            "•",
            MofNCompleteColumn(),
            "•",
            TimeRemainingColumn(),
            console=console,
            transient=False,
        )
        ok = fail = 0
        with progress:
            task_bytes = progress.add_task("[cyan]下载字节", total=total_size or None)
            task_files = progress.add_task("[green]下载文件", total=len(items))
            done_bytes = 0

            def work(item: Dict[str, Any]) -> Tuple[bool, str]:
                dest = os.path.join(outdir, item["dest"])
                nonlocal done_bytes
                ok_ = self._download_one(
                    item["url"], dest, item.get("md5", ""), int(item.get("size", 0))
                )
                with self._lock:
                    if os.path.exists(dest):
                        done_bytes += os.path.getsize(dest)
                    progress.update(task_bytes, completed=done_bytes)
                    progress.update(task_files, advance=1)
                    progress.console.print(
                        f"{'[green][OK][/green]' if ok_ else '[red][FAIL][/red]'} {item['name']}"
                    )
                return ok_, item["name"]

            with ThreadPoolExecutor(max_workers=self.threads) as pool:
                futures = [pool.submit(work, it) for it in items]
                for fut in as_completed(futures):
                    try:
                        ok_, name = fut.result()
                    except Exception as e:
                        ok_ = False
                        name = str(e)
                        console.print(f"[red]任务异常: {e}[/red]")
                    if ok_:
                        ok += 1
                    else:
                        fail += 1
        console.print(f"[bold]完成: 成功 {ok}, 失败 {fail}[/bold]")
        return ok, fail

    def _download_one(
        self, url: str, dest: str, expected_md5: str, expected_size: int
    ) -> bool:
        d = os.path.dirname(dest)
        if d:
            os.makedirs(d, exist_ok=True)
        for attempt in range(self.retries):
            try:
                initial = 0
                mode = "wb"
                headers = {}
                if os.path.exists(dest):
                    cur = os.path.getsize(dest)
                    if expected_size and cur == expected_size:
                        if not self.verify or not expected_md5 or md5_file(dest) == expected_md5:
                            return True
                        os.remove(dest)
                    elif cur > 0 and (not expected_size or cur < expected_size):
                        initial = cur
                        headers["Range"] = f"bytes={cur}-"
                        mode = "ab"
                    else:
                        os.remove(dest)
                r = self.session.get(url, headers=headers, stream=True, timeout=30)
                if r.status_code == 206:
                    mode = "ab"
                elif r.status_code == 200:
                    mode = "wb"
                    initial = 0
                else:
                    r.raise_for_status()
                with open(dest, mode) as f:
                    if initial == 0:
                        f.seek(0)
                        f.truncate()
                    for chunk in r.iter_content(CHUNK_SIZE):
                        if chunk:
                            f.write(chunk)
                if expected_size and os.path.getsize(dest) != expected_size:
                    raise ValueError(
                        f"size {os.path.getsize(dest)} != {expected_size}"
                    )
                if self.verify and expected_md5 and md5_file(dest) != expected_md5:
                    raise ValueError("md5 mismatch")
                return True
            except Exception as e:
                if attempt == self.retries - 1:
                    console.print(f"[red]下载失败 {url}: {e}[/red]")
                else:
                    time.sleep(1 + attempt)
        return False


def find_apk(explicit: Optional[str]) -> Optional[str]:
    if explicit:
        return explicit
    apks = sorted(Path(HERE).glob("*.apk"))
    return str(apks[0]) if apks else None


def collect_blocks_dirs(
    game_dir: str, out_dir: str, apk: Optional[str], apk_only: bool = False
) -> List[str]:
    dirs = []
    if not apk_only:
        downloaded = os.path.join(out_dir, "decrypted_assets", "assets", "blocks")
        if os.path.isdir(downloaded) and any(Path(downloaded).glob("*/*.bundle")):
            dirs.append(downloaded)
        local = os.path.join(game_dir, "assets", "blocks")
        if os.path.isdir(local) and any(Path(local).glob("*/*.bundle")):
            dirs.append(local)
    if apk and os.path.isfile(apk):
        apk_blocks = os.path.join(out_dir, "apk_blocks")
        os.makedirs(apk_blocks, exist_ok=True)
        with zipfile.ZipFile(apk) as z:
            n = 0
            for info in z.infolist():
                if info.filename.startswith("assets/blocks/") and info.filename.endswith(".bundle"):
                    target = os.path.join(apk_blocks, info.filename[len("assets/blocks/"):])
                    os.makedirs(os.path.dirname(target), exist_ok=True)
                    with z.open(info) as src, open(target, "wb") as dst:
                        dst.write(src.read())
                    n += 1
        console.print(f"[green]APK 提取 blocks: {n} 个 -> {apk_blocks}[/green]")
        dirs.append(apk_blocks)
    return dirs


def decrypt_downloaded_chunks(
    cfg_dir: str, chunk_dir: str, out_dir: str
) -> int:
    mani = load_json(os.path.join(cfg_dir, "res_chunk_manifest.json"))
    entries_by_chunk: Dict[int, List[Dict[str, Any]]] = {}
    for e in mani["Entries"]:
        entries_by_chunk.setdefault(e["ChunkIndex"], []).append(e)
    for lst in entries_by_chunk.values():
        lst.sort(key=lambda e: e["Offset"])

    decrypted_root = os.path.join(out_dir, "decrypted_assets")
    chunk_files = sorted(
        f for f in os.listdir(chunk_dir) if f.startswith("res_") and f.endswith(".bin")
    )
    if not chunk_files:
        console.print("[yellow]chunk 目录没有 res_*.bin, 跳过解密[/yellow]")
        return 0

    sys.path.insert(0, os.path.dirname(cfg_dir))
    n_ok = 0
    for idx, cp in enumerate(mani["ChunkPatches"]):
        if cp["Filename"] not in chunk_files:
            continue
        chunk_path = os.path.join(chunk_dir, cp["Filename"])
        buf = open(chunk_path, "rb").read()
        try:
            entries = PathToNowhereDecrypt.walk_entries(buf)
        except Exception as e:
            console.print(f"[red]chunk 解析失败 {cp['Filename']}: {e}[/red]")
            continue
        n_entries = 0
        for e, (pos, size, j) in zip(entries_by_chunk.get(idx, []), entries):
            if e["Offset"] != pos:
                console.print(f"[yellow]offset 不匹配 {cp['Filename']} {e['Offset']} != {pos}[/yellow]")
                continue
            pay_key = PathToNowhereDecrypt.ASSET_KEY[j] ^ PathToNowhereDecrypt.ASSET_KEY[(j + 1) % 32]
            payload = bytes(b ^ pay_key for b in buf[pos + 50 : pos + 50 + e["Length"]])
            dest = os.path.join(decrypted_root, e["Path"].lstrip("/"))
            os.makedirs(os.path.dirname(dest), exist_ok=True)
            with open(dest, "wb") as f:
                f.write(payload)
            n_entries += 1
        n_ok += 1
        console.print(f"[green][解密][/green] {cp['Filename']}: {n_entries} 个 bundle -> decrypted_assets/")
    console.print(f"[bold]解密完成: {n_ok}/{len(chunk_files)} 个 chunk[/bold]")
    return n_ok


def find_slice_entries(data: bytes):
    entries = []
    n = len(data)
    pos = 0
    while pos < n:
        end = data.find(b"\x00", pos, pos + 100)
        if end < 0 or end - pos < 4:
            break
        path = data[pos:end].decode("ascii", "replace")
        if "/" not in path or not all(32 <= c < 127 for c in path.encode()):
            break
        if data[pos + 100 : pos + 104] != b"664\x00":
            break
        entries.append((pos, path))
        region_start = pos + 0x200
        cand = (region_start + 0x1FF) & ~0x1FF
        nxt = n
        while cand + 0x200 <= n:
            e = data.find(b"\x00", cand, cand + 100)
            if e - cand >= 4 and "/" in data[cand:e].decode("ascii", "replace") and \
                    data[cand + 100 : cand + 104] == b"664\x00":
                magic = data[cand + 0x200 : cand + 0x204]
                if magic[:4] in (b"BKHD", b"RIFF", b"Unity", b"\x1bLua") or \
                        any(PathToNowhereDecrypt.try_entry_header(data, cand + 0x200, PathToNowhereDecrypt.ASSET_KEY[j]) for j in range(32)):
                    nxt = cand
                    break
            cand += 0x200
        pos = nxt
    return entries


def extract_slice_file(data: bytes, src_name: str, out_root: str) -> int:
    entries = find_slice_entries(data)
    count = 0
    for i, (pos, path) in enumerate(entries):
        region_start = pos + 0x200
        region_end = entries[i + 1][0] if i + 1 < len(entries) else len(data)
        blob = data[region_start:region_end]
        dest = os.path.join(out_root, path.lstrip("/"))
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        j0 = None
        entry_size = 0
        for j in range(32):
            s = PathToNowhereDecrypt.try_entry_header(blob, 0, PathToNowhereDecrypt.ASSET_KEY[j])
            if s is not None:
                j0, entry_size = j, s
                break
        if blob[:4] in (b"BKHD", b"RIFF", b"UnityFS", b"\x1bLua") or j0 is None:
            size = len(blob)
            if blob[:4] == b"RIFF" and len(blob) >= 8:
                size = min(size, struct_unpack(blob[4:8]) + 8)
            elif blob[:4] == b"BKHD":
                off = 0
                while off + 8 <= len(blob):
                    tag = blob[off : off + 4]
                    if not all(32 <= c < 127 for c in tag):
                        break
                    sz = struct_unpack(blob[off + 4 : off + 8])
                    if off + 8 + sz > len(blob):
                        break
                    off += 8 + sz
                size = min(size, off)
            with open(dest, "wb") as f:
                f.write(blob[:size])
        else:
            pk = PathToNowhereDecrypt.ASSET_KEY[j0] ^ PathToNowhereDecrypt.ASSET_KEY[(j0 + 1) % 32]
            payload = bytes(b ^ pk for b in blob[50 : entry_size])
            with open(dest, "wb") as f:
                f.write(payload)
        count += 1
    return count


def extract_slices(out_dir: str) -> int:
    slices = []
    for sub in ("base", "classify"):
        d = os.path.join(out_dir, sub)
        if os.path.isdir(d):
            slices += [os.path.join(d, f) for f in sorted(os.listdir(d)) if f.endswith(".slice")]
    if not slices:
        console.print("[yellow]没有下载 .slice, 跳过[/yellow]")
        return 0
    total = 0
    for sp in slices:
        with open(sp, "rb") as f:
            data = f.read()
        try:
            n = extract_slice_file(data, os.path.basename(sp), os.path.join(out_dir, "slice_extracted"))
        except Exception as e:
            console.print(f"[red]slice 提取失败 {os.path.basename(sp)}: {e}[/red]")
            continue
        total += n
        console.print(f"[green][slice][/green] {os.path.basename(sp)}: {n} 个文件 -> slice_extracted/")
    console.print(f"[bold]slice 提取完成: {len(slices)} 个包, {total} 个文件[/bold]")
    return total


def struct_unpack(b: bytes) -> int:
    import struct
    return struct.unpack("<I", b)[0]


def _lua_stem(name: str) -> str:
    if name.endswith(".lua54"):
        name = name[:-6]
    if name.endswith(".luac"):
        name = name[:-5]
    return name


def convert_batch(lua_scripts_dir: str, luac_dir: str, keep_opcodes: bool) -> Tuple[int, int]:
    os.makedirs(luac_dir, exist_ok=True)
    ok = fail = 0
    for p in sorted(Path(lua_scripts_dir).glob("*.luac")):
        try:
            PathToNowhereConvert.convert(
                str(p), os.path.join(luac_dir, p.name + ".lua54"), keep_opcodes=keep_opcodes
            )
            ok += 1
        except Exception as e:
            fail += 1
            console.print(f"[red]转换失败 {p.name}: {e}[/red]")
    label = "lua54_ptn" if keep_opcodes else "lua54"
    console.print(f"[green]{label}: 成功 {ok}, 失败 {fail} -> {luac_dir}[/green]")
    return ok, fail


def write_source_map(lua_scripts_dir: str, dest_dir: str) -> None:
    src_map: Dict[str, str] = {}
    for p in sorted(Path(lua_scripts_dir).glob("*.luac")):
        try:
            _, main, _ = PathToNowhereConvert.decode_chunk(p.read_bytes())
            src = (main.source or b"").rstrip(b"\x00").decode("utf-8", "replace")
            src_map[p.name] = src
        except Exception:
            pass
    map_path = os.path.join(dest_dir, "_source_paths.json")
    with open(map_path, "w", encoding="utf-8") as f:
        json.dump(src_map, f, ensure_ascii=False, indent=1)
    console.print(f"[green]source 映射: {len(src_map)} 条 -> {map_path}[/green]")


def decompile_ptn(luac_dir: str, lua_dir: str, jar: str, threads: int = 8) -> Tuple[int, int]:
    if not os.path.isfile(jar):
        console.print(f"[red]找不到 unluac jar: {jar}[/red]")
        return 0, 0
    os.makedirs(lua_dir, exist_ok=True)
    files = sorted(p for p in Path(luac_dir).glob("*.lua54") if p.name != "_source_paths.json")
    if not files:
        console.print(f"[yellow]没有可反编译的 .lua54: {luac_dir}[/yellow]")
        return 0, 0

    def one(src: Path) -> Tuple[str, bool, str]:
        dst = os.path.join(lua_dir, _lua_stem(src.name) + ".lua")
        try:
            r = subprocess.run(
                ["java", "-Xmx1g", "-jar", jar, "--ptn", "--rawstring", "--output", dst, str(src)],
                capture_output=True,
                text=True,
                timeout=120,
            )
        except subprocess.TimeoutExpired:
            return src.name, False, "TIMEOUT"
        if r.returncode == 0 and os.path.isfile(dst) and os.path.getsize(dst) > 0:
            return src.name, True, ""
        if os.path.isfile(dst):
            try:
                os.remove(dst)
            except OSError:
                pass
        err = ""
        for line in (r.stderr or "").splitlines():
            if "Exception" in line:
                err = line.replace('Exception in thread "main" ', "")[:120]
                break
        return src.name, False, err or (r.stderr or "empty")[:120]

    ok = fail = 0
    err_counts: Dict[str, int] = {}
    workers = max(1, threads)
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("unluac --ptn", total=len(files))
        with ThreadPoolExecutor(max_workers=workers) as pool:
            futs = [pool.submit(one, p) for p in files]
            for fut in as_completed(futs):
                name, success, err = fut.result()
                if success:
                    ok += 1
                else:
                    fail += 1
                    key = (err.split(":")[0] if err else "fail")[:80]
                    err_counts[key] = err_counts.get(key, 0) + 1
                progress.advance(task)
    console.print(f"[green]unluac: 成功 {ok}, 失败 {fail} -> {lua_dir}[/green]")
    for msg, n in sorted(err_counts.items(), key=lambda kv: -kv[1])[:8]:
        console.print(f"  [yellow]{n}x[/yellow] {msg}")
    return ok, fail


def convert_lua_to_luac(
    game_dir: str,
    out_dir: str,
    apk: Optional[str] = None,
    apk_only: bool = False,
    to_luac: bool = True,
    to_lua: bool = False,
    unluac_jar: str = UNLUAC_JAR,
    threads: int = 8,
) -> None:
    if not apk_only and not os.path.isdir(game_dir):
        console.print(f"[red]game-dir 不存在: {game_dir}[/red]")
        return
    lua_scripts_dir = os.path.join(out_dir, "lua_scripts")
    os.makedirs(lua_scripts_dir, exist_ok=True)
    blocks_dirs = collect_blocks_dirs(game_dir, out_dir, apk, apk_only=apk_only)
    if not blocks_dirs:
        console.print("[yellow]未找到任何 assets/blocks 源[/yellow]")
        return
    n_pkg = n_files = 0
    seen = set()
    for blocks_dir in blocks_dirs:
        for p in sorted(Path(blocks_dir).glob("*/*.bundle")):
            key = p.name
            if key in seen:
                continue
            seen.add(key)
            data = p.read_bytes()
            pt = bytes(b ^ 0x65 for b in data)
            lua_files = PathToNowhereExtract.parse_pkg(pt)
            if lua_files is None:
                continue
            n_pkg += 1
            prefix = f"{p.parent.name}_{p.stem[:8]}"
            for i, bc in lua_files:
                ext = ".lua" if bc[:1] in (b"\n", b"-", b"--") else ".luac"
                (Path(lua_scripts_dir) / f"{prefix}_{i}{ext}").write_bytes(bc)
                n_files += 1
    console.print(f"[green]Lua 包: {n_pkg}, 文件: {n_files} -> {lua_scripts_dir}[/green]")

    if to_luac:
        luac_dir = os.path.join(out_dir, "lua54")
        convert_batch(lua_scripts_dir, luac_dir, keep_opcodes=False)
        write_source_map(lua_scripts_dir, luac_dir)

    if to_lua:
        ptn_dir = os.path.join(out_dir, "lua54_ptn")
        convert_batch(lua_scripts_dir, ptn_dir, keep_opcodes=True)
        write_source_map(lua_scripts_dir, ptn_dir)
        decompile_ptn(ptn_dir, os.path.join(out_dir, "lua"), unluac_jar, threads=threads)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--game-dir", default="/home/rikka/Games/无期迷途", help="游戏工作目录 (含 decrypted_cfg/ 与解密脚本)")
    ap.add_argument("--config-dir", default=None, help="解密配置目录, 默认 <game-dir>/decrypted_cfg")
    ap.add_argument("--outdir", default="downloads", help="下载 / 提取输出目录")
    ap.add_argument("--category", choices=["all", "chunk", "base", "classify"], default="all")
    ap.add_argument("--cdn-base", default=None, help="覆盖 CDN 地址")
    ap.add_argument("--threads", type=int, default=8)
    ap.add_argument("--limit", type=int, default=0, help="只下载前 N 个文件 (测试用)")
    ap.add_argument("--dry-run", action="store_true", help="只打印清单")
    ap.add_argument("--no-verify", action="store_true", help="跳过 MD5 校验")
    ap.add_argument("--skip-download", action="store_true", help="不拉 CDN，只做解密/提取/反编译")
    ap.add_argument("--to-luac", action="store_true", help="把 Lua 转成标准 5.4 luac (lua54/)")
    ap.add_argument("--to-lua", action="store_true", help="保留 88 槽编号并用 unluac-ptn.jar --ptn 反编译 (lua/)")
    ap.add_argument("--unluac-jar", default=UNLUAC_JAR, help="unluac jar 路径")
    ap.add_argument("--no-decrypt", action="store_true", help="下载后不解密 chunk")
    ap.add_argument("--no-slice", action="store_true", help="下载后不提取 slice")
    ap.add_argument("--apk", default=None, help="APK 路径；省略时使用本目录下第一个 .apk")
    ap.add_argument("--apk-only", action="store_true", help="只从 APK 抽 Lua，不用 game-dir / 已下载 chunk")
    args = ap.parse_args()

    apk = find_apk(args.apk)
    if (args.to_luac or args.to_lua) and apk:
        console.print(f"[cyan]APK: {apk}[/cyan]")

    if not args.skip_download:
        cfg_dir = args.config_dir or os.path.join(args.game_dir, "decrypted_cfg")
        app_config = load_json(os.path.join(cfg_dir, "app_config.json"))
        app_version = load_json(os.path.join(args.game_dir, "assets", "app_version.json"))
        cdn = args.cdn_base or fetch_cdn_candidates(app_config)[0]
        console.print(f"[cyan]CDN: {cdn}[/cyan]")
        items = build_ptn_items(cfg_dir, app_config, app_version, cdn, args.category)

        if args.limit > 0:
            items = items[: args.limit]
        total = sum(int(i.get("size", 0)) for i in items)
        console.print(f"[cyan]下载清单: {len(items)} 个文件, {total/1024**3:.2f} GiB[/cyan]")
        if args.dry_run:
            for it in items[:30]:
                console.print(f"  {it['name']:48s} {int(it['size'])/1024**2:9.1f} MiB  {it['url']}")
            if len(items) > 30:
                console.print(f"  ... 共 {len(items)} 个")
            return

        dl = AssetDownloader(threads=args.threads, verify=not args.no_verify)
        dl.download_all(items, args.outdir)

        if not args.no_decrypt:
            decrypt_downloaded_chunks(cfg_dir, os.path.join(args.outdir, "chunk"), args.outdir)

        if not args.no_slice:
            extract_slices(args.outdir)
    elif args.dry_run:
        console.print("[cyan]--skip-download: 无下载清单[/cyan]")
        return

    if args.to_luac or args.to_lua:
        convert_lua_to_luac(
            args.game_dir,
            args.outdir,
            apk,
            apk_only=args.apk_only,
            to_luac=args.to_luac,
            to_lua=args.to_lua,
            unluac_jar=args.unluac_jar,
            threads=args.threads,
        )


if __name__ == "__main__":
    main()
