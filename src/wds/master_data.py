"""Master data manifest, download and MasterMemory .db deserialization.

The master data pipeline (HAR entry /api/data/master + game client):

  1. GET /api/data/master (Bearer) -> MasterDataManifest
       [Uri, SasToken, Version, PublishTimestamp]
  2. download <MasterDataUrl>/<Uri><SasToken> -> mastermemory_<Version>.db
  3. the .db is a MasterMemory binary:
       - header: msgpack map16 {tableName: [dataOffset, byteLength]}
       - each table blob: ext16(type 99) [msgpack int size][LZ4 block]
       - LZ4-decompress -> one msgpack array of records
       - field names from [MemoryTable("Name")] + [Key(n)] (index == Key)
  4. write summary.json, version.json and tables/<Table>.json (indent=2).
"""

from __future__ import annotations

import datetime as _dt
import io
import json
import os
import re
from pathlib import Path
from typing import Any, Iterator

import msgpack

from . import codec
from .api import ApiClient, MasterDataManifest
from .metadata import (
    build_class_field_index,
    build_table_type_map,
    expand_fields,
    field_names,
)


class MasterDataError(RuntimeError):
    pass


def build_download_url(
    env_master_data_url: str, manifest: MasterDataManifest
) -> str:
    return f"{env_master_data_url.rstrip('/')}/{manifest.uri}{manifest.sas_token}"


def parse_master_db(
    db_path: str,
    class_fields: dict[str, list[tuple[int, str, str]]],
) -> Iterator[tuple[str, Any, list[Any]]]:
    """Yield (tableName, fieldSlots, records) for every table in the .db."""
    data = Path(db_path).read_bytes()
    header = next(
        iter(msgpack.Unpacker(io.BytesIO(data), raw=True, strict_map_key=False))
    )
    header_len = len(codec.pack_header_table(header))

    for table_name, (offset, length) in header.items():
        blob = data[header_len + offset: header_len + offset + length]
        obj = next(
            iter(msgpack.Unpacker(io.BytesIO(blob), raw=True, strict_map_key=False))
        )
        if isinstance(obj, msgpack.ext.ExtType) and obj.code == codec.EXT_SINGLE:
            out = codec._decode_single_block(obj)
        else:
            out = blob
        inner = list(msgpack.Unpacker(io.BytesIO(out), raw=True, strict_map_key=False))
        records = inner[0] if inner else []
        if not isinstance(records, list):
            records = [records]
        triples = class_fields.get(table_name.decode("utf-8", "replace"))
        slots = expand_fields(triples) if triples else None
        yield table_name.decode("utf-8", "replace"), slots, records


def map_record(record: list[Any], slots) -> dict[str, Any]:
    out: dict[str, Any] = {}
    for i, v in enumerate(record):
        slot = slots[i] if slots and i < len(slots) else None
        name = slot[0] if slot else f"field_{i}"
        out[name] = codec.to_json_value(v)
    if slots:
        for i in range(len(record), len(slots)):
            slot = slots[i]
            out[slot[0] if slot else f"field_{i}"] = None
    return out


def update_master_data(
    api: ApiClient,
    token: str,
    *,
    out_dir: str | os.PathLike[str] = "masterdata",
    db_path: str | None = None,
    force: bool = False,
    indent: int = 2,
) -> dict[str, Any]:
    """Fetch manifest, download and deserialize; returns the summary dict."""
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    version_file = out / "version.json"

    env = api.fetch_environment()
    manifest = api.fetch_master_manifest(token)

    local_version = None
    if version_file.exists():
        try:
            local_version = json.loads(version_file.read_text(encoding="utf-8")).get("version")
        except Exception:
            pass

    db = Path(db_path) if db_path else out / f"mastermemory_{manifest.version}.db"
    if db_path is None:
        if not force and local_version == manifest.version and db.exists():
            print(f"[*] master data up to date ({manifest.version}), skip download")
        else:
            url = build_download_url(env.master_data_url, manifest)
            print("[*] downloading:", url[:150], "...")
            blob = _raw_get(url)
            db.write_bytes(blob)
            print(f"[*] saved {db} ({len(blob)} bytes)")

    print("[*] deserializing master data ...")
    from .metadata import load_il2cpp_cs

    cs_text = load_il2cpp_cs()
    class_fields = build_class_field_index(cs_text)
    table_types = build_table_type_map(cs_text)

    tables_dir = out / "tables"
    tables_dir.mkdir(parents=True, exist_ok=True)
    summary: dict[str, Any] = {
        "version": manifest.version,
        "publish_timestamp": manifest.publish_timestamp,
        "uri": manifest.uri,
        "tables": {},
    }

    for table_name, slots, records in parse_master_db(str(db), class_fields):
        rows = [map_record(r, slots) for r in records]
        safe = re.sub(r"[^A-Za-z0-9_]+", "_", table_name)
        (tables_dir / f"{safe}.json").write_text(
            json.dumps(rows, ensure_ascii=False, indent=indent),
            encoding="utf-8",
        )
        summary["tables"][table_name] = {
            "records": len(rows),
            "fields": field_names(slots),
            "type": table_types.get(table_name),
        }

    version_file.write_text(
        json.dumps(
            {
                "version": manifest.version,
                "publish_timestamp": manifest.publish_timestamp,
                "downloaded_at": _dt.datetime.now(_dt.timezone.utc).isoformat(),
            },
            ensure_ascii=False,
            indent=indent,
        ),
        encoding="utf-8",
    )
    (out / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=indent), encoding="utf-8"
    )
    return summary


def _raw_get(url: str, timeout: int = 120) -> bytes:
    import urllib.request

    req = urllib.request.Request(url, headers={"user-agent": "BestHTTP/2 v2.8.5"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()
