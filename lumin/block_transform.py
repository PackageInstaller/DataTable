from __future__ import annotations

import struct

MASK = 0xFFFFFFFF


def transform32(tab: bytes, prga: bytes, x25: bytes, hash_buf: bytes) -> bytes:
    L = len(tab)
    t = list(struct.unpack("<32I", tab.ljust(128, b"\x00")))
    p = list(struct.unpack("<32I", prga[:128]))
    s = list(struct.unpack("<9I", x25[:36]))
    h = list(struct.unpack("<4I", hash_buf[:16]))
    for k in range(32):
        w5 = (0x20 - k) & MASK
        t[k] = (p[k] ^ t[k] ^ w5 ^ h[s[k % 9] & 3]) & MASK
    return b"".join(struct.pack("<I", x) for x in t)[:L]


def byte_transform(data: bytes, prga: bytes, x25: bytes, hash_buf: bytes) -> bytes:
    h = list(struct.unpack("<4I", hash_buf[:16]))
    s = list(struct.unpack("<9I", x25[:36]))
    out = bytearray(data)
    for i in range(len(out)):
        t = s[h[i % 4] % 9]
        out[i] ^= prga[i] ^ i ^ (t % 255)
    return bytes(out)


def transform_d67(tab: bytes, prga: bytes, hash_buf: bytes) -> bytes:
    L = len(tab)
    t = list(struct.unpack("<32I", tab.ljust(128, b"\x00")))
    p = list(struct.unpack("<32I", prga[:128]))
    h = list(struct.unpack("<4I", hash_buf[:16]))
    for k in range(32):
        t[k] = (p[k] ^ t[k] ^ k ^ h[p[k] & 3]) & MASK
    return b"".join(struct.pack("<I", x) for x in t)[:L]


def transform_d74(tab: bytes, prga: bytes, x25: bytes, hash_buf: bytes) -> bytes:
    L = len(tab)
    t = list(struct.unpack("<32I", tab.ljust(128, b"\x00")))
    p = list(struct.unpack("<32I", prga[:128]))
    h = list(struct.unpack("<4I", hash_buf[:16]))
    s = list(struct.unpack("<9I", x25[:36]))
    for k in range(32):
        w5 = (0x20 - k) & MASK
        t[k] = (p[k] ^ t[k] ^ w5 ^ s[h[k & 3] % 9]) & MASK
    return b"".join(struct.pack("<I", x) for x in t)[:L]


def transform_d74cc(tab: bytes, prga: bytes, x25: bytes, hash_buf: bytes) -> bytes:
    L = len(tab)
    t = list(struct.unpack("<32I", tab.ljust(128, b"\x00")))
    p = list(struct.unpack("<32I", prga[:128]))
    h = list(struct.unpack("<4I", hash_buf[:16]))
    s = list(struct.unpack("<9I", x25[:36]))
    for k in range(32):
        t[k] = (p[k] ^ t[k] ^ h[p[k] & 3] ^ s[p[k] % 9]) & MASK
    return b"".join(struct.pack("<I", x) for x in t)[:L]
