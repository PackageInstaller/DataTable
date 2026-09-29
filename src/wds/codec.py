"""MessagePack wire codec for the Sirius API.

Response wire format (verified against the game client in IDA):

  * body is a MessagePack stream of five frames:
        [Fault[]], [TResult], [IDataObject[]], [DeletedDataObject[]], [INotificationObject[]]
  * or the same payload wrapped in base64 text sent as one fixint per char
  * the TResult frame is either:
        - array starting with ExtType(98, <sizes...>): sizes are MessagePack ints,
          one per LZ4 block; blocks are decompressed and CONCATENATED into one
          buffer (arrays may span multiple blocks), then parsed as a stream
        - ExtType(99, <size><LZ4 block>): single block with a MessagePack int
          size prefix inside the ext data (used per-table in the master .db)

Request bodies are plain MessagePack for most endpoints; the Authenticate
payload mirrors the game and is wrapped in the same ext-98 LZ4 envelope.
"""

from __future__ import annotations

import base64
import datetime as _dt
import io
import struct
from typing import Any

import lz4.block
import msgpack


EXT_DATA = 98   # multi-block data frame marker
EXT_SINGLE = 99  # single LZ4 block marker (master data tables)


def read_stream(data: bytes, raw: bool = False) -> list[Any]:
    """Parse every top-level MessagePack object from a byte buffer."""
    return list(
        msgpack.Unpacker(io.BytesIO(data), raw=raw, strict_map_key=False)
    )


def lz4_decompress(block: bytes, size: int) -> bytes:
    return lz4.block.decompress(bytes(block), uncompressed_size=size)


def decode_response(body: bytes) -> list[Any]:
    """Decode a full response body into payload objects."""
    objs = read_stream(body)
    if objs and all(isinstance(o, int) for o in objs):
        inner = base64.b64decode(bytes(objs).decode("ascii"))
        objs = read_stream(inner)

    payloads: list[Any] = []
    for obj in objs:
        if (
            isinstance(obj, list)
            and obj
            and isinstance(obj[0], msgpack.ext.ExtType)
            and obj[0].code == EXT_DATA
        ):
            ext = obj[0]
            bins = [x for x in obj[1:] if isinstance(x, (bytes, bytearray))]
            try:
                sizes = list(msgpack.Unpacker(io.BytesIO(ext.data), raw=False))
            except Exception:
                sizes = []
            chunks: list[bytes] = []
            for block, size in zip(bins, sizes):
                try:
                    chunks.append(lz4_decompress(block, size))
                except Exception:
                    continue
            if chunks:
                payloads.extend(read_stream(b"".join(chunks)))
            else:
                payloads.append(obj)
        elif isinstance(obj, msgpack.ext.ExtType) and obj.code == EXT_SINGLE:
            payloads.extend(read_stream(_decode_single_block(obj)))
        else:
            payloads.append(obj)
    return payloads


def _int_prefix_len(b0: int) -> int | None:
    """Byte length of a MessagePack integer whose first byte is b0."""
    if b0 in (0xCC,): return 2
    if b0 in (0xCD,): return 3
    if b0 in (0xCE,): return 5
    if b0 in (0xCF,): return 9
    if b0 in (0xD1,): return 3
    if b0 in (0xD2,): return 5
    if b0 in (0xD3,): return 9
    if 0x00 <= b0 <= 0x7F or 0xE0 <= b0 <= 0xFF:
        return 1
    return None


def _decode_single_block(ext: msgpack.ext.ExtType) -> bytes:
    """ext-99 payload: [msgpack int size][LZ4 block] -> decompressed bytes."""
    n = _int_prefix_len(ext.data[0])
    if n is None:
        raise ValueError("unknown size int prefix in ext-99")
    size = msgpack.unpackb(ext.data[:n], raw=False)
    return lz4_decompress(ext.data[n:], size)


def encode_lz4_frame(payload: bytes) -> bytes:
    """Wrap MessagePack bytes in the ext-98 LZ4 envelope used by Authenticate."""
    # MessagePack's Lz4BlockArray uses raw LZ4 blocks without the 4-byte
    # size prefix that python-lz4's block.compress adds by default.
    compressed = lz4.block.compress(payload, store_size=False)
    size = msgpack.packb(len(payload))
    ext = msgpack.ExtType(EXT_DATA, size)
    return msgpack.packb([ext, compressed], use_bin_type=True)


def pack_request(payload: Any, compressed: bool = False) -> bytes:
    """Encode a request body (optionally in the ext-98 LZ4 envelope)."""
    raw = msgpack.packb(payload, use_bin_type=True)
    return encode_lz4_frame(raw) if compressed else raw


def to_json_value(value: Any) -> Any:
    """Convert MessagePack values into JSON-friendly Python values."""
    if isinstance(value, msgpack.ext.Timestamp):
        return _dt.datetime.fromtimestamp(
            value.seconds + value.nanoseconds / 1e9,
            tz=_dt.timezone.utc,
        ).isoformat()
    if isinstance(value, (bytes, bytearray)):
        b = bytes(value)
        try:
            return b.decode("utf-8")
        except UnicodeDecodeError:
            return "0x" + b.hex()
    if isinstance(value, list):
        return [to_json_value(x) for x in value]
    if isinstance(value, dict):
        return {k: to_json_value(v) for k, v in value.items()}
    if isinstance(value, msgpack.ext.ExtType):
        return {"$ext": value.code, "data": value.data.hex()}
    return value


def pack_header_table(header: dict[bytes, list[int]]) -> bytes:
    """Re-encode the master .db header map exactly as the game writes it."""

    def enc_str(b: bytes) -> bytes:
        n = len(b)
        if n <= 31:
            return bytes([0xA0 + n]) + b
        if n <= 255:
            return b"\xD9" + bytes([n]) + b
        return b"\xDA" + struct.pack(">H", n) + b

    def enc_int32(v: int) -> bytes:
        return b"\xD2" + struct.pack(">i", v)

    return (
        b"\xDE"
        + struct.pack(">H", len(header))
        + b"".join(
            enc_str(k) + b"\x92" + enc_int32(a) + enc_int32(b)
            for k, (a, b) in header.items()
        )
    )
