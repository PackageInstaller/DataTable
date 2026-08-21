import struct
import sys


OP = {
    0: "JMP", 1: "EQ", 2: "LT", 3: "LE", 4: "TEST", 5: "TESTSET",
    6: "CALL", 7: "TAILCALL", 8: "RETURN", 9: "FORLOOP", 10: "FORPREP",
    11: "TFORCALL", 12: "TFORLOOP", 13: "SETLIST", 14: "CLOSURE",
    15: "VARARG", 16: "EXTRAARG",
    17: "MOVE", 18: "LOADK", 19: "LOADKX", 20: "LOADBOOL", 21: "LOADNIL",
    22: "GETUPVAL", 23: "GETTABUP", 24: "GETTABLE", 25: "SETTABUP",
    26: "SETUPVAL", 27: "SETTABLE", 28: "NEWTABLE", 29: "SELF", 30: "ADD",
    31: "SUB", 32: "MUL", 33: "MOD", 34: "POW", 35: "DIV", 36: "IDIV",
    37: "BAND", 38: "BOR", 39: "BXOR", 40: "SHL", 41: "SHR", 42: "UNM",
    43: "BNOT", 44: "NOT", 45: "LEN", 46: "CONCAT",
}


def decode(code):
    op = code & 0x3F
    a = (code >> 6) & 0xFF
    c = (code >> 14) & 0x1FF
    b = (code >> 23) & 0x1FF
    bx = (code >> 14) & 0x3FFFF
    sbx = bx - 131071
    ax = code >> 6
    return op, a, b, c, bx, sbx, ax


def fmt(code, names):
    op, a, b, c, bx, sbx, ax = decode(code)
    name = names.get(op, f"OP_{op}")
    if op in (0, 9, 10, 12):  # JMP FORLOOP FORPREP TFORLOOP: A sBx
        return f"{name:10s} {a:3d} {sbx:+6d}"
    if op == 16:  # EXTRAARG
        return f"{name:10s} {ax}"
    if op in (1, 2, 3, 11):  # EQ LT LE TFORCALL: A B C
        return f"{name:10s} {a:3d} {b:3d} {c:3d}"
    if op in (18, 14):  # LOADK CLOSURE: A Bx
        return f"{name:10s} {a:3d} {bx:6d}"
    if op == 19:  # LOADKX: A
        return f"{name:10s} {a:3d}"
    if op in (22, 26, 42, 43, 44, 45, 15):  # A B
        return f"{name:10s} {a:3d} {b:3d}"
    return f"{name:10s} {a:3d} {b:3d} {c:3d}"


class Reader:
    def __init__(self, data):
        self.d = data
        self.p = 0

    def byte(self):
        v = self.d[self.p]
        self.p += 1
        return v

    def int32(self):
        v = struct.unpack_from("<i", self.d, self.p)[0]
        self.p += 4
        return v

    def i64(self):
        v = struct.unpack_from("<q", self.d, self.p)[0]
        self.p += 8
        return v

    def double(self):
        v = struct.unpack_from("<d", self.d, self.p)[0]
        self.p += 8
        return v

    def string(self):
        n = self.byte()
        if n == 0:
            return None
        if n < 255:
            size = n - 1
        else:
            size = self.int32() - 1  # DumpString 写的是 size+1
        s = self.d[self.p : self.p + size]
        self.p += size
        return s.decode("utf-8", "replace")


def parse_function(r, names=None, depth=0, pcounter=None):
    names = names or {}
    src = r.string()
    linedefined = r.int32()
    lastlinedefined = r.int32()
    numparams = r.byte()
    is_vararg = r.byte()
    maxstacksize = r.byte()
    ncode = r.int32()
    code = [struct.unpack_from("<I", r.d, r.p + 4 * i)[0] for i in range(ncode)]
    r.p += 4 * ncode
    nk = r.int32()
    consts = []
    for _ in range(nk):
        tag = r.byte()
        if tag == 0:
            consts.append(("nil", None))
        elif tag == 1:
            consts.append(("bool", bool(r.byte())))
        elif tag == 3:
            consts.append(("float", r.double()))
        elif tag == 19:
            consts.append(("int", r.i64()))
        else:
            consts.append(("str", r.string()))
    nup = r.int32()
    ups = []
    for _ in range(nup):
        ups.append((r.byte(), r.byte()))
    np = r.int32()
    protos = []
    for _ in range(np):
        protos.append(parse_function(r, names, depth + 1, pcounter))
    # debug
    nline = r.int32()
    r.p += 4 * nline
    nloc = r.int32()
    locvars = []
    for _ in range(nloc):
        locvars.append((r.string(), r.int32(), r.int32()))
    nupnames = r.int32()
    upnames = [r.string() for _ in range(nupnames)]

    f = {
        "src": src,
        "linedefined": linedefined,
        "lastlinedefined": lastlinedefined,
        "numparams": numparams,
        "is_vararg": is_vararg,
        "maxstacksize": maxstacksize,
        "code": code,
        "consts": consts,
        "ups": ups,
        "protos": protos,
        "locvars": locvars,
        "upnames": upnames,
    }
    return f


def parse_lua(data):
    assert data[:4] == b"\0fci", f"bad signature: {data[:4]!r}"
    version = data[4]
    r = Reader(data)
    r.p = 5
    f = parse_function(r)
    return version, f, r.p


def dump_all(src_dir="data/lua", out_dir="deserialized/lua_disasm"):
    import os

    ok = fail = 0
    for root, _dirs, files in os.walk(src_dir):
        for fn in files:
            p = os.path.join(root, fn)
            with open(p, "rb") as fh:
                data = fh.read()
            if data[:4] != b"\0fci":
                continue
            rel = os.path.relpath(p, src_dir)
            dst = os.path.join(out_dir, rel + ".txt")
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            try:
                ver, f, end = parse_lua(data)
                lines = [f"# {p}  ({len(data)} bytes, version={ver})",
                         f"# source: {f['src']!r}",
                         "--- main ---"]
                lines.extend(disasm(f, names=OP))
                with open(dst, "w", encoding="utf-8") as fh:
                    fh.write("\n".join(lines))
                ok += 1
            except Exception as e:
                fail += 1
                print("FAIL", p, e)
    print(f"lua disasm: ok={ok} fail={fail}")


def disasm(f, names=None, depth=0, indent="", kref=None, upnames=None):
    names = names or {}
    upnames = upnames or []
    if kref is None:
        kref = f["consts"]
    out = []
    for i, code in enumerate(f["code"]):
        op, a, b, c, bx, sbx, ax = decode(code)
        line = fmt(code, names)
        if op == 18 and 0 <= bx < len(kref):  # LOADK
            line += f"   ; {kref[bx]}"
        if op == 14 and 0 <= bx < len(f["protos"]):  # CLOSURE
            line += f"   ; proto[{bx}]"
        out.append(f"{indent}{i:4d} {line}")
    for pi, p in enumerate(f["protos"]):
        out.append(f"{indent}-- proto {pi} {p['src']!r} lines {p['linedefined']}-{p['lastlinedefined']}")
        out.extend(disasm(p, names, depth + 1, indent + "  ", p["consts"], p["upnames"]))
    return out


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--all":
        dump_all()
        sys.exit(0)
    path = sys.argv[1] if len(sys.argv) > 1 else "data/lua/window/account/Account.bytes"
    data = open(path, "rb").read()
    version, f, end = parse_lua(data)
    print(f"file: {path}")
    print(f"custom version byte: {version}, total {len(data)} bytes, parsed to {end}")
    print(f"source: {f['src']!r}, lines {f['linedefined']}-{f['lastlinedefined']}, "
          f"params={f['numparams']} vararg={f['is_vararg']} stack={f['maxstacksize']}")
    print(f"instructions: {len(f['code'])}, consts: {len(f['consts'])}, protos: {len(f['protos'])}")
    print("--- main disasm ---")
    for line in disasm(f, names=OP)[:40]:
        print(line)
