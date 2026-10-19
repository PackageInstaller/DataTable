from __future__ import annotations

_MASK = 0xFFFFFFFF
_U63_XOR = 0xF0200C9F
_U77_TREE = 0xF01FF490
_UVAR35 = 0xF01E06B9
_H0 = 0xC1646153
_U30_INIT = 0x2947E56B
_U78_INIT = 0x78DA0550


def _ror(x: int, n: int) -> int:
    x &= _MASK
    return ((x >> n) | (x << (32 - n))) & _MASK


def init_h() -> int:
    arr = [0, 0, 0, 0]
    u30 = (_UVAR35 ^ (_UVAR35 >> 9)) & 3
    arr[3] = u30
    if u30 == 1:
        arr[0], arr[1], arr[2] = 2, 0, 3
    elif u30 == 0:
        arr[0], arr[1], arr[2], arr[3] = 1, 3, arr[3], 2
    elif u30 == 2:
        arr[0], arr[1], arr[2], arr[3] = 3, arr[3], 1, 0
    else:
        arr[0], arr[1], arr[2], arr[3] = 0, 2, 3, 1
    a = (_UVAR35 >> 7) ^ 0x71
    b = a ^ _UVAR35
    c = a ^ _UVAR35 ^ 3
    d = b
    if arr[(_UVAR35 >> 3) & 3] & 1:
        d, c = c, d
    return ((c ^ d) & 0xFF) + 0xC1646150


def _tree_branch(i: int, h: int, u30: int, u78: int) -> int:
    u63 = (i ^ _U63_XOR) & _MASK
    u77 = _U77_TREE
    v82 = (u63 ^ (u77 >> 5) ^ 0x2F) & _MASK
    v44 = (_ror(u63, 25) + 0x4F) & _MASK
    v36 = (u77 ^ 0x67 ^ (u63 >> 0xB)) & _MASK
    v48 = (_ror(u63, 3) + 0x97) & _MASK
    A = (v48 ^ v82) & _MASK
    B = (v48 ^ v44) & _MASK
    C = (v44 ^ v36 ^ v82 ^ v48) & _MASK
    D = (v48 ^ v36 ^ ((((u63 | 1) * (u63 | 1)) & 7) << 2)) & _MASK
    E = (((u63 + 0x3B) & _MASK) ^ (v48 >> 1)) & _MASK
    F = ((u63 ^ 0xB3) + v48 * 2) & _MASK
    root = [A, None, None]
    n8b8 = [B, None, None]
    n8b0 = [C, None, None]
    n8a8 = [D, None, None]
    n84 = [E, None, None]
    n38 = [F, None, None]
    b = (u63 ^ root[0]) & 1
    root[1 + b] = n8b8
    root[1 + (b ^ 1)] = n84
    b = (n8b8[0] ^ 1 ^ u63) & 1
    n8b8[1 + b] = n8b0
    n8b8[1 + (b ^ 1)] = n38
    b = (n8b0[0] ^ u63) & 1
    n8b0[1 + b] = n8a8
    n8b0[1 + (b ^ 1)] = n84
    b = (n8a8[0] ^ 3 ^ u63) & 1
    n8a8[1 + b] = None
    n8a8[1 + (b ^ 1)] = n38
    n84[1] = n38
    n84[2] = n84
    n38[1] = n84
    n38[2] = n38
    acc = 0
    step = 0
    p = root
    while p is not None and step <= 5:
        acc ^= p[0]
        bb = (u63 ^ p[0] ^ step) & 1
        step += 1
        p = p[1 + bb]
    bit = 1
    if (u30 >> 9) == 0:
        bit = 1 if (u30 & 0x1FF) else 0
    return ((u78 ^ ((acc + 0xAB4A0107) & _MASK)) + (bit ^ h)) & _MASK


def hash16(buf: bytes) -> int:
    if len(buf) != 16:
        raise ValueError("hash16 expects 16 bytes")
    h = init_h()
    u30 = _U30_INIT
    u78 = _U78_INIT
    for i, byte in enumerate(buf):
        h = (h * 0x21 + byte) & _MASK
        if (h & 0xF) >= 0xB:
            bit = 1
            if (u30 >> 6) == 0:
                bit = 1 if (u30 & 0x3F) else 0
            h = ((bit ^ h) + 0xD3279CEB) & _MASK
        elif ((h >> 4) & 0xF) != 0xF:
            if ((h >> 8) & 0xF) < 2:
                u70 = 3
                u78 = (((u30 >> u70) + 0xAA115485) & _MASK) ^ h
            elif ((u78 + 0x567A) & _MASK) < 0xAB5489E4:
                if u30 < ((u78 ^ 0x738766FA) & _MASK):
                    if u78 == 0x68F53AA6:
                        if (((h + u30) & _MASK) ^ 0x68F53AA6) < 0x594AF86F:
                            u30 = (u30 + 0x89F5E9B7) & _MASK
                        else:
                            u78 = 0x602B1178
                    else:
                        if h < 0x865703B0:
                            u78 = (h ^ ((u78 + 0xED46226E) & _MASK)) & _MASK
                        else:
                            u78 = (((h + 0xA9BC7629) & _MASK) ^ u30) & _MASK
                        bit = 1
                        if (u78 >> 8) == 0:
                            bit = 1 if (u78 & 0xFF) else 0
                        h ^= bit
                else:
                    u78 = (u30 ^ (u78 >> 8)) & _MASK
            else:
                u78 = (h ^ (u78 >> 16)) & _MASK
        else:
            h = _tree_branch(i, h, u30, u78)
    return h
