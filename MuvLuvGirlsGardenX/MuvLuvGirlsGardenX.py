import msgpack
import json
import lz4.block
import io

def convert(obj: any) -> any:
    if isinstance(obj, msgpack.Timestamp):
        return obj.to_datetime().isoformat()
    if isinstance(obj, dict):
        return {key: convert(value) for key, value in obj.items()}
    if isinstance(obj, list):
        return [convert(item) for item in obj]
    return obj

def decompress(data: list) -> bytes:
    sizes = list(msgpack.Unpacker(io.BytesIO(data[0].data), raw=False, strict_map_key=False))
    decompress = bytearray()
    for i, block in enumerate(data[1:]):
        if i < len(sizes):
            decompress.extend(lz4.block.decompress(block, uncompressed_size=sizes[i]))
    return bytes(decompress)

if __name__ == "__main__":
    with open("masterdata.bin", 'rb') as f:
        data = f.read()

    unpacker = msgpack.Unpacker(raw=True, strict_map_key=False)
    unpacker.feed(data)
    root = next(unpacker)

    if (isinstance(root, list) and len(root) > 1 and
            isinstance(root[0], msgpack.ExtType) and
            root[0].code == 98):
        unpack = decompress(root)

    with open("MasterData.json", 'w', encoding='utf-8') as f:
        json.dump(convert(msgpack.unpackb(unpack, raw=False, strict_map_key=False)),
                    f, indent=4, ensure_ascii=False)