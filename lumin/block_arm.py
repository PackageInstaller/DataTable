from __future__ import annotations

from capstone import CS_ARCH_ARM64, CS_MODE_ARM, Cs

V168_CODE = bytes.fromhex(
    "050040396d6221d1c400010b6b01010b90fe53d38ffe44d3a61c00532901010b"
    "6300010b4200010b0101010beecc8c52a4d926b8ceccac72650257386af22ad1"
    "1104403928b89052e403252a671257388c1c7ed366225738311e005365325738"
    "64425738e8d3b772abd931b80b020f4a0f084039ef1d0053a9d92fb8090c4039"
    "291d0053a3d929b803104039631c0053a2d923b802144039421c0053a1d922b8"
    "011440390c6b6cb8211c0053a1d961b802004039421c0053a2d962b803044039"
    "2200024b611c0053a9d961b801104039211c0053a3d961b8010c40392301034b"
    "211c00536308030b4200030ba3d961b800084039001c0053a0d960b86300004b"
    "6308030b4204030b417c0453427c06532104024b210c010b21781f536001014a"
    "22040011237c2e9b002c404a63fc60d30f040012607c0213007c814b01008012"
    "2124c01a21000c4a2100020b270007ca2324c01ae71c7ed3016b67b86100014a"
    "2100020b260006ca2324c01ac61c7ed3016b66b86100014a2100020b250005ca"
    "2324c01aa51c7ed3016b65b86100014a2100020b240004ca2324c01a841c7ed3"
    "016b64b8655257386100014a646257382100020b6e725738250005ca2324c01a"
    "a51c7ed36d8257386c9257386ba25738016b65b869b257386100014a67c25738"
    "2100020b66d25738240004ca2324c01a901c7ed365e2573864f257384f0100b9"
    "016b70b84a0140b96100014a2100020b5f0500712e000eca2324c01ace1d7ed3"
    "016b6eb86100014a2100020b2d000dca2324c01aad1d7ed3016b6db86100014a"
    "2100020b2c000cca2324c01a8c1d7ed3016b6cb86100014a2100020b2b000bca"
    "2324c01a6b1d7ed3016b6bb86100014a2100020b290009ca2324c01a291d7ed3"
    "016b69b86100014a2100020b270007ca2324c01ae71c7ed3016b67b86100014a"
    "2100020b260006ca2324c01ac61c7ed3016b66b86100014a2100020b250005ca"
    "2324c01aa51c7ed3016b65b86100014a2100020b240004ca2124c01a841c7ed3"
    "006b64b89f0600f92000004a9f0a00f90000020b9f1600f99f1a00f9e003202a"
    "9f2600f90000080b9f2a00f9"
)

CRC = [
    (lambda x: (
        [x := ((x >> 1) ^ (0xD35E417E if x & 1 else 0)) for _ in range(8)][-1] & 0xFFFFFFFF
    ))(i)
    for i in range(256)
]


class _Mem:
    def __init__(self):
        self.m = {}

    def rb(self, a):
        return self.m.get(a, 0) & 0xFF

    def wb(self, a, v):
        self.m[a] = v & 0xFF

    def r32(self, a):
        return self.rb(a) | (self.rb(a + 1) << 8) | (self.rb(a + 2) << 16) | (self.rb(a + 3) << 24)

    def w32(self, a, v):
        for i in range(4):
            self.wb(a + i, v >> (8 * i))

    def r64(self, a):
        return self.r32(a) | (self.r32(a + 4) << 32)

    def w64(self, a, v):
        self.w32(a, v)
        self.w32(a + 4, v >> 32)


def _sext32(x):
    x &= 0xFFFFFFFF
    return x - 0x100000000 if x & 0x80000000 else x


try:
    _MD = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    _PARSED_INS = [
        (ins.mnemonic, ins.op_str.replace(" ", "").split(","))
        for ins in _MD.disasm(V168_CODE, 0x2CACDC)
    ]
except Exception:
    _PARSED_INS = []


def run(state16: bytes) -> int:
    mem = _Mem()
    X19 = 0x100090
    X0 = 0x400000
    X13 = 0x200000
    X24 = 0x300000
    X10 = 0x500000

    mem.wb(X0, 5)
    mem.wb(X0 + 1, 0)
    mem.wb(X0 + 2, 3)
    mem.wb(X0 + 3, 2)
    mem.wb(X0 + 4, 4)
    mem.wb(X0 + 5, 1)

    for i, b in enumerate(state16):
        mem.wb(X19 - 0x90 + i, b)
    for i, v in enumerate(CRC):
        mem.w32(X24 + 4 * i, v)

    r = [0] * 32
    r[0] = X0
    r[10] = X10
    r[13] = X13
    r[19] = X19
    r[20] = X19 + 0x740
    r[24] = X24
    r[1] = 0xF79F6255
    r[2] = 0x3BAE5FF1
    r[3] = 0xE4300000
    r[5] = 0x5A913210
    r[6] = 0xE14661FD
    r[8] = 0x76CCAF20
    r[9] = 0xD7582BEF
    r[11] = 0x04170EE0
    r[14] = 0x66666667
    r[16] = 0xFFE03

    def reg(x):
        x = x.lstrip("#")
        if x.startswith(("w", "x")):
            return int(x[1:])
        raise ValueError(x)

    def val(x):
        x = x.lstrip("#")
        if x in ("wzr", "xzr"):
            return 0
        if x.startswith(("w", "x")):
            return r[int(x[1:])] & (0xFFFFFFFF if x[0] == "w" else 0xFFFFFFFFFFFFFFFF)
        if x.startswith("0x"):
            return int(x, 16)
        if x.lstrip("-").isdigit():
            return int(x)
        raise ValueError(x)

    def memop(s):
        inner = s[s.index("[") + 1 : s.index("]")]
        parts = inner.split(",")
        base = r[int(parts[0][1:])]
        if len(parts) == 1:
            return base
        if parts[1].startswith("#"):
            return (base + int(parts[1][1:], 0)) & 0xFFFFFFFFFFFFFFFF
        idx = r[int(parts[1][1:])]
        if len(parts) > 2:
            if "sxtw" in parts[2]:
                sh = parts[2].split("#")[-1]
                idx = _sext32(idx) << int(sh, 0)
            elif parts[2].startswith("#"):
                idx = (idx & 0xFFFFFFFF) << int(parts[2][1:], 0)
        return (base + idx) & 0xFFFFFFFFFFFFFFFF

    for mn, ops in _PARSED_INS:
        if mn in ("ldrb", "ldurb"):
            r[reg(ops[0])] = mem.rb(memop(",".join(ops[1:])))
        elif mn == "ldr":
            a = memop(",".join(ops[1:]))
            r[reg(ops[0])] = mem.r32(a) if ops[0].startswith("w") else mem.r64(a)
        elif mn == "str":
            a = memop(",".join(ops[1:]))
            if ops[0] in ("xzr", "wzr"):
                mem.w32(a, 0) if ops[0] == "wzr" else mem.w64(a, 0)
            elif ops[0].startswith("w"):
                mem.w32(a, r[reg(ops[0])])
            else:
                mem.w64(a, r[reg(ops[0])])
        elif mn == "mov":
            r[reg(ops[0])] = val(ops[1])
        elif mn == "movk":
            n = reg(ops[0])
            sh = int(ops[2].split("#")[-1], 0)
            r[n] = (r[n] & ~(0xFFFF << sh)) | ((val(ops[1]) & 0xFFFF) << sh)
        elif mn == "mvn":
            r[reg(ops[0])] = (~val(ops[1])) & 0xFFFFFFFF
        elif mn in ("add", "sub", "eor"):
            a = val(ops[1])
            b = val(ops[2])
            if len(ops) > 3:
                sh = ops[3]
                n = int(sh.split("#")[-1], 0)
                if sh.startswith("lsl"):
                    b = (b << n) & 0xFFFFFFFF
                elif sh.startswith("lsr"):
                    b = (b & 0xFFFFFFFF) >> n
                elif sh.startswith("asr"):
                    b = _sext32(b) >> n
            if mn == "add":
                r[reg(ops[0])] = a + b
            elif mn == "sub":
                r[reg(ops[0])] = a - b
            else:
                r[reg(ops[0])] = a ^ b
        elif mn == "lsr":
            r[reg(ops[0])] = val(ops[1]) >> (val(ops[2]) & 0x3F)
        elif mn == "lsl":
            r[reg(ops[0])] = val(ops[1]) << (val(ops[2]) & 0x3F)
        elif mn == "asr":
            r[reg(ops[0])] = _sext32(val(ops[1]) & 0xFFFFFFFF) >> (val(ops[2]) & 0x1F)
        elif mn == "and":
            r[reg(ops[0])] = val(ops[1]) & val(ops[2])
        elif mn == "orr":
            r[reg(ops[0])] = val(ops[1]) | val(ops[2])
        elif mn == "uxtb":
            r[reg(ops[0])] = val(ops[1]) & 0xFF
        elif mn == "ubfiz":
            n = reg(ops[0])
            src = val(ops[1]) & ((1 << int(ops[3].lstrip("#"), 0)) - 1)
            r[n] = src << int(ops[2].lstrip("#"), 0)
        elif mn == "smull":
            r[reg(ops[0])] = (_sext32(val(ops[1])) * _sext32(val(ops[2]))) & 0xFFFFFFFFFFFFFFFF
        elif mn == "cmp":
            pass
        else:
            raise ValueError(f"unhandled {mn} {ops}")

        if ops and len(ops[0]) > 1 and ops[0][0] == "w" and ops[0][1:].isdigit():
            r[int(ops[0][1:])] &= 0xFFFFFFFF

    return r[0] & 0xFFFFFFFF
