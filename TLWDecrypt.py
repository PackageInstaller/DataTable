from __future__ import annotations

import base64
import hashlib
from functools import lru_cache

from cryptography.hazmat.primitives import padding as _padding
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

MASTER_MSGPACK_SECRET = (
    "jR3GTK6vR6gPz2MNA7hPiGEYbG6vBsMAS5jaretmHu4PS78zz3YcijFBM9yJha5HL7wn3DFYd4XaFNLB"
)
MASTER_MSGPACK_NAME = "MasterMsgPack"

EAST_MAGIC = b"EAST"
EAST_XOR_CONST = bytes.fromhex("CC111D13")
EAST_HEAD_SIZE = 128
EAST_TAIL_SIZE = 124

HOTFIX_DES_KEY = "abcd"

MASTER_TABLE_ENCRYPTION_KEYS = {
    "GachaMaster.bytes": "j4XpPUZq",
    "UnitMaster.bytes": "P9bcuyda",
}


def _generate_encryption_key(name: str, length: int, index: int) -> tuple[str, int]:
    chars: list[str] = []
    name_len = len(name)
    secret_len = len(MASTER_MSGPACK_SECRET)
    for i in range(length):
        nc = ord(name[i % name_len])
        sc = ord(MASTER_MSGPACK_SECRET[index % secret_len])
        chars.append(chr(sc ^ nc))
        index += nc
    return "".join(chars), index


def _generate_bytes(password: str, length: int) -> bytes:
    raw = password.encode("utf-8")
    return raw[:length] + b"\x00" * max(0, length - len(raw))


@lru_cache(maxsize=1)
def master_aes_key_iv() -> tuple[bytes, bytes]:
    index = len(MASTER_MSGPACK_NAME)
    key_text, index = _generate_encryption_key(MASTER_MSGPACK_NAME, 16, index)
    iv_text, index = _generate_encryption_key(MASTER_MSGPACK_NAME, 16, index)
    return _generate_bytes(key_text, 16), _generate_bytes(iv_text, 16)


def _enckey_shift(enckey: str) -> int:
    if not enckey:
        return 0
    first = ord(enckey[0])
    base = ord("a") if first >= ord("a") else ord("A")
    shift = first - base
    if shift < 0:
        shift = first - ord("A")
    return 1 << max(0, shift)


def rotate_cipher_bytes(data: bytes, enckey: str) -> bytes:
    if not enckey:
        return data
    count = len(data) // 3
    if count <= 0:
        return data
    shift = _enckey_shift(enckey) % count
    if shift == 0:
        return data
    return data[-shift:] + data[:-shift]


def decrypt_master(data: bytes, enckey: str = "") -> bytes:
    if enckey:
        data = rotate_cipher_bytes(data, enckey)
    key, iv = master_aes_key_iv()
    decryptor = Cipher(algorithms.AES(key), modes.CBC(iv)).decryptor()
    plain = decryptor.update(data) + decryptor.finalize()
    unpadder = _padding.PKCS7(128).unpadder()
    return unpadder.update(plain) + unpadder.finalize()


def decode_east(data: bytes) -> bytes:
    if len(data) < EAST_HEAD_SIZE or data[:4] != EAST_MAGIC:
        return data
    head = bytearray(data[:EAST_HEAD_SIZE])
    key = bytearray(EAST_HEAD_SIZE)
    key[: len(EAST_XOR_CONST)] = EAST_XOR_CONST
    key[len(EAST_XOR_CONST) :] = data[-EAST_TAIL_SIZE:]
    for i in range(EAST_HEAD_SIZE):
        head[i] ^= key[i]
    return bytes(head) + data[EAST_HEAD_SIZE:]


def decrypt_hotfix_text(text: str) -> str:
    from Crypto.Cipher import DES  # pycryptodome

    key = HOTFIX_DES_KEY.encode("utf-16-le")
    stripped = "".join(text.split())
    stripped += "=" * ((4 - len(stripped) % 4) % 4)
    cipher_bytes = base64.b64decode(stripped)
    raw = DES.new(key, DES.MODE_CBC, key).decrypt(cipher_bytes)
    pad = raw[-1]
    if 0 < pad <= 8 and raw[-pad:] == bytes([pad]) * pad:
        raw = raw[:-pad]
    return raw.decode("utf-16-le")


def unpack_msgpack(data: bytes):
    import msgpack

    return msgpack.unpackb(data, raw=False, strict_map_key=False)


def is_east(data: bytes) -> bool:
    return data[:4] == EAST_MAGIC


def is_unityfs(data: bytes) -> bool:
    return data[:7] == b"UnityFS"



def md5_bytes(data: bytes) -> str:
    return hashlib.md5(data).hexdigest()


def md5_file(path) -> str:
    digest = hashlib.md5()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()
