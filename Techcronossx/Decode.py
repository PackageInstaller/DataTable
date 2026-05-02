import msgpack
import json

def unpack_nested(data):
    if isinstance(data, list):
        return [unpack_nested(item) for item in data]
    elif isinstance(data, dict):
        return {unpack_nested(k): unpack_nested(v) for k, v in data.items()}
    elif isinstance(data, msgpack.Timestamp):
        return data.to_datetime().isoformat()
    elif isinstance(data, msgpack.ExtType):
        try:
            return unpack_nested(data.data)
        except:
            return {"type": data.code, "data": data.data.hex().upper()}
    elif isinstance(data, bytes):
        try:
            unpacked = msgpack.unpackb(data, raw=False, strict_map_key=False)
            return unpack_nested(unpacked)
        except Exception:
            return data.hex().upper()
    return data


if __name__ == "__main__":
    import sys

    with open(sys.argv[1], "rb") as f:
        raw_data = f.read()

    with open("version.json", "w", encoding="utf-8") as f:
        json.dump(
            unpack_nested(msgpack.unpackb(raw_data, raw=False, strict_map_key=False)),
            f,
            indent=4,
            ensure_ascii=False,
        )
