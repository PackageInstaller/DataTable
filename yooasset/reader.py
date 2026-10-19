"""
二进制数据读取器

提供小端序的二进制数据顺序读取能力，用于解析 YooAsset 二进制格式文件。
"""

from __future__ import annotations

import struct
from typing import List


class BufferReader:
    """小端序二进制缓冲区顺序读取器"""

    def __init__(self, data: bytes) -> None:
        self._buffer = data
        self._index = 0

    # 属性

    @property
    def is_valid(self) -> bool:
        """缓冲区是否包含有效数据"""
        return self._buffer is not None and len(self._buffer) > 0

    @property
    def capacity(self) -> int:
        """缓冲区总字节数"""
        return len(self._buffer)

    @property
    def position(self) -> int:
        """当前读取位置"""
        return self._index

    @property
    def remaining(self) -> int:
        """剩余可读字节数"""
        return max(0, len(self._buffer) - self._index)

    # 原始读取

    def _check_bounds(self, count: int) -> None:
        """检查读取操作是否会越界"""
        if self._index + count > len(self._buffer):
            raise IndexError(
                f"缓冲区溢出: 尝试读取 {count} 字节，"
                f"当前索引 {self._index}，缓冲区大小 {len(self._buffer)}"
            )

    def read_bytes(self, count: int) -> bytes:
        """读取指定数量的原始字节"""
        self._check_bounds(count)
        data = self._buffer[self._index : self._index + count]
        self._index += count
        return data

    # 基本类型
    def read_byte(self) -> int:
        """读取 uint8"""
        return struct.unpack("<B", self.read_bytes(1))[0]

    def read_bool(self) -> bool:
        """读取布尔值 (1 字节)"""
        return self.read_byte() != 0

    def read_int16(self) -> int:
        """读取 int16 (小端序)"""
        return struct.unpack("<h", self.read_bytes(2))[0]

    def read_uint16(self) -> int:
        """读取 uint16 (小端序)"""
        return struct.unpack("<H", self.read_bytes(2))[0]

    def read_int32(self) -> int:
        """读取 int32 (小端序)"""
        return struct.unpack("<i", self.read_bytes(4))[0]

    def read_uint32(self) -> int:
        """读取 uint32 (小端序)"""
        return struct.unpack("<I", self.read_bytes(4))[0]

    def read_int64(self) -> int:
        """读取 int64 (小端序)"""
        return struct.unpack("<q", self.read_bytes(8))[0]

    # 字符串
    def read_utf8(self) -> str:
        """读取 UTF-8 字符串 (uint16 长度前缀)"""
        length = self.read_uint16()
        if length == 0:
            return ""
        return self.read_bytes(length).decode("utf-8")

    def skip_utf8(self) -> None:
        """跳过一个 UTF-8 字符串而不解码"""
        length = self.read_uint16()
        if length > 0:
            self._check_bounds(length)
            self._index += length

    # 数组
    def read_utf8_array(self) -> List[str]:
        """读取 UTF-8 字符串数组 (uint16 计数前缀)"""
        count = self.read_uint16()
        return [self.read_utf8() for _ in range(count)]

    def read_int32_array(self) -> List[int]:
        """读取 int32 数组 (uint16 计数前缀)"""
        count = self.read_uint16()
        return [self.read_int32() for _ in range(count)]
