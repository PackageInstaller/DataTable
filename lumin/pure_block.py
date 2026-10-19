from __future__ import annotations

import struct
from .hash import hash16
from .block_arm import run as run_v168
from .block_transform import (
    byte_transform,
    transform32,
    transform_d67,
    transform_d74,
    transform_d74cc,
)

C25 = [0x88558046, None, 0x5C7782C2, 0x38922E17, None, None, 0x44B38670, None, 0x6B07A514]


def _ksa(key: bytes) -> list[int]:
    S = list(range(256))
    j = 0
    ln = len(key)
    for i in range(256):
        j = (j + S[i] + key[i % ln]) & 0xFF
        S[i], S[j] = S[j], S[i]
    return S


def _prga(S: list[int], n: int) -> bytes:
    j = 0
    out = bytearray()
    for m in range(n):
        i = (m + 1) & 0xFF
        j = (j + S[i]) & 0xFF
        S[i], S[j] = S[j], S[i]
        t = S[(S[i] + S[j]) & 0xFF]
        t = ((t << 1) | (t >> 7)) & 0xFF
        out.append((t - 0x61) & 0xFF)
    return bytes(out)


def derive_keys(raw: bytes) -> tuple[bytes, int]:
    L = min(0x500, len(raw))
    w = [int.from_bytes(raw[i : i + 4], "little") for i in range(0, 0x20, 4)]
    v = [
        w[2] ^ w[5] ^ 0x3F72EAF3,
        w[3] ^ w[7] ^ L,
        w[1] ^ w[4] ^ 0x753BDCAA ^ L,
        w[0] ^ w[6] ^ 0xE3D947D3,
    ]
    key1 = v[0] ^ v[1] ^ 0x5E8BC918 ^ v[2] ^ v[3] ^ L
    simple = b"".join(x.to_bytes(4, "little") for x in v)
    state = bytes(a ^ b for a, b in zip(simple, _prga(_ksa(key1.to_bytes(4, "little")), 16)))
    v1355 = hash16(simple)
    v168 = (run_v168(state) + 2) & 0xFFFFFFFF
    s = [int.from_bytes(state[i : i + 4], "little") for i in range(0, 16, 4)]
    hb = b"".join(
        x.to_bytes(4, "little")
        for x in [
            (v168 ^ ((s[3] + 0x6F1A36D8) & 0xFFFFFFFF)) & 0xFFFFFFFF,
            (((s[2] + 0x8165D38A) & 0xFFFFFFFF) ^ v1355) & 0xFFFFFFFF,
            ((s[0] ^ 0x840CF7D0) ^ v168) & 0xFFFFFFFF,
            (((s[1] + 0x48D0E844) & 0xFFFFFFFF) ^ v1355) & 0xFFFFFFFF,
        ]
    )
    return hb, hash16(hb)


def decrypt_core_block(raw: bytes) -> bytes:
    n = min(0x500, len(raw))
    C = bytearray(raw)
    hb, key2 = derive_keys(raw)
    prga128 = _prga(_ksa(key2.to_bytes(4, "little")), 128)
    x21 = bytes(a ^ b for a, b in zip(raw[0x20:0xA0], prga128))
    h = list(struct.unpack("<4I", hb))
    x25 = [C25[0], h[3], C25[2], C25[3], h[0], h[1], C25[6], h[2], C25[8]]
    x25_bytes = struct.pack("<9I", *x25)

    for i in range(min(0x20, n)):
        C[i] ^= 0xB7

    stream = _prga(_ksa(hb[:12]), 128)
    for i, t in enumerate(stream):
        if 0x20 + i < n:
            C[0x20 + i] ^= t

    cur = 0xA0
    for step in range(8):
        if cur + 0x80 > n:
            break
        seg = bytes(C[cur : cur + 0x80])
        choice = x25[step] & 3
        if choice == 0:
            out = transform_d74(seg, x21, x25_bytes, hb)
        elif choice == 1:
            out = transform_d74cc(seg, x21, x25_bytes, hb)
        elif choice == 2:
            out = transform_d67(seg, x21, hb)
        elif choice == 3:
            out = transform32(seg, x21, x25_bytes, hb)
        C[cur : cur + 0x80] = out
        cur += 0x80

    if n > cur:
        C[cur:n] = byte_transform(bytes(C[cur:n]), x21, x25_bytes, hb)

    return bytes(C)


def get_keystream(raw: bytes) -> bytes:
    n = min(0x500, len(raw))
    dec = decrypt_core_block(raw)
    return bytes(a ^ b for a, b in zip(raw[:n], dec[:n]))
