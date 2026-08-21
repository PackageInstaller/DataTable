from __future__ import annotations

import argparse
import json
import struct
from pathlib import Path


def load_schema(path: str | Path) -> dict[str, dict[int, list[dict]]]:
    s = json.loads(Path(path).read_text(encoding="utf-8"))
    by_name: dict[str, dict[int, list[dict]]] = {}
    for m in s.get("messages", []):
        if not m:
            continue
        fields: dict[int, list[dict]] = {}
        for f in m.get("fields", []):
            fields.setdefault(f["fieldNumber"], []).append(f)
        by_name[m["message"]] = fields
    return by_name


class VarintReader:
    def __init__(self, buf: bytes):
        self.b = buf
        self.i = 0

    def read_varint(self) -> int:
        v = 0
        s = 0
        while True:
            if self.i >= len(self.b):
                raise ValueError("varint 越界")
            x = self.b[self.i]
            self.i += 1
            v |= (x & 0x7F) << s
            if not x & 0x80:
                return v
            s += 7
            if s > 70:
                raise ValueError("varint 过长")

    def read_bytes(self, n: int) -> bytes:
        if self.i + n > len(self.b):
            raise ValueError("bytes 越界")
        out = self.b[self.i : self.i + n]
        self.i += n
        return out


def clean_str(raw: bytes) -> str:
    try:
        return raw.decode("utf-8")
    except UnicodeDecodeError:
        return raw.hex()


def decode_message(buf: bytes, msg_name: str, schema, depth: int = 0) -> dict:
    if depth > 16:
        return {"__depth_exceeded__": buf.hex()}
    fields = schema.get(msg_name, {})
    r = VarintReader(buf)
    out: dict = {}
    unknown = []
    while r.i < len(r.b):
        tag = r.read_varint()
        fnum = tag >> 3
        wt = tag & 7
        if fnum == 0:
            raise ValueError("field 0")
        specs = fields.get(fnum)
        if wt == 0:
            v = r.read_varint()
            if specs:
                for f in specs:
                    nm = f["name"]
                    if (
                        f.get("type") in ("bool", "Boolean")
                        or f.get("elementType") == "bool"
                    ):
                        vv = bool(v)
                    else:
                        vv = v
                    if f.get("repeated"):
                        out.setdefault(nm, []).append(vv)
                    else:
                        out[nm] = vv
            else:
                unknown.append([fnum, "varint", v])
        elif wt == 2:
            ln = r.read_varint()
            raw = r.read_bytes(ln)
            if specs:
                for f in specs:
                    nm = f["name"]
                    t = f.get("type", "")
                    et = f.get("elementType")
                    if f.get("repeated"):
                        lst = out.setdefault(nm, [])
                        if et in ("int", "uint", "long", "ulong", "int32", "uint32"):
                            pr = VarintReader(raw)
                            try:
                                while pr.i < len(raw):
                                    lst.append(pr.read_varint())
                            except ValueError:
                                lst.append(clean_str(raw))
                        elif et in schema:
                            lst.append(decode_message(raw, et, schema, depth + 1))
                        elif et == "string":
                            lst.append(clean_str(raw))
                        else:
                            lst.append(clean_str(raw))
                    else:
                        if t in schema:
                            out[nm] = decode_message(raw, t, schema, depth + 1)
                        elif t in ("string", "String", "ByteString"):
                            out[nm] = clean_str(raw)
                        elif t in ("bytes",):
                            out[nm] = raw.hex()
                        else:
                            out[nm] = clean_str(raw)
            else:
                unknown.append([fnum, "len", raw])
        elif wt == 5:
            raw = r.read_bytes(4)
            v = struct.unpack("<I", raw)[0]
            if specs:
                out.setdefault(specs[0]["name"], v)
            else:
                unknown.append([fnum, "fixed32", v])
        elif wt == 1:
            raw = r.read_bytes(8)
            v = struct.unpack("<Q", raw)[0]
            if specs:
                out.setdefault(specs[0]["name"], v)
            else:
                unknown.append([fnum, "fixed64", v])
        else:
            raise ValueError(f"bad wire type {wt}")
    if unknown:
        out["__unknown__"] = [
            [n, k, v if isinstance(v, (str, int)) else v.hex()] for n, k, v in unknown
        ]
    return out


def find_next_header(data: bytes, p: int):
    q = p
    while q + 8 <= len(data):
        nl2 = struct.unpack_from("<I", data, q)[0]
        if 1 <= nl2 <= 128 and q + 4 + nl2 <= len(data):
            b = data[q + 4 : q + 4 + nl2]
            if all(32 <= x < 127 for x in b):
                return q, None, nl2, b.decode(), 4
        rc = struct.unpack_from("<I", data, q)[0]
        nl = struct.unpack_from("<I", data, q + 4)[0]
        if 1 <= nl <= 128 and q + 8 + nl <= len(data):
            b = data[q + 8 : q + 8 + nl]
            if all(32 <= x < 127 for x in b) and rc <= 200000:
                return q, rc, nl, b.decode(), 8
        q += 1
    return None


def parse_config(data: bytes, schema) -> list[dict]:
    tables = []
    off = 8
    guard = 0
    while off + 8 <= len(data) and guard < 500:
        guard += 1
        rc = struct.unpack_from("<I", data, off)[0]
        nl = struct.unpack_from("<I", data, off + 4)[0]
        name = None
        hdr = None
        if 1 <= nl <= 128 and off + 8 + nl <= len(data):
            b = data[off + 8 : off + 8 + nl]
            if all(32 <= x < 127 for x in b) and rc <= 200000:
                name = b.decode()
                hdr = 8
        if name is None:
            nl2 = struct.unpack_from("<I", data, off)[0]
            if 1 <= nl2 <= 128 and off + 4 + nl2 <= len(data):
                b = data[off + 4 : off + 4 + nl2]
                if all(32 <= x < 127 for x in b):
                    name = b.decode()
                    hdr = 4
                    rc = None
        if name is None:
            nxt = find_next_header(data, off)
            if nxt is None:
                break
            off, rc, nl, name, hdr = nxt
        p = off + hdr + nl
        rows = []
        limit = rc if rc is not None else (1 << 30)
        while len(rows) < limit and p + 8 <= len(data):
            rid = struct.unpack_from("<I", data, p)[0]
            rl = struct.unpack_from("<I", data, p + 4)[0]
            if rl > 50_000_000 or p + 8 + rl > len(data):
                break
            rowbuf = data[p + 8 : p + 8 + rl]
            try:
                dec = decode_message(rowbuf, name, schema)
            except Exception:
                dec = {"__raw__": rowbuf.hex()}
            rows.append({"id": rid, "data": dec})
            p += 8 + rl
        tables.append({"name": name, "rowCount": len(rows), "rows": rows})
        off = p
    return tables


def write_masterdata(tables: list[dict], out_dir: Path, compact: bool = False) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    indent = None if compact else 2
    stats = []
    for t in tables:
        rows = [{"id": r["id"], **r["data"]} for r in t["rows"]]
        (out_dir / f"{t['name']}.json").write_text(
            json.dumps(rows, ensure_ascii=False, indent=indent), encoding="utf-8"
        )
        stats.append({"table": t["name"], "rows": t["rowCount"]})
    (out_dir / "masterdata_index.json").write_text(
        json.dumps(stats, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def main() -> int:
    ap = argparse.ArgumentParser(description="深空之眼 Config 数据表反序列化")
    ap.add_argument("config", help="Config.bin（config.ys 提取出的 TextAsset）")
    ap.add_argument("--schema", default=None, help="config_schema.json 路径")
    ap.add_argument("--out", default="MasterData", help="输出目录")
    ap.add_argument("--compact", action="store_true", help="紧凑 JSON 输出")
    args = ap.parse_args()

    schema_path = args.schema or str(
        Path(__file__).resolve().parent / "config_schema.json"
    )
    schema = load_schema(schema_path)
    data = Path(args.config).read_bytes()
    tables = parse_config(data, schema)
    write_masterdata(tables, Path(args.out), args.compact)

    raw_rows = sum(1 for t in tables for r in t["rows"] if "__raw__" in r["data"])
    unknown_fields = sum(
        len(r["data"].get("__unknown__", []))
        for t in tables
        for r in t["rows"]
        if "__unknown__" in r["data"]
    )
    print(f"[*] 表数: {len(tables)}，总行数: {sum(t['rowCount'] for t in tables)}")
    print(f"[*] 未解码行: {raw_rows}，未知字段: {unknown_fields}")
    print(f"[*] 已写出 -> {Path(args.out).resolve()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
