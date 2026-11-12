from __future__ import annotations

import json
import re
import struct
from pathlib import Path
from typing import Any

from google.protobuf import descriptor_pb2, descriptor_pool, message_factory
from google.protobuf.json_format import MessageToDict
from rich.console import Console
from rich.progress import Progress

from StellaArchive import StellaArchive
from StellaCrypto import xxhash64


def load_descriptor_pool(pb_bytes: bytes) -> tuple[descriptor_pool.DescriptorPool, Any]:
    fds = descriptor_pb2.FileDescriptorSet()
    fds.ParseFromString(pb_bytes)
    pool = descriptor_pool.DescriptorPool()
    for fd in fds.file:
        pool.Add(fd)
    return pool, message_factory


def parse_table_defines_from_lua(lua_text: str) -> dict[str, dict[str, Any]]:
    tables: dict[str, dict[str, Any]] = {}
    lines = lua_text.splitlines()
    current_name = None
    current_body = []

    for line in lines:
        m = re.match(r"^\s{2}([A-Za-z0-9_]+)\s*=\s*\{", line)
        if m:
            current_name = m.group(1)
            current_body = [line]
            if line.strip().endswith("},"):
                body_str = line
                has_key = "Key = true" in body_str
                tables[current_name] = {"has_key": has_key, "langs": []}
                current_name = None
        elif current_name:
            current_body.append(line)
            if re.match(r"^\s{2}\},?", line):
                body_str = "\n".join(current_body)
                has_key = "Key = true" in body_str
                lang_m = re.search(r"Lang\s*=\s*\{([^}]*)\}", body_str, re.DOTALL)
                langs = []
                if lang_m:
                    langs = re.findall(r"\"([^\"]+)\"", lang_m.group(1))
                tables[current_name] = {"has_key": has_key, "langs": langs}
                current_name = None

    return tables


def parse_binary_table(
    bin_data: bytes,
    proto_cls: Any,
    lang_dict: dict[str, str],
    lang_fields: list[str],
) -> dict[Any, Any] | list[Any]:
    magic_key, vlen = struct.unpack_from("<IH", bin_data, 0)
    if magic_key != 234324:
        raise ValueError(f"非法的表格魔数: {magic_key}")

    pos = 6 + vlen
    has_pk, pk_type, row_count = struct.unpack_from("<BBI", bin_data, pos)
    pos += 6

    if has_pk:
        rows_dict: dict[Any, Any] = {}
        for _ in range(row_count):
            if pk_type == 1:
                row_id = struct.unpack_from("<i", bin_data, pos)[0]
                pos += 4
            elif pk_type == 2:
                row_id = struct.unpack_from("<q", bin_data, pos)[0]
                pos += 8
            else:
                slen = struct.unpack_from("<H", bin_data, pos)[0]
                pos += 2
                row_id = bin_data[pos : pos + slen].decode("utf-8", "ignore")
                pos += slen

            row_len = struct.unpack_from("<H", bin_data, pos)[0]
            pos += 2
            row_bytes = bin_data[pos : pos + row_len]
            pos += row_len

            msg = proto_cls()
            msg.ParseFromString(row_bytes)
            row_dict = MessageToDict(msg, preserving_proto_field_name=True)

            for field in lang_fields:
                val = row_dict.get(field)
                if isinstance(val, str) and val in lang_dict:
                    row_dict[field] = lang_dict[val]

            rows_dict[row_id] = row_dict
        return rows_dict
    else:
        rows_list: list[Any] = []
        for _ in range(row_count):
            row_len = struct.unpack_from("<H", bin_data, pos)[0]
            pos += 2
            row_bytes = bin_data[pos : pos + row_len]
            pos += row_len

            msg = proto_cls()
            msg.ParseFromString(row_bytes)
            row_dict = MessageToDict(msg, preserving_proto_field_name=True)

            for field in lang_fields:
                val = row_dict.get(field)
                if isinstance(val, str) and val in lang_dict:
                    row_dict[field] = lang_dict[val]

            rows_list.append(row_dict)
        return rows_list


def load_language_tables(
    data_archive: StellaArchive,
    table_defines: dict[str, dict[str, Any]],
    language: str,
) -> dict[str, dict[str, str]]:
    tables: dict[str, dict[str, str]] = {}
    for tname in table_defines:
        lang_path = f"language/{language}/{tname.lower()}.json"
        lang_bytes = data_archive.read_file(lang_path)
        if not lang_bytes:
            continue
        try:
            tables[tname] = json.loads(lang_bytes.decode("utf-8", "ignore"))
        except Exception:
            continue
    return tables


def write_language_tables(
    data_archive: StellaArchive,
    table_defines: dict[str, dict[str, Any]],
    language: str,
    output_dir: Path,
    force: bool = False,
    console: Console | None = None,
) -> tuple[int, int, int]:
    lang_dir = output_dir / "Language" / language
    lang_dir.mkdir(parents=True, exist_ok=True)
    language_tables = load_language_tables(data_archive, table_defines, language)
    ok_count = skip_count = fail_count = 0
    for tname, data in language_tables.items():
        out_lang_file = lang_dir / f"{tname}.json"
        if out_lang_file.exists() and not force:
            skip_count += 1
            continue
        try:
            out_lang_file.write_text(
                json.dumps(data, ensure_ascii=False, indent=2),
                encoding="utf-8",
            )
            ok_count += 1
        except Exception as ex:
            fail_count += 1
            if console:
                console.print(f"[yellow]语言表写入失败[/yellow] {language}/{tname}: {ex}")
    return (ok_count, skip_count, fail_count)


def export_tables_all(
    data_archive: StellaArchive,
    pb_bytes: bytes,
    table_defines: dict[str, dict[str, Any]],
    output_dir: Path,
    language: str = "zh_cn",
    force: bool = False,
    console: Console | None = None,
    progress: Progress | None = None,
    language_archive: StellaArchive | None = None,
) -> tuple[int, int, int]:
    tables_dir = output_dir / "Tables"
    tables_dir.mkdir(parents=True, exist_ok=True)
    config_dir = output_dir / "Config"
    config_dir.mkdir(parents=True, exist_ok=True)

    pool, factory = load_descriptor_pool(pb_bytes)

    source_archive = language_archive or data_archive
    language_tables = load_language_tables(source_archive, table_defines, language)
    write_language_tables(source_archive, table_defines, language, output_dir, force=force, console=console)

    total_tables = len(table_defines)
    prog_task = None
    if progress is not None:
        prog_task = progress.add_task("[cyan]导出数据表 JSON...", total=total_tables)

    ok_count = 0
    skip_count = 0
    fail_count = 0

    for tname, defn in table_defines.items():
        out_json_path = tables_dir / f"{tname}.json"
        if out_json_path.exists() and not force:
            skip_count += 1
            if progress is not None and prog_task is not None:
                progress.advance(prog_task)
            continue

        bin_path = f"bin/{tname}.bytes"
        bin_bytes = data_archive.read_file(bin_path)
        if not bin_bytes:
            if progress is not None and prog_task is not None:
                progress.advance(prog_task)
            continue

        try:
            proto_name = f"nova.client.{tname}"
            desc = pool.FindMessageTypeByName(proto_name)
            proto_cls = factory.GetMessageClass(desc)
            lang_dict = language_tables.get(tname, {})
            lang_fields = defn.get("langs", [])

            parsed_data = parse_binary_table(bin_bytes, proto_cls, lang_dict, lang_fields)
            out_json_path.write_text(
                json.dumps(parsed_data, ensure_ascii=False, indent=2),
                encoding="utf-8",
            )
            ok_count += 1
        except Exception as ex:
            fail_count += 1
            if console:
                console.print(f"[yellow]导出数据表失败[/yellow] {tname}: {ex}")

        if progress is not None and prog_task is not None:
            progress.advance(prog_task)

    known_hashes = set()
    for tname in table_defines:
        known_hashes.add(xxhash64(f"bin/{tname}.bytes".lower().encode(), seed=0))
        known_hashes.add(xxhash64(f"language/{language}/{tname.lower()}.json".encode(), seed=0))

    other_idx = 0
    for entry in data_archive.entries:
        if entry.hash not in known_hashes:
            raw_data = data_archive.read_entry(entry, decrypt=True)
            if not raw_data:
                continue
            if raw_data.startswith(b"{") or raw_data.startswith(b"["):
                try:
                    parsed = json.loads(raw_data.decode("utf-8", "ignore"))
                    cfg_file = config_dir / f"config_{hex(entry.hash)}.json"
                    cfg_file.write_text(json.dumps(parsed, ensure_ascii=False, indent=2), encoding="utf-8")
                except Exception:
                    pass
            other_idx += 1

    return (ok_count, skip_count, fail_count)
