from __future__ import annotations

import hashlib
from pathlib import Path
from typing import Any

import lz4.block
import xxhash
import xxtea
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad


CDN_HOST = "https://nova-static.yostar.cn"
SERVER_META_KEY = b"Xf&FRcsYm48cJ2A@"
ARCX_XOR_KEY = b"&^^%#$#_$!@![]<_>?GHBFR_7481SDR_"
XXTEA_KEY = bytes.fromhex("a921a467c7d7df396e60909c31225bd2")

REGION_CONFIGS: dict[str, dict[str, Any]] = {
    "cn": {
        "name": "国服",
        "cdn_host": "https://nova-static.yostar.cn",
        "meta_key": b"Xf&FRcsYm48cJ2A@",
        "review_meta_key": b"2T%h&FN2Yg*%229p",
        "garble_key": b"QW*Wi7fKjLk!T82Qf2nEGZA%nSC!D9qV",
        "review_garble_key": b"Jue2kK8PFB3HjB3x@A8MFS2KbWAF^xUi",
        "default_lang": "zh_cn",
        "desc": "国服 (简体中文)",
    },
    "tw": {
        "name": "台服",
        "cdn_host": "https://nova-static.stargazer-games.com",
        "meta_key": b"owGYVDmfHrxi^4pm",
        "review_meta_key": b"^ayERq^Lq9RgAdYr",
        "garble_key": b"N&mfco452ZH5!nE3s&o5uxB57UGPENVo",
        "review_garble_key": b"a3SqRDozk9vJ3jUwo*gSDsjSDk&ze2Q3",
        "default_lang": "zh_tw",
        "desc": "台服/港澳台 (繁体中文)",
    },
    "jp": {
        "name": "日服",
        "cdn_host": "https://nova-static.stellasora.jp",
        "meta_key": b"ZnUFA@S9%4KyoryM",
        "review_meta_key": b"pJkt6M7Y3qW9@g4M",
        "garble_key": b"yX5Gt64PVvVH6$qwBXaPJC*LZKoK5mYh",
        "review_garble_key": b"UPceM$N!9cEZ3e4zAzWLMYqdZ$!4K6XP",
        "default_lang": "ja_jp",
        "desc": "日服 (日文)",
    },
    "kr": {
        "name": "韩服",
        "cdn_host": "https://nova-static.stellasora.kr",
        "meta_key": b"U9cjHuwGDDx&$drn",
        "review_meta_key": b"cC9VVaX7TnP5F&33",
        "garble_key": b"25hdume9H#*6hHn@d9hSF7tekTwN#JYj",
        "review_garble_key": b"u7!AY$gby7GKMyyE8xQnqxe$ahph!2yU",
        "default_lang": "ko_kr",
        "desc": "韩服 (韩文)",
    },
    "en": {
        "name": "国际服",
        "cdn_host": "https://nova-static.stellasora.global",
        "meta_key": b"ma5Dn2FhC*Xhxy%c",
        "review_meta_key": b"8RwNK^P*bcQd5W7b",
        "garble_key": b"xNdVF^XTa6T3HCUATMQ@sKMLzAw&%L!3",
        "review_garble_key": b"2dJdv@cr!5z$3xq63t$q%wriQMNS9%&#",
        "default_lang": "en_us",
        "desc": "国际服 (英文)",
    },
}

ASSET_SIGNATURES = (
    b"UnityFS",
    b"UnityRaw",
    b"UnityWeb",
    b"UnityNEt",
    b"RIFF",
    b"BKHD",
    b"PK\x03\x04",
)


def decrypt_aes_meta(ciphertext: bytes, key: bytes = SERVER_META_KEY) -> bytes:
    iv = ciphertext[:16]
    encrypted_data = ciphertext[16:]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    decrypted = cipher.decrypt(encrypted_data)
    return unpad(decrypted, AES.block_size)


def parse_meta_manifest(buf: bytes) -> dict[str, dict[str, Any]]:
    pos = 0
    items: dict[str, dict[str, Any]] = {}
    buf_len = len(buf)

    while pos < buf_len:
        if buf[pos] != 0x0A:
            break
        pos += 1

        l = 0
        shift = 0
        while True:
            b = buf[pos]
            pos += 1
            l |= (b & 0x7F) << shift
            if not (b & 0x80):
                break
            shift += 7

        sub = buf[pos : pos + l]
        pos += l

        spos = 0
        name = ""
        md5 = ""
        dir_hash = ""
        ver = 0
        sub_len = len(sub)

        while spos < sub_len:
            tag = sub[spos]
            fnum = tag >> 3
            wtype = tag & 7
            spos += 1

            if wtype == 0:
                v = 0
                s = 0
                while True:
                    b = sub[spos]
                    spos += 1
                    v |= (b & 0x7F) << s
                    if not (b & 0x80):
                        break
                    s += 7
                if fnum == 3:
                    ver = v
            elif wtype == 2:
                vl = 0
                s = 0
                while True:
                    b = sub[spos]
                    spos += 1
                    vl |= (b & 0x7F) << s
                    if not (b & 0x80):
                        break
                    s += 7
                val = sub[spos : spos + vl]
                spos += vl
                if fnum == 1:
                    name = val.decode("utf-8", errors="ignore")
                elif fnum == 2:
                    md5 = val.decode("utf-8", errors="ignore")
                elif fnum == 4:
                    dir_hash = val.decode("utf-8", errors="ignore")
            elif wtype == 1:  # 64-bit
                spos += 8
            elif wtype == 5:  # 32-bit
                spos += 4

        if name:
            items[name] = {"name": name, "md5": md5, "ver": ver, "dir": dir_hash}

    return items


def get_cdn_url(name: str, manifest: dict[str, dict[str, Any]], host: str | None = None) -> str | None:
    it = manifest.get(name)
    if not it:
        return None
    ver = it["ver"]
    dir_hash = it["dir"]
    base_host = host or CDN_HOST
    return f"{base_host}/res/and/{ver}/{dir_hash}/{name}"


def xxtea_decrypt(data: bytes, key: bytes = XXTEA_KEY) -> bytes:
    if len(data) % 4 != 0:
        data = data.ljust(len(data) + 4 - len(data) % 4, b"\x00")
    return xxtea.decrypt(data, key, padding=xxtea.Padding.LENGTH_WORD_SUFFIX)


def xxhash64(path: str | bytes, seed: int = 0) -> int:
    if isinstance(path, str):
        path = path.encode("utf-8")
    return xxhash.xxh64(path, seed=seed).intdigest()


def decompress_lz4(data: bytes, uncompressed_size: int) -> bytes:
    return lz4.block.decompress(data, uncompressed_size=uncompressed_size)


def depad_asset_data(data: bytes) -> bytes:
    if not data:
        return data

    if len(data) >= 12 and data[4:8] == b"ftyp":
        return data

    search_limit = min(len(data), 4096)
    head_chunk = data[:search_limit]

    best_offset = -1
    for sig in ASSET_SIGNATURES:
        idx = head_chunk.find(sig)
        if idx > 0 and (best_offset == -1 or idx < best_offset):
            best_offset = idx

    idx_ftyp = head_chunk.find(b"ftyp")
    if idx_ftyp >= 4:
        box_offset = idx_ftyp - 4
        if best_offset == -1 or box_offset < best_offset:
            best_offset = box_offset

    if best_offset > 0:
        return data[best_offset:]

    return data


def md5_bytes(data: bytes) -> str:
    return hashlib.md5(data).hexdigest()


def md5_file(filepath: Path | str) -> str:
    h = hashlib.md5()
    with open(filepath, "rb") as f:
        while chunk := f.read(1024 * 1024):
            h.update(chunk)
    return h.hexdigest()
