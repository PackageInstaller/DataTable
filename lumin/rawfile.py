from __future__ import annotations

import hashlib

from Crypto.Cipher import AES
from Crypto.Util import Counter

MAGIC = b"LRAW"
VERSION = 1
HEADER_SIZE = 21
KEY_SALT = "Lumin.YooAsset.RawFile.AES-CTR.v1"
KEY = hashlib.sha256(KEY_SALT.encode()).digest()


class RawFileError(RuntimeError):
    pass


def is_encrypted(data: bytes) -> bool:
    return data[:4] == MAGIC and len(data) >= HEADER_SIZE and data[4] == VERSION


def decrypt(data: bytes, verify: bool = True) -> bytes:
    if not is_encrypted(data):
        if verify:
            raise RawFileError("不是 LRAW 加密文件")
        return data
    iv = data[5:HEADER_SIZE]
    body = data[HEADER_SIZE:]
    counter = Counter.new(128, initial_value=int.from_bytes(iv, "big"))
    cipher = AES.new(KEY, AES.MODE_CTR, counter=counter)
    return cipher.decrypt(body)


def read_decrypted(path) -> bytes:
    with open(path, "rb") as fh:
        return decrypt(fh.read())
