import glob
import os
import struct
import sys


class GameReader:
    def __init__(self, data):
        self.d = data
        self.pos = 0
        self.offset = 0          # 0-based byte count (镜像 D.offset=0)
        self.strtab = []         # 1-based string intern table

    def u8(self):
        b = self.d[self.pos]
        self.pos += 1
        self.offset += 1
        return b

    def bytes(self, n):
        b = self.d[self.pos:self.pos + n]
        self.pos += n
        self.offset += n
        return b

    def varint(self):
        v = 0
        while True:
            b = self.u8()
            v = (v << 7) | (b & 0x7F)
            if not (b & 0x80):
                break
        return v

    def zig(self):
        v = self.varint()
        return ~(v >> 1) if (v & 1) else (v >> 1)

    def align(self, a=4):
        r = self.offset % a
        if r:
            self.bytes(a - r)

    def string(self):
        l = self.varint()
        if l == 0:
            key = self.varint()
            if key == 0:
                return None
            return self.strtab[key - 1]
        s = self.bytes(l)          # 含末尾 NUL
        self.strtab.append(s)
        return s


class Proto:
    def __init__(self):
        self.linedefined = 0
        self.lastlinedefined = 0
        self.numparams = 0
        self.is_vararg = 0
        self.maxstacksize = 0
        self.code = b""
        self.constants = []      # (kind, value) kind: nil/false/true/int/num/str
        self.upvalues = []       # (instack, idx, kind)
        self.protos = []
        self.source = None
        self.lineinfo = b""
        self.abslineinfo = b""
        self.locvars = []        # (name, startpc, endpc)
        self.upvaluenames = []   # str
        self.custom_opcodes = [] # 含自定义 opcode 的指令序号 (libxlua 特有)


KEEP_OPCODES = False  # True: 保留 libxlua 88 槽编号 (给 unluac --ptn)

# libxlua opcode 顺序 (DWARF L_OP_* 枚举, 88 个) -> 标准 Lua 5.4 编号
XLUA_OPCODES = [
    "MOVE","LOADI","LOADF","LOADFIX32","LOADK","LOADKX","LOADFALSE","LFALSESKIP",
    "LOADTRUE","LOADNIL","GETUPVAL","SETUPVAL","GETTABUP","GETTABLE","GETI","GETFIELD",
    "SETTABUP","SETTABLE","SETI","SETFIELD","NEWTABLE","SELF","ADDI","ADDK","SUBK","MULK",
    "MODK","POWK","DIVK","IDIVK","BANDK","BORK","BXORK","SHLI","SHRI","ADD","SUB","MUL",
    "MOD","POW","DIV","IDIV","BAND","BOR","BXOR","SHL","SHR","MMBIN","MMBINI","MMBINK",
    "UNM","BNOT","FIX32","ASFIX32","NOT","LEN","CONCAT","CLOSE","TBC","JMP","EQ","LT","LE",
    "EQK","EQI","LTI","LEI","GTI","GEI","TEST","TESTSET","CALL","TAILCALL","RETURN",
    "RETURN0","RETURN1","FORLOOP","FORPREP","TFORPREP","TFORCALL","TFORLOOP","SETLIST",
    "CLOSURE","VARARG","GETVARG","ERRNNIL","VARARGPREP","EXTRAARG",
]
STD_OPCODES = [
    "MOVE","LOADI","LOADF","LOADK","LOADKX","LOADFALSE","LFALSESKIP","LOADTRUE","LOADNIL",
    "GETUPVAL","SETUPVAL","GETTABUP","GETTABLE","GETI","GETFIELD","SETTABUP","SETTABLE",
    "SETI","SETFIELD","NEWTABLE","SELF","ADDI","ADDK","SUBK","MULK","MODK","POWK","DIVK",
    "IDIVK","BANDK","BORK","BXORK","SHRI","SHLI","ADD","SUB","MUL","MOD","POW","DIV","IDIV",
    "BAND","BOR","BXOR","SHL","SHR","MMBIN","MMBINI","MMBINK","UNM","BNOT","NOT","LEN",
    "CONCAT","CLOSE","TBC","JMP","EQ","LT","LE","EQK","EQI","LTI","LEI","GTI","GEI","TEST",
    "TESTSET","CALL","TAILCALL","RETURN","RETURN0","RETURN1","FORLOOP","FORPREP","TFORPREP",
    "TFORCALL","TFORLOOP","SETLIST","CLOSURE","VARARG","VARARGPREP","EXTRAARG",
]
STD_IDX = {name: i for i, name in enumerate(STD_OPCODES)}
# libxlua opcode 编号 -> 标准编号; 自定义 opcode 为 None
OP_REMAP = {i: STD_IDX.get(name) for i, name in enumerate(XLUA_OPCODES)}
CUSTOM_OP = {i: name for i, name in enumerate(XLUA_OPCODES) if name not in STD_IDX}


def read_function(r):
    p = Proto()
    p.linedefined = r.varint()
    p.lastlinedefined = r.varint()
    p.numparams = r.u8()
    p.is_vararg = r.u8() & 0xFB
    p.maxstacksize = r.u8()
    n = r.varint()
    r.align(4)
    code = r.bytes(4 * n)
    insns = [int.from_bytes(code[i:i+4], 'little') for i in range(0, len(code), 4)]
    p.code, p.custom_opcodes, p.pc_map = expand_code(insns)
    nk = r.varint()
    for _ in range(nk):
        tag = r.u8()
        if tag == 0:
            p.constants.append(('nil', None))
        elif tag == 1:
            p.constants.append(('false', None))
        elif tag == 17:
            p.constants.append(('true', None))
        elif tag in (3, 35):
            p.constants.append(('int', r.zig()))
        elif tag == 19:
            p.constants.append(('num', struct.unpack('<d', r.bytes(8))[0]))
        elif tag in (4, 20):
            p.constants.append(('str', r.string()))
        else:
            raise ValueError(f'unknown const tag {tag} at {r.pos - 1:#x}')
    nu = r.varint()
    for _ in range(nu):
        p.upvalues.append((r.u8(), r.u8(), r.u8()))
    np_ = r.varint()
    for _ in range(np_):
        p.protos.append(read_function(r))
    p.source = r.string()
    nl = r.varint()
    lineinfo = r.bytes(nl)
    na = r.varint()
    if na > 0:
        r.align(4)
        p.abslineinfo = r.bytes(8 * na)
    nlv = r.varint()
    for _ in range(nlv):
        nm = r.string()
        spc = r.varint()
        epc = r.varint()
        p.locvars.append((nm, spc, epc))
    nuv = r.varint()
    for _ in range(nuv):
        p.upvaluenames.append(r.string())
    # 应用 SETLIST 展开导致的 pc 重映射
    if p.pc_map:
        p.lineinfo = bytes(lineinfo[pc] for pc in p.pc_map)
        old2new = {}
        for new_pc, old_pc in enumerate(p.pc_map):
            old2new.setdefault(old_pc, new_pc)
        new_abs = bytearray()
        for i in range(0, len(p.abslineinfo), 8):
            pc, line = struct.unpack_from('<II', p.abslineinfo, i)
            new_abs += struct.pack('<II', old2new.get(pc, pc), line)
        p.abslineinfo = bytes(new_abs)
        p.locvars = [(nm, old2new.get(spc, spc), old2new.get(epc, epc))
                     for nm, spc, epc in p.locvars]
    else:
        p.lineinfo = lineinfo
    return p


def expand_code(insns):
    STD_NEWTABLE = 19
    STD_SETLIST = 78
    STD_EXTRAARG = 82
    XLUA_NEWTABLE = XLUA_OPCODES.index("NEWTABLE")
    XLUA_SETLIST = XLUA_OPCODES.index("SETLIST")
    XLUA_EXTRAARG = XLUA_OPCODES.index("EXTRAARG")
    XLUA_SELF = XLUA_OPCODES.index("SELF")
    out = []
    pc_map = []
    custom = []
    i = 0
    while i < len(insns):
        ins = insns[i]
        op = ins & 0x7F
        if op in CUSTOM_OP:
            custom.append(len(out))
        remap = OP_REMAP.get(op)
        work = ins
        if not KEEP_OPCODES and remap is not None:
            work = (ins & ~0x7F) | remap
        wop = work & 0x7F
        is_newtable = op == XLUA_NEWTABLE
        is_setlist = op == XLUA_SETLIST
        if is_newtable:
            a = (ins >> 7) & 0xFF
            hash_exp = (ins >> 16) & 0x3F
            c10 = (ins >> 22) & 0x3FF
            k = (ins >> 15) & 1
            ax = 0
            # VM 总是消费下一条 EXTRAARG（luaK_settablesize 永远写出）
            if i + 1 < len(insns) and (insns[i + 1] & 0x7F) == XLUA_EXTRAARG:
                ax = insns[i + 1] >> 7
                i += 1
            asize = c10 + (ax << 10 if k else 0)
            k2 = 1 if asize >= 256 else 0
            c8 = asize & 0xFF
            ax2 = asize >> 8
            nt_op = XLUA_NEWTABLE if KEEP_OPCODES else STD_NEWTABLE
            ea_op = XLUA_EXTRAARG if KEEP_OPCODES else STD_EXTRAARG
            out.append(nt_op | (a << 7) | (k2 << 15) | (hash_exp << 16) | (c8 << 24))
            pc_map.append(i)
            out.append(ea_op | (ax2 << 7))
            pc_map.append(i)
        elif is_setlist:
            a = (ins >> 7) & 0xFF
            tostore = (ins >> 16) & 0x3F
            c10 = (ins >> 22) & 0x3FF
            k = (ins >> 15) & 1
            ax = 0
            if i + 1 < len(insns) and (insns[i + 1] & 0x7F) == XLUA_EXTRAARG:
                ax = insns[i + 1] >> 7
                i += 1
            nelems = c10 + (ax << 10 if k else 0)
            k2 = 1 if nelems >= 256 else 0
            c8 = nelems & 0xFF
            ax2 = nelems >> 8
            sl_op = XLUA_SETLIST if KEEP_OPCODES else STD_SETLIST
            ea_op = XLUA_EXTRAARG if KEEP_OPCODES else STD_EXTRAARG
            out.append(sl_op | (a << 7) | (k2 << 15) | (tostore << 16) | (c8 << 24))
            pc_map.append(i)
            if k2:
                out.append(ea_op | (ax2 << 7))
                pc_map.append(i)
        else:
            # libxlua SELF is 5.5-style (C always K). Standard 5.4 SELF54 needs k=1.
            if op == XLUA_SELF:
                work |= (1 << 15)
            out.append(work)
            pc_map.append(i)
        i += 1
    code = b''.join(x.to_bytes(4, 'little') for x in out)
    return code, custom, pc_map


def decode_chunk(data):
    r = GameReader(data)
    assert r.bytes(3) == b'\x1bXX', 'bad signature'
    ver = r.u8()
    assert ver == 7, f'bad version {ver}'
    sizes = [r.u8() for _ in range(3)]
    assert sizes == [4, 8, 8], f'bad sizes {sizes}'
    nup = r.u8()
    main = read_function(r)
    return nup, main, r.pos


def lua_varint(x):
    groups = []
    while True:
        groups.append(x & 0x7F)
        x >>= 7
        if x == 0:
            break
    groups[0] |= 0x80
    return bytes(reversed(groups))


def dump_string(out, s):
    if s is None:
        out += b'\x80'
    else:
        out += lua_varint(len(s)) + s[:-1]
    return out


def dump_function(out, p):
    out = dump_string(out, p.source)                 # 标准 5.4: source 在最前
    out += lua_varint(p.linedefined)
    out += lua_varint(p.lastlinedefined)
    out += bytes([p.numparams, p.is_vararg, p.maxstacksize])
    out += lua_varint(len(p.code) // 4)
    out += p.code
    out += lua_varint(len(p.constants))
    for kind, val in p.constants:
        if kind == 'nil':
            out += b'\x00'
        elif kind == 'false':
            out += b'\x01'
        elif kind == 'true':
            out += b'\x11'
        elif kind == 'int':                          # 标准 tag 3 = LUA_VNUMINT
            out += b'\x03' + struct.pack('<q', val)
        elif kind == 'num':                          # 标准 tag 19 = LUA_VNUMFLT
            out += b'\x13' + struct.pack('<d', val)
        elif kind == 'str':
            content_len = len(val) - 1 if val is not None else 0
            out += (b'\x04' if content_len <= 40 else b'\x14')
            out = dump_string(out, val)
    out += lua_varint(len(p.upvalues))
    for instack, idx, kind in p.upvalues:
        out += bytes([instack, idx, kind])
    out += lua_varint(len(p.protos))
    for sub in p.protos:
        dump_function(out, sub)
    # debug
    out += lua_varint(len(p.lineinfo))
    out += p.lineinfo
    out += lua_varint(len(p.abslineinfo) // 8)
    for i in range(0, len(p.abslineinfo), 8):
        pc, line = struct.unpack_from('<II', p.abslineinfo, i)
        out += lua_varint(pc)
        out += lua_varint(line)
    out += lua_varint(len(p.locvars))
    for name, spc, epc in p.locvars:
        out = dump_string(out, name)
        out += lua_varint(spc)
        out += lua_varint(epc)
    out += lua_varint(len(p.upvaluenames))
    for nm in p.upvaluenames:
        out = dump_string(out, nm)
    return out


def to_lua54(nup, main):
    out = bytearray(b'\x1bLua\x54\x00')
    out += bytes([0x19, 0x93, 0x0D, 0x0A, 0x1A, 0x0A])
    out += bytes([4, 8, 8])                      # 5.4 头部只写 3 个 size 字节
    out += struct.pack('<q', 0x5678)
    out += struct.pack('<d', 370.5)
    out += bytes([nup])
    return bytes(dump_function(out, main))


def convert(src, dst, keep_opcodes=False):
    global KEEP_OPCODES
    KEEP_OPCODES = keep_opcodes
    data = open(src, 'rb').read()
    nup, main, end = decode_chunk(data)
    if end != len(data):
        print(f'[warn] {src}: 解析到 {end:#x}, 剩余 {len(data) - end} 字节', file=sys.stderr)
    out = to_lua54(nup, main)
    with open(dst, 'wb') as f:
        f.write(out)
    return main


def main():
    args = [a for a in sys.argv[1:] if a != '--keep-opcodes']
    keep = '--keep-opcodes' in sys.argv
    if len(args) < 1:
        print(__doc__)
        print('  --keep-opcodes  保留 libxlua 88 槽编号 (配合 unluac --ptn)')
        sys.exit(1)
    src = args[0]
    dst = args[1] if len(args) > 1 else src + ('.ptn.luac' if keep else '.lua54')
    if os.path.isdir(src):
        files = sorted(glob.glob(os.path.join(src, '*.luac')))
        if len(args) > 1:
            outdir = dst
            os.makedirs(outdir, exist_ok=True)
        else:
            outdir = src + ('_ptn' if keep else '_std')
            os.makedirs(outdir, exist_ok=True)
        ok = fail = 0
        for fp in files:
            try:
                m = convert(fp, os.path.join(outdir, os.path.basename(fp) + '.lua54'), keep)
                ok += 1
            except Exception as e:
                fail += 1
                print(f'[FAIL] {fp}: {e}')
        print(f'完成 {ok}/{len(files)} -> {outdir}/, 失败 {fail}')
        return
    m = convert(src, dst, keep)
    print(f'{src} -> {dst}: code={len(m.code)//4} instr, consts={len(m.constants)}, '
          f'upvals={len(m.upvalues)}, protos={len(m.protos)}')


if __name__ == '__main__':
    main()
