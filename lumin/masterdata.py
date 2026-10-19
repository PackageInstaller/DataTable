from __future__ import annotations

import base64
import hashlib
import json
import re
import shutil
import subprocess
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any

import UnityPy

from .unityfs import UnityFS

AOT_CRYPTO_KEY = hashlib.sha256(b"Lumin_Key_v1").digest()
_JSON_NAME = re.compile(r"[^\w.\-()\[\] ]+")


def _decrypt_bundle(raw: bytes) -> bytes:
    try:
        return UnityFS(raw).decrypted_bytes()
    except Exception:
        return raw


def _iter_textassets(raw: bytes):
    env = UnityPy.load(_decrypt_bundle(raw))
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        try:
            ta = obj.read()
        except Exception:
            continue
        name = getattr(ta, "m_Name", None) or f"textasset_{obj.path_id}"
        data = getattr(ta, "m_Script", b"")
        if isinstance(data, str):
            data = data.encode("utf-8", "surrogateescape")
        yield name, bytes(data)


def _json_bytes(data: bytes) -> tuple[bytes, str] | None:
    text = None
    for enc in ("utf-8-sig", "utf-8", "gb18030"):
        try:
            text = data.decode(enc)
            break
        except UnicodeDecodeError:
            continue
    if text is None:
        return None
    try:
        obj = json.loads(text)
    except Exception:
        return None
    return (
        json.dumps(obj, ensure_ascii=False, indent=2).encode("utf-8") + b"\n",
        "json",
    )


def _safe_name(name: str) -> str:
    name = name.replace("\\", "/").split("/")[-1].strip()
    name = _JSON_NAME.sub("_", name)
    return name or "unnamed"


def export_clientstatic_bundle(raw: bytes, out_dir: Path, overwrite: bool = False) -> dict:
    out_dir.mkdir(parents=True, exist_ok=True)
    stats = {"tables": 0, "json": 0, "raw": 0, "files": []}
    for name, data in _iter_textassets(raw):
        stats["tables"] += 1
        parsed = _json_bytes(data)
        base = _safe_name(name)
        if parsed is not None:
            payload, kind = parsed
            path = out_dir / (base if base.endswith(".json") else base + ".json")
            stats["json"] += 1
        else:
            kind = "raw"
            path = out_dir / (base if Path(base).suffix else base + ".bytes")
            payload = data
            stats["raw"] += 1
        stats["files"].append(path.name)
        if path.is_file() and not overwrite and path.stat().st_size == len(payload):
            continue
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(payload)
    return stats


def export_dll_bundle(raw: bytes, out_dir: Path, overwrite: bool = False) -> dict:
    out_dir.mkdir(parents=True, exist_ok=True)
    stats = {"files": 0, "names": []}
    for name, data in _iter_textassets(raw):
        base = _safe_name(name)
        if not Path(base).suffix:
            base += ".dll"
        path = out_dir / base
        stats["files"] += 1
        stats["names"].append(path.name)
        if path.is_file() and not overwrite and path.stat().st_size == len(data):
            continue
        path.write_bytes(data)
    return stats


def decompile_dlls(
    dll_dir: Path,
    out_dir: Path | None = None,
    dep_dirs: list[Path] | tuple[Path, ...] | Path | None = None,
    overwrite: bool = False,
    jobs: int = 4,
    log_fn: Any | None = None,
) -> int:
    dll_dir = Path(dll_dir)
    if not dll_dir.is_dir():
        return 0

    dlls = sorted(dll_dir.glob("*.dll"))
    if not dlls:
        return 0

    ilspy = shutil.which("ilspycmd")
    if not ilspy:
        msg = "未检测到系统命令 ilspycmd，保留原始 DLL，跳过反编译。"
        if log_fn:
            log_fn(msg)
        else:
            print(f"[!] {msg}")
        return 0

    ref_paths: list[Path] = []
    if dep_dirs:
        raw_deps = [dep_dirs] if isinstance(dep_dirs, (str, Path)) else list(dep_dirs)
        for d in raw_deps:
            p = Path(d)
            if p.is_dir() and p not in ref_paths:
                ref_paths.append(p)
    if dll_dir not in ref_paths:
        ref_paths.append(dll_dir)

    target_root = Path(out_dir) if out_dir else dll_dir
    needed: list[Path] = []
    for dll in dlls:
        t_dir = target_root / dll.stem
        if not overwrite and t_dir.is_dir() and any(t_dir.glob("*.csproj")):
            continue
        needed.append(dll)

    if not needed:
        if log_fn:
            log_fn(f"AOT: 所有 {len(dlls)} 个程序集均已完成反编译，跳过")
        return len(dlls)

    dep_desc = f" (依赖目录: {', '.join(str(p) for p in ref_paths)})" if ref_paths else ""
    if log_fn:
        log_fn(f"AOT: 正在调用 ilspycmd 反编译 {len(needed)}/{len(dlls)} 个程序集 (并发 {jobs}){dep_desc}...")

    def _decompile_one(dll_path: Path) -> tuple[Path, bool, str]:
        t_dir = target_root / dll_path.stem
        t_dir.mkdir(parents=True, exist_ok=True)
        cmd = [
            ilspy,
            "-p",
            "--nested-directories",
            "-o",
            str(t_dir),
        ]
        for r in ref_paths:
            cmd.extend(["-r", str(r)])
        cmd.append(str(dll_path))
        try:
            res = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=600,
                check=False,
            )
            ncs = sum(1 for _ in t_dir.rglob("*.cs"))
            if res.returncode == 0 or ncs > 0:
                return dll_path, True, f"{ncs} 个 .cs"
            err = (res.stderr or res.stdout or "").strip()[:100]
            return dll_path, False, f"异常 ({err})"
        except Exception as exc:
            return dll_path, False, str(exc)

    success_count = len(dlls) - len(needed)
    with ThreadPoolExecutor(max_workers=max(1, min(jobs, 8))) as pool:
        futures = {pool.submit(_decompile_one, d): d for d in needed}
        for fut in as_completed(futures):
            dll_path, ok, info = fut.result()
            if ok:
                success_count += 1
                if log_fn:
                    log_fn(f"  ✓ {dll_path.name} -> {info}")
            else:
                if log_fn:
                    log_fn(f"  ⚠ {dll_path.name} 反编译告警: {info}")

    return success_count


def decrypt_version_txt(text: str) -> str | None:
    text = text.strip().lstrip("\ufeff")
    if not text.startswith("ENC:"):
        return None
    try:
        from Crypto.Cipher import AES
        from Crypto.Util.Padding import unpad

        blob = base64.b64decode(text[4:])
        iv, body = blob[:16], blob[16:]
        plain = AES.new(AOT_CRYPTO_KEY, AES.MODE_CBC, iv).decrypt(body)
        return unpad(plain, 16).decode("utf-8", "replace")
    except Exception:
        return None


def write_configs(
    out_dir: Path,
    *,
    remote_config: dict | None = None,
    manifests: dict[str, dict] | None = None,
    version_txt: str | None = None,
    overwrite: bool = True,
) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    if remote_config is not None:
        (out_dir / "remote_config.json").write_text(
            json.dumps(remote_config, ensure_ascii=False, indent=2), encoding="utf-8"
        )
    if manifests:
        mdir = out_dir / "manifests"
        mdir.mkdir(parents=True, exist_ok=True)
        for name, summary in manifests.items():
            (mdir / f"{name}.json").write_text(
                json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8"
            )
    if version_txt:
        (out_dir / "version.txt").write_text(version_txt, encoding="utf-8")


def write_index(master_dir: Path, tables: list[str], aot: list[str], localization: int = 0) -> None:
    master_dir.mkdir(parents=True, exist_ok=True)
    index = {
        "generated_by": "Lumin.py",
        "clientstatic_tables": sorted(tables),
        "aot_assemblies": sorted(aot),
        "localization_json": localization,
    }
    (master_dir / "index.json").write_text(
        json.dumps(index, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def export_localization(
    bundle_path: Path,
    out_dir: Path,
    overwrite: bool = False,
    log_fn=None,
) -> int:
    bundle_path = Path(bundle_path)
    if not bundle_path.is_file():
        return 0

    try:
        raw = UnityFS(bundle_path.read_bytes()).decrypted_bytes()
        env = UnityPy.load(raw)
    except Exception as exc:
        if log_fn:
            log_fn(f"无法加载本地化 Bundle {bundle_path.name}: {exc}")
        return 0

    shared_keys: dict[str, dict[int, str]] = {}
    for obj in env.objects:
        if obj.type.name != "MonoBehaviour":
            continue
        try:
            data = obj.read()
        except Exception:
            continue
        name = getattr(data, "m_Name", "")
        if hasattr(data, "m_Entries"):
            coll = name.replace(" Shared Data", "").strip()
            shared_keys[coll] = {}
            for e in getattr(data, "m_Entries", []):
                kid = getattr(e, "m_Id", None)
                key = getattr(e, "m_Key", None)
                if kid is not None:
                    shared_keys[coll][int(kid)] = str(key) if key is not None else ""

    count = 0
    out_dir = Path(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    for obj in env.objects:
        if obj.type.name != "MonoBehaviour":
            continue
        try:
            data = obj.read()
        except Exception:
            continue
        name = getattr(data, "m_Name", "")
        if hasattr(data, "m_TableData"):
            code = getattr(data.m_LocaleId, "m_Code", "unknown") if hasattr(data, "m_LocaleId") else "unknown"
            coll = name.rsplit("_", 1)[0]
            keys = shared_keys.get(coll, {})
            entries = getattr(data, "m_TableData", [])
            if not entries:
                continue

            rows = []
            for e in entries:
                kid = getattr(e, "m_Id", None)
                loc = getattr(e, "m_Localized", "")
                rows.append({
                    "id": kid,
                    "key": keys.get(int(kid)) if kid is not None else None,
                    "value": loc,
                })

            sub = out_dir / code
            sub.mkdir(parents=True, exist_ok=True)
            target = sub / f"{name}.json"
            if target.is_file() and not overwrite:
                count += 1
                continue

            content = json.dumps(rows, ensure_ascii=False, indent=2).encode("utf-8")
            target.write_bytes(content)
            count += 1

    return count

