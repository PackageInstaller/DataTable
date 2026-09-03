"""CCZ! / CCZp → PVR 解码。

对照 PVR File Format Specification：
- PVR v3：低 32 位为枚举格式；高 32 位非 0 则为 packed channel（通道名 + 位宽）
- PVR v2：头 52 字节，flags 低 8 位为像素类型
- 本游戏常见：JPEG + packed A8 的 @alpha、ETC1 + ETC1 @alpha、PVR v2 RGB565
"""
from __future__ import annotations

import io
import struct
import zlib
from typing import Optional

import numpy as np
from PIL import Image
from texture2ddecoder import (
    decode_etc1,
    decode_etc2,
    decode_etc2a1,
    decode_etc2a8,
    decode_pvrtc,
)

# PVR v3 枚举（高 32 位为 0 时）
_PVR3_ETC1 = 6
_PVR3_PVRTC_2BPP_RGB = 0
_PVR3_PVRTC_2BPP_RGBA = 1
_PVR3_PVRTC_4BPP_RGB = 2
_PVR3_PVRTC_4BPP_RGBA = 3
_PVR3_ETC2_RGB = 22
_PVR3_ETC2_RGBA = 23
_PVR3_ETC2_RGB_A1 = 24

# PVR v2 flags & 0xFF（cocos2d CCTexturePVR）
_PVR2_RGBA_4444 = 0x10
_PVR2_RGBA_5551 = 0x11
_PVR2_RGBA_8888 = 0x12
_PVR2_RGB_565 = 0x13
_PVR2_RGB_888 = 0x15
_PVR2_I_8 = 0x16
_PVR2_AI_88 = 0x17
_PVR2_PVRTC_2 = 0x18
_PVR2_PVRTC_4 = 0x19
_PVR2_BGRA_8888 = 0x1A
_PVR2_A_8 = 0x1B


def _unpremultiply_rgba(arr: np.ndarray, flags: int) -> np.ndarray:
    if not (flags & 0x02):
        return arr
    a = arr[:, :, 3]
    nz = a > 0
    if nz.any():
        rgb = arr[:, :, :3].astype(np.uint16)
        rgb[nz] = np.minimum(255, rgb[nz] * 255 // a[nz, None])
        arr[:, :, :3] = rgb.astype(np.uint8)
    arr[~nz, :3] = 0
    return arr


def _bgra_to_image(pixels: bytes, width: int, height: int, flags: int) -> Image.Image:
    arr = np.frombuffer(pixels, dtype=np.uint8).reshape(height, width, 4).copy()
    arr[:, :, [0, 2]] = arr[:, :, [2, 0]]
    arr = _unpremultiply_rgba(arr, flags)
    return Image.fromarray(arr, "RGBA")


def _rgb565_to_image(payload: bytes, width: int, height: int) -> Image.Image:
    need = width * height * 2
    pix = np.frombuffer(payload[:need], dtype="<u2").reshape(height, width)
    r = ((pix >> 11) & 31) * 255 // 31
    g = ((pix >> 5) & 63) * 255 // 63
    b = (pix & 31) * 255 // 31
    return Image.fromarray(np.stack([r, g, b], axis=-1).astype(np.uint8), "RGB")


def _rgba4444_to_image(payload: bytes, width: int, height: int) -> Image.Image:
    need = width * height * 2
    pix = np.frombuffer(payload[:need], dtype="<u2").reshape(height, width)
    r = ((pix >> 12) & 15) * 255 // 15
    g = ((pix >> 8) & 15) * 255 // 15
    b = ((pix >> 4) & 15) * 255 // 15
    a = (pix & 15) * 255 // 15
    return Image.fromarray(np.stack([r, g, b, a], axis=-1).astype(np.uint8), "RGBA")


def _decode_packed(payload: bytes, width: int, height: int, fmt64: int) -> Image.Image:
    names = struct.pack("<I", fmt64 & 0xFFFFFFFF)
    bits = [
        (fmt64 >> 32) & 0xFF,
        (fmt64 >> 40) & 0xFF,
        (fmt64 >> 48) & 0xFF,
        (fmt64 >> 56) & 0xFF,
    ]
    chans = [(names[i], bits[i]) for i in range(4) if names[i] and bits[i]]
    if not chans:
        raise ValueError("empty packed channels")
    if chans in ([(ord("a"), 8)], [(ord("l"), 8)], [(ord("i"), 8)]):
        return Image.frombytes("L", (width, height), payload[: width * height])
    if [c[1] for c in chans] == [5, 6, 5]:
        return _rgb565_to_image(payload, width, height)
    if any(b != 8 for _, b in chans):
        raise ValueError(f"unsupported packed bits {chans}")
    order = bytes(c for c, _ in chans)
    n = len(chans)
    raw = payload[: width * height * n]
    if order == b"rgb":
        return Image.frombytes("RGB", (width, height), raw)
    if order == b"bgr":
        img = Image.frombytes("RGB", (width, height), raw)
        r, g, b = img.split()
        return Image.merge("RGB", (b, g, r))
    if order == b"rgba":
        return Image.frombytes("RGBA", (width, height), raw)
    if order == b"bgra":
        arr = np.frombuffer(raw, dtype=np.uint8).reshape(height, width, 4).copy()
        arr[:, :, [0, 2]] = arr[:, :, [2, 0]]
        return Image.fromarray(arr, "RGBA")
    if order == b"argb":
        arr = np.frombuffer(raw, dtype=np.uint8).reshape(height, width, 4)
        return Image.fromarray(arr[:, :, [1, 2, 3, 0]].copy(), "RGBA")
    if order == b"la" or order == b"al":
        return Image.frombytes("LA", (width, height), raw)
    raise ValueError(f"unsupported packed order {order!r}")


def _decode_pvr3(pvr: bytes) -> Image.Image:
    if len(pvr) < 52 or pvr[:4] != b"PVR\x03":
        raise ValueError("not PVR v3")
    flags, fmt64, _cs, _ct, height, width, _d, _ns, _nf, _nm, meta = struct.unpack(
        "<IQIIIIIIIII", pvr[4:52]
    )
    payload = pvr[52 + meta :]
    if not width or not height:
        raise ValueError("empty pvr size")
    if (fmt64 >> 32) != 0:
        return _decode_packed(payload, width, height, fmt64)
    fmt = fmt64 & 0xFFFFFFFF
    if fmt == _PVR3_ETC2_RGBA:
        return _bgra_to_image(decode_etc2a8(payload, width, height), width, height, flags)
    if fmt == _PVR3_ETC2_RGB:
        return _bgra_to_image(decode_etc2(payload, width, height), width, height, flags)
    if fmt == _PVR3_ETC2_RGB_A1:
        return _bgra_to_image(decode_etc2a1(payload, width, height), width, height, flags)
    if fmt == _PVR3_ETC1:
        return _bgra_to_image(decode_etc1(payload, width, height), width, height, flags)
    if fmt in (_PVR3_PVRTC_2BPP_RGB, _PVR3_PVRTC_2BPP_RGBA):
        return _bgra_to_image(decode_pvrtc(payload, width, height, True), width, height, flags)
    if fmt in (_PVR3_PVRTC_4BPP_RGB, _PVR3_PVRTC_4BPP_RGBA):
        return _bgra_to_image(decode_pvrtc(payload, width, height, False), width, height, flags)
    raise ValueError(f"unsupported PVR v3 format {fmt}")


def _decode_pvr2(pvr: bytes) -> Image.Image:
    if len(pvr) < 52:
        raise ValueError("not PVR v2")
    header_len, height, width, _mips, flags, data_len, bpp, _r, _g, _b, _a, tag, _ns = (
        struct.unpack("<11I4sI", pvr[:52])
    )
    if header_len != 52 or tag != b"PVR!":
        raise ValueError("bad PVR v2 header")
    payload = pvr[header_len : header_len + data_len]
    ptype = flags & 0xFF
    if ptype == _PVR2_RGB_565 or (bpp == 16 and ptype == _PVR2_RGB_565):
        return _rgb565_to_image(payload, width, height)
    if ptype == _PVR2_RGBA_4444:
        return _rgba4444_to_image(payload, width, height)
    if ptype == _PVR2_RGBA_8888:
        return Image.frombytes("RGBA", (width, height), payload[: width * height * 4])
    if ptype == _PVR2_BGRA_8888:
        arr = np.frombuffer(payload[: width * height * 4], dtype=np.uint8).reshape(
            height, width, 4
        ).copy()
        arr[:, :, [0, 2]] = arr[:, :, [2, 0]]
        return Image.fromarray(arr, "RGBA")
    if ptype == _PVR2_RGB_888:
        return Image.frombytes("RGB", (width, height), payload[: width * height * 3])
    if ptype in (_PVR2_A_8, _PVR2_I_8):
        return Image.frombytes("L", (width, height), payload[: width * height])
    if ptype == _PVR2_AI_88:
        return Image.frombytes("LA", (width, height), payload[: width * height * 2])
    if ptype == _PVR2_PVRTC_2:
        return _bgra_to_image(decode_pvrtc(payload, width, height, True), width, height, 0)
    if ptype == _PVR2_PVRTC_4:
        return _bgra_to_image(decode_pvrtc(payload, width, height, False), width, height, 0)
    if bpp == 16:
        return _rgb565_to_image(payload, width, height)
    raise ValueError(f"unsupported PVR v2 type {ptype:#x}")


def decode_pvr(pvr: bytes) -> Image.Image:
    if pvr[:4] == b"PVR\x03":
        return _decode_pvr3(pvr)
    if len(pvr) >= 52 and pvr[:4] == b"\x34\x00\x00\x00" and pvr[44:48] == b"PVR!":
        return _decode_pvr2(pvr)
    raise ValueError(f"unknown pvr magic {pvr[:4]!r}")


def compose_rgb_alpha(rgb: Image.Image, alpha: Image.Image) -> Image.Image:
    """把 RGB/RGBA 和 @alpha（L 或 ETC1 灰度）合成带 alpha 的 PNG。"""
    color = rgb.convert("RGB")
    if alpha.mode in ("RGBA", "RGB"):
        a = alpha.convert("RGB").split()[0]
    else:
        a = alpha.convert("L")
    if a.size != color.size:
        a = a.resize(color.size, Image.Resampling.BILINEAR)
    out = color.convert("RGBA")
    out.putalpha(a)
    return out


def load_image(data: bytes, zip_utils: "ZipUtils | None" = None) -> Image.Image | None:
    if not data:
        return None
    if data.startswith((b"CCZ!", b"CCZp")):
        zu = zip_utils or ZipUtils()
        img = zu.inflateCCZBuffer(data)
        return img if isinstance(img, Image.Image) else None
    if data[:4] == b"PVR\x03" or (
        len(data) >= 52 and data[:4] == b"\x34\x00\x00\x00" and data[44:48] == b"PVR!"
    ):
        try:
            return decode_pvr(data)
        except Exception:
            return None
    if data.startswith(b"\x89PNG") or data.startswith(b"\xff\xd8"):
        try:
            img = Image.open(io.BytesIO(data))
            img.load()
            return img
        except Exception:
            return None
    return None


class ZipUtils:
    def __init__(
        self,
        key_part1: Optional[int] = None,
        key_part2: Optional[int] = None,
        key_part3: Optional[int] = None,
        key_part4: Optional[int] = None,
    ):
        """
        Args:
            key_part1-4: 解密密钥的四个部分，仅在处理 CCZp 格式时需要
                        如果只处理 CCZ! 格式，可以不传入密钥
        """
        if key_part1 and key_part2 and key_part3 and key_part4:
            self.s_uEncryptedPvrKeyParts = [key_part1, key_part2, key_part3, key_part4]
        else:
            self.s_uEncryptedPvrKeyParts = None

    def _generate_key_stream(self, initial_sum: int) -> list[int]:
        s_uEncryptionKey = [0] * 1024

        v8 = initial_sum
        v5 = 0

        while True:
            v6 = 0
            v7 = 0
            v8 = (v8 - 0x61C88647) & 0xFFFFFFFF
            v9 = v8 >> 2
            while v7 != 1023:
                v10 = ((v7 & 0xFF) ^ (v9 & 0xFF)) & 3
                mx = (
                    ((v5 >> 5) ^ (s_uEncryptionKey[v6 + 1] << 2))
                    + ((s_uEncryptionKey[v6 + 1] >> 3) ^ (v5 << 4))
                ) & 0xFFFFFFFF
                mx ^= (
                    (v8 ^ s_uEncryptionKey[v6 + 1])
                    + (self.s_uEncryptedPvrKeyParts[v10] ^ v5)  # pyright: ignore[reportOptionalSubscript]
                ) & 0xFFFFFFFF
                s_uEncryptionKey[v6] = (s_uEncryptionKey[v6] + mx) & 0xFFFFFFFF
                v5 = s_uEncryptionKey[v6]
                v6 += 1
                v7 += 1

            y = s_uEncryptionKey[0]
            mx = (((v5 >> 5) ^ (y << 2)) + ((y >> 3) ^ (v5 << 4))) & 0xFFFFFFFF
            mx ^= (
                (v8 ^ y) + (self.s_uEncryptedPvrKeyParts[((~v9) & 3)] ^ v5)  # pyright: ignore[reportOptionalSubscript]
            ) & 0xFFFFFFFF
            s_uEncryptionKey[1023] = (s_uEncryptionKey[1023] + mx) & 0xFFFFFFFF
            v5 = s_uEncryptionKey[1023]

            if v8 == 0xB54CDA56:
                break

        return s_uEncryptionKey

    def _decrypt_data(
        self, encrypted_uints: list[int], key_stream: list[int]
    ) -> list[int]:
        num_uints = len(encrypted_uints)
        if num_uints == 0:
            return []
        key_idx, i = 0, 0
        limit = min(num_uints, 512)
        while i < limit:
            encrypted_uints[i] ^= key_stream[key_idx]
            key_idx = (key_idx + 1) % 1024
            i += 1
        while i < num_uints:
            encrypted_uints[i] ^= key_stream[key_idx]
            key_idx = (key_idx + 1) % 1024
            i += 64
        return encrypted_uints

    def inflateCCZBuffer(self, content: bytes) -> bytes | Image.Image:
        file_len = len(content)
        if file_len < 16:
            return b""
        header = content[0:4]

        if header == b"CCZp":
            try:
                if self.s_uEncryptedPvrKeyParts is None:
                    print("错误: CCZp 格式需要提供解密密钥")
                    return b""

                initial_sum = struct.unpack(">H", content[4:6])[0]
                if initial_sum != 0:
                    return b""
                key_stream = self._generate_key_stream(initial_sum)
                data_len_bytes = file_len - 12
                num_uints = data_len_bytes // 4
                encrypted_uints = list(
                    struct.unpack_from(f"<{num_uints}I", content, 12)
                )
                decrypted_uints = self._decrypt_data(encrypted_uints, key_stream)
                if not decrypted_uints:
                    return b""
                buffer = b"".join(
                    [struct.pack("<I", val) for val in decrypted_uints[1:]]
                )
                mod = data_len_bytes % 4
                if mod > 0:
                    buffer += content[-mod:]
                return decode_pvr(zlib.decompress(buffer))
            except Exception:
                return b""
        elif header == b"CCZ!":
            try:
                return decode_pvr(zlib.decompress(content[16:]))
            except Exception:
                return b""
        return b""


def _self_check() -> None:
    """合成一张 packed A8 的 CCZ!，解码后应对上像素。"""
    w, h = 4, 2
    alpha = bytes(range(w * h))
    fmt64 = (8 << 32) | ord("a")
    header = struct.pack(
        "<4sIQIIIIIIIII",
        b"PVR\x03",
        0,
        fmt64,
        0,
        0,
        h,
        w,
        1,
        1,
        1,
        1,
        0,
    )
    pvr = header + alpha
    ccz = b"CCZ!" + b"\x00" * 12 + zlib.compress(pvr)
    img = ZipUtils().inflateCCZBuffer(ccz)
    assert isinstance(img, Image.Image), type(img)
    assert img.size == (w, h) and img.mode == "L"
    assert img.tobytes() == alpha
    rgb = Image.new("RGB", (w, h), (10, 20, 30))
    merged = compose_rgb_alpha(rgb, img)
    assert merged.mode == "RGBA" and merged.size == (w, h)
    assert merged.getpixel((3, 1))[3] == alpha[-1]


if __name__ == "__main__":
    _self_check()
    print("ZipUtils self-check ok")
