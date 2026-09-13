from __future__ import annotations

import hashlib
import shutil
import struct
from dataclasses import dataclass
from pathlib import Path
from typing import Any

BUNDLE_MAGIC = 0x6B746B41  # "Aktk"
HEADER_SIZE = 12
HASH_SIZE = 16
BLOCK_SIZE = 512

MASK32 = 0xFFFFFFFF


@dataclass
class BundleInfo:
    relative_path: str
    bundle_name: str = ""
    hash: str = ""
    crc: int = 0
    file_size: int = 0
    file_md5: str = ""
    compression: int = 0
    user_data: str = ""

    @property
    def encrypted(self) -> bool:
        return self.compression == 3

    @classmethod
    def from_catalog(cls, raw: dict[str, Any]) -> "BundleInfo":
        return cls(
            relative_path=str(raw.get("_relativePath") or raw.get("bundleName") or ""),
            bundle_name=str(raw.get("_bundleName") or ""),
            hash=str(raw.get("_hash") or ""),
            crc=int(raw.get("_crc") or 0),
            file_size=int(raw.get("_fileSize") or 0),
            file_md5=str(raw.get("_fileMd5") or ""),
            compression=int(raw.get("_compression") or 0),
            user_data=str(raw.get("_userData") or ""),
        )


def _rotl32(value: int, offset: int) -> int:
    offset &= 31
    return ((value << offset) | (value >> ((32 - offset) & 31))) & MASK32


def _rotr32(value: int, offset: int) -> int:
    return _rotl32(value, -offset)


class ChaCha20:
    def __init__(self, key: bytes, nonce: bytes, counter: int) -> None:
        ctx = [0] * 16
        ctx[0:4] = struct.unpack("<4I", b"expand 32-byte k")
        ctx[4:12] = struct.unpack("<8I", key[:32])
        n = struct.unpack("<3I", nonce[:12])
        ctx[12] = counter & MASK32
        ctx[13], ctx[14], ctx[15] = n
        self.ctx = ctx

    @staticmethod
    def _quarter(x: list[int], a: int, b: int, c: int, d: int) -> None:
        x[a] = (x[a] + x[b]) & MASK32
        x[d] = _rotl32(x[d] ^ x[a], 16)
        x[c] = (x[c] + x[d]) & MASK32
        x[b] = _rotl32(x[b] ^ x[c], 12)
        x[a] = (x[a] + x[b]) & MASK32
        x[d] = _rotl32(x[d] ^ x[a], 8)
        x[c] = (x[c] + x[d]) & MASK32
        x[b] = _rotl32(x[b] ^ x[c], 7)

    def block(self, initial: list[int] | None, rounds: int) -> bytes:
        if initial is None:
            x = list(self.ctx)
        else:
            x = [(self.ctx[i] ^ initial[i]) & MASK32 for i in range(16)]
        y = list(x)
        for _ in range(rounds, 0, -2):
            c = self._quarter
            c(x, 0, 4, 8, 12)
            c(x, 1, 5, 9, 13)
            c(x, 2, 6, 10, 14)
            c(x, 3, 7, 11, 15)
            c(x, 0, 5, 10, 15)
            c(x, 1, 6, 11, 12)
            c(x, 2, 7, 8, 13)
            c(x, 3, 4, 9, 14)
        out = struct.pack("<16I", *[(x[i] + y[i]) & MASK32 for i in range(16)])
        self.ctx[12] = (self.ctx[12] + 1) & MASK32
        if self.ctx[12] == 0:
            self.ctx[13] = (self.ctx[13] + 1) & MASK32
        return out

    def key_stream_512(self) -> bytes:
        rounds = (12, 8, 8, 8, 4, 4, 4, 4)
        blocks: list[bytes] = []
        for index, r in enumerate(rounds):
            initial = None
            if index:
                initial = struct.unpack("<16I", blocks[index - 1])
            blocks.append(self.block(initial, r))
        return b"".join(blocks)


def generate_key_stream(
    nonce_material: bytes,
    key: bytes,
    counter: int,
) -> tuple[bytes, int]:
    i = counter
    value = struct.unpack_from("<I", nonce_material, (i % 13) | 0x30)[0]
    value2 = struct.unpack_from("<I", nonce_material, (i // 13) % 13)[0]
    xor1 = struct.unpack_from("<I", nonce_material, (i // 169 % 13) | 0x10)[0]
    xor2 = struct.unpack_from("<I", nonce_material, (i // 2197 % 13) | 0x20)[0]
    seed = _rotr32(value, -(2 * (i % 2366 // 169) % 27)) ^ _rotr32(
        value2, -(3 * (i // 2366) % 27)
    )
    seed &= MASK32
    nonce = struct.pack("<3I", seed, (seed ^ xor1) & MASK32, (seed ^ xor1 ^ xor2) & MASK32)
    counter += 1
    return ChaCha20(key, nonce, counter).key_stream_512(), counter



try: 
    import numpy as _np
except ImportError: 
    _np = None

_U32 = None if _np is None else _np.uint32
_CONST = (0x61707865, 0x3320646E, 0x79622D32, 0x6B206574)
_ROUNDS = (12, 8, 8, 8, 4, 4, 4, 4)
BATCH_CHUNKS = 4096


def _rotl_np(value, amount):
    amount = amount & _U32(31)
    return (value << amount) | (value >> ((_U32(32) - amount) & _U32(31)))


class NumpyKeyStream:
    def __init__(self, nonce_material: bytes, key: bytes) -> None:
        if _np is None:  # pragma: no cover
            raise RuntimeError("numpy 不可用")
        self.windows = _np.lib.stride_tricks.sliding_window_view(
            _np.frombuffer(nonce_material, dtype=_np.uint8), 4
        )
        self.key = _np.frombuffer(key, dtype="<u4").astype("<u4")
        self.const = _np.array(_CONST, dtype="<u4")

    def _gather(self, offsets):
        return self.windows[offsets].copy().view("<u4").reshape(-1)

    @staticmethod
    def _quarter(x, a, b, c, d) -> None:
        xa, xb, xc, xd = x[a], x[b], x[c], x[d]
        xa = xa + xb
        xd = _rotl_np(xd ^ xa, _U32(16))
        xc = xc + xd
        xb = _rotl_np(xb ^ xc, _U32(12))
        xa = xa + xb
        xd = _rotl_np(xd ^ xa, _U32(8))
        xc = xc + xd
        xb = _rotl_np(xb ^ xc, _U32(7))
        x[a], x[b], x[c], x[d] = xa, xb, xc, xd

    def _batch(self, first: int, count: int) -> bytes:
        np = _np
        counter = np.arange(first, first + count, dtype=np.uint64)
        w0 = self._gather((48 + (counter % 13)).astype(np.int64))
        w1 = self._gather((counter // 13 % 13).astype(np.int64))
        w2 = self._gather((16 + (counter // 169 % 13)).astype(np.int64))
        w3 = self._gather((32 + (counter // 2197 % 13)).astype(np.int64))
        seed = _rotl_np(w0, (2 * ((counter % 2366) // 169) % 27).astype(np.uint32)) ^ _rotl_np(
            w1, (3 * (counter // 2366) % 27).astype(np.uint32)
        )
        nonce1 = seed ^ w2
        nonce2 = nonce1 ^ w3

        x = np.empty((16, count), dtype="<u4")
        x[0:4] = self.const[:, None]
        x[4:12] = self.key[:, None]
        x[12] = ((counter + 1) & np.uint64(0xFFFFFFFF)).astype("<u4")
        x[13] = seed.astype("<u4")
        x[14] = nonce1.astype("<u4")
        x[15] = nonce2.astype("<u4")

        blocks = []
        previous = None
        for index in range(8):
            y = x if previous is None else (x ^ previous)
            state = y.copy()
            for _ in range(_ROUNDS[index] // 2):
                self._quarter(state, 0, 4, 8, 12)
                self._quarter(state, 1, 5, 9, 13)
                self._quarter(state, 2, 6, 10, 14)
                self._quarter(state, 3, 7, 11, 15)
                self._quarter(state, 0, 5, 10, 15)
                self._quarter(state, 1, 6, 11, 12)
                self._quarter(state, 2, 7, 8, 13)
                self._quarter(state, 3, 4, 9, 14)
            out = state + y
            previous = out
            x[12] = x[12] + _U32(1)
            blocks.append(out)
        stacked = np.stack(blocks)  # (8 block, 16 word, count)
        return np.transpose(stacked, (2, 0, 1)).astype("<u4").tobytes()

    def generate(self, first_chunk: int, count: int) -> bytes:
        out = []
        done = 0
        while done < count:
            step = min(BATCH_CHUNKS, count - done)
            out.append(self._batch(first_chunk + done, step))
            done += step
        return b"".join(out)


def _xor_bytes(data: bytes, stream: bytes) -> bytes:
    if not data:
        return b""
    size = len(data)
    if _np is not None and size >= (1 << 16):
        left = _np.frombuffer(data, dtype=_np.uint8)
        right = _np.frombuffer(stream, dtype=_np.uint8)
        if len(left) == len(right):
            return (left ^ right).tobytes()
    step = 1 << 20
    parts = []
    for offset in range(0, size, step):
        chunk = data[offset:offset + step]
        key_chunk = stream[offset:offset + step]
        parts.append(
            (int.from_bytes(chunk, "big") ^ int.from_bytes(key_chunk, "big")).to_bytes(
                len(chunk), "big"
            )
        )
    return b"".join(parts)


class BundleCipher:
    def __init__(self, bundle: BundleInfo) -> None:
        key_material = bundle_key_material(
            bundle.bundle_name,
            bundle.file_size - HEADER_SIZE - HASH_SIZE,
            bundle.hash,
            bundle.crc,
        )
        full = hashlib.sha512(key_material).digest()
        self.key = full[:32]
        self.nonce_material = hashlib.sha512(full).digest()
        self.fast = NumpyKeyStream(self.nonce_material, self.key) if _np is not None else None

    def apply(self, payload: bytes, first_chunk: int = 0) -> bytes:
        """就地异或密钥流（加密与解密是同一个操作）。"""
        return _xor_bytes(payload, self.stream(first_chunk, len(payload)))

    def stream(self, first_chunk: int, size: int) -> bytes:
        """生成 size 字节密钥流（从第 first_chunk 个 512B 块开始）。"""
        if size <= 0:
            return b""
        if self.fast is not None:
            stream = self.fast.generate(first_chunk, (size + BLOCK_SIZE - 1) // BLOCK_SIZE)
        else:  # pragma: no cover - 无 numpy 时的回退
            counter = first_chunk
            chunks = []
            for _ in range((size + BLOCK_SIZE - 1) // BLOCK_SIZE):
                chunk, counter = generate_key_stream(self.nonce_material, self.key, counter)
                chunks.append(chunk)
            stream = b"".join(chunks)
        return stream[:size]



def is_aktk_bundle(data: bytes) -> bool:
    if len(data) < HEADER_SIZE:
        return False
    magic, version, reserved, encrypted = struct.unpack_from("<IHHI", data, 0)
    return magic == BUNDLE_MAGIC and version == 1 and reserved == 0 and encrypted <= 1


def bundle_key_material(
    bundle_name: str, payload_size: int, bundle_hash: str, crc: int
) -> bytes:
    return f"{bundle_name}-{payload_size}-{bundle_hash}-{crc}".encode("utf-8")


def decrypt_bundle(data: bytes, bundle: BundleInfo) -> bytes:
    if len(data) < HEADER_SIZE + HASH_SIZE:
        return data
    magic, version, reserved, encrypted = struct.unpack_from("<IHHI", data, 0)
    if magic != BUNDLE_MAGIC or version != 1 or reserved != 0:
        return data
    enc_hash = data[HEADER_SIZE:HEADER_SIZE + HASH_SIZE]
    payload = data[HEADER_SIZE + HASH_SIZE:]
    if hashlib.md5(payload).digest() != enc_hash:
        raise ValueError(f"{bundle.relative_path}: 加密段 MD5 不匹配")
    if encrypted != 1:
        return payload
    return BundleCipher(bundle).apply(payload)


def encrypt_bundle(payload: bytes, bundle: BundleInfo) -> bytes:
    blob = BundleCipher(bundle).apply(payload)
    header = struct.pack("<IHHI", BUNDLE_MAGIC, 1, 0, 1)
    return header + hashlib.md5(blob).digest() + blob


def is_unityfs(data: bytes) -> bool:
    return data[:8] == b"UnityFS\x00"


def transform_file(src: Path, dest: Path, bundle: BundleInfo, *, block_mb: int = 8) -> str:
    step = max(1, block_mb) * (1 << 20)
    step -= step % BLOCK_SIZE
    with src.open("rb") as handle:
        head = handle.read(HEADER_SIZE + HASH_SIZE)
        if len(head) < HEADER_SIZE + HASH_SIZE or not is_aktk_bundle(head):
            shutil.copyfile(src, dest)
            return "copied"
        magic, version, reserved, encrypted = struct.unpack_from("<IHHI", head, 0)
        if encrypted != 1:
            shutil.copyfile(src, dest)
            return "copied"
        expected_md5 = head[HEADER_SIZE:HEADER_SIZE + HASH_SIZE]
        cipher = BundleCipher(bundle)
        chunk_index = 0
        digest = hashlib.md5()
        dest.parent.mkdir(parents=True, exist_ok=True)
        with dest.open("wb") as out:
            while True:
                block = handle.read(step)
                if not block:
                    break
                digest.update(block)
                out.write(_xor_bytes(block, cipher.stream(chunk_index, len(block))))
                chunk_index += (len(block) + BLOCK_SIZE - 1) // BLOCK_SIZE
        if digest.digest() != expected_md5:
            dest.unlink(missing_ok=True)
            raise ValueError(f"{src.name}: 密文 MD5 校验失败（下载不完整？）")
    return "decrypted"


def encrypt_file(src: Path, dest: Path, bundle: BundleInfo, *, block_mb: int = 8) -> None:
    step = max(1, block_mb) * (1 << 20)
    step -= step % BLOCK_SIZE
    cipher = BundleCipher(bundle)
    payload = src.read_bytes()
    blob = cipher.apply(payload) if len(payload) <= step else b"".join(
        cipher.apply(payload[o:o + step], first_chunk=o // BLOCK_SIZE)
        for o in range(0, len(payload), step)
    )
    header = struct.pack("<IHHI", BUNDLE_MAGIC, 1, 0, 1)
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_bytes(header + hashlib.md5(blob).digest() + blob)
