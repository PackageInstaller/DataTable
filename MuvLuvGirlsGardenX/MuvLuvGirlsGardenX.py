import io
import re
import json
import msgpack
import lz4.block
from pathlib import Path
from MasterMap import MASTER_SCHEMA_BY_ID, MASTER_SCHEMA_BY_NAME, ENUM_MAPPINGS, FIELD_TYPE_MAP


def conv(obj: any) -> any:
    if isinstance(obj, msgpack.Timestamp): return obj.to_datetime().isoformat()
    if isinstance(obj, dict): 
        return {k: conv(v) for k, v in obj.items()}
    if isinstance(obj, list): 
        return [conv(i) for i in obj]
    return obj

def decom(dat: list) -> bytes:
    s = list(msgpack.Unpacker(io.BytesIO(dat[0].data), raw=False, strict_map_key=False))
    decom = bytearray()
    for i, b in enumerate(dat[1:]):
        if i < len(s):
            decom.extend(lz4.block.decompress(b, uncompressed_size=s[i]))
    return bytes(decom)

def restore(obj: any, th: str = None) -> any:
    if th:
        if th.endswith('[]') and isinstance(obj, list):
            bt = th[:-2]
            return [restore(i, bt) for i in obj]

        if th.startswith('IDictionary<') and isinstance(obj, dict):
            m = re.search(r'IDictionary<([\w\.]+)\s*,\s*([\w\.]+)>', th)
            if m:
                kt, vt = m.groups()
                kt = kt.split('.')[-1]
                vt = vt.split('.')[-1]
                
                rd = {}
                for k, v in obj.items():
                    new_key = restore(k, kt)
                    rd[str(new_key)] = restore(v, vt)
                return rd

        if th in MASTER_SCHEMA_BY_NAME and isinstance(obj, list):
            ro = {"type": th}
            for i, fn in enumerate(MASTER_SCHEMA_BY_NAME[th]):
                if i < len(obj):
                    ro[fn] = restore(obj[i], (FIELD_TYPE_MAP.get(th, {})).get(fn))
            return ro
        
        if th in ENUM_MAPPINGS and isinstance(obj, int):
            return ENUM_MAPPINGS[th].get(obj, obj)

    if isinstance(obj, list) and len(obj) == 2 and isinstance(obj[0], int) and obj[0] in MASTER_SCHEMA_BY_ID:
        tid, dat = obj
        cn, _ = MASTER_SCHEMA_BY_ID[tid]
        return restore(dat, cn)
    
    if isinstance(obj, dict): return {k: restore(v) for k, v in obj.items()}
    if isinstance(obj, list): return [restore(i) for i in obj]

    return obj

def process(i: Path, o: Path):
    dat = i.read_bytes()
    unpacker = msgpack.Unpacker(raw=True, strict_map_key=False)
    unpacker.feed(dat)
    root = next(unpacker)
    with o.open('w', encoding='utf-8') as f:
        json.dump(conv(restore(msgpack.unpackb(decom(root) if (isinstance(root, list) and len(root) > 1 and
            isinstance(root[0], msgpack.ExtType) and root[0].code == 98) else dat, raw=False, strict_map_key=False))), f, indent=4, ensure_ascii=False)

if __name__ == "__main__":
    process(Path("masterdata.bin"), Path("MasterData.json"))