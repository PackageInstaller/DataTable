import sys, os, json, datetime
from collections import defaultdict

import msgpack
import lz4.block

import TenkeiParadoxSchema as SCHEMA 

LZ4_BLOCK_ARRAY_EXT = 98   # MessagePackCompression.Lz4BlockArray
LZ4_BLOCK_EXT = 99         # MessagePackCompression.Lz4Block
_CONTAINER_GENERICS = ('List', 'IEnumerable', 'IReadOnlyList', 'IList',
                       'ICollection', 'HashSet', 'IReadOnlyCollection', 'Queue', 'Stack')
_DICT_GENERICS = ('Dictionary', 'IDictionary', 'IReadOnlyDictionary', 'SortedDictionary')

def lz4_decompress(data):


    def _array_header(b, pos):
        c = b[pos]
        if 0x90 <= c <= 0x9f:
            return c & 0x0f, pos + 1
        if c == 0xdc:
            return int.from_bytes(b[pos + 1:pos + 3], 'big'), pos + 3
        if c == 0xdd:
            return int.from_bytes(b[pos + 1:pos + 5], 'big'), pos + 5
        return None, pos

    def _ext_header(b, pos):
        c = b[pos]
        if c == 0xd4: return b[pos + 1], b[pos + 2:pos + 3], pos + 3
        if c == 0xd5: return b[pos + 1], b[pos + 2:pos + 4], pos + 4
        if c == 0xd6: return b[pos + 1], b[pos + 2:pos + 6], pos + 6
        if c == 0xd7: return b[pos + 1], b[pos + 2:pos + 10], pos + 10
        if c == 0xd8: return b[pos + 1], b[pos + 2:pos + 18], pos + 18
        if c == 0xc7:
            n = b[pos + 1]; t = b[pos + 2]; return t, b[pos + 3:pos + 3 + n], pos + 3 + n
        if c == 0xc8:
            n = int.from_bytes(b[pos + 1:pos + 3], 'big'); t = b[pos + 3]; return t, b[pos + 4:pos + 4 + n], pos + 4 + n
        if c == 0xc9:
            n = int.from_bytes(b[pos + 1:pos + 5], 'big'); t = b[pos + 5]; return t, b[pos + 6:pos + 6 + n], pos + 6 + n
        return None, None, pos

    def _bin_block(b, pos):
        c = b[pos]
        if c == 0xc4: n = b[pos + 1]; dp = pos + 2
        elif c == 0xc5: n = int.from_bytes(b[pos + 1:pos + 3], 'big'); dp = pos + 3
        elif c == 0xc6: n = int.from_bytes(b[pos + 1:pos + 5], 'big'); dp = pos + 5
        else: raise ValueError("expected bin block, got 0x%02x" % c)
        return b[dp:dp + n], dp + n

    count, pos = _array_header(data, 0)
    if count is not None and pos < len(data):
        etype, edata, npos = _ext_header(data, pos)
        if etype == LZ4_BLOCK_ARRAY_EXT:
            up = msgpack.Unpacker(strict_map_key=False); up.feed(edata)
            lengths = [x for x in up]# 头部 = 连续 N 个 msgpack int
            pos = npos
            out = bytearray()
            for i in range(count - 1):
                comp, pos = _bin_block(data, pos)
                out += lz4.block.decompress(comp, uncompressed_size=lengths[i])
            return bytes(out)

    etype, edata, npos = _ext_header(data, 0)
    if etype == LZ4_BLOCK_EXT:
        up = msgpack.Unpacker(strict_map_key=False); up.feed(edata)
        uncomp_len = next(iter(up))
        comp = edata[up.tell():]
        return lz4.block.decompress(comp, uncompressed_size=uncomp_len)

    return data 

def unpack_msgpack(data, timestamp=3):
    raw = lz4_decompress(data)
    return msgpack.unpackb(raw, strict_map_key=False, raw=False, timestamp=timestamp)


class Decoder:
    def __init__(self, translate_enums=True):
        self.classes = SCHEMA.CLASSES
        self.enums = SCHEMA.ENUMS
        self.id2class = SCHEMA.UNIONS.get("IDataObject", {})   # {tableId(int): 类名}
        self.translate_enums = translate_enums


    @staticmethod
    def _strip(t):
        t = t.strip()
        if t.endswith('?'):
            t = t[:-1].strip()
        is_arr = t.endswith('[]')
        if is_arr:
            t = t[:-2].strip()
        return t, is_arr

    @staticmethod
    def _simple(t):
        return t.split('<')[0].split('.')[-1].strip()

    @staticmethod
    def _split_generic(s):
        parts, depth, cur = [], 0, ''
        for ch in s:
            if ch == '<': depth += 1; cur += ch
            elif ch == '>': depth -= 1; cur += ch
            elif ch == ',' and depth == 0: parts.append(cur); cur = ''
            else: cur += ch
        if cur: parts.append(cur)
        return [p.strip() for p in parts]

    def decode_value(self, val, decl_type):
        if val is None:
            return None
        base, is_arr = self._strip(decl_type)
        head = base.split('<', 1)[0].split('.')[-1]

        inner = None
        if is_arr:
            inner = base
        elif '<' in base and head in _CONTAINER_GENERICS:
            inner = base[base.index('<') + 1:base.rindex('>')]
        if inner is not None and isinstance(val, list):
            return [self.decode_value(v, inner) for v in val]

        if head in _DICT_GENERICS and isinstance(val, dict):
            kv = self._split_generic(base[base.index('<') + 1:base.rindex('>')])
            if len(kv) == 2:
                return {k: self.decode_value(v, kv[1]) for k, v in val.items()}
            return val

        sc = self._simple(base)
        if sc in self.classes:
            return self.decode_object(sc, val)
        if self.translate_enums and sc in self.enums and isinstance(val, int):
            return self.enums[sc].get(val, val)
        if isinstance(val, datetime.datetime):
            return val.isoformat()
        if hasattr(val, 'to_datetime'):
            try: return val.to_datetime().isoformat()
            except Exception: return str(val)
        return val

    def decode_object(self, cname, val):
        c = self.classes.get(cname)
        if not c:
            return val
        fields = c.get("fields")
        if isinstance(val, list) and fields:
            out = {}
            named = set()
            for idx, (fname, ftype) in fields.items():
                named.add(idx)
                out[fname] = self.decode_value(val[idx], ftype) if idx < len(val) else None
            for idx in range(len(val)):
                if idx not in named and val[idx] is not None:
                    out.setdefault("_extra", {})[idx] = val[idx]
            return out
        strf = c.get("strfields")
        if isinstance(val, dict) and strf:
            return {fname: self.decode_value(val[sk], ftype)
                    for sk, (fname, ftype) in strf.items() if sk in val}
        return val


def _json_default(o):
    if isinstance(o, (datetime.datetime, datetime.date)):
        return o.isoformat()
    if isinstance(o, bytes):
        return o.hex()
    return str(o)


def parse_bin(data):
    pkg = unpack_msgpack(data) # [IDataObject[], Version]
    objects = pkg[0]
    version = pkg[1] if len(pkg) > 1 else None

    dec = Decoder(translate_enums=True)
    grouped = defaultdict(list)
    for el in objects:
        if not (isinstance(el, list) and len(el) == 2):
            continue
        tid, value = el
        cname = dec.id2class.get(tid)

        grouped[cname].append(dec.decode_object(cname, value))
    return version, dict(grouped)


if __name__ == "__main__":
    bin_path = sys.argv[1]

    data = open(bin_path, "rb").read()
    version, tables = parse_bin(data)
    total = sum(len(v) for v in tables.values())
    print("版本 %s | %d 张表 | %d 行" % (version, len(tables), total))
    with open("MasterData.json", "w", encoding="utf-8") as f:
        json.dump({"version": version, "tables": tables}, f,
                  ensure_ascii=False, indent=2, default=_json_default)
    print("完事")