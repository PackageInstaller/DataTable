from __future__ import annotations

import argparse
import json
import re
import shutil
import struct
import subprocess
import sys
import tempfile
import threading
import time
import urllib.request
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Iterable

from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TaskID,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "YooAsset"))
from yooasset import deserialize_from_bytes  # noqa: E402
from yooasset.extractor import convert_bundle_name_to_path  # noqa: E402

console = Console()

DEFAULT_CDN = "https://newseer.61.com/Assets/"
PLATFORM = "StandaloneWindows64"
PACKAGES = (
    "StartupPackage",
    "DefaultPackage",
    "ConfigPackage",
    "PetAnimPackage",
    "FollowPackage",
)
PAINTING_PACKAGES = ("DefaultPackage", "ConfigPackage")
PAINTING_PATH_MARKERS = (
    "/art/ui/assets/pet/body/",
    "pgame/configs/bytes",
    "game/configs/bytes",
)

GAME_TITLE = "赛尔号"
UNITY_FALLBACK = "2022.3.51f1"
BODY_DIR = Path("defaultpackage/assets/art/ui/assets/pet/body")
CONFIG_BUNDLE = Path("pgame/configs/bytes.bundle")
DLL_REL = Path("Game/Dll/GameLogic.dll.bytes")
CS_DIR = ROOT / "cs" / "GameLogic"
MASTER_DIR = ROOT / "MasterData"
PAINTING_DIR = ROOT / "Painting"
SKIN_ID_BASE = 1_400_000
INVALID_FS = re.compile(r'[\\/:*?"<>|\x00-\x1f]')

try:
    import UnityPy

    UnityPy.config.FALLBACK_UNITY_VERSION = UNITY_FALLBACK
except ImportError:
    UnityPy = None  # type: ignore



@dataclass(frozen=True)
class Job:
    url: str
    dest: Path
    size: int
    kind: str
    file_hash: str = ""


def package_host(cdn: str, package: str) -> str:
    return f"{cdn.rstrip('/')}/{PLATFORM}/{package}"


def logical_relpath(bundle, asset_paths: list[str]) -> str:
    if len(asset_paths) == 1 and asset_paths[0]:
        p = asset_paths[0].replace("\\", "/")
    else:
        p = convert_bundle_name_to_path(bundle.bundle_name).replace("\\", "/")
        if not Path(p).suffix:
            p = f"{p}.bundle"
    if p.startswith("Assets/"):
        p = p[len("Assets/") :]
    return p


def ensure_parent(dest: Path) -> None:
    parent = dest.parent
    parts = list(parent.parts)
    for i in range(1, len(parts) + 1):
        cur = Path(*parts[:i])
        if cur.exists() and cur.is_file():
            bumped = cur.with_name(cur.name + ".bundle")
            if not bumped.exists():
                cur.rename(bumped)
            else:
                cur.unlink()
    parent.mkdir(parents=True, exist_ok=True)


def fetch_bytes(url: str, timeout: int = 60) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": "Seer/1.0"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()


def fetch_text(url: str, timeout: int = 30) -> str:
    return fetch_bytes(url, timeout=timeout).decode("utf-8").strip()


def is_painting_rel(rel: str, asset_paths: list[str]) -> bool:
    keys = [rel.replace("\\", "/").lower()]
    keys.extend(p.replace("\\", "/").lower() for p in asset_paths if p)
    return any(any(m in k for m in PAINTING_PATH_MARKERS) for k in keys)


def collect_jobs(
    cdn: str, out_root: Path, packages: list[str], painting: bool = False
) -> list[Job]:
    jobs: list[Job] = []
    for pkg in packages:
        host = package_host(cdn, pkg)
        meta_dir = out_root / "_yoo" / pkg
        meta_dir.mkdir(parents=True, exist_ok=True)
        version = fetch_text(f"{host}/PackageManifest_{pkg}.version")
        console.print(f"[cyan]{pkg}[/] version={version}")
        for name in (
            f"PackageManifest_{pkg}.version",
            f"PackageManifest_{pkg}_{version}.hash",
            f"PackageManifest_{pkg}_{version}.bytes",
        ):
            jobs.append(Job(f"{host}/{name}", meta_dir / name, 0, "meta"))
        manifest = fetch_bytes(f"{host}/PackageManifest_{pkg}_{version}.bytes")
        (meta_dir / f"PackageManifest_{pkg}_{version}.bytes").write_bytes(manifest)
        (meta_dir / f"PackageManifest_{pkg}.version").write_text(version, encoding="utf-8")
        try:
            h = fetch_text(f"{host}/PackageManifest_{pkg}_{version}.hash")
            (meta_dir / f"PackageManifest_{pkg}_{version}.hash").write_text(h, encoding="utf-8")
        except Exception:
            pass
        parsed = deserialize_from_bytes(manifest)
        assert parsed.package_name == pkg, (parsed.package_name, pkg)
        by_bid: dict[int, list[str]] = defaultdict(list)
        for a in parsed.asset_list:
            by_bid[a.bundle_id].append(a.asset_path)
        kept = kept_size = 0
        for i, b in enumerate(parsed.bundle_list):
            paths = by_bid.get(i, [])
            rel = logical_relpath(b, paths)
            if painting and not is_painting_rel(rel, paths):
                continue
            jobs.append(
                Job(f"{host}/{b.file_hash}", out_root / rel, int(b.file_size), "bundle", b.file_hash)
            )
            kept += 1
            kept_size += int(b.file_size)
        console.print(
            f"  bundles={kept}/{len(parsed.bundle_list)} "
            f"size={kept_size / 1024 / 1024:.1f}MB"
            + (" [painting]" if painting else "")
        )
    return jobs


def migrate_hash_layout(out_root: Path) -> int:
    legacy = out_root / PLATFORM
    if not legacy.is_dir():
        return 0
    moved = 0
    for pkg_dir in legacy.iterdir():
        if not pkg_dir.is_dir():
            continue
        manifests = list(pkg_dir.glob("PackageManifest_*.bytes"))
        if not manifests:
            continue
        parsed = deserialize_from_bytes(manifests[0].read_bytes())
        by_bid: dict[int, list[str]] = defaultdict(list)
        for a in parsed.asset_list:
            by_bid[a.bundle_id].append(a.asset_path)
        hash_map = {
            b.file_hash: logical_relpath(b, by_bid.get(i, []))
            for i, b in enumerate(parsed.bundle_list)
        }
        for f in pkg_dir.iterdir():
            if not f.is_file() or f.name.startswith("PackageManifest"):
                continue
            rel = hash_map.get(f.name)
            if not rel:
                continue
            dest = out_root / rel
            if dest.exists() and dest.stat().st_size == f.stat().st_size:
                f.unlink()
                moved += 1
                continue
            ensure_parent(dest)
            if dest.exists():
                dest.unlink()
            shutil.move(str(f), str(dest))
            moved += 1
        meta = out_root / "_yoo" / pkg_dir.name
        meta.mkdir(parents=True, exist_ok=True)
        for f in pkg_dir.glob("PackageManifest*"):
            shutil.move(str(f), str(meta / f.name))
    if legacy.is_dir():
        shutil.rmtree(legacy, ignore_errors=True)
    return moved


def file_ok(path: Path, size: int) -> bool:
    if not path.is_file():
        return False
    if size > 0:
        return path.stat().st_size == size
    return path.stat().st_size > 0


def download_one(
    job: Job, progress: Progress, task: TaskID, lock: threading.Lock, retries: int, timeout: int
) -> str:
    dest, part = job.dest, Path(str(job.dest) + ".part")
    if file_ok(dest, job.size):
        with lock:
            progress.reset(task, total=max(job.size, 1), completed=max(job.size, 1))
        return "skip"
    ensure_parent(dest)
    existing = part.stat().st_size if part.is_file() else 0
    if job.size > 0 and existing > job.size:
        part.unlink(missing_ok=True)
        existing = 0
    last_err: Exception | None = None
    for attempt in range(1, retries + 1):
        try:
            headers = {"User-Agent": "Seer/1.0"}
            mode, pos = "ab", existing
            if pos > 0:
                headers["Range"] = f"bytes={pos}-"
            req = urllib.request.Request(job.url, headers=headers)
            with urllib.request.urlopen(req, timeout=timeout) as resp:
                if pos > 0 and resp.status == 200:
                    pos, mode = 0, "wb"
                total = job.size
                cl = resp.headers.get("Content-Length")
                if total <= 0 and cl:
                    total = pos + int(cl)
                with lock:
                    progress.reset(task, total=max(total, 1), completed=pos)
                with open(part, mode) as f:
                    while True:
                        chunk = resp.read(1024 * 256)
                        if not chunk:
                            break
                        f.write(chunk)
                        pos += len(chunk)
                        with lock:
                            progress.update(task, completed=pos)
            got = part.stat().st_size
            if job.size > 0 and got != job.size:
                raise IOError(f"size mismatch {got} != {job.size}")
            part.replace(dest)
            return "ok"
        except Exception as e:
            last_err = e
            existing = part.stat().st_size if part.is_file() else 0
            time.sleep(min(2 ** (attempt - 1), 8))
    raise RuntimeError(f"{job.url} -> {dest} failed after {retries}: {last_err}")


def run_download(
    cdn: str,
    out: Path,
    packages: list[str],
    workers: int,
    retries: int,
    timeout: int,
    painting: bool = False,
) -> None:
    out.mkdir(parents=True, exist_ok=True)
    n = migrate_hash_layout(out)
    if n:
        console.print(f"[yellow]migrated {n} hash-named files -> logical paths[/]")
    console.print(f"CDN={cdn} out={out}" + (" mode=painting" if painting else ""))
    jobs = collect_jobs(cdn, out, packages, painting=painting)
    pending = [j for j in jobs if not file_ok(j.dest, j.size)]
    console.print(f"jobs={len(jobs)} pending={len(pending)} workers={workers}")
    ok = skip = fail = 0
    errors: list[str] = []
    lock = threading.Lock()
    with Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        overall = progress.add_task("overall", total=len(jobs), completed=len(jobs) - len(pending))

        def work(job: Job) -> tuple[str, Job, str | None]:
            label = job.dest.name[:24] if job.dest.name else job.file_hash[:12]
            tid = progress.add_task(label, total=max(job.size, 1))
            try:
                return download_one(job, progress, tid, lock, retries, timeout), job, None
            except Exception as e:
                return "fail", job, str(e)
            finally:
                progress.remove_task(tid)

        with ThreadPoolExecutor(max_workers=workers) as pool:
            futs = [pool.submit(work, j) for j in pending]
            for fut in as_completed(futs):
                status, job, err = fut.result()
                if status == "ok":
                    ok += 1
                elif status == "skip":
                    skip += 1
                else:
                    fail += 1
                    errors.append(f"{job.dest}: {err}")
                progress.advance(overall)
    skip += len(jobs) - len(pending)
    summary = {"ok": ok, "skip": skip, "fail": fail, "total": len(jobs)}
    (out / "download_summary.json").write_text(json.dumps(summary, indent=2), encoding="utf-8")
    console.print(summary)
    if errors:
        console.print("[red]failures:[/]")
        for e in errors[:20]:
            console.print(f"  {e}")
        raise SystemExit(1)



def which(cmd: str) -> str | None:
    return shutil.which(cmd)


def ensure_game_dlls(
    assets: Path,
    cdn: str = DEFAULT_CDN,
    retries: int = 5,
    timeout: int = 120,
    skip_download: bool = False,
    names: tuple[str, ...] = ("GameLogic.dll.bytes", "Core.dll.bytes"),
) -> Path:
    """确保 Game/Dll 与 CDN DefaultPackage 版本一致；缺或过期则重拉。"""
    dll_dir = assets / "Game" / "Dll"
    pkg = "DefaultPackage"
    meta_dir = assets / "_yoo" / pkg
    local_ver_path = meta_dir / f"PackageManifest_{pkg}.version"
    need = [n for n in names if not (dll_dir / n).is_file() or (dll_dir / n).stat().st_size <= 0]

    remote_ver = None
    if not skip_download:
        try:
            remote_ver = fetch_text(f"{package_host(cdn, pkg)}/PackageManifest_{pkg}.version")
            local_ver = local_ver_path.read_text(encoding="utf-8").strip() if local_ver_path.is_file() else ""
            if remote_ver and remote_ver != local_ver:
                console.print(
                    f"[cyan]DefaultPackage[/] {local_ver or '?'} → {remote_ver}，刷新 Game/Dll"
                )
                need = list(names)
                if dll_dir.is_dir():
                    for p in dll_dir.iterdir():
                        if p.is_file():
                            p.unlink()
        except Exception as e:
            if need:
                raise
            console.print(f"[yellow]无法检查 DefaultPackage 版本，沿用本地 DLL[/] ({e})")

    if not need:
        return dll_dir / "GameLogic.dll.bytes"
    if skip_download:
        raise FileNotFoundError(dll_dir / need[0])

    console.print(f"[cyan]缺少 {', '.join(need)}，从 DefaultPackage 拉取 Game/Dll[/]")
    host = package_host(cdn, pkg)
    meta_dir.mkdir(parents=True, exist_ok=True)
    version = remote_ver or fetch_text(f"{host}/PackageManifest_{pkg}.version")
    mani_name = f"PackageManifest_{pkg}_{version}.bytes"
    manifest = fetch_bytes(f"{host}/{mani_name}")
    (meta_dir / mani_name).write_bytes(manifest)
    local_ver_path.write_text(version, encoding="utf-8")

    parsed = deserialize_from_bytes(manifest)
    by_bid: dict[int, list[str]] = defaultdict(list)
    for a in parsed.asset_list:
        by_bid[a.bundle_id].append(a.asset_path)

    jobs: list[Job] = []
    for i, b in enumerate(parsed.bundle_list):
        paths = by_bid.get(i, [])
        rel = logical_relpath(b, paths).replace("\\", "/")
        low = rel.lower()
        if "/game/dll/" not in low and not any(
            "/game/dll/" in (p or "").replace("\\", "/").lower() for p in paths
        ):
            continue
        jobs.append(
            Job(f"{host}/{b.file_hash}", assets / rel, int(b.file_size), "bundle", b.file_hash)
        )
    if not jobs:
        raise FileNotFoundError("DefaultPackage 清单中无 Game/Dll")

    pending = [j for j in jobs if not file_ok(j.dest, j.size)]
    console.print(f"  Game/Dll jobs={len(jobs)} pending={len(pending)}")
    lock = threading.Lock()
    with Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        overall = progress.add_task("Game/Dll", total=len(jobs), completed=len(jobs) - len(pending))
        for job in pending:
            tid = progress.add_task(job.dest.name[:24], total=max(job.size, 1))
            try:
                download_one(job, progress, tid, lock, retries, timeout)
            finally:
                progress.remove_task(tid)
            progress.advance(overall)

    dest = dll_dir / "GameLogic.dll.bytes"
    if not dest.is_file():
        raise FileNotFoundError(dest)
    console.print(f"[green]GameLogic[/] {dest.stat().st_size / 1024 / 1024:.1f}MB")
    return dest


def ensure_game_logic_dll(
    assets: Path,
    cdn: str = DEFAULT_CDN,
    retries: int = 5,
    timeout: int = 120,
    skip_download: bool = False,
) -> Path:
    return ensure_game_dlls(
        assets, cdn=cdn, retries=retries, timeout=timeout, skip_download=skip_download
    )


def cmd_decompile(
    force: bool = False,
    assets: Path | None = None,
    cdn: str = DEFAULT_CDN,
    skip_download: bool = False,
) -> Path:
    """ilspycmd -p 反编译 GameLogic，只保留 core.config* 到 cs/GameLogic。"""
    if CS_DIR.is_dir() and any(CS_DIR.glob("core.config*")) and not force:
        n = sum(1 for _ in CS_DIR.rglob("*.cs"))
        console.print(f"[cyan]decompile[/] 已有 {n} 个 C# @ {CS_DIR}")
        return CS_DIR
    ilspy = which("ilspycmd")
    if not ilspy:
        raise SystemExit("需要 ilspycmd（dotnet tool）")
    assets = (assets or (ROOT / "Assets")).resolve()
    dll = ensure_game_logic_dll(assets, cdn=cdn, skip_download=skip_download)
    tmp = Path(tempfile.mkdtemp(prefix="seer_ilspy_"))
    try:
        console.print(f"[cyan]ilspycmd -p[/] {dll.name} …")
        subprocess.check_call([ilspy, "-p", "-o", str(tmp), str(dll)])
        if CS_DIR.exists():
            shutil.rmtree(CS_DIR)
        CS_DIR.mkdir(parents=True)
        n = 0
        for p in tmp.iterdir():
            if p.name.startswith("core.config"):
                dest = CS_DIR / p.name
                if p.is_dir():
                    shutil.copytree(p, dest)
                else:
                    shutil.copy2(p, dest)
                n += 1
        console.print(f"[green]decompile[/] {n} 个 core.config* → {CS_DIR}")
    finally:
        shutil.rmtree(tmp, ignore_errors=True)
    return CS_DIR


class Buf:
    __slots__ = ("b", "i")

    def __init__(self, b: bytes):
        self.b = b
        self.i = 0

    def i32(self) -> int:
        v = struct.unpack_from("<i", self.b, self.i)[0]
        self.i += 4
        return v

    def u32(self) -> int:
        v = struct.unpack_from("<I", self.b, self.i)[0]
        self.i += 4
        return v

    def i16(self) -> int:
        v = struct.unpack_from("<h", self.b, self.i)[0]
        self.i += 2
        return v

    def u16(self) -> int:
        v = struct.unpack_from("<H", self.b, self.i)[0]
        self.i += 2
        return v

    def u8(self) -> int:
        v = self.b[self.i]
        self.i += 1
        return v

    def bool(self) -> bool:
        return self.u8() != 0

    def f32(self) -> float:
        v = struct.unpack_from("<f", self.b, self.i)[0]
        self.i += 4
        return v

    def i64(self) -> int:
        v = struct.unpack_from("<q", self.b, self.i)[0]
        self.i += 8
        return v

    def utf(self, n: int | None = None) -> str:
        if n is None:
            n = self.u16()
        s = self.b[self.i : self.i + n].decode("utf-8", "replace")
        self.i += n
        return s


def _match_brace(s: str, open_idx: int) -> int:
    depth = 0
    for j in range(open_idx, len(s)):
        if s[j] == "{":
            depth += 1
        elif s[j] == "}":
            depth -= 1
            if depth == 0:
                return j
    return -1


def _method_body(src: str, pat: str) -> str | None:
    m = re.search(pat, src)
    if not m:
        return None
    i = m.end() - 1
    j = _match_brace(src, i)
    return src[i + 1 : j] if j >= 0 else None


def _strip_comments(s: str) -> str:
    s = re.sub(r"//.*?$", "", s, flags=re.M)
    return re.sub(r"/\*.*?\*/", "", s, flags=re.S)


_LEN_COND = re.compile(
    r"if\s*\(\s*(?:"
    r"\w+\s*\+\s*\d+\s*[<>]=?\s*bytes\.Length|"
    r"\w+\s*[<>]=?\s*bytes\.Length|"
    r"bytes\.Length\s*[<>]=?\s*\w+"
    r")\s*\)\s*",
    re.S,
)


def _preprocess(body: str, style: str) -> str:
    body = _strip_comments(body)
    # b = ReadBoolean; if (b) → if (ReadBoolean)
    body = re.sub(
        r"(\w+)\s*=\s*ByteUtil\.ReadBoolean\(bytes,\s*ref\s*\w+\);\s*"
        r"if\s*\(\s*\1\s*\)",
        "if (ByteUtil.ReadBoolean(bytes, ref byteIndex))",
        body,
    )
    if style != "bc":
        return body
    body = re.sub(r"byteIndex\s*=\s*\w+\s*;", "", body)
    changed = True
    while changed:
        changed = False
        for m in _LEN_COND.finditer(body):
            if m.end() >= len(body) or body[m.end()] != "{":
                continue
            j = _match_brace(body, m.end())
            if j < 0:
                continue
            inner = body[m.end() + 1 : j].strip()
            if re.fullmatch(r"return;", inner) or "bytes.Length" in m.group(0):
                body = body[: m.start()] + ("" if re.fullmatch(r"return;", inner) else inner) + body[j + 1 :]
                changed = True
                break
    return body


def _detect_style(body: str) -> str:
    if "ByteUtil." in body:
        return "bu"
    if "BitConverter." in body or "bytes[" in body:
        return "bc"
    return "bu"


def _parse_ops(body: str, style: str) -> list[tuple] | None:
    body = _preprocess(body, style)
    ops: list[tuple] = []
    safety = 0
    while body.strip() and safety < 12000:
        safety += 1
        body = body.lstrip()
        if not body:
            break
        if body[0] in "};":
            body = body[1:]
            continue
        m = re.match(
            r"else\s*\{\s*@?\w+\s*=\s*string\.Empty;\s*\}",
            body,
            re.S,
        )
        if m:
            body = body[m.end() :]
            continue
        if re.match(r"int\s+\w+\s*=\s*\w+\s*;", body):
            body = body[re.match(r"int\s+\w+\s*=\s*\w+\s*;", body).end() :]
            continue
        if re.match(r"byteIndex\w*\s*=\s*\w+\s*;", body):
            body = body[re.match(r"byteIndex\w*\s*=\s*\w+\s*;", body).end() :]
            continue

        if style == "bu":
            hit = False
            m = re.match(
                r"this\.(\w+)\s*=\s*ByteUtil\.ReadSignedInt\(bytes,\s*ref\s*\w+\);",
                body,
            )
            if m:
                ops.append(("i32", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"if\s*\(\s*ByteUtil\.ReadBoolean\(bytes,\s*ref\s*\w+\)\s*\)\s*\{\s*"
                r"int\s+\w+\s*=\s*ByteUtil\.ReadSignedInt\(bytes,\s*ref\s*\w+\);\s*"
                r"this\.(\w+)\s*=\s*new\s+int\s*\[\s*\w+\s*\]\s*;\s*"
                r"for\s*\([^)]+\)\s*\{\s*"
                r"this\.\1\[\w+\]\s*=\s*ByteUtil\.ReadSignedInt\(bytes,\s*ref\s*\w+\);\s*"
                r"\}\s*\}",
                body,
                re.S,
            )
            if m:
                ops.append(("opt_i32_arr", m.group(1)))
                body = body[m.end() :]
                continue
            for kind, pat in (
                ("utf", r"@?(\w+)\s*=\s*ByteUtil\.ReadUTFByte\(bytes,\s*\(int\)ByteUtil\.ReadUnsignedShort\(bytes,\s*ref\s*\w+\),\s*ref\s*\w+\);"),
                ("i32", r"@?(\w+)\s*=\s*ByteUtil\.ReadSignedInt\(bytes,\s*ref\s*\w+\);"),
                ("u32", r"@?(\w+)\s*=\s*ByteUtil\.ReadUnsignedInt\(bytes,\s*ref\s*\w+\);"),
                ("i16", r"@?(\w+)\s*=\s*ByteUtil\.ReadSignedShort\(bytes,\s*ref\s*\w+\);"),
                ("u16v", r"@?(\w+)\s*=\s*ByteUtil\.ReadUnsignedShort\(bytes,\s*ref\s*\w+\);"),
                ("bool_f", r"@?(\w+)\s*=\s*ByteUtil\.ReadBoolean\(bytes,\s*ref\s*\w+\);"),
                ("f32", r"@?(\w+)\s*=\s*ByteUtil\.ReadFloat\(bytes,\s*ref\s*\w+\);"),
                ("i64", r"@?(\w+)\s*=\s*ByteUtil\.ReadLong\(bytes,\s*ref\s*\w+\);"),
                ("u8", r"@?(\w+)\s*=\s*ByteUtil\.ReadUnsignedByte\(bytes,\s*ref\s*\w+\);"),
                ("i8", r"@?(\w+)\s*=\s*ByteUtil\.ReadSignedByte\(bytes,\s*ref\s*\w+\);"),
            ):
                m = re.match(pat, body)
                if m:
                    ops.append((kind, m.group(1)))
                    body = body[m.end() :]
                    hit = True
                    break
            if hit:
                continue
            m = re.match(
                r"if\s*\(\s*ByteUtil\.ReadBoolean\(bytes,\s*ref\s*\w+\)\s*\)\s*\{\s*"
                r"int\s+\w+\s*=\s*ByteUtil\.ReadSignedInt\(bytes,\s*ref\s*\w+\);\s*"
                r"(\w+)\s*=\s*new\s+int\s*\[\s*\w+\s*\]\s*;\s*"
                r"for\s*\([^)]+\)\s*\{\s*"
                r"\1\[\w+\]\s*=\s*ByteUtil\.ReadSignedInt\(bytes,\s*ref\s*\w+\);\s*"
                r"\}\s*\}",
                body,
                re.S,
            )
            if m:
                ops.append(("opt_i32_arr", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"if\s*\(\s*ByteUtil\.ReadBoolean\(bytes,\s*ref\s*\w+\)\s*\)\s*\{\s*"
                r"int\s+\w+\s*=\s*ByteUtil\.ReadSignedInt\(bytes,\s*ref\s*\w+\);\s*"
                r"@?(\w+)\s*=\s*new\s+string\s*\[\s*\w+\s*\]\s*;\s*"
                r"for\s*\([^)]+\)\s*\{\s*"
                r"@?\1\[\w+\]\s*=\s*ByteUtil\.ReadUTFByte\(bytes,\s*\(int\)ByteUtil\.ReadUnsignedShort\(bytes,\s*ref\s*\w+\),\s*ref\s*\w+\);\s*"
                r"\}\s*\}",
                body,
                re.S,
            )
            if m:
                ops.append(("opt_str_arr", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"if\s*\(\s*ByteUtil\.ReadBoolean\(bytes,\s*ref\s*\w+\)\s*\)\s*\{\s*"
                r"int\s+\w+\s*=\s*ByteUtil\.ReadSignedInt\(bytes,\s*ref\s*\w+\);\s*"
                r"(\w+)\s*=\s*new\s+(\w+)\s*\[\s*\w+\s*\]\s*;\s*"
                r"for\s*\([^)]+\)\s*\{\s*"
                r"\1\[\w+\]\s*=\s*new\s+\2\(\);\s*"
                r"\1\[\w+\]\.Parse\(bytes,\s*ref\s*\w+\);\s*"
                r"\}\s*\}",
                body,
                re.S,
            )
            if m:
                ops.append(("opt_arr", m.group(1), m.group(2)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"if\s*\(\s*ByteUtil\.ReadBoolean\(bytes,\s*ref\s*\w+\)\s*\)\s*\{\s*"
                r"(\w+)\s*=\s*new\s+(\w+)\(\);\s*"
                r"\1\.Parse\(bytes,\s*ref\s*\w+\);\s*"
                r"\}",
                body,
                re.S,
            )
            if m:
                ops.append(("opt_obj", m.group(1), m.group(2)))
                body = body[m.end() :]
                continue
        else:
            m = re.match(r"(\w+)\s*=\s*BitConverter\.ToInt32\(bytes,\s*\w+\);\s*\w+\s*\+=\s*4;", body)
            if m:
                ops.append(("i32", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(r"(\w+)\s*=\s*BitConverter\.ToSingle\(bytes,\s*\w+\);\s*\w+\s*\+=\s*4;", body)
            if m:
                ops.append(("f32", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(r"(\w+)\s*=\s*BitConverter\.ToInt16\(bytes,\s*\w+\);\s*\w+\s*\+=\s*2;", body)
            if m:
                ops.append(("i16", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(r"(\w+)\s*=\s*BitConverter\.ToInt64\(bytes,\s*\w+\);\s*\w+\s*\+=\s*8;", body)
            if m:
                ops.append(("i64", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"(?:ushort|int)\s+\w+\s*=\s*BitConverter\.ToUInt16\(bytes,\s*\w+\);\s*\w+\s*\+=\s*2;\s*"
                r"if\s*\(\s*\w+\s*>\s*0\s*(?:&&[^)]*)?\)\s*\{\s*"
                r"@?(\w+)\s*=\s*Encoding\.UTF8\.GetString\(bytes,\s*\w+,\s*\w+\);\s*\w+\s*\+=\s*\w+;\s*"
                r"\}\s*(?:else\s*\{\s*@?\1\s*=\s*string\.Empty;\s*\})?",
                body,
                re.S,
            )
            if m:
                ops.append(("utf", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"(?:ushort|int)\s+\w+\s*=\s*BitConverter\.ToUInt16\(bytes,\s*\w+\);\s*\w+\s*\+=\s*2;\s*"
                r"@?(\w+)\s*=\s*Encoding\.UTF8\.GetString\(bytes,\s*\w+,\s*\w+\);\s*\w+\s*\+=\s*\w+;\s*"
                r"(?:else\s*\{\s*@?\1\s*=\s*string\.Empty;\s*\})?",
                body,
                re.S,
            )
            if m:
                ops.append(("utf", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"if\s*\(\s*bytes\[\w+\+\+\]\s*!=\s*0\s*\)\s*\{\s*"
                r"int\s+\w+\s*=\s*BitConverter\.ToInt32\(bytes,\s*\w+\);\s*\w+\s*\+=\s*4;\s*"
                r"(?:if\s*\([^)]*\)\s*\{\s*)?"
                r"(\w+)\s*=\s*new\s+int\s*\[\s*\w+\s*\]\s*;\s*"
                r"Buffer\.BlockCopy\(bytes,\s*\w+,\s*\1,\s*0,\s*\w+\s*\*\s*4\);\s*"
                r"\w+\s*\+=\s*\w+\s*\*\s*4;\s*"
                r"(?:\}\s*)?"
                r"\}",
                body,
                re.S,
            )
            if m:
                ops.append(("opt_i32_arr", m.group(1)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"if\s*\(\s*bytes\[\w+\+\+\]\s*!=\s*0\s*\)\s*\{\s*"
                r"int\s+\w+\s*=\s*BitConverter\.ToInt32\(bytes,\s*\w+\);\s*\w+\s*\+=\s*4;\s*"
                r"(?:if\s*\(\s*\w+\s*>\s*0\s*\)\s*\{\s*)?"
                r"(\w+)\s*=\s*new\s+(\w+)\s*\[\s*\w+\s*\]\s*;\s*"
                r"for\s*\([^)]+\)\s*\{\s*"
                r"\1\[\w+\]\s*=\s*new\s+\2\(\);\s*"
                r"\1\[\w+\]\.Parse\(bytes,\s*ref\s*\w+\);\s*"
                r"\}\s*"
                r"(?:\}\s*)?"
                r"\}",
                body,
                re.S,
            )
            if m:
                ops.append(("opt_arr", m.group(1), m.group(2)))
                body = body[m.end() :]
                continue
            m = re.match(
                r"if\s*\(\s*bytes\[\w+\+\+\]\s*!=\s*0\s*\)\s*\{\s*"
                r"(\w+)\s*=\s*new\s+(\w+)\(\);\s*"
                r"\1\.Parse\(bytes,\s*ref\s*\w+\);\s*"
                r"\}",
                body,
                re.S,
            )
            if m:
                ops.append(("opt_obj", m.group(1), m.group(2)))
                body = body[m.end() :]
                continue
        return None
    return ops


class SchemaIndex:
    def __init__(self, cs_root: Path):
        self.cs_root = cs_root
        self.by_name: dict[str, list[tuple[str, Path]]] = defaultdict(list)
        self.file_roots: dict[str, tuple[str, str]] = {}  # fileName -> (ns, type)
        self._cache: dict[tuple[str, str], Any] = {}
        for p in cs_root.rglob("*.cs"):
            ns = p.parent.name
            if not ns.startswith("core.config"):
                continue
            self.by_name[p.stem].append((ns, p))
            src = p.read_text(encoding="utf-8", errors="replace")
            m = re.search(r'fileName\s*=>\s*"([^"]+)"', src)
            if m and _method_body(src, r"public void Parse\(byte\[\] bytes, ref int \w+\)\s*\{"):
                self.file_roots.setdefault(m.group(1), (ns, p.stem))

    def resolve(self, short: str, cur_ns: str) -> tuple[str, Path]:
        short = short.split(".")[-1]
        cands = self.by_name.get(short, [])
        if not cands:
            raise KeyError(short)
        for ns, p in cands:
            if ns == cur_ns:
                return ns, p
        for ns, p in cands:
            if ns.startswith(cur_ns) or cur_ns.startswith(ns):
                return ns, p
        return cands[0]

    def schema(self, ns: str, name: str):
        key = (ns, name)
        if key in self._cache:
            return self._cache[key]
        ns, path = self.resolve(name, ns)
        ns = path.parent.name
        src = path.read_text(encoding="utf-8", errors="replace")
        body = _method_body(src, r"public void Parse\(byte\[\] bytes, ref int \w+\)\s*\{")
        if not body:
            self._cache[key] = None
            return None
        style = _detect_style(body)
        ops = _parse_ops(body, style)
        if ops is None:
            raise RuntimeError(f"无法解析 Parse: {ns}.{name}")
        sch = (style, ops, ns)
        self._cache[key] = sch
        self._cache[(ns, name)] = sch
        return sch

    def exec_schema(self, r: Buf, sch) -> dict:
        _style, ops, ns = sch
        obj: dict[str, Any] = {}
        for op in ops:
            k = op[0]
            if k == "i32":
                obj[op[1]] = r.i32()
            elif k == "u32":
                obj[op[1]] = r.u32()
            elif k == "i16":
                obj[op[1]] = r.i16()
            elif k == "u16v":
                obj[op[1]] = r.u16()
            elif k == "u8":
                obj[op[1]] = r.u8()
            elif k == "i8":
                v = r.u8()
                obj[op[1]] = v - 256 if v > 127 else v
            elif k == "f32":
                obj[op[1]] = r.f32()
            elif k == "i64":
                obj[op[1]] = r.i64()
            elif k == "bool_f":
                obj[op[1]] = r.bool()
            elif k == "utf":
                obj[op[1]] = r.utf()
            elif k == "opt_obj":
                if r.bool():
                    tns, _ = self.resolve(op[2], ns)
                    obj[op[1]] = self.exec_schema(r, self.schema(tns, op[2]))
                else:
                    obj[op[1]] = None
            elif k == "opt_arr":
                if r.bool():
                    n = r.i32()
                    tns, _ = self.resolve(op[2], ns)
                    ch = self.schema(tns, op[2])
                    obj[op[1]] = [self.exec_schema(r, ch) for _ in range(max(n, 0))]
                else:
                    obj[op[1]] = None
            elif k == "opt_i32_arr":
                if r.bool():
                    n = r.i32()
                    obj[op[1]] = [r.i32() for _ in range(max(n, 0))]
                else:
                    obj[op[1]] = None
            elif k == "opt_str_arr":
                if r.bool():
                    n = r.i32()
                    obj[op[1]] = [r.utf() for _ in range(max(n, 0))]
                else:
                    obj[op[1]] = None
            else:
                raise RuntimeError(op)
        return obj


def textasset_map(bundle: Path) -> dict[str, bytes]:
    if UnityPy is None:
        raise SystemExit("需要 UnityPy")
    env = UnityPy.load(str(bundle))
    out: dict[str, bytes] = {}
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        d = obj.read()
        script = d.m_Script
        if isinstance(script, bytes):
            raw = script
        elif isinstance(script, str):
            raw = script.encode("utf-8", "surrogateescape")
        else:
            raw = bytes(script)
        out[d.m_Name] = raw
    return out


def normalize_root_json(data: dict) -> dict:
    """XlsConfig 的 data 字段改名为 Items，与常见 MasterData 一致。"""
    if set(data.keys()) == {"data"} and isinstance(data["data"], list):
        return {"Items": data["data"]}
    return data


DUMP_CS = ROOT / "SeerMasterDataDump.cs"
DUMP_EXE = ROOT / "SeerMasterDataDump.exe"
UNITY_DLL_DIR = ROOT / "dll"


def compile_masterdata_dumper() -> Path:
    mcs = which("mcs") or which("csc")
    if not mcs:
        raise SystemExit("需要 mcs/csc（mono）以编译配表导出器")
    if DUMP_EXE.is_file() and DUMP_EXE.stat().st_mtime >= DUMP_CS.stat().st_mtime:
        return DUMP_EXE
    console.print(f"[cyan]编译[/] {DUMP_CS.name}")
    subprocess.check_call([mcs, str(DUMP_CS), f"-out:{DUMP_EXE}", "-r:System.Core"], cwd=str(ROOT))
    return DUMP_EXE


def cmd_masterdata(
    assets: Path,
    out_dir: Path,
    force_decompile: bool = False,
    cdn: str = DEFAULT_CDN,
    skip_download: bool = False,
) -> None:
    """用 mono 反射调用 GameLogic.Parse 导出 MasterData（比手写 schema 稳）。"""
    del force_decompile  # 保留参数兼容 CLI；masterdata 不再依赖 ilspycmd schema
    mono = which("mono")
    if not mono:
        raise SystemExit("需要 mono")
    ensure_game_dlls(assets, cdn=cdn, skip_download=skip_download)

    cfg = assets / CONFIG_BUNDLE
    if not cfg.is_file():
        if skip_download:
            raise FileNotFoundError(cfg)
        console.print("[cyan]缺少配置，补下 ConfigPackage[/]")
        run_download(cdn, assets, ["ConfigPackage"], 8, 5, 120, painting=True)

    if UnityPy is None:
        raise SystemExit("需要 UnityPy")

    raw_tmp = Path(tempfile.mkdtemp(prefix="seer_cfg_"))
    try:
        tables = textasset_map(cfg)
        console.print(f"[cyan]配表[/] {len(tables)} 个 TextAsset")
        for name, raw in tables.items():
            (raw_tmp / f"{name}.bin").write_bytes(raw)

        exe = compile_masterdata_dumper()
        dll_dir = assets / "Game" / "Dll"
        cmd = [mono, str(exe), str(dll_dir), str(raw_tmp), str(out_dir)]
        if UNITY_DLL_DIR.is_dir():
            cmd.append(str(UNITY_DLL_DIR))
        out_dir.mkdir(parents=True, exist_ok=True)
        console.print("[cyan]mono 反射 Parse -> JSON[/]")
        proc = subprocess.Popen(
            cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1
        )
        ok = fail = 0
        assert proc.stdout is not None
        for line in proc.stdout:
            line = line.rstrip()
            if line.startswith("OK "):
                ok += 1
                if ok <= 5 or ok % 50 == 0:
                    console.print(f"  [green]{line}[/]")
            elif line.startswith("FAIL "):
                fail += 1
                console.print(f"  [red]{line}[/]")
            elif line.startswith("roots ") or line.startswith("ok="):
                console.print(f"  {line}")
        rc = proc.wait()
        n = len(list(out_dir.glob("*.json")))
        console.print({"ok": ok, "fail": fail, "json": n, "out": str(out_dir), "rc": rc})
        if ok == 0:
            raise SystemExit(1)
    finally:
        shutil.rmtree(raw_tmp, ignore_errors=True)


def sanitize_filename(name: str) -> str:
    name = INVALID_FS.sub("_", (name or "").strip()).rstrip(".")
    return name or "unnamed"


@dataclass
class SkinRow:
    sid: int
    mon_id: int
    name: str
    typ: int
    years: list[int] = field(default_factory=list)
    kind_skin_types: list[int] = field(default_factory=list)
    body_id: int = 0
    exclusive: bool = False


def _load_naming_from_master(master: Path) -> tuple[dict, dict, dict] | None:
    mp, sp, tp = master / "monsters.json", master / "pet_skin.json", master / "pet_skin_rewardtype.json"
    if not (mp.is_file() and sp.is_file() and tp.is_file()):
        return None
    monsters = json.loads(mp.read_text(encoding="utf-8"))
    skins_j = json.loads(sp.read_text(encoding="utf-8"))
    types_j = json.loads(tp.read_text(encoding="utf-8"))
    mons: dict[int, dict] = {}
    for it in monsters.get("Monsters", {}).get("Monster") or []:
        mons[int(it["ID"])] = {"id": int(it["ID"]), "name": (it.get("DefName") or "").strip(), "real": int(it.get("RealId") or 0)}
    types = {int(it["type"]): (it.get("name") or "").strip() for it in types_j.get("Items") or []}
    by_body: dict[int, SkinRow] = {}
    for it in skins_j.get("PetSkins", {}).get("Skin") or []:
        sid = int(it["ID"])
        cand = SKIN_ID_BASE + sid
        real = mons[cand]["real"] if cand in mons and mons[cand]["real"] > 0 else cand
        years, kinds = [], []
        for k in it.get("SkinKind") or []:
            if int(k.get("Year") or 0) > 0:
                years.append(int(k["Year"]))
            if int(k.get("SkinType") or 0) > 0:
                kinds.append(int(k["SkinType"]))
        row = SkinRow(
            sid=sid,
            mon_id=int(it.get("MonID") or 0),
            name=(it.get("Name") or "").strip(),
            typ=int(it.get("Type") or 0),
            years=years,
            kind_skin_types=kinds,
            body_id=real,
            exclusive=real == cand or real >= SKIN_ID_BASE,
        )
        if row.exclusive:
            by_body.setdefault(row.body_id, row)
    return mons, by_body, types


def _load_naming_from_schema(assets: Path) -> tuple[dict, dict, dict]:
    """无 MasterData 时现场用 mono 导出后再读。"""
    cmd_masterdata(assets, MASTER_DIR, skip_download=False)
    hit = _load_naming_from_master(MASTER_DIR)
    if not hit:
        raise RuntimeError("MasterData 导出后仍缺少 monsters/pet_skin/pet_skin_rewardtype")
    return hit


def load_naming(assets: Path, master: Path) -> tuple[dict, dict, dict]:
    hit = _load_naming_from_master(master)
    if hit:
        console.print(f"[cyan]命名[/] 来自 {master}")
        return hit
    console.print("[cyan]命名[/] 现场导出 MasterData")
    return _load_naming_from_schema(assets)


def name_parts(tex_id: int, mons: dict, skins: dict, types: dict) -> list[str]:
    skin = skins.get(tex_id)
    if skin is not None:
        hero = (mons.get(skin.mon_id) or {}).get("name") or str(skin.mon_id)
        variant = skin.name or f"皮肤{skin.sid}"
        remarks: list[str] = []
        if skin.typ and types.get(skin.typ):
            remarks.append(types[skin.typ])
        for st in skin.kind_skin_types:
            label = types.get(st)
            if label and label not in remarks:
                remarks.append(label)
        for y in skin.years:
            ys = str(y)
            if ys not in remarks:
                remarks.append(ys)
        return [hero, variant, *remarks]
    mon = mons.get(tex_id)
    if mon is not None:
        return [mon["name"] or str(tex_id), "默认"]
    return [str(tex_id), "未知"]


def painting_dest(parts: Iterable[str], used: set[str], out_dir: Path) -> Path:
    stems = [sanitize_filename(p) for p in parts if p]
    base = f"{GAME_TITLE}_{'_'.join(stems)}"
    n = 1
    while True:
        name = f"{base}.png" if n == 1 else f"{base}_{n}.png"
        if name not in used:
            used.add(name)
            return out_dir / name
        n += 1


def iter_body_textures(body_dir: Path):
    for path in sorted(p for p in body_dir.iterdir() if p.is_file() and not p.name.endswith(".part")):
        try:
            env = UnityPy.load(str(path))
        except Exception as e:
            console.print(f"[yellow]跳过[/] {path.name}: {e}")
            continue
        for obj in env.objects:
            if obj.type.name != "Texture2D":
                continue
            try:
                tex = obj.read()
            except Exception:
                continue
            name = (tex.m_Name or "").strip()
            if not name.isdigit():
                continue
            img = getattr(tex, "image", None)
            if img is None:
                continue
            yield int(name), img, path.name


def cmd_painting(
    assets: Path,
    out_dir: Path,
    master: Path,
    workers: int,
    force: bool,
    limit: int,
    skip_download: bool,
) -> None:
    body = assets / BODY_DIR
    cfg = assets / CONFIG_BUNDLE
    if not skip_download and (not body.is_dir() or not any(body.iterdir()) or not cfg.is_file()):
        console.print("[cyan]立绘资产缺失，painting 模式补下[/]")
        run_download(DEFAULT_CDN, assets, list(PAINTING_PACKAGES), workers, 5, 120, painting=True)
    mons, skins, types = load_naming(assets, master)
    console.print(f"[cyan]配表[/] monsters={len(mons)} exclusive_skins={len(skins)} types={len(types)}")
    out_dir.mkdir(parents=True, exist_ok=True)
    used: set[str] = set()
    items = list(iter_body_textures(body))
    if limit > 0:
        items = items[:limit]
    ok = skip = fail = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出立绘", total=len(items))
        for tex_id, img, _src in items:
            dest = painting_dest(name_parts(tex_id, mons, skins, types), used, out_dir)
            if dest.is_file() and not force:
                skip += 1
                progress.advance(task)
                continue
            try:
                img.save(str(dest))
                ok += 1
            except Exception as e:
                fail += 1
                console.print(f"[red]fail[/] {tex_id}: {e}")
            progress.advance(task)
    console.print({"ok": ok, "skip": skip, "fail": fail, "out": str(out_dir)})
    if fail:
        raise SystemExit(1)



def cmd_status(assets: Path) -> None:
    console.print(f"ROOT={ROOT}")
    console.print(f"Assets body={ (assets/BODY_DIR).is_dir() } config={ (assets/CONFIG_BUNDLE).is_file() }")
    console.print(f"cs/GameLogic={CS_DIR.is_dir()} files={sum(1 for _ in CS_DIR.rglob('*.cs')) if CS_DIR.is_dir() else 0}")
    console.print(f"MasterData={sum(1 for _ in MASTER_DIR.glob('*.json')) if MASTER_DIR.is_dir() else 0}")
    console.print(f"Painting={sum(1 for _ in PAINTING_DIR.glob('*.png')) if PAINTING_DIR.is_dir() else 0}")


def cmd_self_check(assets: Path) -> None:
    cmd_masterdata(assets, MASTER_DIR, skip_download=False)
    reward = json.loads((MASTER_DIR / "pet_skin_rewardtype.json").read_text(encoding="utf-8"))
    assert reward["Items"][0]["name"] == "巅峰时装", reward["Items"][0]
    skin = json.loads((MASTER_DIR / "pet_skin.json").read_text(encoding="utf-8"))
    assert skin["PetSkins"]["Skin"][0]["Name"].startswith("漆墨白羽"), skin["PetSkins"]["Skin"][0]
    mons = json.loads((MASTER_DIR / "monsters.json").read_text(encoding="utf-8"))
    first = mons["Monsters"]["Monster"][0]
    assert first["DefName"] == "布布种子" and first["ID"] == 1, first
    # GameLogic 与 ConfigPackage 版本对齐后，C# Parse 可写出（含 showmonster 可选数组）
    sign = json.loads((MASTER_DIR / "signIcon_fight.json").read_text(encoding="utf-8"))
    assert len(sign["config"]["item"]) == 205 and sign["config"]["item"][0]["dec"] == "抗性"
    console.print("[green]self-check ok[/]")


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    ap.add_argument(
        "cmd",
        nargs="?",
        default="all",
        choices=("all", "assets", "decompile", "masterdata", "painting", "status"),
        help="默认 all= masterdata+painting（不下全量资产）; assets 全量/过滤下载",
    )
    ap.add_argument("--cdn", default=DEFAULT_CDN)
    ap.add_argument("-o", "--assets", type=Path, default=ROOT / "Assets")
    ap.add_argument("-j", "--workers", type=int, default=8)
    ap.add_argument("--retries", type=int, default=5)
    ap.add_argument("--timeout", type=int, default=120)
    ap.add_argument("--packages", nargs="+", default=None)
    ap.add_argument("--painting-dl", action="store_true", help="assets 时只下 body+配置")
    ap.add_argument("--skip-download", action="store_true")
    ap.add_argument("--force", action="store_true", help="覆盖 / 强制反编译")
    ap.add_argument("--limit", type=int, default=0, help="立绘只导出前 N 张")
    ap.add_argument("--master-dir", type=Path, default=MASTER_DIR)
    ap.add_argument("--painting-dir", type=Path, default=PAINTING_DIR)
    ap.add_argument("--self-check", action="store_true")
    args = ap.parse_args(argv)

    assets = args.assets.resolve()
    if args.self_check:
        cmd_self_check(assets)
        return 0
    if args.cmd == "status":
        cmd_status(assets)
        return 0
    if args.cmd == "decompile":
        cmd_decompile(
            force=args.force,
            assets=assets,
            cdn=args.cdn,
            skip_download=args.skip_download,
        )
        return 0
    if args.cmd == "assets":
        pkgs = args.packages or list(PAINTING_PACKAGES if args.painting_dl else PACKAGES)
        run_download(
            args.cdn, assets, pkgs, args.workers, args.retries, args.timeout, painting=args.painting_dl
        )
        return 0
    if args.cmd == "masterdata":
        cmd_masterdata(
            assets,
            args.master_dir.resolve(),
            force_decompile=args.force,
            cdn=args.cdn,
            skip_download=args.skip_download,
        )
        return 0
    if args.cmd == "painting":
        cmd_painting(
            assets,
            args.painting_dir.resolve(),
            args.master_dir.resolve(),
            args.workers,
            args.force,
            args.limit,
            args.skip_download,
        )
        return 0
    if not args.skip_download:
        need = not (assets / CONFIG_BUNDLE).is_file() or not (assets / BODY_DIR).is_dir()
        if need:
            run_download(
                args.cdn, assets, list(PAINTING_PACKAGES), args.workers, args.retries, args.timeout, True
            )
    cmd_masterdata(
        assets,
        args.master_dir.resolve(),
        force_decompile=args.force,
        cdn=args.cdn,
        skip_download=args.skip_download,
    )
    cmd_painting(
        assets,
        args.painting_dir.resolve(),
        args.master_dir.resolve(),
        args.workers,
        args.force,
        args.limit,
        skip_download=True,
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/]")
        raise SystemExit(130)
