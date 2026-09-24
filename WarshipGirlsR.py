from __future__ import annotations

import argparse
import base64
import hashlib
import json
import shutil
import subprocess
import sys
import tempfile
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET
import zipfile
import zlib
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Iterable

from WarshipGirlsRFormat import (
    decrypt_manifest,
    decode_data_string,
    fix_lua_header,
    iter_lxdata,
    parse_game_json,
    strip_unityfs,
)

GAME_TITLE = "战舰少女R"
SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
CACHE_DIR = SCRIPT_DIR / ".cache"
PAINTING_DIR = SCRIPT_DIR / "Painting"
MODEL_L_DIR = ASSETS_DIR / "data" / "ui" / "model_normal_l"
OVERLAY_INDEX = CACHE_DIR / "overlays.json"
RPC_URL = "http://xrpc.moefantasy.com"
USER_AGENT = "UnityPlayer/2022.3.62f3c1 (UnityWebRequest/1.0, libcurl/8.10.1-DEV)"
DEFAULT_PATCH_VERSION = "0.0.585.1"
DEFAULT_JOBS = 8


def find_apk(path: str | None) -> Path:
    if path:
        apk = Path(path)
        if not apk.is_file():
            raise FileNotFoundError(f"找不到 APK: {apk}")
        return apk
    found = sorted(SCRIPT_DIR.glob("*.apk"), key=lambda p: p.stat().st_mtime, reverse=True)
    if not found:
        raise FileNotFoundError(f"{SCRIPT_DIR} 下没有 APK")
    return found[0]


def app_version_from_apk(apk: Path, override: str | None) -> str:
    if override:
        text = override[1:] if override.startswith("v") else override
        return text
    stem = apk.stem
    for part in stem.replace("-", "_").split("_"):
        bits = part.split(".")
        if len(bits) >= 3 and all(b.isdigit() for b in bits[:3]):
            return ".".join(bits[:3])
    raise RuntimeError("APK 文件名里没有 x.y.z 版本号，请传 --app-version")


def fetch_patch_info(app_version: str, patch_version: str) -> dict:
    form = urllib.parse.urlencode(
        {
            "app_id": "xr_cn_release",
            "os_type": "android",
            "channel": "taptap",
            "app_version": f"v{app_version}",
            "patch_list": json.dumps({"main": patch_version}, separators=(",", ":")),
        }
    )
    req = urllib.request.Request(
        RPC_URL,
        data=form.encode(),
        headers={"Content-Type": "application/x-www-form-urlencoded; charset=utf-8", "User-Agent": USER_AGENT},
    )
    with urllib.request.urlopen(req, timeout=60) as resp:
        raw = resp.read()
    try:
        raw = zlib.decompress(raw)
    except zlib.error:
        pass
    info = json.loads(raw)
    versions = info.get("patch", {}).get("patch_set", {}).get("main", {}).get("version_set")
    if not versions:
        raise RuntimeError(f"补丁列表为空: {list(info)[:6]}")
    return info


def patch_chain(version_set: dict, installed: str) -> list[dict]:
    nxt = {item["version"]: item.get("next_version") or "" for item in version_set.values()}
    pointed = set(nxt.values()) - {""}
    heads = [ver for ver in version_set if ver not in pointed]
    if installed in version_set:
        node = installed
    elif len(heads) == 1:
        node = heads[0]
    else:
        raise RuntimeError(f"无法从 {installed} 接上补丁链，起点 {heads}")
    order = []
    seen = set()
    while node and node in version_set and node not in seen:
        seen.add(node)
        order.append(version_set[node])
        node = version_set[node].get("next_version") or ""
    return order


def download(url: str, dest: Path, md5: str) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.is_file() and hashlib.md5(dest.read_bytes()).hexdigest() == md5:
        return
    tmp = dest.with_suffix(dest.suffix + ".part")
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    digest = hashlib.md5()
    with urllib.request.urlopen(req, timeout=180) as resp, tmp.open("wb") as out:
        while True:
            chunk = resp.read(1 << 20)
            if not chunk:
                break
            digest.update(chunk)
            out.write(chunk)
    if digest.hexdigest() != md5:
        tmp.unlink(missing_ok=True)
        raise RuntimeError(f"MD5 不符 {url}")
    tmp.replace(dest)


def extract_apk_assets(apk: Path, dest: Path) -> int:
    if dest.exists():
        shutil.rmtree(dest)
    dest.mkdir(parents=True)
    count = 0
    with zipfile.ZipFile(apk) as zf:
        for info in zf.infolist():
            name = info.filename
            if not name.startswith("assets/") or name.endswith("/"):
                continue
            out = dest / name[len("assets/") :]
            out.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(info) as src, out.open("wb") as dst:
                shutil.copyfileobj(src, dst, 1 << 20)
            count += 1
    return count


def _safe_rel(name: str) -> Path:
    path = Path(name)
    if path.is_absolute() or ".." in path.parts:
        raise ValueError(f"补丁路径非法: {name}")
    return path


def parse_patch_xml(blob: bytes) -> ET.Element:
    text = decode_data_string(blob)
    return ET.fromstring(text)


def apply_patch_zip(zip_path: Path, assets: Path, index: dict) -> tuple[int, int]:
    loose = packets = 0
    with zipfile.ZipFile(zip_path) as zf:
        xml_name = next(n for n in zf.namelist() if Path(n).name == "patch.xml")
        root = parse_patch_xml(zf.read(xml_name))
        by_filename = {}
        for source in root.findall("source"):
            filename = source.get("filename")
            if source.get("is_packet") == "true" and filename:
                by_filename[Path(filename).name] = source.get("name")
            if source.get("is_packet") == "true":
                for node in source.findall("file"):
                    if node.get("operate") == "delete" and node.get("url"):
                        index["deletes"].append({"container": source.get("name"), "url": node.get("url")})
            else:
                for node in source.findall("file"):
                    if node.get("operate") == "delete" and node.get("url"):
                        target = assets / _safe_rel(node.get("url"))
                        if target.is_file():
                            target.unlink()
        for info in zf.infolist():
            if info.is_dir() or Path(info.filename).name == "patch.xml":
                continue
            blob = zf.read(info)
            entry = Path(info.filename).name
            if entry in by_filename:
                container = by_filename[entry]
                folder = CACHE_DIR / "packet" / container
                folder.mkdir(parents=True, exist_ok=True)
                saved = folder / f"{zip_path.stem}_{entry}"
                saved.write_bytes(blob)
                index["overlays"].append({"container": container, "file": str(saved.relative_to(SCRIPT_DIR))})
                packets += 1
                continue
            out = assets / _safe_rel(info.filename)
            out.parent.mkdir(parents=True, exist_ok=True)
            out.write_bytes(blob)
            loose += 1
    return loose, packets


def locate_container(name: str) -> Path | None:
    direct = ASSETS_DIR / name
    if direct.is_file():
        return direct
    matches = [p for p in ASSETS_DIR.rglob(name) if p.is_file()]
    if len(matches) == 1:
        return matches[0]
    return None


def normalize_bundles() -> tuple[int, int]:
    stripped = manifests = 0
    for path in ASSETS_DIR.rglob("*.unity3d"):
        data = path.read_bytes()
        plain = strip_unityfs(data)
        if plain is not None and len(plain) != len(data):
            path.write_bytes(plain)
            stripped += 1
            continue
        manifest = decrypt_manifest(data)
        if manifest is None:
            continue
        obj = json.loads(manifest)
        rel = path.relative_to(ASSETS_DIR).with_suffix(".json")
        out = CACHE_DIR / "manifest" / rel
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        path.unlink()
        manifests += 1
    return stripped, manifests


def decompile_lua(data: bytes, dest: Path) -> bool:
    data = fix_lua_header(data)
    if data.startswith((b"--", b"local", b"return", b"function", b"\n")) or (
        data[:1].isalpha() and b"\x00" not in data[:32]
    ):
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data if data.endswith(b"\n") else data + b"\n")
        return True
    dest.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory() as tmp:
        folder = Path(tmp)
        src = folder / "in.luac"
        src.write_bytes(data)
        if data.startswith(b"\x1bLua"):
            proc = subprocess.run(["unluac", str(src)], capture_output=True)
            if proc.returncode == 0 and proc.stdout.strip():
                dest.write_bytes(proc.stdout if proc.stdout.endswith(b"\n") else proc.stdout + b"\n")
                return True
            return False
        out = folder / "out"
        proc = subprocess.run(
            ["luajit-decompiler", str(src), "-o", str(out), "-s", "-f"],
            capture_output=True,
        )
        files = list(out.rglob("*.lua")) if out.exists() else []
        if proc.returncode == 0 and files:
            try:
                text = files[0].read_text(encoding="utf-8").lstrip("\ufeff")
            except UnicodeDecodeError:
                return False
            dest.write_text(text if text.endswith("\n") else text + "\n", encoding="utf-8")
            return True
    return False


def write_lua(rel: str, blob: bytes, stats: dict) -> None:
    dest = MASTER_DIR / rel
    if decompile_lua(blob, dest):
        stats["lua"] += 1
        return
    fallback = dest.with_suffix(".luac")
    fallback.parent.mkdir(parents=True, exist_ok=True)
    fallback.write_bytes(fix_lua_header(blob))
    stats["luac"] += 1


def write_json(rel: str, blob: bytes, stats: dict) -> None:
    obj = parse_game_json(blob)
    dest = MASTER_DIR / rel
    dest.parent.mkdir(parents=True, exist_ok=True)
    if obj is None:
        dest.with_suffix(dest.suffix + ".fail").write_bytes(blob)
        stats["json_fail"] += 1
        return
    if rel.replace("\\", "/") == "config/protocol/protocols.json":
        obj = unwrap_protocols(obj, dest.parent)
    dest.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    stats["json"] += 1


def emit_member(rel: str, blob: bytes, stats: dict) -> None:
    if rel.endswith(".lua") or blob.startswith(b"\x1b"):
        write_lua(rel, blob, stats)
        return
    if rel.endswith(".json") or blob[:1] in (b"{", b"["):
        write_json(rel, blob, stats)
        return
    dest = MASTER_DIR / rel
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(blob)
    stats["other"] += 1


def merged_packets() -> dict[str, dict[str, bytes]]:
    """容器名 -> {内部路径: 明文}，补丁按记录顺序覆盖。"""
    tables: dict[str, dict[str, bytes]] = {}
    for path in ASSETS_DIR.rglob("*"):
        if not path.is_file() or path.stat().st_size < 12:
            continue
        with path.open("rb") as fh:
            if fh.read(7) != b"lxdata\x00":
                continue
        rel = str(path.relative_to(ASSETS_DIR))
        tables[path.name] = {name: body for name, body in iter_lxdata(path.read_bytes(), path.name)}
        tables.setdefault(rel, tables[path.name])
    if OVERLAY_INDEX.is_file():
        index = json.loads(OVERLAY_INDEX.read_text(encoding="utf-8"))
        for item in index.get("overlays", []):
            container = item["container"]
            packet = SCRIPT_DIR / item["file"]
            base = tables.setdefault(container, {})
            base.update(dict(iter_lxdata(packet.read_bytes(), packet.name)))
            tables.setdefault(Path(container).name, base)
        for item in index.get("deletes", []):
            base = tables.get(item["container"]) or tables.get(Path(item["container"]).name)
            if base is not None:
                base.pop(item["url"], None)
    return tables


def dir_size(path: Path) -> int:
    if not path.exists():
        return 0
    total = 0
    for file in path.rglob("*"):
        if file.is_file():
            total += file.stat().st_size
    return total


_PROTO_TYPES = {
    1: "double",
    2: "float",
    3: "int64",
    4: "uint64",
    5: "int32",
    6: "fixed64",
    7: "fixed32",
    8: "bool",
    9: "string",
    12: "bytes",
    13: "uint32",
    15: "sfixed32",
    16: "sfixed64",
    17: "sint32",
    18: "sint64",
}
_PROTO_LABELS = {1: "optional", 2: "required", 3: "repeated"}


def _proto_type(field, package: str) -> str:
    if field.type_name:
        name = field.type_name.lstrip(".")
        prefix = f"{package}."
        if package and name.startswith(prefix):
            return name[len(prefix) :]
        return name
    return _PROTO_TYPES.get(field.type, f"type{field.type}")


def _proto_enum(enum, indent: str) -> str:
    lines = [f"{indent}enum {enum.name} {{\n"]
    for val in enum.value:
        lines.append(f"{indent}  {val.name} = {val.number};\n")
    lines.append(f"{indent}}}\n")
    return "".join(lines)


def _proto_message(msg, package: str, indent: str) -> str:
    lines = [f"{indent}message {msg.name} {{\n"]
    inner = indent + "  "
    for nested in msg.nested_type:
        lines.append(_proto_message(nested, package, inner))
    for enum in msg.enum_type:
        lines.append(_proto_enum(enum, inner))
    for field in msg.field:
        extra = ""
        if field.default_value:
            val = json.dumps(field.default_value) if field.type == 9 else field.default_value
            extra = f" [default = {val}]"
        lines.append(
            f"{inner}{_PROTO_LABELS.get(field.label, 'optional')} "
            f"{_proto_type(field, package)} {field.name} = {field.number}{extra};\n"
        )
    lines.append(f"{indent}}}\n")
    return "".join(lines)


def file_descriptor_to_proto(fdesc) -> str:
    parts = ['syntax = "proto2";\n']
    if fdesc.package:
        parts.append(f"package {fdesc.package};\n")
    for dep in fdesc.dependency:
        parts.append(f'import "{dep}";\n')
    parts.append("\n")
    for enum in fdesc.enum_type:
        parts.append(_proto_enum(enum, ""))
    for msg in fdesc.message_type:
        parts.append(_proto_message(msg, fdesc.package, ""))
        parts.append("\n")
    for svc in fdesc.service:
        parts.append(f"service {svc.name} {{\n")
        for method in svc.method:
            parts.append(
                f"  rpc {method.name} ({method.input_type.lstrip('.')}) "
                f"returns ({method.output_type.lstrip('.')});\n"
            )
        parts.append("}\n")
    return "".join(parts)


def unwrap_protocols(obj, folder: Path):
    """lx.jsonfile_decode + lx.base64_decode + protobuf.register：data 是 FileDescriptorSet。"""
    if not isinstance(obj, list):
        return obj
    from google.protobuf.descriptor_pb2 import FileDescriptorSet

    out = []
    for item in obj:
        if not isinstance(item, dict) or not item.get("data"):
            out.append(item)
            continue
        raw = base64.b64decode(item["data"])
        fds = FileDescriptorSet.FromString(raw)
        names = []
        for fdesc in fds.file:
            name = Path(fdesc.name).name or Path(str(item.get("name") or "file.pb")).with_suffix(".proto").name
            text = file_descriptor_to_proto(fdesc)
            dest = folder / name
            dest.write_text(text if text.endswith("\n") else text + "\n", encoding="utf-8")
            names.append(name)
        row = {"name": item.get("name", "")}
        if names:
            row["proto"] = names[0] if len(names) == 1 else names
        out.append(row)
    return out


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
    return text.translate(table).strip() or "未知"


def painting_filename(cha: str, skin: str, used: set[str], notes: Iterable[str] | None = None) -> str:
    """游戏名_角色_皮肤[_备注].png，备注可追加；重名则 _2。"""
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


def _model_stem(path: str) -> str:
    if not path:
        return ""
    parts = path.replace("\\", "/").split("/")
    return parts[-2] if len(parts) >= 2 else Path(path).stem


def _related_stems(stem: str) -> set[str]:
    """原皮/改造差 1000；战利品店 8xxx 对应原 pic。9xxx 是怪物图，不连。"""
    out = {stem}
    if stem.isdigit():
        n = int(stem)
        if 8000 <= n < 9000:
            out.add(str(n - 8000))
        elif 1000 <= n < 8000:
            out.add(str(n - 1000))
        elif n < 1000:
            out.add(str(n + 1000))
            out.add(str(n + 8000))
    return out


def _json_sequence(name: str) -> list:
    path = MASTER_DIR / "config" / "json" / name
    if not path.is_file():
        return []
    obj = json.loads(path.read_text(encoding="utf-8"))
    return obj.get("sequence") or [] if isinstance(obj, dict) else []


def _title_score(ship: dict) -> int:
    title = (ship.get("title") or "").strip()
    if not title or title == "未知":
        return -1000
    cid = str(ship.get("cid") or "")
    score = len(title)
    if cid.startswith("11"):
        score += 50
    elif cid.startswith("10"):
        score += 40
    elif cid.startswith("18"):
        score += 10
    elif cid.startswith("16"):
        score += 5
    if ship.get("evo_class"):
        score += 5
    return score


def _best_title(ships: list[dict]) -> str:
    if not ships:
        return "未知"
    return (max(ships, key=_title_score).get("title") or "").strip() or "未知"


def _row_model_stems(row: dict) -> set[str]:
    stems: set[str] = set()
    for key in ("skin_id", "pic_id"):
        if row.get(key) not in (None, ""):
            stems.add(str(row[key]))
    for key in ("model_normal_l", "h_model_normal_l"):
        stem = _model_stem(row.get(key) or "")
        if stem:
            stems.add(stem)
    for path in row.get("switchover_path") or []:
        if isinstance(path, str):
            stem = _model_stem(path)
            if stem:
                stems.add(stem)
    for item in row.get("time_switchover") or []:
        path = item.get("path") if isinstance(item, dict) else item
        stem = _model_stem(path or "")
        if stem:
            stems.add(stem)
    return stems


def load_painting_maps() -> tuple[dict, dict, dict, dict]:
    ships = _json_sequence("ship.json")
    skins = _json_sequence("skin.json")
    monsters = _json_sequence("monster.json")
    by_cid = {row["cid"]: row for row in ships if row.get("cid") is not None}
    by_skin: dict[str, list] = {}
    for row in skins:
        for stem in _row_model_stems(row):
            by_skin.setdefault(stem, []).append(row)
    by_ship: dict[str, list] = {}
    for row in ships:
        for stem in _row_model_stems(row):
            by_ship.setdefault(stem, []).append(row)
    by_mon: dict[str, list] = {}
    for row in monsters:
        stem = str(row.get("pic_id") or "")
        if stem:
            by_mon.setdefault(stem, []).append(row)
    return by_cid, by_skin, by_ship, by_mon


def resolve_painting_name(
    stem: str,
    by_cid: dict,
    by_skin: dict,
    by_ship: dict,
    by_mon: dict,
) -> tuple[str, str, list[str], bool]:
    skins = by_skin.get(stem) or []
    exact = by_ship.get(stem) or []
    related = [row for key in _related_stems(stem) for row in (by_ship.get(key) or [])]
    mons = by_mon.get(stem) or []
    candidates = list(related)
    for skin in skins:
        cid = skin.get("evo_cid")
        if cid in by_cid:
            candidates.append(by_cid[cid])
        for card in skin.get("card_cids") or []:
            if card in by_cid:
                candidates.append(by_cid[card])
    cha = _best_title(candidates)
    if cha == "未知" and mons:
        cha = (mons[0].get("title") or "").strip() or "未知"
    notes: list[str] = []
    if skins:
        row = next((item for item in skins if str(item.get("skin_id")) == stem), skins[0])
        skin = (row.get("title") or "").strip() or "未知"
        if str(row.get("skin_id") or "") != stem:
            for item in row.get("time_switchover") or []:
                if isinstance(item, dict) and _model_stem(item.get("path") or "") == stem:
                    notes.append("日间" if int(item.get("start_time") or 0) < 18 else "夜间")
                    break
            else:
                notes.append(stem)
        return cha, skin, notes, True
    if exact:
        if any(row.get("evo_class") for row in exact):
            skin = "改造"
        else:
            skin = "初见"
            if any(str(row.get("cid") or "").startswith("18") for row in exact):
                notes.append("战利品")
        return cha, skin, notes, True
    if mons:
        return cha, "初见", notes, True
    return cha, stem or "未知", notes, False


def _check_painting_names(by_cid, by_skin, by_ship, by_mon) -> None:
    cases = {
        "11_1": ("内华达", "圣诞服"),
        "1": ("胡德", "初见"),
        "1001": ("胡德", "改造"),
        "15": ("比睿", "初见"),
        "1015": ("比睿", "改造"),
        "38": ("欧根亲王", "初见"),
        "8038": ("欧根亲王", "初见"),
        "9601": ("狐灰色", "初见"),
        "528_9": ("芝加哥", "圣诞夜的信使"),
    }
    for stem, expect in cases.items():
        cha, skin, _notes, _hit = resolve_painting_name(stem, by_cid, by_skin, by_ship, by_mon)
        if (cha, skin) != expect:
            raise RuntimeError(f"立绘名 {stem}: {(cha, skin)} != {expect}")


def export_painting_texture(bundle: Path, dest: Path) -> str:
    import UnityPy

    env = UnityPy.load(str(bundle))
    images = []
    for obj in env.objects:
        if getattr(obj.type, "name", None) != "Texture2D":
            continue
        data = obj.read()
        if data.image is not None:
            images.append(data.image)
    if not images:
        return "empty"
    picked = max(images, key=lambda image: image.width * image.height)
    dest.parent.mkdir(parents=True, exist_ok=True)
    picked.save(dest, "PNG")
    return "ok"


def cmd_painting(args: argparse.Namespace) -> int:
    if not MODEL_L_DIR.is_dir():
        raise FileNotFoundError(f"还没有 {MODEL_L_DIR}，先跑 assets")
    ship_table = MASTER_DIR / "config" / "json" / "ship.json"
    if not ship_table.is_file():
        raise FileNotFoundError("还没有 MasterData 表，先跑 masterdata")
    by_cid, by_skin, by_ship, by_mon = load_painting_maps()
    _check_painting_names(by_cid, by_skin, by_ship, by_mon)
    bundles = sorted(MODEL_L_DIR.glob("*.unity3d"))
    if args.limit:
        bundles = bundles[: args.limit]
    used: set[str] = set()
    jobs = []
    named = 0
    for bundle in bundles:
        cha, skin, notes, hit = resolve_painting_name(bundle.stem, by_cid, by_skin, by_ship, by_mon)
        if hit:
            named += 1
        jobs.append((bundle, PAINTING_DIR / painting_filename(cha, skin, used, notes), hit))
    print(f"立绘名称 命中 {named}/{len(jobs)} → {PAINTING_DIR}")
    written = skipped = fail = empty = 0
    force = bool(args.force)

    def one(item: tuple[Path, Path, bool]) -> str:
        bundle, dest, _hit = item
        if dest.is_file() and not force:
            return "skip"
        try:
            return export_painting_texture(bundle, dest)
        except Exception as exc:
            dest.unlink(missing_ok=True)
            print(f"立绘失败 {bundle.stem}: {exc}", flush=True)
            return "fail"

    workers = max(1, args.jobs)
    done = 0
    with ThreadPoolExecutor(max_workers=workers) as pool:
        futures = [pool.submit(one, item) for item in jobs]
        for fut in as_completed(futures):
            status = fut.result()
            if status == "ok":
                written += 1
            elif status == "skip":
                skipped += 1
            elif status == "empty":
                empty += 1
            else:
                fail += 1
            done += 1
            if done % 100 == 0 or done == len(jobs):
                print(f"  导出 {done}/{len(jobs)}", flush=True)
    print(f"Painting 写出 {written}  跳过 {skipped}  空 {empty}  失败 {fail} → {PAINTING_DIR}")
    return 0 if fail == 0 else 1


def cmd_assets(args: argparse.Namespace) -> int:
    apk = find_apk(args.apk)
    version = app_version_from_apk(apk, args.app_version)
    print(f"{GAME_TITLE} APK {apk.name}  v{version}")
    count = extract_apk_assets(apk, ASSETS_DIR)
    print(f"解出 assets {count} 个文件")
    info = fetch_patch_info(version, args.from_version)
    chain = patch_chain(info["patch"]["patch_set"]["main"]["version_set"], args.from_version)
    files = [(item["version"], part) for item in chain for part in item["file_list"]]
    print(f"热更 {len(chain)} 个版本，{len(files)} 个包")
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    packet_root = CACHE_DIR / "packet"
    if packet_root.exists():
        shutil.rmtree(packet_root)

    def one(job: tuple[str, dict]) -> Path:
        ver, part = job
        dest = CACHE_DIR / "zip" / ver / Path(urllib.parse.urlparse(part["url"]).path).name
        download(part["url"], dest, part["md5"])
        return dest

    done = 0
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = [pool.submit(one, job) for job in files]
        for fut in as_completed(futures):
            fut.result()
            done += 1
            print(f"  下载 {done}/{len(files)}", flush=True)
    zips = [
        CACHE_DIR / "zip" / ver / Path(urllib.parse.urlparse(part["url"]).path).name
        for ver, part in files
    ]
    index = {"overlays": [], "deletes": []}
    loose = packets = 0
    for zip_path in zips:
        a, b = apply_patch_zip(zip_path, ASSETS_DIR, index)
        loose += a
        packets += b
    OVERLAY_INDEX.write_text(json.dumps(index, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    stripped, manifests = normalize_bundles()
    size = dir_size(ASSETS_DIR)
    print(f"散文件 {loose}，数据包 {packets}，去掉假头 {stripped}，清单 {manifests}")
    print(f"Assets {size / 1024 / 1024:.1f} MiB")
    return 0


def cmd_masterdata(args: argparse.Namespace) -> int:
    if not ASSETS_DIR.is_dir():
        raise FileNotFoundError("还没有 Assets，先跑 assets")
    if MASTER_DIR.exists():
        shutil.rmtree(MASTER_DIR)
    MASTER_DIR.mkdir()
    stats = {"lua": 0, "luac": 0, "json": 0, "json_fail": 0, "other": 0}
    tables = merged_packets()
    seen = set()
    for members in tables.values():
        if id(members) in seen:
            continue
        seen.add(id(members))
        for rel, blob in members.items():
            emit_member(rel, blob, stats)
    print(
        f"MasterData  json {stats['json']}  失败 {stats['json_fail']}  "
        f"lua {stats['lua']}  未反编译 {stats['luac']}  其他 {stats['other']}"
    )
    return 0


def cmd_update(args: argparse.Namespace) -> int:
    cmd_assets(args)
    return cmd_masterdata(args)


def cmd_status(_args: argparse.Namespace) -> int:
    apk = next(iter(sorted(SCRIPT_DIR.glob("*.apk"))), None)
    print(f"APK {apk.name if apk else '无'}")
    print(f"Assets {dir_size(ASSETS_DIR) / 1024 / 1024:.1f} MiB  存在 {ASSETS_DIR.is_dir()}")
    print(f"MasterData {dir_size(MASTER_DIR) / 1024 / 1024:.1f} MiB  存在 {MASTER_DIR.is_dir()}")
    print(f"Painting {dir_size(PAINTING_DIR) / 1024 / 1024:.1f} MiB  存在 {PAINTING_DIR.is_dir()}")
    if OVERLAY_INDEX.is_file():
        index = json.loads(OVERLAY_INDEX.read_text(encoding="utf-8"))
        print(f"补丁包覆盖 {len(index.get('overlays', []))}  删除 {len(index.get('deletes', []))}")
    return 0


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--apk", help="APK 路径，默认脚本目录里最新的一个")
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="下载线程数")
    shared.add_argument("--app-version", help="例如 5.6.0，默认从 APK 文件名取")
    shared.add_argument("--from-version", default=DEFAULT_PATCH_VERSION, help="客户端已有的热更版本")
    parser = argparse.ArgumentParser(description=f"{GAME_TITLE} 资产与数据表")
    sub = parser.add_subparsers(dest="cmd", required=True)
    sub.add_parser("assets", parents=[shared], help="APK + 热更 → Assets/，去掉 UnityFS 假头")
    sub.add_parser("masterdata", parents=[shared], help="lxdata 里的 JSON / Lua → MasterData/")
    sub.add_parser("update", parents=[shared], help="assets 然后 masterdata")
    paint = sub.add_parser("painting", parents=[shared], help="立绘 → Painting/，名字还原")
    paint.add_argument("--force", action="store_true", help="覆盖已有 PNG")
    paint.add_argument("--limit", type=int, default=0, help="只处理前 N 个，调试用")
    sub.add_parser("status", parents=[shared], help="看 APK / Assets / MasterData")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    commands = {
        "assets": cmd_assets,
        "masterdata": cmd_masterdata,
        "update": cmd_update,
        "painting": cmd_painting,
        "status": cmd_status,
    }
    return commands[args.cmd](args)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (FileNotFoundError, RuntimeError, ValueError) as exc:
        print(exc, file=sys.stderr)
        raise SystemExit(1)
