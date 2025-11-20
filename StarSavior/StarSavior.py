import os
import sys
import json
import lz4.frame
import bson
import hashlib


class FileNameMasking:
    def __init__(self, filename):
        if not filename.endswith(".bytes"):
            filename = filename + ".bytes"
        md5_hash = hashlib.md5(filename.encode("utf-8")).digest()

        self.mask_bytes = bytearray(md5_hash)
        self.mask_longs = [
            int.from_bytes(md5_hash[0:8], byteorder="little", signed=False),
            int.from_bytes(md5_hash[8:16], byteorder="little", signed=False),
        ]

    def decrypt(self, buffer, offset, size, file_position, skip_bytes=0):
        pos = 0

        while pos < size:
            buffer_idx = offset + pos
            current_file_pos = file_position + pos
            if current_file_pos < skip_bytes:
                pos += 1
                continue
            key_pos = current_file_pos - skip_bytes
            if key_pos % 8 == 0 and size - pos >= 8 and buffer_idx % 8 == 0:
                mask_idx = (key_pos // 8) % len(self.mask_longs)
                mask = self.mask_longs[mask_idx]
                value = int.from_bytes(
                    buffer[buffer_idx : buffer_idx + 8],
                    byteorder="little",
                    signed=False,
                )
                value ^= mask
                buffer[buffer_idx : buffer_idx + 8] = value.to_bytes(
                    8, byteorder="little", signed=False
                )
                pos += 8
            else:
                mask_idx = key_pos % len(self.mask_bytes)
                buffer[buffer_idx] ^= self.mask_bytes[mask_idx]
                pos += 1


def decrypt_file(content, filename, skip_bytes=4):
    base_name = os.path.splitext(filename)[0]
    masking = FileNameMasking(base_name)
    buffer = bytearray(content)
    if len(buffer) > 0:
        masking.decrypt(buffer, 0, len(buffer), 0, skip_bytes)
    return bytes(buffer)


def deserialize(ip, op):
    with open(ip, "rb") as f:
        content = f.read()
    filename = os.path.basename(ip)
    header = content[:4]
    if len(header) == 4 and header == b"\x02\xde\x21\x2b":
        content = decrypt_file(content, filename, skip_bytes=4)
    header = content[:4]

    if len(header) == 4 and header[1:4] == b"\xde\x21\x2b":
        try:
            decompressed = lz4.frame.decompress(content[4:])
            try:
                str_data = json.dumps(
                    bson.decode_all(decompressed),
                    indent=4,
                    ensure_ascii=False,
                )
            except:
                str_data = decompressed.decode("utf-8-sig")
        except Exception as e:
            print(f"错误: {e}")
            return False
    elif len(header) == 4 and header == b"\x04\x22\x4d\x18":
        try:
            decompressed = lz4.frame.decompress(content)
            try:
                str_data = json.dumps(
                    bson.decode_all(decompressed), indent=4, ensure_ascii=False
                )
            except:
                str_data = decompressed.decode("utf-8-sig")
        except Exception as e:
            print(f"错误: {e}")
            return False
    else:
        try:
            str_data = content.decode("utf-8-sig")
        except:
            return False

    with open(op, "w", encoding="utf-8-sig") as f:
        f.write(str_data)
    return True


if __name__ == "__main__":
    ip = sys.argv[1]
    op = os.path.join(os.getcwd(), "MasterData")

    if not os.path.exists(op):
        os.makedirs(op)

    fc = 0
    sc = 0

    for fn in [f for f in os.listdir(ip) if os.path.isfile(os.path.join(ip, f))]:
        fc += 1
        if deserialize(
            os.path.join(ip, fn), os.path.join(op, f"{os.path.splitext(fn)[0]}.json")
        ):
            sc += 1
            print(f"✓ {fn}")
        else:
            print(f"✗ {fn} (解析失败)")

    print(f"成功解密{sc}/{fc}个文件")
