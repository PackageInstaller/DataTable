from __future__ import annotations

# 基于多项式 0xD35E417E 的 256 项 CRC 查找表
CRC: list[int] = [
    (lambda x: (
        [x := ((x >> 1) ^ (0xD35E417E if x & 1 else 0)) for _ in range(8)][-1] & 0xFFFFFFFF
    ))(i)
    for i in range(256)
]


def run(state16: bytes) -> int:
    if len(state16) < 16:
        raise ValueError(f"state16 长度必须至少为 16 字节，当前为 {len(state16)}")

    acc = ((0x007FFFFF ^ CRC[(~state16[0]) & 0xFF]) + 91) & 0xFFFFFFFF

    for b in state16[1:16]:
        idx = (acc ^ b) & 0xFF
        acc = ((CRC[idx] ^ (acc >> 9)) + 91) & 0xFFFFFFFF

    return ((~acc) + 0xBE9F85C1) & 0xFFFFFFFF
