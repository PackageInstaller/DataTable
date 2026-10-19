from __future__ import annotations

import struct
from pathlib import Path

import lz4.block

from .pure_block import decrypt_core_block

UNITYFS_MAGIC = b"UnityFS\0"
COMPRESSION_NONE = 0
COMPRESSION_LZMA = 1
COMPRESSION_LZ4 = 2
COMPRESSION_LZ4HC = 3

_PADDING_AT_START = 0x40


class UnityFSError(RuntimeError):
    pass


class BlockInfo:
    __slots__ = ("uncompressed", "compressed", "flags")

    def __init__(self, uncompressed: int, compressed: int, flags: int) -> None:
        self.uncompressed = uncompressed
        self.compressed = compressed
        self.flags = flags


class Node:
    __slots__ = ("offset", "size", "flags", "path")

    def __init__(self, offset: int, size: int, flags: int, path: str) -> None:
        self.offset = offset
        self.size = size
        self.flags = flags
        self.path = path


def _cstr(data: bytes, offset: int) -> tuple[str, int]:
    end = data.index(b"\0", offset)
    return data[offset:end].decode("utf-8", "surrogateescape"), end + 1


def _align(value: int, alignment: int = 16) -> int:
    return (value + alignment - 1) & ~(alignment - 1)


def lz4_decompress(data: bytes, uncompressed_size: int) -> bytes:
    return lz4.block.decompress(data, uncompressed_size=uncompressed_size)


def decompress_block(data: bytes, uncompressed_size: int, flags: int) -> bytes:
    comp = flags & 0x3F
    if comp == COMPRESSION_NONE:
        return data
    if comp in (COMPRESSION_LZ4, COMPRESSION_LZ4HC):
        return lz4_decompress(data, uncompressed_size)
    raise UnityFSError(f"不支持的压缩类型: {comp}")


class UnityFS:
    def __init__(self, data: bytes) -> None:
        self.data = data
        if not data.startswith(UNITYFS_MAGIC):
            raise UnityFSError("不是 UnityFS 文件")
        offset = 8
        self.version = struct.unpack_from(">I", data, offset)[0]
        offset += 4
        self.unity_version, offset = _cstr(data, offset)
        self.unity_revision, offset = _cstr(data, offset)
        self.size = struct.unpack_from(">q", data, offset)[0]
        offset += 8
        self.compressed_info_size, self.uncompressed_info_size, self.flags = struct.unpack_from(
            ">III", data, offset
        )
        offset += 12

        if self.flags & _PADDING_AT_START:
            offset = _align(offset)

        self.info_offset = offset
        info_raw = data[offset : offset + self.compressed_info_size]
        info = decompress_block(info_raw, self.uncompressed_info_size, COMPRESSION_LZ4HC)
        self.blocks_info_raw = info

        pos = 16
        (block_count,) = struct.unpack_from(">I", info, pos)
        pos += 4
        self.blocks: list[BlockInfo] = []
        for _ in range(block_count):
            u, c = struct.unpack_from(">II", info, pos)
            (f,) = struct.unpack_from(">H", info, pos + 8)
            pos += 10
            self.blocks.append(BlockInfo(u, c, f))

        (node_count,) = struct.unpack_from(">I", info, pos)
        pos += 4
        self.nodes: list[Node] = []
        for _ in range(node_count):
            no, ns, nf = struct.unpack_from(">qqI", info, pos)
            pos += 20
            name, pos = _cstr(info, pos)
            self.nodes.append(Node(no, ns, nf, name))

        self.data_offset = _align(self.info_offset + self.compressed_info_size)

    def block_offset(self, index: int) -> int:
        return self.data_offset + sum(b.compressed for b in self.blocks[:index])

    def raw_block(self, index: int) -> bytes:
        b = self.blocks[index]
        off = self.block_offset(index)
        return self.data[off : off + b.compressed]

    def is_encrypted_core(self) -> bool:
        return bool(self.blocks and self.raw_block(0)[:4] == b"\xa1\xb7\xb6\xb7")

    def decrypted_bytes(self) -> bytes:
        if not self.blocks or not self.is_encrypted_core():
            return self.data
        raw = self.raw_block(0)
        plain = decrypt_core_block(raw)
        buf = bytearray(self.data)
        buf[self.data_offset : self.data_offset + len(raw)] = plain
        return bytes(buf)


def is_unityfs(data: bytes) -> bool:
    return data.startswith(UNITYFS_MAGIC)
