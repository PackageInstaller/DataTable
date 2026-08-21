import base64
import struct

M = 0xFFFFFFFF
DELTA = 117423365

_KEY_B64 = (
    "vEt3HejAlgCMomkAucvaNcLOYwCla1oALnGSFBnekgCTYgsARlbfA8JjUADVk3IAo1t"
    "eAMuvwzB2phwBrU54AAK5SwCM9EkAVDmBBQ=="
)
_KEY_RAW = base64.b64decode(_KEY_B64)
KEY = list(struct.unpack("<19I", _KEY_RAW))


def _mx(y, z, s, k):
    a = (((z >> 5) ^ ((y << 2) & M)) + ((y >> 3) ^ ((z << 4) & M))) & M
    b = (((s ^ y) & M) + ((k ^ z) & M)) & M
    return a ^ b


def _dec_xxtea(v0, v1, key):
    v = [v0, v1]
    n = 2
    rounds = 2
    y = v[0]
    s = (rounds * DELTA) & M
    for _ in range(rounds):
        e = (s >> 2) & 3
        for p in range(n - 1, 0, -1):
            z = v[p - 1]
            v[p] = (v[p] - _mx(y, z, s, key[(p & 3) ^ e])) & M
            y = v[p]
        z = v[n - 1]
        v[0] = (v[0] - _mx(y, z, s, key[e])) & M
        y = v[0]
        s = (s - DELTA) & M
    return v[0], v[1]


def _dec_tea(v0, v1, key):
    s = (2 * DELTA) & M
    k0, k1, k2, k3 = key[0], key[1], key[2], key[3]
    for _ in range(2):
        v1 = (v1 - ((((v0 << 4) & M) + k2) ^ ((v0 + s) & M) ^ (((v0 >> 5) + k3) & M))) & M
        v0 = (v0 - ((((v1 << 4) & M) + k0) ^ ((s + v1) & M) ^ (((v1 >> 5) + k1) & M))) & M
        s = (s - DELTA) & M
    return v0, v1


def _dec_xor(v0, v1, key, offset):
    v0 ^= (offset ^ key[13]) & M
    v1 ^= (offset ^ key[2]) & M
    return v0 & M, v1 & M


def _dec_xtea_variant(v0, v1, key):
    s1 = (2 * DELTA) & M
    s0 = DELTA
    for _ in range(2):
        idx1 = (s1 >> 11) & 3
        inner = ((((v0 << 4) & M) ^ (v0 >> 5)) + v0) & M
        v1 = (v1 - (((s1 + key[idx1]) & M) ^ inner)) & M
        s1 = (s1 - DELTA) & M
        idx0 = s0 & 3
        inner = ((((v1 << 4) & M) ^ (v1 >> 5)) + v1) & M
        v0 = (v0 - (((s0 + key[idx0]) & M) ^ inner)) & M
        s0 = (s0 - DELTA) & M
    return v0, v1


def scipio_www(data: bytes) -> bytes:
    n = len(data)
    v4 = (data[n - 4] << 24) | (data[n - 3] << 16) | (data[n - 2] << 8) | data[n - 1]
    os_ = n - 4 - v4
    out = bytearray(os_)

    gcb = bytearray(data[os_:n - 4]) if v4 > 0 else bytearray()
    s = 235
    for i in range(len(gcb)):
        b = gcb[i]
        gcb[i] = (b ^ (s >> 8)) & 0xFF
        s = (205 * (s + b) + 207) & M

    limit = os_ - 8
    if os_ != 8:
        j = 0
        mode = 0
        while True:
            v0 = data[j] | (data[j + 1] << 8) | (data[j + 2] << 16) | (data[j + 3] << 24)
            v1 = data[j + 4] | (data[j + 5] << 8) | (data[j + 6] << 16) | (data[j + 7] << 24)
            if mode == 0:
                v0, v1 = _dec_xxtea(v0, v1, KEY)
            elif mode == 1:
                v0, v1 = _dec_tea(v0, v1, KEY)
            elif mode == 3:
                v0, v1 = _dec_xtea_variant(v0, v1, KEY)
            else:
                v0, v1 = _dec_xor(v0, v1, KEY, j)
            out[j] = v0 & 0xFF
            out[j + 1] = (v0 >> 8) & 0xFF
            out[j + 2] = (v0 >> 16) & 0xFF
            out[j + 3] = (v0 >> 24) & 0xFF
            out[j + 4] = v1 & 0xFF
            out[j + 5] = (v1 >> 8) & 0xFF
            out[j + 6] = (v1 >> 16) & 0xFF
            out[j + 7] = (v1 >> 24) & 0xFF
            j += 8
            mode = (mode + 1) & 3
            if j >= limit:
                break
        ts = j
    else:
        ts = 0

    for i in range(ts, os_):
        out[i] = data[i]
    return bytes(out)
