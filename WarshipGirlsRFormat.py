from __future__ import annotations

import json
import re
import struct
from pathlib import Path

# packet_open：16 字节常量，从下标 15 起盖上扩展名（最长 8）
_PACKET_BASE = struct.pack("<QQ", 0x99FCE0FFB036E332, 0x3EE6F303A23F3742) + bytes([0xF1])
# 清单 data*.unity3d：整文件 XOR，相位 5
_MANIFEST_KEY = bytes.fromhex("99366988093366")
# file_key 前缀：packet_open 对容器密钥前 4 字节做有符号 /3（LDRSB + 0x55555556）

def packet_key(filename: str) -> bytes:
    """容器文件名决定 XOR 密钥。扩展名取最后一个 . / \\ 之后，超过 8 字节只留末尾。"""
    name = filename.replace("\\", "/").rsplit("/", 1)[-1]
    dot = name.rfind(".")
    ext = name[dot + 1 :] if dot >= 0 else name
    if len(ext) > 8:
        ext = ext[-8:]
    if len(ext) > 1:
        return _PACKET_BASE[:15] + ext.encode("latin1")
    return _PACKET_BASE[:17]


def xor_bytes(data: bytes, key: bytes, start: int = 0) -> bytes:
    """packet_read_file 的循环：下标走到 key 长度时用 key[0]，下一字节从 key[1] 继续。"""
    if not key or not data:
        return data
    out = bytearray(data)
    klen = len(key)
    idx = start % klen
    for i in range(len(out)):
        kidx = 0 if idx >= klen else idx
        idx = 1 if idx >= klen else idx + 1
        out[i] ^= key[kidx]
    return bytes(out)


def _sdiv3(b: int) -> int:
    """int8 向零除以 3，对应 ARM 的 signed / 3。"""
    sb = b - 256 if b >= 128 else b
    return int(sb / 3) & 0xFF


def file_key(container_key: bytes, inner_name: bytes) -> bytes:
    n = min(4, len(container_key))
    return bytes(_sdiv3(b) for b in container_key[:n]) + inner_name


def iter_lxdata(data: bytes, container_name: str):
    """产出 (内部路径, 明文)。"""
    key = packet_key(container_name)
    if len(data) < 12 or data[:6] != b"lxdata":
        raise ValueError(f"{container_name} 不是 lxdata")
    hdr = bytearray(data[:12])
    hdr[10] ^= key[0]
    if len(key) > 1:
        hdr[11] ^= key[1]
    if bytes(hdr[:6]) != b"lxdata" or hdr[7] not in (0, 3) or hdr[8] != (3 if hdr[7] == 0 else 0):
        raise ValueError(f"{container_name} 头校验失败")
    pos = struct.unpack_from("<h", hdr, 10)[0]
    while pos + 2 <= len(data):
        ln = struct.unpack("<H", xor_bytes(data[pos : pos + 2], key))[0]
        if not 11 <= ln <= 0x3FFF:
            break
        rec = bytearray(xor_bytes(data[pos : pos + ln], key))
        rec[-1] = 0
        name = bytes(rec[11:]).split(b"\x00", 1)[0]
        size = struct.unpack_from("<I", rec, 2)[0]
        body = data[pos + ln : pos + ln + size]
        yield name.decode("utf-8", "replace"), xor_bytes(xor_bytes(body, key), file_key(key, name))
        pos += ln + size
        if pos >= len(data):
            break


def encode_data_string(src: bytes) -> bytes:
    """data_encode_to_string。每 3 字节打成 4 个 (6bit+60) 字符。"""
    if not src:
        return b""
    v5 = 0
    v7 = 0
    out = bytearray()
    for v9 in src:
        v10 = 6 - v7
        carry = v7 + 2 <= 5
        v7 += 2
        v12 = ((v9 >> v7) | v5) & 0x3F
        v5 = ((v9 << v10) & 0xFF) >> 2
        if carry:
            out.append(v12 + 60)
            continue
        out.append(v12 + 60)
        out.append(v5 + 60)
        v5 = 0
        v7 = 0
    if v7:
        out.append(v5 + 60)
    return bytes(out)


def decode_data_string(text: bytes) -> bytes:
    """encode_data_string 的逆。patch.xml 用这个。"""
    syms = [c - 60 for c in text if c not in (0, 10, 13)]
    out = bytearray()

    def group(s0: int, s1: int, s2: int, s3: int) -> bytes:
        a = (s0 << 2) | (s1 >> 4)
        b = ((s1 & 0x0F) << 4) | (s2 >> 2)
        c = ((s2 & 3) << 6) | (s3 & 0x3F)
        return bytes((a & 255, b & 255, c & 255))

    i = 0
    while i + 4 <= len(syms):
        out += group(*syms[i : i + 4])
        i += 4
    rest = syms[i:]
    if len(rest) == 2:
        s0, s1 = rest
        out.append(((s0 << 2) | (s1 >> 4)) & 255)
    elif len(rest) == 3:
        s0, s1, s2 = rest
        out.append(((s0 << 2) | (s1 >> 4)) & 255)
        out.append((((s1 & 0x0F) << 4) | (s2 >> 2)) & 255)
    elif rest:
        raise ValueError(f"data 字符串长度无法还原: {len(syms)}")
    return bytes(out)


def unityfs_payload_size(data: bytes, off: int) -> int | None:
    if data[off : off + 7] != b"UnityFS":
        return None
    p = off + 8
    if p + 4 > len(data):
        return None
    p += 4
    for _ in range(2):
        z = data.find(b"\x00", p, p + 80)
        if z < 0:
            return None
        p = z + 1
    if p + 8 > len(data):
        return None
    return struct.unpack_from(">Q", data, p)[0]


def strip_unityfs(data: bytes) -> bytes | None:
    """假头后面还有一个 UnityFS，且它的 size 等于剩余长度时去掉假头。"""
    if not data.startswith(b"UnityFS"):
        return None
    if unityfs_payload_size(data, 0) == len(data):
        return data
    second = data.find(b"UnityFS", 8, 4096)
    if second > 0 and unityfs_payload_size(data, second) == len(data) - second:
        return data[second:]
    return None


def decrypt_manifest(data: bytes) -> bytes | None:
    if len(data) < 8:
        return None
    dec = bytes(b ^ _MANIFEST_KEY[(5 + i) % 7] for i, b in enumerate(data))
    if dec.startswith((b"[", b"{")):
        return dec
    return None


_NUM_KEY = re.compile(r"(?<=[{,\n])(\s*)(-?\d+)(\s*):")


def parse_game_json(data: bytes) -> object | None:
    """lxdata 解开后就是 JSON；少数表数字键没加引号。"""
    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError:
        return None
    try:
        return json.loads(text)
    except json.JSONDecodeError:
        text = _NUM_KEY.sub(r'\1"\2"\3:', text)
        try:
            return json.loads(text)
        except json.JSONDecodeError:
            return None


def fix_lua_header(data: bytes) -> bytes:
    """正确解开后就是 1B 4C 4A 02。旧的错误 file_key 会留下 1B F0 4A DE。"""
    if data.startswith(b"\x1b\xf0J\xde"):
        return b"\x1bLJ\x02" + data[4:]
    return data


def is_lxdata(data: bytes) -> bool:
    return data.startswith(b"lxdata\x00")


def _check() -> None:
    assert decode_data_string(encode_data_string(b'<?xml version="1.0"?>')) == b'<?xml version="1.0"?>'
    assert decode_data_string(encode_data_string(b"A")) == b"A"
    assert decode_data_string(encode_data_string(b"hi")) == b"hi"
    assert decode_data_string(encode_data_string(b"<patch>")) == b"<patch>"
    key = packet_key("xbask.core")
    assert key.endswith(b"core") and len(key) == 19
    assert _sdiv3(0xE3) == 0xF7 and _sdiv3(0xB0) == 0xE6
    assert file_key(key, b"a")[:4] == bytes((_sdiv3(b) for b in key[:4]))
    sample = fix_lua_header(b"\x1b\xf0J\xde\x0a")
    assert sample.startswith(b"\x1bLJ\x02")
    root = Path(__file__).resolve().parent
    apk = next(iter(sorted(root.glob("*.apk"))), None)
    if apk is None:
        return
    import zipfile

    with zipfile.ZipFile(apk) as z:
        raw = z.read("assets/starter/xbask.core")
        luas = [(name, body) for name, body in iter_lxdata(raw, "xbask.core")]
        assert any(name.endswith("init.lua") for name, _ in luas)
        lua = next(body for name, body in luas if name.endswith("init.lua"))
        assert lua.startswith(b"\x1bLJ\x02")
        bundle = z.read("assets/data/audio/story0.unity3d")
        stripped = strip_unityfs(bundle)
        assert stripped is not None and stripped.startswith(b"UnityFS")
        assert unityfs_payload_size(stripped, 0) == len(stripped)
        manifest = decrypt_manifest(z.read("assets/data_cn/data_cn.unity3d"))
        assert manifest is not None and manifest.startswith(b"[")
        cfg = next(body for name, body in iter_lxdata(z.read("assets/config.conf"), "config.conf") if name.endswith("pve_fifth_award.json"))
        assert cfg.startswith(b"{") and b'"sequence"' in cfg
        obj = parse_game_json(cfg)
        assert isinstance(obj, dict) and "sequence" in obj
    har = next(iter(sorted(root.glob("*.har"))), None)
    if har is not None:
        import base64
        import zipfile
        import io

        blob = json.loads(har.read_text())["log"]["entries"]
        entry = next(e for e in blob if str(e["request"]["url"]).endswith("part2.zip"))
        raw = base64.b64decode(entry["response"]["content"]["text"])
        xml = decode_data_string(zipfile.ZipFile(io.BytesIO(raw)).read("patch.xml"))
        assert xml.startswith(b"<?xml") and b"<patch>" in xml


if __name__ == "__main__":
    _check()
    print("ok")
