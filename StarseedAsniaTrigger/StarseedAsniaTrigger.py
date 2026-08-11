import datetime
import json
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from StarseedAsniaTriggerSchema import TABLE_SCHEMA, ENUM_SCHEMA

import lz4.block
import msgpack

BASE_URL = (
    "http://starseed-fn.qpyou.cn/starseed/com2us-jp-live/design/6.10.234/bytes/client/"
)
OUTPUT_DIR = Path("MasterData")
WORKERS = 8


def fetch(url: str, timeout: int = 90) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": "UnityPlayer/2021.3.58f1"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()


def unpack_crc(data: bytes) -> dict:
    obj = msgpack.unpackb(data, raw=False, strict_map_key=False)
    if obj.code != 0x63:
        raise ValueError(f"unexpected ext code: {obj.code:#x}")
    payload = obj.data
    if payload[0] != 0xD2:
        raise ValueError("unexpected uncompressed-size marker")
    size = int.from_bytes(payload[1:5], "big")
    raw = lz4.block.decompress(payload[5:], uncompressed_size=size)
    return msgpack.unpackb(raw, raw=False, strict_map_key=False)


def decode_xored(data: bytes):
    xored = bytes(b ^ 0x80 for b in data)
    try:
        return json.loads(xored.decode("utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError):
        pass
    obj = msgpack.unpackb(xored, raw=False, strict_map_key=False)
    if not hasattr(obj, "code"):
        return obj
    if obj.code != 0x63:
        raise ValueError(f"unexpected ext code: {obj.code:#x}")
    payload = obj.data
    if payload[0] != 0xD2:
        raise ValueError("unexpected uncompressed-size marker")
    size = int.from_bytes(payload[1:5], "big")
    raw = lz4.block.decompress(payload[5:], uncompressed_size=size)
    return msgpack.unpackb(raw, raw=False, strict_map_key=False)


def simple_name(type_name: str) -> str:
    return type_name.split(".")[-1].split("<")[0].split("?")[0]


def translate_enum(value, type_name: str, enum_cache: dict) -> object:
    if value is None:
        return None
    type_name = type_name.strip()
    if type_name.startswith("Nullable<") and type_name.endswith(">"):
        return translate_enum(value, type_name[9:-1], enum_cache)
    if type_name.startswith("List<") and type_name.endswith(">"):
        inner = type_name[5:-1]
        if isinstance(value, list):
            return [translate_enum(v, inner, enum_cache) for v in value]
        return value
    if type_name.startswith("Dictionary<") and type_name.endswith(">"):
        inner = type_name[len("Dictionary<") : -1]
        depth = 0
        comma = -1
        for i, ch in enumerate(inner):
            if ch == "<":
                depth += 1
            elif ch == ">":
                depth -= 1
            elif ch == "," and depth == 0:
                comma = i
                break
        value_type = inner[comma + 1 :].strip() if comma >= 0 else inner
        if isinstance(value, dict):
            return {
                k: translate_enum(v, value_type, enum_cache) for k, v in value.items()
            }
        return value
    mapping = enum_cache.get(simple_name(type_name))
    if mapping and isinstance(value, int) and value in mapping:
        return mapping[value]
    return value


def looks_like_row(value, fields: list[dict]) -> bool:
    return isinstance(value, list) and bool(fields)


def first_field_list_like(fields: list[dict]) -> bool:
    if not fields:
        return False
    t = fields[0]["type"].strip()
    return t.startswith("List<") or t.startswith("Dictionary<")


def map_row(value, fields: list[dict], enum_cache: dict) -> object:
    if value is None:
        return None
    if isinstance(value, dict):
        return {
            k: translate_enum(v, field_type_for_name(fields, k), enum_cache)
            for k, v in value.items()
        }
    if not isinstance(value, list):
        return value
    if (
        value
        and isinstance(value[0], list)
        and (len(value) != len(fields) or not first_field_list_like(fields))
    ):
        return [map_row(v, fields, enum_cache) for v in value]
    out = {}
    for i, field in enumerate(fields):
        if i < len(value):
            out[field["name"]] = translate_enum(value[i], field["type"], enum_cache)
        else:
            out[field["name"]] = None
    for i in range(len(fields), len(value)):
        out[f"__extra_{i - len(fields)}"] = value[i]
    return out


def field_type_for_name(fields: list[dict], name: str) -> str:
    for f in fields:
        if f["name"] == name:
            return f["type"]
    return ""


def map_table(data, fields: list[dict], enum_cache: dict) -> object:
    if not fields:
        return data
    if isinstance(data, list):
        return [map_row(v, fields, enum_cache) for v in data]
    if isinstance(data, dict):
        out = {}
        for key, value in data.items():
            if isinstance(value, dict):
                out[key] = {k: map_row(v, fields, enum_cache) for k, v in value.items()}
            elif isinstance(value, list):
                if (
                    value
                    and isinstance(value[0], list)
                    and (len(value) != len(fields) or not first_field_list_like(fields))
                ):
                    out[key] = [map_row(v, fields, enum_cache) for v in value]
                elif looks_like_row(value, fields):
                    out[key] = map_row(value, fields, enum_cache)
                else:
                    out[key] = value
            else:
                out[key] = value
        return out
    return data


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------


def json_default(value):
    if isinstance(value, msgpack.Timestamp):
        return datetime.datetime.fromtimestamp(
            value.seconds, datetime.timezone.utc
        ).isoformat()
    if isinstance(value, msgpack.ExtType):
        return {"code": value.code, "data": value.data.hex()}
    return str(value)


def process_one(name: str, fields: list[dict], enum_cache: dict) -> tuple[str, str]:
    raw = fetch(
        urllib.parse.urljoin(BASE_URL.rstrip("/") + "/", urllib.parse.quote(name))
    )
    data = decode_xored(raw)
    mapped = map_table(data, fields, enum_cache)
    return name, json.dumps(
        mapped,
        ensure_ascii=False,
        separators=(",", ":"),
        default=json_default,
        indent=2,
    )


def main() -> int:
    print("Fetching Crc.txt ...")
    crc = unpack_crc(fetch(urllib.parse.urljoin(BASE_URL.rstrip("/") + "/", "Crc.txt")))
    names = sorted(crc)

    table_fields = {
        fname: [
            {"key": key, "type": typ, "name": name} for key, typ, name in info["fields"]
        ]
        for fname, info in TABLE_SCHEMA.items()
    }
    enum_cache: dict[str, dict[int, str]] = {}
    for full, info in ENUM_SCHEMA.items():
        values = {int(k): v for k, v in info.items() if k != "__underlying_type"}
        simple = full.split(".")[-1]
        if simple not in enum_cache or full.startswith("MasterData.Types."):
            enum_cache[simple] = values

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    print(f"Downloading and mapping {len(names)} tables...")

    ok = 0
    with ThreadPoolExecutor(max_workers=WORKERS) as pool:
        futures = {
            pool.submit(process_one, name, table_fields.get(name, []), enum_cache): name
            for name in names
        }
        for i, fut in enumerate(as_completed(futures), 1):
            name, text = fut.result()
            (OUTPUT_DIR / name).write_text(text, encoding="utf-8")
            ok += 1
            if i % 25 == 0 or i == len(futures):
                print(f"  {i}/{len(futures)}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
