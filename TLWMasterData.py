from __future__ import annotations

import argparse
import base64
import csv
import io
import json
import os
import re
import shutil
import time
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from functools import lru_cache
from pathlib import Path
from typing import Any
from urllib.parse import urlparse

from rich.console import Console
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
)
from rich.table import Table

import TLWConfig as C
import TLWDecrypt as D
import TLWHotUpdate as H

CONSOLE = Console()


MASTER_SUFFIX = "Master.bytes"
TABLE_SUFFIX = ".bytes"
SCHEMA_FILENAME = "_schema.json"
SUMMARY_FILENAME = "masterdata_summary.json"

IL2CPP_CS = C.SCRIPT_DIR / "cs" / "il2cpp.cs"
UNITY_DATA_CACHE = C.DATA_CACHE_DIR / "data.unity3d"
APK_MASTER_MANIFEST = C.APK_MASTER_PREFIX + "manifest.json"

HAR_GLOB = "*.har"
SERVER_HOST_HINTS = ("eastmajor.yuqinet.com",)
SERVER_DIRNAME = "server"


_SIMPLE_TYPES = (str, int, float, bool, type(None))



def _atomic_write_bytes(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name("." + path.name + "." + str(os.getpid()) + ".part")
    tmp.write_bytes(data)
    os.replace(tmp, path)



def _json_default(value: Any) -> Any:
    if isinstance(value, bytes):
        try:
            return value.decode("utf-8")
        except UnicodeDecodeError:
            return base64.b64encode(value).decode("ascii")
    if isinstance(value, (set, frozenset, tuple)):
        return list(value)
    if isinstance(value, Path):
        return str(value)
    raise TypeError("无法序列化的类型 " + type(value).__name__)


def _write_json(path: Path, payload: Any) -> int:
    text = json.dumps(payload, ensure_ascii=False, indent=2, default=_json_default)
    data = (text + "\n").encode("utf-8")
    _atomic_write_bytes(path, data)
    return len(data)


def _sanitize_value(value: Any) -> Any:
    if isinstance(value, _SIMPLE_TYPES):
        return value
    if isinstance(value, bytes):
        return _json_default(value)
    if isinstance(value, dict):
        return {str(k): _sanitize_value(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [_sanitize_value(v) for v in value]
    return str(value)


def _sorted_table_items(mapping: dict) -> list[tuple[Any, Any]]:
    def sort_key(item: tuple[Any, Any]) -> tuple[int, Any]:
        key = item[0]
        if isinstance(key, bool):
            return (0, int(key))
        if isinstance(key, (int, float)):
            return (0, key)
        return (1, str(key))

    return sorted(mapping.items(), key=sort_key)


def _json_safe(value: Any) -> Any:
    if isinstance(value, dict):
        return {str(k): _json_safe(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [_json_safe(v) for v in value]
    if isinstance(value, (str, int, float, bool)) or value is None:
        return value
    return str(value)


_CLASS_RE = re.compile(
    r"^public\s+(?:sealed\s+|abstract\s+|partial\s+)*class\s+(\w+)"
    r"(?:\s*<[^>]*>)?\s*(?::\s*([^{]+?))?\s*(?://.*)?$"
)
_ATTR_RE = re.compile(r"\[MessagePackMember\((\d+)\)\]")
_FIELD_RE = re.compile(
    r"^\s*public\s+([A-Za-z_][\w\.\<\>\[\],\s\?]*?)\s+(\w+)\s*;\s*(?://.*)?$"
)
_NON_INSTANCE_WORDS = ("static", "const", "readonly")


def _sanitize_line(line: str) -> str:
    out: list[str] = []
    i = 0
    n = len(line)
    in_str = False
    in_chr = False
    while i < n:
        ch = line[i]
        if in_str:
            if ch == "\\":
                i += 2
                continue
            if ch == '"':
                in_str = False
            i += 1
            continue
        if in_chr:
            if ch == "\\":
                i += 2
                continue
            if ch == "'":
                in_chr = False
            i += 1
            continue
        if ch == '"':
            in_str = True
            i += 1
            continue
        if ch == "'":
            in_chr = True
            i += 1
            continue
        if ch == "/" and i + 1 < n and line[i + 1] == "/":
            break
        out.append(ch)
        i += 1
    return "".join(out)


def _split_top_level(text: str) -> list[str]:
    parts: list[str] = []
    buf: list[str] = []
    depth = 0
    for ch in text:
        if ch in "<([":
            depth += 1
        elif ch in ">)]":
            depth -= 1
        if ch == "," and depth == 0:
            parts.append("".join(buf).strip())
            buf = []
        else:
            buf.append(ch)
    if "".join(buf).strip():
        parts.append("".join(buf).strip())
    return parts


def _base_class_name(base_text: str) -> str:
    base_text = (base_text or "").strip()
    if not base_text:
        return ""
    first = _split_top_level(base_text)[0]
    return re.sub(r"<.*", "", first).strip()


@lru_cache(maxsize=1)
def _load_il2cpp_classes() -> dict[str, dict]:
    path = IL2CPP_CS
    classes: dict[str, dict] = {}
    cur: dict | None = None
    open_seen = False
    depth = 0
    pending: int | None = None

    def finish() -> None:
        nonlocal cur, open_seen, depth, pending
        if cur is not None:
            classes[cur["name"]] = cur
        cur = None
        open_seen = False
        depth = 0
        pending = None

    with open(path, encoding="utf-8-sig", errors="replace") as fh:
        for raw_line in fh:
            clean = _sanitize_line(raw_line)
            if cur is None:
                m = _CLASS_RE.match(clean)
                if m:
                    cur = {
                        "name": m.group(1),
                        "base": (m.group(2) or "").strip(),
                        "fields": {},
                        "decl": [],
                    }
                continue
            if not open_seen:
                depth += clean.count("{") - clean.count("}")
                if "{" in clean:
                    open_seen = True
                    if depth <= 0:
                        finish()
                continue
            if depth == 1:
                attr = _ATTR_RE.search(clean)
                if attr:
                    pending = int(attr.group(1))
                elif pending is not None:
                    field = _FIELD_RE.match(raw_line)
                    if field:
                        cur["fields"][pending] = (field.group(2), field.group(1).strip())
                        pending = None
                field2 = _FIELD_RE.match(raw_line)
                if field2:
                    type_words = field2.group(1).strip().split()
                    if not any(word in _NON_INSTANCE_WORDS for word in type_words):
                        cur["decl"].append(field2.group(2))
            depth += clean.count("{") - clean.count("}")
            if depth <= 0:
                finish()
    finish()
    return classes


def _table_record_map(classes: dict[str, dict]) -> dict[str, dict]:
    mapping: dict[str, dict] = {}
    for name, info in classes.items():
        base = info.get("base") or ""
        if "MasterTable" not in base:
            continue
        generic = re.search(r"MasterTable\s*<(.*)>", _split_top_level(base)[0])
        if not generic:
            continue
        args = _split_top_level(generic.group(1))
        if len(args) != 2:
            continue
        mapping[name] = {"key": args[0].strip(), "record": args[1].strip()}
    return mapping


def _is_master_record(classes: dict[str, dict], record_name: str) -> bool:
    cur = record_name
    seen: set[str] = set()
    while cur and cur in classes and cur not in seen:
        seen.add(cur)
        if cur == "MasterRecord":
            return True
        base = _base_class_name(classes[cur].get("base") or "")
        if base == "MasterRecord":
            return True
        cur = base
    return False


def _record_field_names(
    classes: dict[str, dict], record_name: str
) -> tuple[list[str] | None, str, list[str]]:
    chain: list[str] = []
    cur: str | None = record_name
    seen: set[str] = set()
    while cur and cur in classes and cur not in seen:
        seen.add(cur)
        chain.append(cur)
        cur = _base_class_name(classes[cur].get("base") or "")

    fields: dict[int, str] = {}
    for cls in reversed(chain):
        for index, (field_name, _field_type) in classes[cls]["fields"].items():
            fields[index] = field_name
    if fields:
        max_index = max(fields)
        result = [fields.get(i, "field_" + str(i)) for i in range(max_index + 1)]
        return result, "il2cpp", chain

    # 无 [MessagePackMember] 的 Record（如 PriceRecord / RandomNameRecord）：
    # MessagePack 按字段声明顺序序列化，所以按声明顺序收集 public 实例字段。
    decl: list[str] = []
    for cls in reversed(chain):
        decl.extend(classes[cls]["decl"])
    if decl:
        return decl, "decl", chain
    return None, "none", chain


class _SchemaRegistry:
    def __init__(self, classes: dict[str, dict]):
        self.classes = classes
        self.table_map = _table_record_map(classes)
        self.csv_headers: dict[str, list[str]] = {}
        self.record_schemas: dict[str, tuple[list[str], str]] = {}
        for name in classes:
            if not name.endswith("Record"):
                continue
            if not _is_master_record(classes, name):
                continue
            fields, source, _chain = _record_field_names(classes, name)
            if fields:
                self.record_schemas[name] = (fields, source)
        self._by_length: dict[int, list[str]] = {}
        for name, (fields, _source) in self.record_schemas.items():
            self._by_length.setdefault(len(fields), []).append(name)

    def _record_of(self, base: str) -> str | None:
        conn = self.table_map.get(base + "Table")
        if conn:
            return conn["record"]
        direct = base + "Record"
        return direct if direct in self.classes else None

    def resolve(self, base: str, row_length: int) -> tuple[list[str], dict]:
        notes: list[str] = []
        record = self._record_of(base)
        fields: list[str] | None = None
        source = "none"
        if record and record in self.classes:
            fields, source, _chain = _record_field_names(self.classes, record)
            if fields and (row_length == 0 or len(fields) == row_length):
                return fields, {"record": record, "source": source, "notes": notes}
            if fields:
                notes.append(
                    "IL 字段数 " + str(len(fields)) + " 与数据列数 " + str(row_length) + " 不一致"
                )

        csv_name = base + "Master"
        header = self.csv_headers.get(csv_name)
        if header and (row_length == 0 or len(header) == row_length):
            notes.append("使用 APK CSV 表头：" + csv_name)
            return header, {"record": record or "", "source": "csv", "notes": notes}

        if row_length > 0:
            candidates = self._by_length.get(row_length) or []
            if len(candidates) == 1:
                cand = candidates[0]
                notes.append("按列数唯一匹配 Record：" + cand)
                return self.record_schemas[cand][0], {
                    "record": cand,
                    "source": "count",
                    "notes": notes,
                }

        if fields:
            notes.append("字段数与列数不一致，按 IL 字段截断/补齐")
            if len(fields) > row_length:
                fields = fields[:row_length]
                src = "il2cpp-trunc"
            else:
                fields = fields + ["field_" + str(i) for i in range(len(fields), row_length)]
                src = "il2cpp-pad"
            return fields, {"record": record or "", "source": src, "notes": notes}

        notes.append("无法确定字段名，使用 field_N")
        return ["field_" + str(i) for i in range(row_length)], {
            "record": record or "",
            "source": "generic",
            "notes": notes,
        }




def _ensure_unity_data() -> Path:
    cache = UNITY_DATA_CACHE
    if cache.is_file() and cache.stat().st_size > (1 << 20):
        return cache

    apk = C.find_default_apk()
    if apk is None:
        raise FileNotFoundError("找不到 APK，无法提取 " + C.APK_UNITY_DATA)
    cache.parent.mkdir(parents=True, exist_ok=True)
    tmp = cache.with_name("." + cache.name + "." + str(os.getpid()) + ".part")
    with zipfile.ZipFile(apk) as zf:
        try:
            info = zf.getinfo(C.APK_UNITY_DATA)
        except KeyError as ex:
            raise FileNotFoundError(
                "APK 内缺少 " + C.APK_UNITY_DATA + "，请确认 APK 完整性"
            ) from ex
        CONSOLE.print(
            "[cyan]从 APK 提取 data.unity3d（"
            + format(info.file_size / 1e6, ".1f")
            + " MB）...[/cyan]"
        )
        with zf.open(info) as src, open(tmp, "wb") as dst:
            shutil.copyfileobj(src, dst, 1 << 20)
    os.replace(tmp, cache)
    return cache


@lru_cache(maxsize=1)
def _load_unity_text_assets() -> dict[str, bytes]:
    try:
        import UnityPy  # type: ignore
    except Exception as ex:  # noqa: BLE001
        CONSOLE.print("[yellow]UnityPy 不可用，跳过 CSV 校验与 APK TextAsset 导出："
                      + str(ex) + "[/yellow]")
        return {}
    try:
        unity_data = _ensure_unity_data()
        env = UnityPy.load(str(unity_data))
    except Exception as ex:  # noqa: BLE001
        CONSOLE.print("[yellow]读取 data.unity3d 失败：" + str(ex) + "[/yellow]")
        return {}

    assets: dict[str, bytes] = {}
    for obj in env.objects:
        if getattr(obj.type, "name", "") != "TextAsset":
            continue
        try:
            data = obj.read()
        except Exception:  # noqa: BLE001
            continue
        name = str(getattr(data, "m_Name", "") or "")
        script = getattr(data, "m_Script", b"")
        if isinstance(script, str):
            script = script.encode("utf-8", "surrogateescape")
        if name:
            assets[name] = bytes(script)
    return assets


def _load_csv_headers() -> dict[str, list[str]]:
    assets = _load_unity_text_assets()
    if not assets:
        return {}
    wanted = {_table_name(filename) for filename in _manifest_filenames()}
    headers: dict[str, list[str]] = {}
    for name, raw in assets.items():
        if name not in wanted:
            continue
        try:
            text = raw.decode("utf-8-sig", errors="replace")
            header = next(csv.reader(io.StringIO(text)), None)
        except Exception:  # noqa: BLE001
            continue
        if not header:
            continue
        header = [str(col).strip() for col in header]
        if header and all(header):
            headers[name] = header
    return headers



def _load_manifest(refresh: bool = False) -> dict:
    return H.load_manifest("master", refresh=refresh)


def _manifest_entries(refresh: bool = False) -> list[dict]:
    return H.manifest_entries(_load_manifest(refresh))


def _manifest_filenames(refresh: bool = False) -> list[str]:
    return [_entry_filename(entry) for entry in _manifest_entries(refresh)]


def _entry_filename(entry: dict) -> str:
    paths = entry.get("AssetPaths") or []
    if paths:
        return str(paths[0]).rsplit("/", 1)[-1]
    name = str(entry.get("Name") or "unknown")
    return name if name.endswith(TABLE_SUFFIX) else name + TABLE_SUFFIX


def _table_name(filename: str) -> str:
    """AbilityMaster.bytes -> AbilityMaster。"""
    return filename[: -len(TABLE_SUFFIX)] if filename.endswith(TABLE_SUFFIX) else Path(filename).stem


def _master_dest(entry: dict) -> Path:
    return C.MASTER_OUT_DIR / _entry_filename(entry)



def _merge_stats(total: dict, part: dict) -> None:
    for key in ("total", "ok", "skip", "fail", "bytes"):
        total[key] = total.get(key, 0) + int(part.get(key) or 0)


def _download_master(
    *,
    progress: Progress | None,
    jobs: int,
    force: bool,
    refresh: bool,
    limit: int,
) -> dict:
    if refresh:
        _load_manifest(refresh=True)

    special = dict(D.MASTER_TABLE_ENCRYPTION_KEYS)
    filename_of = _entry_filename
    summary = {"total": 0, "ok": 0, "skip": 0, "fail": 0, "bytes": 0}

    stats = H.sync_category(
        "master",
        _master_dest,
        transform=D.decrypt_master,
        jobs=jobs,
        force=force,
        limit=limit,
        filter_fn=lambda entry: filename_of(entry) not in special,
        progress=progress,
    )
    _merge_stats(summary, stats)

    for filename, enckey in special.items():
        stats = H.sync_category(
            "master",
            _master_dest,
            transform=lambda data, key=enckey: D.decrypt_master(data, key),
            jobs=1,
            force=force,
            limit=1,
            filter_fn=lambda entry, name=filename: filename_of(entry) == name,
            progress=None,
        )
        _merge_stats(summary, stats)

    return summary


def _decode_one_table(
    entry: dict,
    registry: _SchemaRegistry,
    csv_headers: dict[str, list[str]],
    tables_dir: Path,
) -> dict:
    filename = _entry_filename(entry)
    table_name = _table_name(filename)
    base = table_name[: -len("Master")] if table_name.endswith("Master") else table_name
    info: dict[str, Any] = {"file": filename, "table": table_name, "base": base}

    path = _master_dest(entry)
    if not path.is_file():
        info["status"] = "missing"
        return info
    raw = path.read_bytes()
    info["bytes"] = len(raw)
    try:
        payload = D.unpack_msgpack(raw)
    except Exception as ex:  # noqa: BLE001
        info["status"] = "fail"
        info["error"] = "MessagePack 解码失败: " + type(ex).__name__ + ": " + str(ex)
        return info
    if not isinstance(payload, dict):
        info["status"] = "fail"
        info["error"] = "顶层类型不是 dict 而是 " + type(payload).__name__
        return info

    rows = len(payload)
    info["rows"] = rows
    fields: list[str] = []
    meta: dict[str, Any] = {"record": "", "source": "none", "notes": []}

    if rows:
        lengths = set()
        for row in payload.values():
            if not isinstance(row, (list, tuple)):
                info["status"] = "fail"
                info["error"] = "记录值不是数组（MessagePack 结构异常）"
                return info
            lengths.add(len(row))
        row_length = len(next(iter(payload.values())))
        if len(lengths) != 1:
            row_length = max(lengths)
            meta["notes"].append("同一张表行长度不一致: " + str(sorted(lengths)))
        fields, meta = registry.resolve(base, row_length)
        meta = {
            "record": meta.get("record", ""),
            "source": meta.get("source", "none"),
            "notes": list(meta.get("notes") or []),
        }
    else:
        record = registry._record_of(base)
        if record and record in registry.classes:
            fields, source, _chain = _record_field_names(registry.classes, record)
            meta = {"record": record, "source": source or "none", "notes": []}
        else:
            fields = []

    data: dict[str, Any] = {}
    for key, row in _sorted_table_items(payload):
        values = list(row)
        if len(values) < len(fields):
            values.extend([None] * (len(fields) - len(values)))
        data[str(key)] = {
            name: _sanitize_value(value) for name, value in zip(fields, values)
        }

    dest = tables_dir / (table_name + ".json")
    written = _write_json(dest, data)
    info.update(
        {
            "status": "ok",
            "fields": fields,
            "field_count": len(fields),
            "source": meta["source"],
            "record": meta["record"],
            "notes": meta["notes"],
            "json_bytes": written,
        }
    )

    header = csv_headers.get(table_name)
    if header:
        if len(header) == len(fields):
            if header == fields:
                info["csv_check"] = "match"
            else:
                info["csv_check"] = "mismatch"
                info["csv_diff"] = [
                    left + "≠" + right
                    for left, right in zip(fields, header)
                    if left != right
                ][:5]
        else:
            info["csv_check"] = "length"
            info["csv_lengths"] = (len(fields), len(header))
    return info


def _decode_masterdata(
    *, jobs: int, progress: Progress | None, limit: int
) -> dict:
    entries = _manifest_entries()
    if limit > 0:
        entries = entries[:limit]

    classes = _load_il2cpp_classes()
    registry = _SchemaRegistry(classes)
    csv_headers = _load_csv_headers()
    registry.csv_headers = csv_headers

    tables_dir = C.MASTERDATA_TABLES_DIR
    tables_dir.mkdir(parents=True, exist_ok=True)

    stats: dict[str, Any] = {
        "tables": len(entries),
        "ok": 0,
        "empty": 0,
        "rows": 0,
        "bytes": 0,
        "schema_sources": {},
        "empty_tables": [],
        "fail": [],
        "missing": [],
        "warnings": [],
        "csv_checks": {"match": 0, "mismatch": [], "length_mismatch": []},
        "il2cpp_classes": len(classes),
        "il2cpp_records": len(registry.record_schemas),
        "csv_tables": len(csv_headers),
    }
    schema_map: dict[str, list[str]] = {}
    table_row_counts: dict[str, int] = {}

    task_id = None
    if progress is not None:
        task_id = progress.add_task("[cyan]解码 MasterData", total=len(entries) or 1)

    def work(entry: dict) -> dict:
        try:
            return _decode_one_table(entry, registry, csv_headers, tables_dir)
        except Exception as ex:  # noqa: BLE001
            return {
                "file": _entry_filename(entry),
                "table": _table_name(_entry_filename(entry)),
                "status": "fail",
                "error": type(ex).__name__ + ": " + str(ex),
            }

    worker_count = max(1, min(jobs, 8)) 
    futures = {}
    with ThreadPoolExecutor(max_workers=worker_count) as pool:
        for entry in entries:
            futures[pool.submit(work, entry)] = entry
        for future in as_completed(futures):
            info = future.result()
            table = info.get("table") or "?"
            status = info.get("status")
            if status == "ok":
                stats["ok"] += 1
                rows = int(info.get("rows") or 0)
                stats["rows"] += rows
                stats["bytes"] += int(info.get("bytes") or 0)
                table_row_counts[table] = rows
                schema_map[table] = list(info.get("fields") or [])
                source = info.get("source") or "none"
                stats["schema_sources"][source] = stats["schema_sources"].get(source, 0) + 1
                if rows == 0:
                    stats["empty"] += 1
                    stats["empty_tables"].append(table)
                for note in info.get("notes") or []:
                    stats["warnings"].append(table + ": " + note)
                csv_check = info.get("csv_check")
                if csv_check == "match":
                    stats["csv_checks"]["match"] += 1
                elif csv_check == "mismatch":
                    stats["csv_checks"]["mismatch"].append(
                        {"table": table, "diff": info.get("csv_diff") or []}
                    )
                elif csv_check == "length":
                    stats["csv_checks"]["length_mismatch"].append(
                        {"table": table, "lengths": list(info.get("csv_lengths") or [])}
                    )
            elif status == "missing":
                stats["missing"].append(table)
            else:
                stats["fail"].append(
                    {"table": table, "error": info.get("error") or "未知错误"}
                )
            if progress is not None and task_id is not None:
                progress.advance(task_id, 1)

    stats["empty_tables"].sort()
    schema_path = tables_dir / SCHEMA_FILENAME
    if limit > 0 and schema_path.is_file():
        try:
            previous = json.loads(schema_path.read_text(encoding="utf-8"))
            if isinstance(previous, dict):
                merged = dict(previous)
                merged.update(schema_map)
                schema_map = merged
        except ValueError:
            pass
    _write_json(schema_path, {name: schema_map[name] for name in sorted(schema_map)})
    stats["tables_written"] = len(schema_map)
    stats["row_counts"] = {name: table_row_counts[name] for name in sorted(table_row_counts)}
    return stats




def _config_dir() -> Path:
    path = C.MASTERDATA_CONFIG_DIR
    path.mkdir(parents=True, exist_ok=True)
    return path


def _export_text_configs(files: list[str], errors: list[str]) -> None:
    cfg = _config_dir()
    for name, url in C.TEXT_CONFIGS.items():
        dest = cfg / name
        try:
            raw = H.fetch_bytes(url)
            try:
                payload = json.loads(raw)
                _write_json(dest, payload)
            except ValueError:
                _atomic_write_bytes(dest, raw)
            files.append(C.relative_posix(dest))
        except Exception as ex:  # noqa: BLE001
            errors.append("文本配置 " + name + " 下载/导出失败: " + str(ex))


def _export_cdn_manifests(files: list[str], errors: list[str], refresh: bool) -> None:
    cfg = _config_dir()
    for category in C.CATEGORIES:
        try:
            manifest = H.load_manifest(category, refresh=refresh)
            cache = C.MANIFEST_CACHE_DIR / (category + ".json")
            dest = cfg / ("cdn_manifest_" + category + ".json")
            if cache.is_file():
                _atomic_write_bytes(dest, cache.read_bytes())
            else:
                _write_json(dest, manifest)
            files.append(C.relative_posix(dest))
        except Exception as ex:  # noqa: BLE001
            errors.append("CDN 清单 " + category + " 导出失败: " + str(ex))


def _export_apk_manifest(files: list[str], errors: list[str]) -> None:
    cfg = _config_dir()
    apk = C.find_default_apk()
    if apk is None:
        errors.append("找不到 APK，无法导出 assets/master/manifest.json")
        return
    try:
        with zipfile.ZipFile(apk) as zf:
            raw = zf.read(APK_MASTER_MANIFEST)
        dest = cfg / "apk_master_manifest.json"
        _atomic_write_bytes(dest, raw)
        files.append(C.relative_posix(dest))
    except Exception as ex:  # noqa: BLE001
        errors.append("APK manifest.json 导出失败: " + str(ex))


def _export_unity_textassets(files: list[str], errors: list[str]) -> None:
    cfg = _config_dir()
    assets = _load_unity_text_assets()
    if not assets:
        errors.append("data.unity3d TextAsset 不可读，跳过 cmdVersionInfo/cmdServer")
        return
    for name in ("cmdVersionInfo", "cmdServer"):
        raw = assets.get(name)
        if raw is None:
            errors.append("data.unity3d 内缺少 TextAsset：" + name)
            continue
        text = raw.decode("utf-8-sig", errors="replace").strip()
        dest_json = cfg / (name + ".json")
        try:
            payload = json.loads(text)
            _write_json(dest_json, payload)
            files.append(C.relative_posix(dest_json))
        except ValueError:
            dest_txt = cfg / (name + ".txt")
            _atomic_write_bytes(dest_txt, raw)
            files.append(C.relative_posix(dest_txt))


def _find_har() -> Path | None:
    candidates = sorted(
        C.SCRIPT_DIR.glob(HAR_GLOB),
        key=lambda item: item.stat().st_mtime,
        reverse=True,
    )
    return candidates[0] if candidates else None


def _export_server_responses(files: list[str], errors: list[str]) -> None:
    har_path = _find_har()
    if har_path is None:
        errors.append("找不到 HAR 抓包文件，跳过服务端响应导出")
        return
    try:
        har = json.loads(har_path.read_bytes())
    except Exception as ex:  # noqa: BLE001
        errors.append("HAR 解析失败: " + str(ex))
        return

    server_dir = _config_dir() / SERVER_DIRNAME
    index: list[dict] = []
    for order, entry in enumerate(har.get("log", {}).get("entries", []), start=1):
        url = str(entry.get("request", {}).get("url") or "")
        host = urlparse(url).netloc
        if not any(hint in host for hint in SERVER_HOST_HINTS):
            continue
        content = entry.get("response", {}).get("content") or {}
        body_text = content.get("text") or ""
        if content.get("encoding") == "base64":
            body = base64.b64decode(body_text)
        else:
            body = body_text.encode("utf-8")
        path = urlparse(url).path.strip("/").replace("/", "_") or "root"
        mime = str(content.get("mimeType") or "")
        looks_json = body.lstrip()[:1] in (b"{", b"[") or "json" in mime
        suffix = ".json" if looks_json else ".bin"
        filename = format(order, "02d") + "_" + path + suffix
        _atomic_write_bytes(server_dir / filename, body)
        files.append(C.relative_posix(server_dir / filename))
        index.append(
            {
                "order": order,
                "url": url,
                "method": entry.get("request", {}).get("method"),
                "status": entry.get("response", {}).get("status"),
                "mimeType": mime,
                "size": len(body),
                "file": filename,
            }
        )
    if index:
        index_path = server_dir / "_index.json"
        _write_json(index_path, index)
        files.append(C.relative_posix(index_path))
    else:
        errors.append("HAR 中未找到 eastmajor 服务端响应")


def _export_configs(refresh: bool) -> dict:
    files: list[str] = []
    errors: list[str] = []
    _export_text_configs(files, errors)
    _export_cdn_manifests(files, errors, refresh)
    _export_apk_manifest(files, errors)
    _export_unity_textassets(files, errors)
    _export_server_responses(files, errors)
    return {"files": files, "errors": errors, "dir": C.relative_posix(C.MASTERDATA_CONFIG_DIR)}



def _summary_payload(result: dict) -> dict:
    decode = dict(result.get("decode") or {})
    return {
        "generated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        "download": result.get("download") or {},
        "master_version": C.MASTER_VERSION,
        "decode": decode,
        "config": result.get("config") or {},
        "elapsed": result.get("elapsed"),
    }


def _print_summary(result: dict) -> None:
    download = result.get("download") or {}
    decode = result.get("decode") or {}
    config = result.get("config") or {}

    table = Table(title="MasterData 导出结果")
    table.add_column("项目", style="cyan", no_wrap=True)
    table.add_column("结果")
    table.add_row(
        "下载",
        "ok="
        + str(download.get("ok", 0))
        + " skip="
        + str(download.get("skip", 0))
        + " fail="
        + str(download.get("fail", 0))
        + " bytes="
        + format(int(download.get("bytes") or 0), ","),
    )
    table.add_row(
        "表",
        "共 "
        + str(decode.get("tables", 0))
        + "，成功 "
        + str(decode.get("ok", 0))
        + "，空表 "
        + str(decode.get("empty", 0))
        + "，失败 "
        + str(len(decode.get("fail") or []))
        + "，缺文件 "
        + str(len(decode.get("missing") or [])),
    )
    table.add_row("总行数", format(int(decode.get("rows") or 0), ","))
    sources = decode.get("schema_sources") or {}
    table.add_row(
        "字段来源", "，".join(name + "=" + str(count) for name, count in sources.items()) or "-"
    )
    csv_checks = decode.get("csv_checks") or {}
    table.add_row(
        "CSV 交叉校验",
        "一致="
        + str(csv_checks.get("match", 0))
        + "，字段名差异="
        + str(len(csv_checks.get("mismatch") or []))
        + "，列数不同="
        + str(len(csv_checks.get("length_mismatch") or [])),
    )
    table.add_row("配置导出", str(len(config.get("files") or [])) + " 个文件")
    table.add_row("耗时", str(result.get("elapsed")) + " s")
    CONSOLE.print(table)

    empty_tables = decode.get("empty_tables") or []
    if empty_tables:
        CONSOLE.print("[dim]空表：" + "、".join(empty_tables) + "[/dim]")
    failures = decode.get("fail") or []
    for item in failures[:10]:
        CONSOLE.print("[red]解码失败[/red] " + str(item))
    for warning in (decode.get("warnings") or [])[:10]:
        CONSOLE.print("[yellow]解码告警[/yellow] " + str(warning))
    for error in (config.get("errors") or [])[:10]:
        CONSOLE.print("[yellow]配置告警[/yellow] " + str(error))
    if decode.get("tables_written") is not None:
        CONSOLE.print(
            "[green]已写 "
            + str(decode.get("tables_written"))
            + " 张表 -> "
            + C.relative_posix(C.MASTERDATA_TABLES_DIR)
            + "[/green]"
        )
    CONSOLE.print(
        "[green]配置 -> " + C.relative_posix(C.MASTERDATA_CONFIG_DIR) + "[/green]"
    )


def export_masterdata(
    *,
    jobs: int = C.DEFAULT_JOBS,
    force: bool = False,
    refresh: bool = False,
    limit: int = 0,
) -> dict:
    started = time.time()
    jobs = max(1, int(jobs or C.DEFAULT_JOBS))
    limit = max(0, int(limit or 0))
    C.ensure_dirs()

    result: dict[str, Any] = {}
    with H.new_progress() as progress:
        CONSOLE.print(
            "[bold]MasterData[/bold] 版本 "
            + C.MASTER_VERSION
            + ("，limit=" + str(limit) if limit else "，全量")
            + ("，force" if force else "")
            + ("，refresh" if refresh else "")
        )
        result["download"] = _download_master(
            progress=progress,
            jobs=jobs,
            force=force,
            refresh=refresh,
            limit=limit,
        )

    with Progress(
        SpinnerColumn(),
        TextColumn("[bold blue]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
    ) as progress:
        result["decode"] = _decode_masterdata(jobs=jobs, progress=progress, limit=limit)

    CONSOLE.print("[bold]导出配置...[/bold]")
    result["config"] = _export_configs(refresh)
    result["elapsed"] = round(time.time() - started, 2)

    _print_summary(result)
    try:
        _write_json(C.MASTERDATA_CONFIG_DIR / SUMMARY_FILENAME, _json_safe(_summary_payload(result)))
    except Exception as ex:  # noqa: BLE001
        CONSOLE.print("[yellow]汇总文件写入失败：" + str(ex) + "[/yellow]")
    return _json_safe(result)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="TLWMasterData.py",
        description="东方归言录 MasterData 下载/解密/解码 + 配置导出",
    )
    parser.add_argument("--jobs", type=int, default=C.DEFAULT_JOBS, help="并发数（默认 16）")
    parser.add_argument("--force", action="store_true", help="强制重新下载全部 master 文件")
    parser.add_argument("--refresh", action="store_true", help="强制重新下载热更清单")
    parser.add_argument("--limit", type=int, default=0, help="只处理前 N 张表（调试用）")
    return parser


def run(args: argparse.Namespace | None = None) -> int:
    """供统一 CLI 调用：接受 argparse.Namespace，返回进程退出码。"""
    if args is None:
        args = build_parser().parse_args()
        return main()
    export_masterdata(
        jobs=getattr(args, "jobs", C.DEFAULT_JOBS),
        force=getattr(args, "force", False),
        refresh=getattr(args, "refresh", False),
        limit=getattr(args, "limit", 0),
    )
    return 0


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        export_masterdata(
            jobs=args.jobs,
            force=args.force,
            refresh=args.refresh,
            limit=args.limit,
        )
    except KeyboardInterrupt:
        CONSOLE.print("[yellow]已中断[/yellow]")
        return 130
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
