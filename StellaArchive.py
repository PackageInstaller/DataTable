from __future__ import annotations

import struct
from pathlib import Path
from typing import Iterator

from StellaCrypto import (
    ARCX_XOR_KEY,
    XXTEA_KEY,
    decompress_lz4,
    xxhash64,
    xxtea_decrypt,
)

ARCX_MAGIC = 0x5241421A  # "RAB\x1a"


class ArcxEntry:
    __slots__ = ("hash", "offset", "origin_size", "size")

    def __init__(self, hash_val: int, offset: int, origin_size: int, size: int):
        self.hash = hash_val
        self.offset = offset
        self.origin_size = origin_size
        self.size = size

    def __repr__(self) -> str:
        return f"ArcxEntry(hash={hex(self.hash)}, offset={self.offset}, orig={self.origin_size}, size={self.size})"


class StellaArchive:
    def __init__(self, raw_data: bytes):
        self._raw = raw_data
        self.magic, self.version, self.flag, self.orig_size, self.size, self.count = struct.unpack_from(
            "<IIIIII", self._raw, 0
        )
        if self.magic != ARCX_MAGIC:
            raise ValueError(f"非法的 ARCX 魔数: {hex(self.magic)}, 期望: {hex(ARCX_MAGIC)}")

        entries_raw = bytearray(self._raw[24 : 24 + self.size])
        key_len = len(ARCX_XOR_KEY)
        for i in range(len(entries_raw)):
            entries_raw[i] ^= ARCX_XOR_KEY[i % key_len]

        decompressed_entries = decompress_lz4(bytes(entries_raw), self.orig_size)

        self._entries: list[ArcxEntry] = []
        self._hash_map: dict[int, ArcxEntry] = {}

        for i in range(self.count):
            h, off, osz, sz = struct.unpack_from("<QIII", decompressed_entries, i * 20)
            entry = ArcxEntry(h, off, osz, sz)
            self._entries.append(entry)
            self._hash_map[h] = entry

    @classmethod
    def from_file(cls, filepath: Path | str) -> StellaArchive:
        with open(filepath, "rb") as f:
            return cls(f.read())

    @property
    def entries(self) -> list[ArcxEntry]:
        return self._entries

    def __len__(self) -> int:
        return len(self._entries)

    def __iter__(self) -> Iterator[ArcxEntry]:
        return iter(self._entries)

    def get_by_hash(self, hash_val: int) -> ArcxEntry | None:
        return self._hash_map.get(hash_val)

    def get_by_path(self, path: str) -> ArcxEntry | None:
        h = xxhash64(path.lower().encode("utf-8"), seed=0)
        return self._hash_map.get(h)

    def read_entry_raw(self, entry: ArcxEntry) -> bytes:
        chunk = self._raw[entry.offset : entry.offset + entry.size]
        if self.flag & 256:  # LZ4
            return decompress_lz4(chunk, entry.origin_size)
        return chunk

    def read_entry(self, entry: ArcxEntry, decrypt: bool = True, key: bytes = XXTEA_KEY) -> bytes:
        data = self.read_entry_raw(entry)
        if decrypt:
            return xxtea_decrypt(data, key=key)
        return data

    def read_file(self, path: str, decrypt: bool = True, key: bytes = XXTEA_KEY) -> bytes | None:
        entry = self.get_by_path(path)
        if not entry:
            return None
        return self.read_entry(entry, decrypt=decrypt, key=key)
