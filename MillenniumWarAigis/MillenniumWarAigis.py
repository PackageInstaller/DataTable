import os
import struct
import lz4.frame
from pathlib import Path
from typing import Any, Dict
from PIL import Image


class ExtractResult:
    def __init__(
        self,
        data: bytes = None,
        archive_files: Dict[str, bytes] = None,
        image: Any = None,
        ext: str = None,
    ):
        self.data = data
        self.archive_files = archive_files
        self.is_archive = archive_files is not None
        self.image = image
        self.ext = ext


class BaseFormat:
    @classmethod
    def can_process(cls, data: bytes) -> bool:
        raise NotImplementedError

    def process(self, data: bytes) -> ExtractResult:
        raise NotImplementedError


# ATX: 贴图集格式，包含子贴图 UV 信息和内嵌图像数据
class ATXFormat(BaseFormat):
    @classmethod
    def can_process(cls, data: bytes) -> bool:
        return len(data) >= 16 and data[0:4] == b"ALTX"

    def process(self, data: bytes) -> ExtractResult:
        # data[6] 是子贴图 UV 的数量，data[8] 是真实图片的偏移量
        child_count = struct.unpack_from("<H", data, 6)[0]
        image_offset = struct.unpack_from("<I", data, 8)[0]

        if image_offset == 0 or image_offset >= len(data):
            return ExtractResult(data=data)  # 偏移异常，回退处理

        image_data = data[image_offset:]

        ext = ".bin"
        if image_data.startswith(b"\x89PNG\r\n\x1a\n"):
            ext = ".png"
        elif image_data.startswith(b"PVR\x03"):
            ext = ".pvr"
        elif image_data.startswith(b"\xabKTX "):
            ext = ".ktx"
        elif image_data.startswith(b"DDS "):
            ext = ".dds"
        elif image_data.startswith(b"ASTC"):
            ext = ".astc"

        print(
            f"  [ALTX] 识别到贴图集，包含 {child_count} 个子图切割(UV)。内嵌图像提取为 -> {ext}"
        )
        return ExtractResult(archive_files={f"atlas{ext}": image_data})


# AOD: 场景装配树格式，包含装配节点数量和结构信息
class AODFormat(BaseFormat):
    @classmethod
    def can_process(cls, data: bytes) -> bool:
        return len(data) >= 16 and data[0:4] == b"ALOD"

    def process(self, data: bytes) -> ExtractResult:
        # count = a3[6] | (((a3[7] >> 6) & 3) << 8)
        count = data[6] | (((data[7] >> 6) & 3) << 8)
        print(f"[ALOD] 识别到场景装配树(NodeTree)，包含 {count} 个装配节点。")
        # 结束递归
        return ExtractResult(data=data)


# ATB: 数据表格式，包含记录数、字段定义和可选的变长数据区
class ATBFormat(BaseFormat):
    """
    ALTB 二进制数据表解析器
    基于 ALTableImp::Save 与 ALRecordPropBind::Save 还原。
    """

    MAPPED_TO_TID = {
        1: 0x01,
        2: 0x02,
        3: 0x03,
        4: 0x04,
        5: 0x0E,
        6: 0x0F,
        7: 0x27,
        8: 0x26,
        9: 0x2C,
        10: 0x2B,
        11: 0x2C,
        32: 0x1D,
        33: 0x1D,
        64: 0x09,
        65: 0x0C,
        66: 0x13,
        96: 0x06,
    }

    FIELD_TYPES = {
        0x01: ("int32", 4),
        0x02: ("int16", 2),
        0x03: ("int8", 1),
        0x04: ("float", 4),
        0x05: ("uint32", 4),
        0x06: ("uint16", 2),
        0x07: ("uint8", 1),
        0x08: ("double", 8),
        0x09: ("vector3", 12),
        0x0A: ("vector2", 8),
        0x0B: ("point", 8),
        0x0C: ("color", 4),
        0x0D: ("bool", 1),
        0x0E: ("bool", 1),
        0x0F: ("angle", 4),
        0x10: ("datetime", 8),
        0x11: ("int64", 8),
        0x12: ("uint64", 8),
        0x13: ("rect", 16),
        0x1D: ("string", 4),
        0x26: ("string", 4),
        0x27: ("int32", 4),
        0x2B: ("int64", 8),
        0x2C: ("double", 8),
        0x00: ("unknown", 0),
    }

    @classmethod
    def can_process(cls, data: bytes) -> bool:
        return len(data) >= 16 and data[0:4] == b"ALTB"

    def process(self, data: bytes) -> ExtractResult:
        import json

        version = data[4]
        flags = data[5]
        endian = ">" if (flags & 0x80) else "<"

        record_count, schema_offset, data_offset, record_size = struct.unpack_from(
            f"{endian}HHHH", data, 6
        )

        has_var_data = bool(flags & 0x04)
        has_sort = bool(flags & 0x08)
        has_custom = bool(flags & 0x10)

        opt_ptr = 16
        var_data_size = var_data_offset = custom_id = 0
        if has_var_data and opt_ptr + 8 <= len(data):
            var_data_size, var_data_offset = struct.unpack_from(
                f"{endian}II", data, opt_ptr
            )
            opt_ptr += 8
        if has_sort and opt_ptr + 4 <= len(data):
            opt_ptr += 4
        if has_custom and opt_ptr + 4 <= len(data):
            custom_id = struct.unpack_from(f"{endian}I", data, opt_ptr)[0]

        print(
            f"  [ALTB] v{version} | 记录数={record_count} | 行大小={record_size}B "
            f"| 变长区={'有' if has_var_data else '无'}"
        )

        fields = self._parse_schema(
            data, schema_offset, data_offset, endian, record_size
        )

        if not fields:
            print(f"  [ALTB] 未检测到有效的 ALRD Schema，输出原始数据。")
            return ExtractResult(data=data, ext=".atb")

        print(
            f"  [ALTB] 解析到 {len(fields)} 个字段: "
            f"{[f['name'] for f in fields[:5]]}{'...' if len(fields) > 5 else ''}"
        )

        records = []
        var_region = (
            data[var_data_offset : var_data_offset + var_data_size]
            if has_var_data
            else None
        )

        for i in range(record_count):
            row_start = data_offset + i * record_size
            if row_start + record_size > len(data):
                break
            row_data = data[row_start : row_start + record_size]
            records.append(self._decode_row(row_data, fields, endian, var_region))

        output = {
            "_meta": {
                "version": version,
                "flags": f"0x{flags:02X}",
                "record_count": record_count,
                "record_size": record_size,
                "custom_id": custom_id if has_custom else None,
            },
            "_fields": fields,
            "records": records,
        }
        return ExtractResult(
            data=json.dumps(output, ensure_ascii=False, indent=2).encode("utf-8"),
            ext=".json",
        )

    def _parse_schema(
        self,
        data: bytes,
        schema_offset: int,
        data_offset: int,
        endian: str,
        record_size: int,
    ):
        if data[schema_offset : schema_offset + 4] != b"ALRD":
            return []

        fields = []
        ptr = schema_offset + 4
        try:
            ptr += 2  # 跳过 version 和 endian
            field_count = struct.unpack_from(f"{endian}H", data, ptr)[0]
            ptr += 4  # 跳过 count1 和 count2

            for _ in range(field_count):
                if ptr >= data_offset:
                    break

                rec_offset = struct.unpack_from(f"{endian}H", data, ptr)[0]
                mapped_type = data[ptr + 2]
                ptr += 3

                if mapped_type == 100:
                    ptr += 1
                    name = f"__special_100_{rec_offset}"
                    tid = 0x00
                else:
                    extra_size = data[ptr]
                    ptr += 3  # 跳过 extra_size 和两个 name_length

                    def read_str():
                        nonlocal ptr
                        end = data.find(b"\x00", ptr, data_offset)
                        if end == -1:
                            end = ptr
                        s = data[ptr:end].decode("utf-8", errors="replace")
                        ptr = end + 1
                        return s

                    name1, name2 = read_str(), read_str()
                    ptr = schema_offset + ((ptr - schema_offset + 3) & ~3)
                    ptr += extra_size

                    name = name1 if name1 else name2
                    if not name:
                        name = f"field_{_}"
                    tid = self.MAPPED_TO_TID.get(mapped_type, 0x00)

                type_name, type_size = self.FIELD_TYPES.get(
                    tid, (f"unknown_{mapped_type}", 0)
                )
                fields.append(
                    {
                        "name": name,
                        "type": type_name,
                        "mapped_type": mapped_type,
                        "rec_offset": rec_offset,
                        "size": type_size,
                    }
                )

            # 推断未映射类型的长度
            offsets = sorted(
                [f["rec_offset"] for f in fields if f["mapped_type"] not in (98, 100)]
                + [record_size]
            )
            for f in fields:
                if f["size"] == 0 and f["mapped_type"] not in (98, 100):
                    next_offs = [o for o in offsets if o > f["rec_offset"]]
                    if next_offs:
                        f["size"] = next_offs[0] - f["rec_offset"]

            return fields
        except Exception as e:
            print(f"  [ALTB] Schema 解析警告: {e}")
            return []

    def _decode_row(
        self, row: bytes, fields: list, endian: str, var_region: bytes
    ) -> dict:
        rec = {}
        for f in fields:
            off, size, name, tid = (
                f["rec_offset"],
                f["size"],
                f["name"],
                self.MAPPED_TO_TID.get(f["mapped_type"], 0x00),
            )
            if size <= 0 or off + size > len(row) or f["mapped_type"] in (98, 100):
                continue

            chunk = row[off : off + size]
            try:
                if tid in (0x01, 0x27):
                    rec[name] = struct.unpack_from(f"{endian}i", chunk)[0]
                elif tid == 0x02:
                    rec[name] = struct.unpack_from(f"{endian}h", chunk)[0]
                elif tid == 0x03:
                    rec[name] = struct.unpack_from("b", chunk)[0]
                elif tid in (0x04, 0x0F):
                    rec[name] = round(struct.unpack_from(f"{endian}f", chunk)[0], 6)
                elif tid == 0x05:
                    rec[name] = struct.unpack_from(f"{endian}I", chunk)[0]
                elif tid == 0x06:
                    rec[name] = struct.unpack_from(f"{endian}H", chunk)[0]
                elif tid == 0x07:
                    rec[name] = chunk[0]
                elif tid in (0x08, 0x2C):
                    rec[name] = struct.unpack_from(f"{endian}d", chunk)[0]
                elif tid == 0x09:
                    x, y, z = struct.unpack_from(f"{endian}fff", chunk)
                    rec[name] = {"x": round(x, 4), "y": round(y, 4), "z": round(z, 4)}
                elif tid == 0x0C:
                    rec[name] = (
                        f"#{chunk[0]:02X}{chunk[1]:02X}{chunk[2]:02X}{chunk[3]:02X}"
                    )
                elif tid in (0x0D, 0x0E):
                    rec[name] = bool(chunk[0])
                elif tid in (0x11, 0x2B):
                    rec[name] = struct.unpack_from(f"{endian}q", chunk)[0]
                elif tid in (0x1D, 0x26):
                    voff = struct.unpack_from(f"{endian}I", chunk)[0]
                    if var_region and voff < len(var_region):
                        end = var_region.find(b"\x00", voff)
                        rec[name] = (
                            var_region[voff:end].decode("utf-8", errors="replace")
                            if end != -1
                            else ""
                        )
                    else:
                        rec[name] = f"OFFSET_{voff}"
                else:
                    rec[name] = chunk.hex()
            except Exception:
                rec[name] = chunk.hex()
        return rec


# ATF: 字体文件格式，包含字符映射表和内嵌纹理数据
class AFTFormat(BaseFormat):
    @classmethod
    def can_process(cls, data: bytes) -> bool:
        return len(data) >= 16 and data[0:4] == b"ALFT"

    def process(self, data: bytes) -> ExtractResult:
        flags = data[5]

        # 偏移 12: 字形映射表数量
        conv_count = struct.unpack_from("<H", data, 12)[0]

        # 表格起始偏移 14，每个条目 6 字节
        offset = 14 + conv_count * 6

        # (v9 & 8) != 0
        if flags & 8:
            # 读取附加数据长度，跳过
            extra_len = struct.unpack_from("<H", data, offset)[0]
            offset += 2 + extra_len

        offset = (offset + 3) & ~3

        # if (v9 & 0x40) != 0
        if flags & 0x40:
            # 这是一个特殊的分支：当存在 0x40 标志时，表示使用了多重子字库。
            # offset 此时指向的是索引表，而实际的流在 offset + 4
            offset = struct.unpack_from("<I", data, offset + 4)[0]

        if offset < len(data):
            image_data = data[offset:]
            magic = image_data[0:4]
            # 验证提取出的数据确实是一张图 (ALIG/ALTX)
            if magic in (b"ALTX", b"ALIG", b"\x89PN", b"DDS ", b"PVR\x03", b"\xabKT"):
                magic_str = magic.decode("ascii", "ignore").strip("\x00")
                print(f"[ALFT] 在偏移 0x{offset:X} 提取出内嵌 {magic_str} 贴图。")
                return ExtractResult(archive_files={"font_texture.bin": image_data})

        print(f"  [ALFT] 定位失败或超出文件范围，输出原文件。")
        return ExtractResult(data=data)


# ALL4: LZ4 压缩格式，包含压缩数据和原始大小信息
class ALL4Format(BaseFormat):
    @classmethod
    def can_process(cls, data: bytes) -> bool:
        return len(data) >= 16 and data[0:4] == b"ALL4" and data[4] <= 1

    def process(self, data: bytes) -> ExtractResult:
        expected_size = struct.unpack_from("<I", data, 8)[0]
        return ExtractResult(data=lz4.frame.decompress(b"\x04\x22\x4d\x18" + data[16:]))


# ALAR3: 归档包格式，包含内嵌文件数量、偏移表和文件数据
class ALAR3Format(BaseFormat):
    @classmethod
    def can_process(cls, data: bytes) -> bool:
        return len(data) >= 18 and data[0:4] == b"ALAR" and data[4] == 3

    def process(self, data: bytes) -> ExtractResult:
        flags = data[5]
        count = struct.unpack_from("<H", data, 6)[0]
        shift_amount = (flags >> 2) & 2
        offsets = struct.unpack_from(f"<{count}H", data, 18)

        print(f"  [ALAR] 成功挂载 AAR 归档包，包含 {count} 个内嵌文件。正在拆解...")
        extracted_files = {}
        for i in range(count):
            entry_ptr = offsets[i] << shift_amount
            entry_id, file_offset, file_size, info = struct.unpack_from(
                "<IIII", data, entry_ptr
            )

            if (info & 0x80000000) != 0:
                name_start = entry_ptr + 18
                name_end = data.find(b"\x00", name_start)
                name = (
                    data[name_start:name_end].decode("utf-8", errors="ignore")
                    if name_end != -1
                    else f"unknown_{entry_id}.dat"
                )
            else:
                name = f"unknown_{entry_id}.dat"

            extracted_files[name] = data[file_offset : file_offset + file_size]
        return ExtractResult(archive_files=extracted_files)


# ALIG: 位图格式，包含图像尺寸、像素格式、调色板信息和原始像素数据
class ALIGFormat(BaseFormat):

    @classmethod
    def can_process(cls, data: bytes):
        return len(data) >= 32 and data[0:4] == b"ALIG"

    def process(self, data: bytes):
        version = data[4]
        fmt = data[8:12].decode("ascii", errors="ignore").strip("\x00")
        pal_count = struct.unpack_from("<H", data, 6)[0]

        # ALAigImageHandler::Load
        if version == 1:
            width, height = struct.unpack_from("<II", data, 16)
            pal_offset = struct.unpack_from("<H", data, 26)[0]
            data_offset = struct.unpack_from("<I", data, 28)[0]
        elif version == 0:
            width, height = struct.unpack_from("<II", data, 16)
            pal_offset = struct.unpack_from("<H", data, 24)[0]
            data_offset = struct.unpack_from("<H", data, 26)[0]
        else:  # Version 2+
            width, height = struct.unpack_from("<HH", data, 16)
            pal_offset = struct.unpack_from("<H", data, 22)[0]
            data_offset = struct.unpack_from("<I", data, 28)[0]

        print(
            f"  [ALIG] 转换位图: {width}x{height}, 格式:{fmt}, 调色板:{pal_count}, Version:{version}"
        )

        palette = (
            data[pal_offset : pal_offset + pal_count * 4] if pal_count > 0 else None
        )
        pixel_data = data[data_offset:]

        try:
            # 1. 16-bit ABG4 (RGBA 4444)
            if fmt == "ABG4":
                rgba = bytearray(width * height * 4)
                for i in range(width * height):
                    p = struct.unpack_from("<H", pixel_data, i * 2)[0]
                    # AssignMain PAL8→ABG4 推导：
                    #   bits[15:12] = R (高位)
                    #   bits[11:8]  = G
                    #   bits[7:4]   = B
                    #   bits[3:0]   = A (低位)
                    r = ((p >> 12) & 0xF) * 17
                    g = ((p >> 8) & 0xF) * 17
                    b = ((p >> 4) & 0xF) * 17
                    a = (p & 0xF) * 17
                    rgba[i * 4 : i * 4 + 4] = bytes([r, g, b, a])
                return ExtractResult(
                    image=Image.frombytes("RGBA", (width, height), bytes(rgba))
                )

            # 16-bit RGB5 (RGB 5551)
            elif fmt in ("RGB5", "BGR5", "ABG5"):
                rgba = bytearray(width * height * 4)
                for i in range(width * height):
                    p = struct.unpack_from("<H", pixel_data, i * 2)[0]
                    # ALImageImp5551: [R:5][G:5][B:5][A:1]
                    b = ((p >> 11) & 0x1F) << 3
                    g = ((p >> 6) & 0x1F) << 3
                    r = ((p >> 1) & 0x1F) << 3
                    a = 255 if (p & 1) else 0
                    rgba[i * 4 : i * 4 + 4] = bytes([r, g, b, a])
                return ExtractResult(
                    image=Image.frombytes("RGBA", (width, height), bytes(rgba))
                )

            # 16-bit 大调色板索引 (PAL6)
            elif fmt == "PAL6":
                rgba = bytearray(width * height * 4)
                for i in range(width * height):
                    idx = struct.unpack_from("<H", pixel_data, i * 2)[0]
                    if palette and idx < pal_count:
                        rgba[i * 4 : i * 4 + 4] = palette[idx * 4 : idx * 4 + 4]
                return ExtractResult(
                    image=Image.frombytes("RGBA", (width, height), bytes(rgba))
                )

            # 1-bit 单色遮罩 (PAL1)
            elif fmt == "PAL1":
                expanded = bytearray(width * height)
                stride = (width + 7) // 8
                for y in range(height):
                    for x in range(width):
                        byte = pixel_data[y * stride + (x // 8)]
                        expanded[y * width + x] = (byte >> (7 - (x % 8))) & 1
                img = Image.frombytes("P", (width, height), bytes(expanded))
                if palette:
                    pal_list = []
                    for i in range(min(pal_count, 2)):
                        pal_list.extend(palette[i * 4 : i * 4 + 3])
                    img.putpalette(pal_list + [0] * (768 - len(pal_list)))
                return ExtractResult(image=img.convert("RGBA"))

            # 标准 8-bit 调色板 (PAL8)
            elif fmt == "PAL8":
                img = Image.frombytes(
                    "P", (width, height), pixel_data[: width * height]
                )
                alpha_map = [255] * 256
                if palette:
                    pal_rgb, pal_count_fixed = [], min(pal_count, 256)
                    for i in range(pal_count_fixed):
                        r, g, b, a = palette[i * 4 : i * 4 + 4]
                        pal_rgb.extend([r, g, b])
                        alpha_map[i] = a
                    img.putpalette(pal_rgb + [0] * (768 - len(pal_rgb)))

                res = img.convert("RGBA")
                # 应用调色板中的 Alpha 通道
                data_rgba = bytearray(res.tobytes())
                pixels_idx = list(pixel_data[: width * height])
                for i in range(width * height):
                    data_rgba[i * 4 + 3] = alpha_map[pixels_idx[i]]
                return ExtractResult(
                    image=Image.frombytes("RGBA", (width, height), bytes(data_rgba))
                )

            # 标准 32-bit (RGBA/BGRA)
            elif fmt in ("RGBA", "8888", "BGRA"):
                mode = "RGBA" if fmt != "BGRA" else "BGRA"
                img = Image.frombytes("RGBA", (width, height), pixel_data, "raw", mode)
                return ExtractResult(image=img)

        except Exception as e:
            print(f"  [ALIG错误] {fmt} 转换失败: {e}")
        return ExtractResult(data=data, ext=f".{fmt}.alig")


class AssetProcessor:
    def __init__(self):
        # 解析器塞这里
        self.formats = [
            ALL4Format,
            ALAR3Format,
            ATXFormat,
            AFTFormat,
            ATBFormat,
            ALIGFormat,
            AODFormat,
        ]

    def recursive_process(self, filename: str, data: bytes) -> Dict[str, Any]:
        for fmt_cls in self.formats:
            if fmt_cls.can_process(data):
                try:
                    fmt = fmt_cls()
                    result = fmt.process(data)

                    if result.is_archive:
                        final_output = {}
                        for sub_name, sub_data in result.archive_files.items():
                            base_name = os.path.basename(filename)
                            archive_dir = os.path.splitext(base_name)[0] + "_unpacked"
                            sub_path = os.path.join(
                                os.path.dirname(filename), archive_dir, sub_name
                            )

                            if sub_data is data or sub_data == data:
                                final_output[sub_path] = sub_data
                            else:
                                final_output.update(
                                    self.recursive_process(sub_path, sub_data)
                                )
                        return final_output

                    elif result.image:
                        new_name = os.path.splitext(filename)[0] + (
                            result.ext or ".png"
                        )
                        return {new_name: result.image}

                    else:
                        if result.data is data or result.data == data:
                            new_name = filename
                            if result.ext:
                                new_name = os.path.splitext(new_name)[0] + result.ext
                            return {new_name: result.data}

                        new_filename = filename
                        if new_filename.endswith(".all4") or new_filename.endswith(
                            ".lz4"
                        ):
                            new_filename = os.path.splitext(new_filename)[0]
                        if result.ext:
                            new_filename = (
                                os.path.splitext(new_filename)[0] + result.ext
                            )

                        return self.recursive_process(new_filename, result.data)

                except Exception as e:
                    print(f"  [处理错误] 格式 {fmt_cls.__name__} 异常: {e}")
                    break

        return {filename: data}


def process_directory(input_dir: str, output_dir: str):
    in_path = Path(input_dir)
    out_path = Path(output_dir)

    if not in_path.exists():
        print(f"输入目录 {input_dir} 不存在！")
        return

    processor = AssetProcessor()
    success_count = 0

    for file_path in in_path.rglob("*"):
        if not file_path.is_file():
            continue

        rel_path = file_path.relative_to(in_path)
        with open(file_path, "rb") as f:
            file_data = f.read()

        print(f"\n--- 开始处理: {rel_path} ---")
        final_files = processor.recursive_process(str(rel_path), file_data)

        for final_name, final_content in final_files.items():
            clean_name = final_name.replace("\\", "/").lstrip("/")

            # 数据表提取到MasterData
            if clean_name.endswith(".json") or clean_name.endswith(".atb"):
                target_path = Path("MasterData") / Path(clean_name).name
            else:
                target_path = out_path / clean_name

            target_path.parent.mkdir(parents=True, exist_ok=True)

            if isinstance(final_content, bytes):
                with open(target_path, "wb") as f_out:
                    f_out.write(final_content)
            else:
                final_content.save(target_path)
            success_count += 1

    print(f"\n管道共输出 {success_count} 个最终资源。")


if __name__ == "__main__":
    process_directory("./input", "./output")
