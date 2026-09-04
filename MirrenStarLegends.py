from __future__ import annotations

import argparse
import json
import re
import shutil
import struct
import sys
import threading
import zipfile
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
    TimeRemainingColumn,
    TransferSpeedColumn,
)


ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
PAINTING_DIR = ROOT / "Painting"
CACHE_DIR = ROOT / ".cache"

CDN_BASE = "https://qnzlcdn.duolehuyu.com.cn/chdl"
ZONE_CONFIG_URL = f"{CDN_BASE}/ZoneConfig_10"
PLATFORM = "android"
CONFIGS_DIR = ASSETS_DIR / "configs"
GAME_TITLE = "千年之旅"
LIHUI_DIR = ASSETS_DIR / "ui" / "texture" / "lihui"

TABLE_XOR_KEY = b"ryrs"
BUNDLE_XOR_BYTE = 0x7B
BUNDLE_XOR_LEN = 1000

HTTP_HEADERS = {
    "User-Agent": "UnityPlayer/2019.4.40f1 (UnityWebRequest/1.0, libcurl/7.52.0-DEV)",
    "Accept": "*/*",
    "X-Unity-Version": "2019.4.40f1",
}
CHUNK = 1 << 20
RETRY = 3
DEFAULT_JOBS = 8

DEFAULT_PREFIXES = (
    "Table/",
    "dll/",
    "configs/",
    "common/",
    "ui/texture/lihui/",
    "StreamingAssets",
    "filelist.txt",
    "firstfile.txt",
)

_SKIN_CATEGORY_NOTES = {
    "温泉",
    "泳装",
    "泳装皮",
    "万圣节",
    "圣诞节",
    "和风床照",
    "床照",
    "婚纱",
    "女仆",
    "旗袍",
    "兔女郎",
    "魔女",
    "睡衣",
    "炼金",
    "ol",
}

console = Console()
_tls = threading.local()


def format_size(n: int) -> str:
    size = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{n} B"


def session() -> requests.Session:
    s = getattr(_tls, "session", None)
    if s is None:
        s = requests.Session()
        s.headers.update(HTTP_HEADERS)
        _tls.session = s
    return s


def http_get(url: str, timeout: int = 60, stream: bool = False) -> requests.Response:
    last: Exception | None = None
    for i in range(RETRY):
        try:
            r = session().get(url, timeout=timeout, stream=stream)
            r.raise_for_status()
            return r
        except Exception as exc:  # noqa: BLE001
            last = exc
            if i + 1 < RETRY:
                continue
    assert last is not None
    raise last


def find_apk(explicit: str | None = None) -> Path:
    if explicit:
        p = Path(explicit)
        if not p.is_file():
            raise FileNotFoundError(p)
        return p
    cands = sorted(ROOT.glob("*.apk"), key=lambda p: p.stat().st_mtime, reverse=True)
    if not cands:
        raise FileNotFoundError("目录下没有 .apk，请用 --apk 指定")
    return cands[0]



def xor_repeating(data: bytes, key: bytes) -> bytes:
    if not data or not key:
        return data
    kl = len(key)
    return bytes(b ^ key[i % kl] for i, b in enumerate(data))


def decrypt_table_or_dll(data: bytes) -> bytes:
    """CryptoUtils.DecryptRaw(bytes, \"ryrs\")。"""
    return xor_repeating(data, TABLE_XOR_KEY)


def decrypt_bundle(data: bytes) -> bytes:
    """ResUtils.Encrypt(bytes, 0x7B)"""
    out = bytearray(data)
    n = min(BUNDLE_XOR_LEN, len(out))
    for i in range(n):
        out[i] ^= BUNDLE_XOR_BYTE
    return bytes(out)


def is_unity_fs(data: bytes) -> bool:
    return data.startswith(b"UnityFS")


def looks_encrypted_bundle(data: bytes) -> bool:
    if len(data) < 7:
        return False
    if is_unity_fs(data):
        return False
    return bytes(b ^ BUNDLE_XOR_BYTE for b in data[:7]) == b"UnityFS"


def looks_plain_table(data: bytes) -> bool:
    if len(data) < 8:
        return False
    row_count, col_count = struct.unpack_from("<II", data, 0)
    if not (1 <= row_count <= 200_000 and 1 <= col_count <= 512):
        return False
    try:
        DotNetBinaryReader(data).parse_table()
        return True
    except Exception:
        return False


def decrypt_asset_file(path: Path, inplace: bool = True) -> str:
    """按后缀/魔数解密单个资产。返回 skip|bundle|ryrs|plain。"""
    data = path.read_bytes()
    name = path.name.lower()
    suffix = path.suffix.lower()

    if suffix == ".data" or looks_encrypted_bundle(data):
        if is_unity_fs(data):
            return "plain"
        if not looks_encrypted_bundle(data):
            return "skip"
        plain = decrypt_bundle(data)
        if not is_unity_fs(plain):
            return "skip"
        if inplace:
            path.write_bytes(plain)
        return "bundle"

    if suffix in (".txt", ".bytes") or name.endswith(".dll.bytes") or name.endswith(
        ".pdb.bytes"
    ):
        if data[:2] == b"MZ":
            return "plain"
        if suffix == ".txt" and looks_plain_table(data):
            return "plain"
        plain = decrypt_table_or_dll(data)
        if suffix == ".txt" and not looks_plain_table(plain):
            return "skip"
        if inplace:
            if name.endswith(".dll.bytes") or name.endswith(".pdb.bytes"):
                out = path.with_name(path.name[: -len(".bytes")])
                out.write_bytes(plain)
                if out != path:
                    path.unlink(missing_ok=True)
            else:
                path.write_bytes(plain)
        return "ryrs"

    return "skip"



class DotNetBinaryReader:
    def __init__(self, data: bytes):
        self.data = data
        self.index = 0

    def _read_7bit_encoded_int(self) -> int:
        v = 0
        s = 0
        while True:
            if self.index >= len(self.data):
                raise EOFError("truncated 7-bit int")
            b = self.data[self.index]
            self.index += 1
            v |= (b & 0x7F) << s
            if (b & 0x80) == 0:
                return v
            s += 7
            if s > 35:
                raise ValueError("invalid 7-bit int")

    def read_string(self) -> str:
        length = self._read_7bit_encoded_int()
        if length < 0 or self.index + length > len(self.data):
            raise ValueError("bad string length")
        s = self.data[self.index : self.index + length]
        self.index += length
        return s.decode("utf-8", errors="replace")

    def parse_table(self) -> tuple[list[str], list[dict[str, str]]]:
        if len(self.data) < 8:
            raise ValueError("too short")
        row_count = struct.unpack_from("<I", self.data, self.index)[0]
        self.index += 4
        col_count = struct.unpack_from("<I", self.data, self.index)[0]
        self.index += 4
        rows: list[list[str]] = []
        for _ in range(row_count):
            rows.append([self.read_string() for _ in range(col_count)])
        if not rows:
            return [], []
        header = rows[0]
        # 空列名补齐，避免 json key 冲突
        used: dict[str, int] = {}
        keys: list[str] = []
        for i, h in enumerate(header):
            name = h.strip() or f"_col{i}"
            if name in used:
                used[name] += 1
                name = f"{name}_{used[name]}"
            else:
                used[name] = 0
            keys.append(name)
        records = [dict(zip(keys, row)) for row in rows[1:]]
        return keys, records


def table_bytes_to_json_obj(data: bytes) -> list[dict[str, str]]:
    try:
        _, records = DotNetBinaryReader(data).parse_table()
        return records
    except Exception:
        plain = decrypt_table_or_dll(data)
        _, records = DotNetBinaryReader(plain).parse_table()
        return records


def export_table_file(src: Path, dest: Path) -> int:
    data = src.read_bytes()
    records = table_bytes_to_json_obj(data)
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(
        json.dumps(records, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    return len(records)



def fetch_zone_config() -> dict[str, Any]:
    text = http_get(ZONE_CONFIG_URL, timeout=30).text
    return json.loads(text)


def cdn_android_base(zone: dict[str, Any] | None = None) -> str:
    base = (zone or {}).get("cdnUrl") or CDN_BASE
    return f"{base.rstrip('/')}/{PLATFORM}"


def parse_filelist(text: str) -> tuple[str, list[dict[str, Any]]]:
    """filelist.txt: Ver:N|FileCount:M \\n path|sha1b64=$size"""
    lines = text.splitlines()
    if not lines:
        return "", []
    ver = ""
    m = re.match(r"Ver:(\d+)\|FileCount:(\d+)", lines[0].strip())
    if m:
        ver = m.group(1)
    items: list[dict[str, Any]] = []
    for line in lines[1:]:
        line = line.strip()
        if not line or "|" not in line:
            continue
        path, rest = line.split("|", 1)
        digest, _, size_s = rest.partition("=$")
        try:
            size = int(size_s)
        except ValueError:
            size = 0
        items.append({"path": path, "sha1": digest, "size": size})
    return ver, items


def fetch_filelist(android_base: str) -> tuple[str, list[dict[str, Any]]]:
    url = f"{android_base}/filelist.txt"
    text = http_get(url, timeout=60).text
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    (CACHE_DIR / "filelist.txt").write_text(text, encoding="utf-8")
    return parse_filelist(text)


def match_prefix(path: str, prefixes: Iterable[str]) -> bool:
    return any(path == p.rstrip("/") or path.startswith(p) for p in prefixes)


def download_one(
    android_base: str,
    item: dict[str, Any],
    dest_root: Path,
    progress: Progress,
    task_id: Any,
) -> str:
    rel = item["path"]
    dest = dest_root / rel
    dest.parent.mkdir(parents=True, exist_ok=True)

    if dest.is_file() and item["size"] and dest.stat().st_size == item["size"]:
        progress.update(task_id, advance=item["size"])
        return "skip"

    url = android_base.rstrip("/") + "/" + quote(rel, safe="/")
    for attempt in range(RETRY):
        try:
            r = http_get(url, timeout=120, stream=True)
            tmp = dest.with_suffix(dest.suffix + ".part")
            written = 0
            with tmp.open("wb") as fh:
                for chunk in r.iter_content(CHUNK):
                    if chunk:
                        fh.write(chunk)
                        written += len(chunk)
                        progress.update(task_id, advance=len(chunk))
            if item["size"] and written != item["size"]:
                # 进度条已 advance，失败时不回滚显示
                tmp.unlink(missing_ok=True)
                raise IOError(f"size mismatch {written} != {item['size']}")
            tmp.replace(dest)
            return "ok"
        except Exception:
            if attempt + 1 >= RETRY:
                raise
            progress.reset(task_id)
            progress.update(task_id, total=item["size"])
    return "fail"



def extract_apk(apk: Path, dest: Path, force: bool = False) -> None:
    stamp = dest / ".apk_extracted"
    if stamp.is_file() and not force:
        console.print("[yellow]已提取过 APK，跳过[/yellow]（--force 可重提）")
        return
    tmp = CACHE_DIR / "apk_extract"
    if tmp.exists():
        shutil.rmtree(tmp)
    tmp.mkdir(parents=True, exist_ok=True)
    console.print(f"[cyan]解压 APK assets/ → {dest}[/cyan]")
    with zipfile.ZipFile(apk) as zf:
        members = [n for n in zf.namelist() if n.startswith("assets/") and not n.endswith("/")]
        for name in members:
            zf.extract(name, tmp)
    assets = tmp / "assets"
    if not assets.is_dir():
        raise RuntimeError("APK 中没有 assets/")
    dest.mkdir(parents=True, exist_ok=True)
    for src in assets.rglob("*"):
        if not src.is_file():
            continue
        rel = src.relative_to(assets)
        out = dest / rel
        out.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, out)
    shutil.rmtree(tmp, ignore_errors=True)
    stamp.write_text(str(apk.resolve()) + "\n", encoding="utf-8")
    console.print(f"[green]APK 已提取[/green] {len(members)} 个文件")


def decrypt_tree(root: Path, jobs: int = DEFAULT_JOBS) -> dict[str, int]:
    files = [p for p in root.rglob("*") if p.is_file()]
    stats = {"bundle": 0, "ryrs": 0, "plain": 0, "skip": 0, "fail": 0}
    lock = threading.Lock()

    def work(path: Path) -> None:
        try:
            kind = decrypt_asset_file(path)
            with lock:
                stats[kind if kind in stats else "skip"] += 1
        except Exception as exc:  # noqa: BLE001
            with lock:
                stats["fail"] += 1
            console.print(f"[red]解密失败[/red] {path}: {exc}")

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("解密 Assets", total=len(files))
        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(work, p) for p in files]
            for fut in as_completed(futs):
                fut.result()
                progress.advance(task)
    return stats



def cmd_assets(args: argparse.Namespace) -> None:
    apk = find_apk(args.apk)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)

    if not args.skip_apk:
        extract_apk(apk, ASSETS_DIR, force=args.force)

    console.print("[cyan]拉取 ZoneConfig / filelist ...[/cyan]")
    zone = fetch_zone_config()
    (CACHE_DIR / "ZoneConfig_10.json").write_text(
        json.dumps(zone, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    android_base = cdn_android_base(zone)
    ver, items = fetch_filelist(android_base)
    console.print(
        f"[cyan]CDN[/cyan] {android_base}  [cyan]Ver[/cyan] {ver}  "
        f"[cyan]文件[/cyan] {len(items)}  [cyan]游戏版本[/cyan] {zone.get('version')}"
    )

    prefixes: tuple[str, ...]
    if args.all_assets:
        prefixes = ("",)  # 全量：空前缀匹配一切 —— 改用全部
        wanted = items
    else:
        prefixes = tuple(args.prefix) if args.prefix else DEFAULT_PREFIXES
        wanted = [it for it in items if match_prefix(it["path"], prefixes)]

    total = sum(it["size"] for it in wanted)
    console.print(
        f"[cyan]计划下载[/cyan] {len(wanted)} 个 / {format_size(total)}"
        + ("（全量）" if args.all_assets else f"（前缀 {prefixes}）")
    )

    if not args.skip_download and wanted:
        ok = skip = fail = 0
        with Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            DownloadColumn(),
            TransferSpeedColumn(),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            task = progress.add_task("下载", total=total)
            with ThreadPoolExecutor(max_workers=args.jobs) as pool:
                futs = {
                    pool.submit(
                        download_one, android_base, it, ASSETS_DIR, progress, task
                    ): it
                    for it in wanted
                }
                for fut in as_completed(futs):
                    it = futs[fut]
                    try:
                        kind = fut.result()
                        if kind == "skip":
                            skip += 1
                        else:
                            ok += 1
                    except Exception as exc:  # noqa: BLE001
                        fail += 1
                        console.print(f"[red]下载失败[/red] {it['path']}: {exc}")
        console.print(
            f"[green]下载完成[/green] ok={ok} skip={skip} fail={fail}"
        )

    if not args.skip_decrypt:
        stats = decrypt_tree(ASSETS_DIR, jobs=args.jobs)
        console.print(
            f"[bold green]解密完成[/bold green] bundle={stats['bundle']} "
            f"ryrs={stats['ryrs']} plain={stats['plain']} "
            f"skip={stats['skip']} fail={stats['fail']}"
        )

    meta = {
        "zone": zone,
        "filelist_ver": ver,
        "android_base": android_base,
        "assets": str(ASSETS_DIR),
    }
    (ASSETS_DIR / ".version.json").write_text(
        json.dumps(meta, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )


# ---------------------------------------------------------------------------
# configs MonoBehaviour → MasterData（按 container 路径）
# ---------------------------------------------------------------------------

_BUNDLE_PREFIXES = ("assets/game/bundle/", "assets/")


def _ensure_unity_bundle(path: Path) -> None:
    data = path.read_bytes()
    if is_unity_fs(data):
        return
    if looks_encrypted_bundle(data):
        path.write_bytes(decrypt_bundle(data))


def container_out_dir(container_path: str, dest_root: Path) -> Path:
    """assets/game/bundle/configs/story/x.asset → MasterData/configs/story/"""
    rel = container_path.replace("\\", "/").lstrip("/")
    low = rel.lower()
    for prefix in _BUNDLE_PREFIXES:
        if low.startswith(prefix):
            rel = rel[len(prefix) :]
            break
    parent = Path(rel).parent
    if str(parent) in (".", ""):
        return dest_root
    return dest_root / parent


def export_configs_monobehaviours(
    configs_root: Path | None = None,
    dest_root: Path | None = None,
) -> tuple[int, int]:
    """Assets/configs/*.data 内 MonoBehaviour → MasterData/<container目录>/<m_Name>.json。"""
    import UnityPy

    configs_root = configs_root or CONFIGS_DIR
    dest_root = dest_root or MASTER_DIR
    if not configs_root.is_dir():
        console.print(f"[yellow]无 configs 目录[/yellow] {configs_root}")
        return 0, 0

    bundles = sorted(p for p in configs_root.rglob("*.data") if p.is_file())
    if not bundles:
        console.print(f"[yellow]configs 下无 .data[/yellow] {configs_root}")
        return 0, 0

    console.print(f"[cyan]导出 configs MonoBehaviour[/cyan] {len(bundles)} bundle → {dest_root}/")
    ok = fail = 0
    used: set[str] = set()

    for bundle in bundles:
        try:
            _ensure_unity_bundle(bundle)
            env = UnityPy.load(str(bundle))
        except Exception as exc:  # noqa: BLE001
            fail += 1
            console.print(f"  [red]✗[/red] {bundle.relative_to(configs_root)}: {exc}")
            continue

        # path_id → 完整 container；未入表的 MB 用首个 container 目录
        id_to_container: dict[int, str] = {}
        first_cpath: str | None = None
        for cpath, ptr in (env.container or {}).items():
            cpath_s = str(cpath)
            if first_cpath is None:
                first_cpath = cpath_s
            pid = getattr(ptr, "path_id", None)
            if pid is not None:
                id_to_container[int(pid)] = cpath_s
        fallback_dir = (
            container_out_dir(first_cpath, dest_root)
            if first_cpath
            else dest_root / "configs"
        )

        for obj in env.objects:
            if getattr(obj.type, "name", None) != "MonoBehaviour":
                continue
            try:
                tree = obj.read_typetree()
                if not isinstance(tree, dict):
                    continue
                name = (tree.get("m_Name") or "").strip()
                cpath = id_to_container.get(int(obj.path_id)) or first_cpath
                out_dir = container_out_dir(cpath, dest_root) if cpath else fallback_dir
                if not name:
                    name = (
                        Path(cpath.replace("\\", "/")).stem
                        if cpath
                        else f"MonoBehaviour_{obj.path_id}"
                    )
                name = _safe_fs_name(name)
                out_dir.mkdir(parents=True, exist_ok=True)
                dest = out_dir / f"{name}.json"
                key = str(dest.relative_to(dest_root)).lower()
                if key in used:
                    n = 2
                    while True:
                        alt = out_dir / f"{name}_{n}.json"
                        key = str(alt.relative_to(dest_root)).lower()
                        if key not in used:
                            dest = alt
                            break
                        n += 1
                used.add(key)
                dest.write_text(
                    json.dumps(tree, ensure_ascii=False, indent=2) + "\n",
                    encoding="utf-8",
                )
                ok += 1
            except Exception as exc:  # noqa: BLE001
                fail += 1
                console.print(
                    f"  [red]✗[/red] {bundle.name} path_id={obj.path_id}: {exc}"
                )

    console.print(
        f"[bold green]configs 完成[/bold green] MonoBehaviour {ok} 失败 {fail}"
    )
    return ok, fail


def cmd_masterdata(args: argparse.Namespace) -> None:
    table_root = Path(args.table_dir) if args.table_dir else ASSETS_DIR / "Table"
    if not table_root.is_dir():
        # 兼容旧流程：本地 Table/ 目录
        alt = ROOT / "Table"
        if alt.is_dir():
            table_root = alt
        else:
            console.print(
                f"[yellow]没有 Table 目录[/yellow] {table_root}，先跑 assets 下载 Table/"
            )
            if not args.skip_assets_hint:
                console.print("提示: python MirrenStarLegends.py assets")
            sys.exit(1)

    files = sorted(table_root.rglob("*.txt"))
    if not files:
        # 可能已解密但仍是 .txt；或误删
        console.print(f"[red]未找到 .txt 表[/red] {table_root}")
        sys.exit(1)

    console.print(f"[cyan]导出数据表[/cyan] {len(files)} → {MASTER_DIR}/")
    ok = fail = rows = 0
    for src in files:
        rel = src.relative_to(table_root)
        dest = MASTER_DIR / rel.with_suffix(".json")
        try:
            n = export_table_file(src, dest)
            ok += 1
            rows += n
            console.print(f"  [green]✓[/green] {rel} ({n})")
        except Exception as exc:  # noqa: BLE001
            fail += 1
            console.print(f"  [red]✗[/red] {rel}: {exc}")

    # 重要配置：ZoneConfig / filelist 摘要
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    zone_path = CACHE_DIR / "ZoneConfig_10.json"
    if zone_path.is_file():
        shutil.copy2(zone_path, MASTER_DIR / "ZoneConfig_10.json")
    fl = CACHE_DIR / "filelist.txt"
    if fl.is_file():
        ver, items = parse_filelist(fl.read_text(encoding="utf-8"))
        (MASTER_DIR / "filelist_meta.json").write_text(
            json.dumps(
                {
                    "ver": ver,
                    "count": len(items),
                    "total_size": sum(i["size"] for i in items),
                    "sample": items[:20],
                },
                ensure_ascii=False,
                indent=2,
            )
            + "\n",
            encoding="utf-8",
        )

    cfg_ok, cfg_fail = export_configs_monobehaviours()

    (MASTER_DIR / ".version.json").write_text(
        json.dumps(
            {
                "tables": ok,
                "fail": fail,
                "rows": rows,
                "configs_mb": cfg_ok,
                "configs_fail": cfg_fail,
                "source": str(table_root),
            },
            ensure_ascii=False,
            indent=2,
        )
        + "\n",
        encoding="utf-8",
    )
    console.print(
        f"[bold green]MasterData 完成[/bold green] 表 {ok} 失败 {fail} 行合计 {rows} "
        f"configs MB {cfg_ok}"
    )
    console.print(
        "[dim]说明: Table/*.txt → JSON；Assets/configs MonoBehaviour 按 container 目录导出。"
        "无独立 Lua 数值表。[/dim]"
    )


# ---------------------------------------------------------------------------
# 立绘 Painting
# ---------------------------------------------------------------------------


def _load_json_table(name: str) -> list[dict[str, str]]:
    path = MASTER_DIR / f"{name}.json"
    if not path.is_file():
        return []
    data = json.loads(path.read_text(encoding="utf-8"))
    return data if isinstance(data, list) else []


def _safe_fs_name(text: str) -> str:
    text = (text or "").strip()
    text = re.sub(r'[\\/:*?"<>|\x00-\x1f]', " ", text)
    text = re.sub(r"\s+", " ", text).strip(" .")
    return text or "未知"


def painting_notes_from_stem(stem: str) -> list[str]:
    notes: list[str] = []
    low = stem.lower()
    if low.endswith("_hx") or "_hx_" in low or low.endswith("lihui_hx"):
        notes.append("和谐")
    if "_xiao" in low:
        notes.append("小")
    return notes


def painting_filename(
    cha: str,
    skin: str,
    used: set[str],
    notes: Iterable[str] | None = None,
) -> str:
    """游戏名_人物名_皮肤/变体名[_备注...].png"""
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


def _strip_skin_label(text: str, cha: str) -> str:
    """Skin._col3 → 变体名：格蕾（原皮）→原皮，炽爱〔午后闲暇〕→午后闲暇。"""
    text = (text or "").strip()
    if not text:
        return ""
    text = re.sub(r"^2[dD]", "", text).strip()
    m = re.match(r"^(.+?)[（(](.+?)[）)]$", text)
    if m:
        return m.group(2).strip()
    m = re.match(r"^(.+?)〔(.+?)〕$", text)
    if m:
        return m.group(2).strip()
    if cha and text.startswith(cha):
        rest = text[len(cha) :].strip(" （()）〔〕")
        if rest:
            return rest
    return text


def _base_character_name(
    rr: dict[str, str],
    pets: dict[str, dict[str, str]],
    roles: dict[str, dict[str, str]],
    base_res: dict[str, dict[str, str]],
) -> str:
    rid = (rr.get("RoleId") or rr.get("Id") or "").strip()
    if rid in pets and (pets[rid].get("_col1") or "").strip():
        return pets[rid]["_col1"].strip()
    if rid in roles and (roles[rid].get("Desc1") or "").strip():
        return roles[rid]["Desc1"].strip()
    if rid in base_res and (base_res[rid].get("_col2") or "").strip():
        return base_res[rid]["_col2"].strip()
    col2 = (rr.get("_col2") or "").strip()
    col2 = re.sub(r"^2[dD]", "", col2).strip()
    col2 = re.sub(r"[〔（(].*$", "", col2).strip()
    return col2 or "未知"


def _skin_variant_name(
    rr: dict[str, str],
    skins: dict[str, dict[str, str]],
    cha: str,
) -> str:
    sid = (rr.get("Id") or "").strip()
    sk = skins.get(sid)
    if sk:
        label = _strip_skin_label(sk.get("_col3") or "", cha)
        if label:
            return label
    col3 = (rr.get("_col3") or "").strip()
    if col3 and col3 not in ("无分类",):
        return col3
    m = re.search(r"[〔（(](.+?)[〕）)]", rr.get("_col2") or "")
    if m:
        return m.group(1).strip()
    return "原皮"


def _category_notes(rr: dict[str, str], skin: str) -> list[str]:
    col3 = (rr.get("_col3") or "").strip()
    if not col3 or col3 in ("无分类", "原皮", ""):
        return []
    if col3.lower() in {skin.lower(), skin.lower().replace(" ", "")}:
        return []
    if col3 in _SKIN_CATEGORY_NOTES or col3.lower() in {c.lower() for c in _SKIN_CATEGORY_NOTES}:
        return [col3]
    return []


def load_painting_tables() -> tuple[
    dict[str, dict[str, str]],
    dict[str, dict[str, str]],
    dict[str, dict[str, str]],
    dict[str, dict[str, str]],
    dict[str, dict[str, str]],
]:
    """by_pic, by_id, pets, roles, skins。"""
    role_res = _load_json_table("RoleRes")
    pets = {
        (p.get("Id") or "").strip(): p
        for p in _load_json_table("RolePet")
        if (p.get("Id") or "").strip()
    }
    roles = {
        (r.get("RoleId") or "").strip(): r
        for r in _load_json_table("Role")
        if (r.get("RoleId") or "").strip()
    }
    skins = {
        (s.get("Id") or "").strip(): s
        for s in _load_json_table("Skin")
        if (s.get("Id") or "").strip()
    }
    by_pic: dict[str, dict[str, str]] = {}
    by_id: dict[str, dict[str, str]] = {}
    for rr in role_res:
        rid = (rr.get("Id") or "").strip()
        if rid:
            by_id[rid] = rr
        pic = (rr.get("Pic") or "").strip()
        if pic and pic != "0":
            by_pic[pic] = rr
    return by_pic, by_id, pets, roles, skins


def resolve_lihui_name(
    stem: str,
    by_pic: dict[str, dict[str, str]],
    by_id: dict[str, dict[str, str]],
    pets: dict[str, dict[str, str]],
    roles: dict[str, dict[str, str]],
    skins: dict[str, dict[str, str]],
) -> tuple[str, str, list[str], bool]:
    stem_notes = painting_notes_from_stem(stem)  # 和谐/小 → 永远垫最后
    core = stem
    for suf in ("_hx", "_xiao"):
        if core.endswith(suf):
            core = core[: -len(suf)]
    asset_id = core.replace("_lihui", "") if core.endswith("_lihui") else core

    rr = by_pic.get(core) or by_id.get(asset_id)
    if not rr and asset_id:
        rr = by_pic.get(f"{asset_id}_lihui") or by_id.get(asset_id)

    if not rr:
        return "未知", asset_id or core, stem_notes, False

    base_res = {
        k: v
        for k, v in by_id.items()
        if k == (v.get("RoleId") or "").strip()
    }
    cha = _base_character_name(rr, pets, roles, base_res)
    skin = _skin_variant_name(rr, skins, cha)
    notes = _category_notes(rr, skin) + list(stem_notes)
    # 去重保序
    seen: set[str] = set()
    uniq: list[str] = []
    for n in notes:
        if n not in seen:
            seen.add(n)
            uniq.append(n)
    return cha, skin, uniq, True


def iter_lihui_bundles(root: Path) -> list[Path]:
    if not root.is_dir():
        return []
    out: list[Path] = []
    for path in sorted(root.glob("*.data")):
        if path.name.endswith(".manifest"):
            continue
        if "_lihui" in path.stem:
            out.append(path)
    return out


def _ensure_bundle_decrypted(path: Path) -> Path:
    data = path.read_bytes()
    if is_unity_fs(data):
        return path
    if looks_encrypted_bundle(data):
        plain = decrypt_bundle(data)
        path.write_bytes(plain)
    return path


def export_lihui_texture(bundle: Path, dest: Path) -> str:
    import UnityPy

    _ensure_bundle_decrypted(bundle)
    env = UnityPy.load(str(bundle))
    best = None
    best_area = -1
    for obj in env.objects:
        if getattr(obj.type, "name", None) != "Texture2D":
            continue
        data = obj.read()
        image = getattr(data, "image", None)
        if image is None:
            continue
        area = int(getattr(data, "m_Width", 0) or 0) * int(
            getattr(data, "m_Height", 0) or 0
        )
        if area >= best_area:
            best_area = area
            best = image
    if best is None:
        return "skip"
    dest.parent.mkdir(parents=True, exist_ok=True)
    best.save(dest)
    return "ok"


def cmd_painting(args: argparse.Namespace) -> None:
    root = Path(args.path) if getattr(args, "path", None) else LIHUI_DIR
    if not root.is_dir():
        console.print(f"[red]立绘目录不存在[/red] {root}")
        console.print(
            "提示: python MirrenStarLegends.py assets --prefix ui/texture/lihui/"
        )
        sys.exit(1)

    if not (MASTER_DIR / "RoleRes.json").is_file():
        console.print("[yellow]缺少 MasterData/RoleRes.json，先导出表[/yellow]")
        cmd_masterdata(
            argparse.Namespace(table_dir=None, skip_assets_hint=True, apk=None, jobs=DEFAULT_JOBS, force=False)
        )

    by_pic, by_id, pets, roles, skins = load_painting_tables()
    bundles = iter_lihui_bundles(root)
    if getattr(args, "limit", 0):
        bundles = bundles[: int(args.limit)]
    console.print(f"[cyan]导出立绘[/cyan] {len(bundles)} → {PAINTING_DIR}/")

    PAINTING_DIR.mkdir(parents=True, exist_ok=True)
    used: set[str] = set()
    ok = skip = fail = unknown = 0
    lock = threading.Lock()

    def work(bundle: Path) -> None:
        nonlocal ok, skip, fail, unknown
        stem = bundle.stem
        cha, skin, notes, hit = resolve_lihui_name(
            stem, by_pic, by_id, pets, roles, skins
        )
        with lock:
            fname = painting_filename(cha, skin, used, notes)
        dest = PAINTING_DIR / fname
        try:
            kind = export_lihui_texture(bundle, dest)
            with lock:
                if kind == "ok":
                    ok += 1
                    if not hit:
                        unknown += 1
                else:
                    skip += 1
        except Exception as exc:  # noqa: BLE001
            with lock:
                fail += 1
            console.print(f"[red]失败[/red] {bundle.name}: {exc}")

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("Painting", total=len(bundles))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = [pool.submit(work, b) for b in bundles]
            for fut in as_completed(futs):
                fut.result()
                progress.advance(task)

    console.print(
        f"[bold green]立绘完成[/bold green] ok={ok} skip={skip} fail={fail} "
        f"未匹配表={unknown} → {PAINTING_DIR}"
    )


def cmd_decrypt(args: argparse.Namespace) -> None:
    root = Path(args.path)
    if not root.exists():
        console.print(f"[red]不存在[/red] {root}")
        sys.exit(1)
    if root.is_file():
        kind = decrypt_asset_file(root)
        console.print(f"{root}: {kind}")
        return
    stats = decrypt_tree(root, jobs=args.jobs)
    console.print(stats)


def cmd_table(args: argparse.Namespace) -> None:
    """单表/目录 → JSON（调试用）。"""
    src = Path(args.path)
    if src.is_file():
        dest = Path(args.output) if args.output else MASTER_DIR / (src.stem + ".json")
        n = export_table_file(src, dest)
        console.print(f"[green]{dest}[/green] rows={n}")
        return
    args.table_dir = str(src)
    args.skip_assets_hint = True
    cmd_masterdata(args)


def cmd_all(args: argparse.Namespace) -> None:
    cmd_assets(args)
    cmd_masterdata(args)
    if not getattr(args, "skip_painting", False):
        if not hasattr(args, "path"):
            args.path = None
        if not hasattr(args, "limit"):
            args.limit = 0
        cmd_painting(args)


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--apk", help="APK 路径")
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    shared.add_argument("--force", action="store_true", help="强制重提 APK")

    p = argparse.ArgumentParser(
        description="千年之旅 MirrenStarLegends：APK+热更 → Assets/，Table → MasterData/*.json，立绘 → Painting/",
        parents=[shared],
    )
    p.set_defaults(command=None)
    sub = p.add_subparsers(dest="command")

    p_assets = sub.add_parser("assets", parents=[shared], help="APK + CDN 热更到 Assets/ 并解密")
    p_assets.add_argument("--skip-apk", action="store_true")
    p_assets.add_argument("--skip-download", action="store_true")
    p_assets.add_argument("--skip-decrypt", action="store_true")
    p_assets.add_argument(
        "--all-assets",
        action="store_true",
        help="下载 filelist 全量（约数 GB）；默认只下 Table/dll/configs/common/lihui 等",
    )
    p_assets.add_argument(
        "--prefix",
        action="append",
        default=[],
        help="额外/覆盖下载前缀，可重复；默认含 ui/texture/lihui/",
    )

    p_md = sub.add_parser(
        "masterdata",
        aliases=["data", "table"],
        parents=[shared],
        help="Table 解密解析为 indent=2 JSON → MasterData/",
    )
    p_md.add_argument("--table-dir", help="表目录，默认 Assets/Table")

    p_one = sub.add_parser("export-table", help="导出单个表文件")
    p_one.add_argument("path")
    p_one.add_argument("-o", "--output")

    p_dec = sub.add_parser("decrypt", help="对文件/目录原地解密")
    p_dec.add_argument("path")
    p_dec.add_argument("--jobs", type=int, default=DEFAULT_JOBS)

    p_paint = sub.add_parser(
        "painting",
        aliases=["lihui"],
        parents=[shared],
        help="立绘 UnityPy 导出 → Painting/千年之旅_人物_皮肤[_备注].png",
    )
    p_paint.add_argument(
        "--path",
        help=f"lihui bundle 目录，默认 {LIHUI_DIR}",
    )
    p_paint.add_argument("--limit", type=int, default=0, help="仅导出前 N 个（调试）")

    p_all = sub.add_parser("all", parents=[shared], help="assets + masterdata + painting")
    p_all.add_argument("--skip-apk", action="store_true")
    p_all.add_argument("--skip-download", action="store_true")
    p_all.add_argument("--skip-decrypt", action="store_true")
    p_all.add_argument("--all-assets", action="store_true")
    p_all.add_argument("--prefix", action="append", default=[])
    p_all.add_argument("--skip-painting", action="store_true", help="跳过立绘导出")
    p_all.add_argument("--table-dir", help="表目录")
    return p


def main(argv: list[str] | None = None) -> None:
    parser = build_parser()
    args = parser.parse_args(argv)
    # 无子命令 → all；给 all/assets 补默认字段
    if args.command in (None, "all"):
        for k, v in {
            "skip_apk": False,
            "skip_download": False,
            "skip_decrypt": False,
            "all_assets": False,
            "prefix": [],
            "table_dir": None,
            "skip_assets_hint": True,
            "skip_painting": False,
            "path": None,
            "limit": 0,
        }.items():
            if not hasattr(args, k):
                setattr(args, k, v)
        cmd_all(args)
    elif args.command == "assets":
        cmd_assets(args)
    elif args.command in ("masterdata", "data", "table"):
        if not hasattr(args, "skip_assets_hint"):
            args.skip_assets_hint = False
        cmd_masterdata(args)
    elif args.command == "export-table":
        cmd_table(args)
    elif args.command == "decrypt":
        cmd_decrypt(args)
    elif args.command in ("painting", "lihui"):
        cmd_painting(args)
    else:
        parser.print_help()


# ---------------------------------------------------------------------------
# 自检（ponytail: 非平凡逻辑留一个可跑检查）
# ---------------------------------------------------------------------------


def _self_check() -> None:
    # 表：构造 1 头 + 1 行
    payload = bytearray()
    payload += struct.pack("<II", 2, 2)

    def put_str(s: str) -> None:
        b = s.encode("utf-8")
        n = len(b)
        while n > 0x7F:
            payload.append((n & 0x7F) | 0x80)
            n >>= 7
        payload.append(n)
        payload.extend(b)

    for s in ("Id", "Name", "1", "测试"):
        put_str(s)
    enc = xor_repeating(bytes(payload), TABLE_XOR_KEY)
    rows = table_bytes_to_json_obj(enc)
    assert rows == [{"Id": "1", "Name": "测试"}], rows

    # AB：前 1000 异或
    fake = bytearray(b"UnityFS" + b"\x00" * 100)
    enc_b = decrypt_bundle(bytes(fake))  # 对称
    assert enc_b[:7] != b"UnityFS"
    assert decrypt_bundle(enc_b)[:7] == b"UnityFS"

    # 立绘命名：备注无限追加 + 冲突序号
    used: set[str] = set()
    n1 = painting_filename("炽爱", "午后闲暇", used)
    assert n1 == "千年之旅_炽爱_午后闲暇.png", n1
    n2 = painting_filename("桃", "含玉钩", used, ["温泉", "和谐"])
    assert n2 == "千年之旅_桃_含玉钩_温泉_和谐.png", n2
    # 分类在前、和谐/小在后（resolve 顺序）
    assert painting_filename("桃", "含玉钩", set(), ["温泉", "和谐"]) == (
        "千年之旅_桃_含玉钩_温泉_和谐.png"
    )
    n3 = painting_filename("炽爱", "午后闲暇", used)
    assert n3 == "千年之旅_炽爱_午后闲暇_2.png", n3
    assert _strip_skin_label("炽爱〔午后闲暇〕", "炽爱") == "午后闲暇"
    assert _strip_skin_label("2d温泉桃〔含玉钩〕", "桃") == "含玉钩"
    print("self_check ok")


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--self-check":
        _self_check()
    else:
        main()
