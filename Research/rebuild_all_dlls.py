"""批量重建 TextAsset/ 下全部 CDPH 热更 DLL。

对每个 CDPH 容器：
  1. 解析容器（key / 8 个 section / 配置）
  2. 读配置 dword -> BSJB 元数据根，解析 5 个流头
  3. 四流整段解密：#Strings=sec1 / #Blob=sec2 / #US=sec3 / #~=sec5（chunk 0x100）
  4. #US 逐条解密（sec4，chunk 0x10）
  5. 解析 #~ 表头（valid/counts/heapSizes）按 ECMA 公式算行宽
  6. TypeDef 表行逐行解密（sec6，行宽）
  7. 逐方法体解密 IL 码（sec7，chunk 0x10，body = rva..next_rva）
  8. 重建两节 PE（.clihdr + .text），MethodDef.Rva += 0x1000
  9. 以 Module 表名为文件名输出

用法:
  python rebuild_all_dlls.py [TextAsset目录] [输出目录]
"""

from __future__ import annotations

import os
import struct
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from cdph_vm import parse_container, run_vm  # noqa: E402


def decrypt_chunked(data, prog, key, chunk=0x10):
    buf = bytearray(data)
    for i in range(0, len(buf), chunk):
        c = buf[i:i + chunk]
        run_vm(prog, key, c)
        buf[i:i + len(c)] = c
    return bytes(buf)


def parse_streams(d: bytes, root: int) -> dict:
    verlen = struct.unpack_from('<I', d, root + 12)[0]
    p = root + 16 + verlen
    nstreams = struct.unpack_from('<H', d, p + 2)[0]
    p += 4
    streams = {}
    for _ in range(nstreams):
        so, ss = struct.unpack_from('<II', d, p)
        p += 8
        ne = d.index(b'\0', p)
        name = d[p:ne].decode('latin1')
        p = (ne + 1 + 3) & ~3
        streams[name] = (root + so, ss)
    return streams


def parse_til_header(til: bytes):
    valid = struct.unpack_from('<Q', til, 8)[0]
    bits = [i for i in range(64) if (valid >> i) & 1]
    hs = til[6]
    cp = 0x18
    counts = {}
    for b in bits:
        counts[b] = struct.unpack_from('<I', til, cp)[0]
        cp += 4
    return hs, bits, counts, cp


def coded_size(n: int) -> int:
    return 2 if n < 0x10000 else 4


def table_row_size(bit: int, counts: dict, strsz: int, guidsz: int, blobsz: int) -> int:
    n = lambda b: counts.get(b, 0)  # noqa: E731
    cs = coded_size
    if bit == 0:
        # Module 行宽因构建而异：自定义 12B（Gen+Name+Mvid）或标准 18B。
        # 由 probe_module_width 在调用前修正（此处默认自定义 12B）。
        return 2 + strsz + guidsz
    if bit == 1:
        return strsz + strsz + cs(n(0) + n(26) + n(35) + n(1))
    if bit == 2:
        return 4 + strsz + strsz + cs(n(2) + n(1) + n(27)) + cs(n(4)) + cs(n(6))
    if bit == 4:
        return 2 + strsz + blobsz
    if bit == 6:
        return 4 + 2 + 2 + strsz + blobsz + cs(n(8))
    if bit == 8:
        return 2 + strsz + cs(n(2))
    if bit == 9:
        return cs(n(2)) + cs(n(1))
    if bit == 10:
        return cs(n(2) + n(1) + n(0)) + strsz + blobsz
    if bit == 11:
        return 2 + 2 + cs(n(4) + n(6) + n(2)) + blobsz
    if bit == 12:
        return cs(n(2) + n(1) + n(27)) + cs(n(10) + n(2)) + blobsz
    if bit == 13:      # FieldMarshal
        return cs(n(4) + n(6) + n(2)) + blobsz
    if bit == 14:      # DeclSecurity
        return 2 + cs(n(2) + n(6) + n(0)) + blobsz
    if bit == 15:
        return 2 + 2 + 4
    if bit == 16:      # FieldLayout
        return 4 + cs(n(4))
    if bit == 17:
        return blobsz
    if bit == 18:
        return 4 + 4
    if bit == 20:
        return 2 + strsz + blobsz
    if bit == 21:
        return 4 + 4
    if bit == 23:
        return 2 + strsz + blobsz
    if bit == 24:
        return 2 + cs(n(20)) + cs(n(6))
    if bit == 25:
        return 4 + cs(n(2)) + cs(n(6))
    if bit == 26:      # ModuleRef
        return strsz
    if bit == 27:
        return blobsz
    if bit == 28:      # ImplMap
        return 2 + cs(n(6) + n(4)) + strsz + cs(n(26))
    if bit == 29:
        return 4 + cs(n(4))
    if bit == 32:
        return 4 + 2 + 2 + 2 + 2 + 4 + blobsz + strsz + strsz + 4
    if bit == 35:
        return 4 + 2 + 2 + 2 + 2 + 4 + blobsz + strsz + strsz
    if bit == 38:      # ExportedType
        return 4 + 4 + strsz + strsz + cs(n(26) + n(32) + n(35))
    if bit == 39:      # ManifestResource
        return 4 + 4 + strsz + cs(n(35) + n(26) + n(0))
    if bit == 40:      # ManifestResource
        return 4 + 4 + strsz + cs(n(26) + n(32) + n(35))
    if bit == 41:      # NestedClass
        return cs(n(2)) + cs(n(2))
    if bit == 42:
        return 2 + 2 + cs(n(2) + n(6)) + strsz
    if bit == 43:
        return cs(n(6)) + blobsz
    if bit == 44:
        return cs(n(42)) + cs(n(2))
    raise ValueError(f"unexpected table bit {bit}")


def table_positions(
    bits, counts, row_start, strsz, guidsz, blobsz, module_width=None
) -> dict:
    pos = row_start
    out = {}
    for b in bits:
        out[b] = pos
        rs = module_width if b == 0 and module_width else table_row_size(
            b, counts, strsz, guidsz, blobsz
        )
        pos += counts[b] * rs
    return out


def probe_module_width(til, bits, counts, row_start, sections, key, strs):
    """探测 Module 表行宽（12B 自定义 / 18B 标准）：
    对 TypeDef 首行做 section6 解密，选择 flags/name 合法的一种。"""
    strsz = 4 if til[6] & 1 else 2
    guidsz = 4 if til[6] & 2 else 2
    blobsz = 4 if til[6] & 4 else 2
    best = None
    for width in (12, 18):
        pos = row_start + width
        # 累加 Module 之后的表到 TypeDef(bit2)
        try:
            for b in bits:
                if b == 2:
                    break
                pos += counts[b] * table_row_size(
                    b, counts, strsz, guidsz, blobsz
                ) if b != 0 else width
            td_row = table_row_size(2, counts, strsz, guidsz, blobsz)
            if pos + td_row > len(til):
                continue
            row = bytearray(til[pos:pos + td_row])
            run_vm(sections[6], key, row)
            flags = struct.unpack_from('<I', row, 0)[0]
            nameoff = (
                struct.unpack_from('<I', row, 4)[0]
                if strsz == 4 else struct.unpack_from('<H', row, 4)[0]
            )
            nsoff = (
                struct.unpack_from('<I', row, 8)[0]
                if strsz == 4 else struct.unpack_from('<H', row, 6)[0]
            )
            if (
                0 < flags < 0x2000000
                and 0 < nameoff < len(strs)
                and strs[nameoff] != 0
                and (nsoff == 0 or nsoff < len(strs))
            ):
                best = width
        except Exception:
            continue
    return best or 12


def read_string(strs: bytes, off: int) -> str:
    if off <= 0 or off >= len(strs):
        return ""
    e = strs.find(b"\0", off)
    return strs[off:e].decode("utf-8", "replace") if e >= 0 else ""


def decrypt_us_entries(us: bytes, prog, key) -> bytes:
    """#US 逐条解密：每条 [压缩长度][UTF-16LE 内容+尾字节]，内容 sec4/chunk0x10。"""
    buf = bytearray(us)
    if not buf:
        return b""
    i = 1  # #US 首字节 0x00 保留

    def rd_compressed(pos):
        b0 = buf[pos]
        if b0 < 0x80:
            return b0, pos + 1
        if b0 < 0xC0:
            return ((b0 & 0x3F) << 8) | buf[pos + 1], pos + 2
        return (
            ((b0 & 0x1F) << 24) | (buf[pos + 1] << 16)
            | (buf[pos + 2] << 8) | buf[pos + 3],
            pos + 4,
        )

    while i < len(buf):
        ln, ni = rd_compressed(i)
        if ln == 0 or ni + ln > len(buf):
            break
        chunk = buf[ni:ni + ln]
        dec = decrypt_chunked(bytes(chunk), prog, key, 0x10)
        buf[ni:ni + ln] = dec
        i = ni + ln
    return bytes(buf)


def module_name(til, counts, tpos, strs, strsz) -> str:
    moff = tpos[0]
    nameoff = struct.unpack_from('<I', til, moff + 2)[0] if strsz == 4 else \
        struct.unpack_from('<H', til, moff + 2)[0]
    return read_string(strs, nameoff)


def locate_typedef_start(til, bits, counts, tpos, row_start, sections, key, strs):
    """自适应定位 TypeDef 表真实起点：
    不同 DLL 的 Module/TypeRef 行宽存在差异（12B/10B 等），
    从公式位置附近扫描 section6 解密后 flags/name 合法的行。"""
    strsz = 4 if til[6] & 1 else 2
    guidsz = 4 if til[6] & 2 else 2
    blobsz = 4 if til[6] & 4 else 2
    td_row = table_row_size(2, counts, strsz, guidsz, blobsz)
    calc = tpos[2]

    def ok(base):
        if base + td_row * 2 > len(til):
            return False
        names = []
        for i in range(2):
            row = bytearray(til[base + i * td_row:base + (i + 1) * td_row])
            run_vm(sections[6], key, row)
            flags = struct.unpack_from('<I', row, 0)[0]
            noff = (
                struct.unpack_from('<I', row, 4)[0]
                if strsz == 4 else struct.unpack_from('<H', row, 4)[0]
            )
            if flags > 0x2000000:
                return False
            if not (0 < noff < len(strs)) or strs[noff] == 0:
                return False
            names.append(read_string(strs, noff))
        return names

    best = None
    for base in range(calc - 0x400, calc + 0x400, 2):
        if base < row_start:
            continue
        names = ok(base)
        if names:
            best = (base, names)
            break
    return best


def build_image(d, key, sections, streams, meta_root):
    """解密并覆盖元数据，返回可写 body（容器偏移不变）。"""
    til_raw = decrypt_chunked(
        d[streams['#~'][0]:streams['#~'][0] + streams['#~'][1]],
        sections[5], key, 0x100,
    )
    strs = decrypt_chunked(
        d[streams['#Strings'][0]:streams['#Strings'][0] + streams['#Strings'][1]],
        sections[1], key, 0x100,
    )
    blob = decrypt_chunked(
        d[streams['#Blob'][0]:streams['#Blob'][0] + streams['#Blob'][1]],
        sections[2], key, 0x100,
    )
    us = None
    if '#US' in streams:
        us = decrypt_chunked(
            d[streams['#US'][0]:streams['#US'][0] + streams['#US'][1]],
            sections[3], key, 0x100,
        )
        us = decrypt_us_entries(us, sections[4], key)

    hs, bits, counts, row_start = parse_til_header(til_raw)
    strsz = 4 if hs & 1 else 2
    guidsz = 4 if hs & 2 else 2
    blobsz = 4 if hs & 4 else 2
    tpos = table_positions(
        bits, counts, row_start, strsz, guidsz, blobsz
    )
    located = locate_typedef_start(
        til_raw, bits, counts, tpos, row_start, sections, key, strs
    )
    if located:
        td_real = located[0]
        delta = td_real - tpos[2]
        if delta:
            for b in list(tpos):
                if b >= 2:
                    tpos[b] += delta
            print(f"    [i] TypeDef 起点修正 {tpos[2] - delta:#x} -> {td_real:#x} "
                  f"(delta {delta:+d}) 首类型: {located[1]}")
    td_row = table_row_size(2, counts, strsz, guidsz, blobsz)
    md_row = table_row_size(6, counts, strsz, guidsz, blobsz)

    # TypeDef 表行解密
    til = bytearray(til_raw)
    td_off = tpos[2]
    for i in range(counts[2]):
        row = bytearray(til[td_off + i * td_row:td_off + (i + 1) * td_row])
        run_vm(sections[6], key, row)
        til[td_off + i * td_row:td_off + (i + 1) * td_row] = row

    # IL 代码逐方法体解密（section7）
    md_off = tpos[6]
    rvas = sorted({
        struct.unpack_from('<I', til, md_off + i * md_row)[0]
        for i in range(counts[6])
        if struct.unpack_from('<I', til, md_off + i * md_row)[0]
    })

    img = bytearray(d)
    for idx, rva in enumerate(rvas):
        nxt = rvas[idx + 1] if idx + 1 < len(rvas) else meta_root
        raw = d[rva:nxt]
        if not raw:
            continue
        h = raw[0]
        if (h & 3) == 2:
            cs = h >> 2
            code = decrypt_chunked(raw[1:1 + cs], sections[7], key, 0x10)
            img[rva + 1:rva + 1 + cs] = code
        elif (h & 3) == 3:
            cs = struct.unpack_from('<I', raw, 4)[0]
            code = decrypt_chunked(raw[12:12 + cs], sections[7], key, 0x10)
            img[rva + 12:rva + 12 + cs] = code

    # 覆盖流
    for name in ('#~', '#Strings', '#Blob'):
        base, size = streams[name]
        data = til if name == '#~' else (
            strs if name == '#Strings' else blob
        )
        img[base:base + size] = data[:size]
    if us is not None:
        base, size = streams['#US']
        img[base:base + size] = us[:size]
    if '#GUID' in streams:
        base, size = streams['#GUID']
        img[base:base + size] = b'\x00' * size

    # 更新 metadata root 中 #Blob 流头 size（blob 解密后长度不变，无需改；
    # 保留以防未来修复改变长度）
    return bytearray(img), til, strs, counts, tpos, td_row, md_row


def build_headers(total_len, meta_root, meta_size):
    hdr = bytearray(0x1000)

    def w16(o, v):
        struct.pack_into('<H', hdr, o, v)

    def w32(o, v):
        struct.pack_into('<I', hdr, o, v)

    hdr[0:2] = b'MZ'
    w32(0x3C, 0x80)
    pe = 0x80
    hdr[pe:pe + 4] = b'PE\0\0'
    coff = pe + 4
    w16(coff + 0, 0x8664)
    w16(coff + 2, 2)
    w16(coff + 16, 0xE0)
    w16(coff + 18, 0x0022)
    o = pe + 4 + 20
    w16(o + 0, 0x10B)
    hdr[o + 2] = 9
    w32(o + 4, 0x200000)
    w32(o + 16, 0x1000)
    w32(o + 20, 0x1000)
    w32(o + 28, 0x18000000)
    w32(o + 32, 0x1000)
    w32(o + 36, 0x200)
    w16(o + 40, 6)
    w16(o + 48, 6)
    w32(o + 56, total_len)
    w32(o + 60, 0x200)
    w16(o + 68, 3)
    w16(o + 70, 0x8160)
    w32(o + 72, 0x100000)
    w32(o + 76, 0x1000)
    w32(o + 80, 0x100000)
    w32(o + 84, 0x1000)
    w32(o + 92, 16)
    dd = o + 96
    w32(dd + 14 * 8 + 0, 0x200)
    w32(dd + 14 * 8 + 4, 0x48)

    sh = o + 0xE0
    hdr[sh:sh + 8] = b'.clihdr\0'
    w32(sh + 8, 0x100)
    w32(sh + 12, 0x200)
    w32(sh + 16, 0x100)
    w32(sh + 20, 0x200)
    w32(sh + 36, 0x40000040)
    sh += 40
    hdr[sh:sh + 8] = b'.text\0\0\0'
    w32(sh + 8, total_len - 0x1000)
    w32(sh + 12, 0x1000)
    w32(sh + 16, total_len - 0x1000)
    w32(sh + 20, 0x1000)
    w32(sh + 36, 0x60000020)

    cli = 0x200
    w32(cli + 0, 0x48)
    w16(cli + 4, 2)
    w16(cli + 6, 5)
    w32(cli + 8, meta_root + 0x1000)
    w32(cli + 12, meta_size)
    w32(cli + 16, 0)
    w32(cli + 20, 0)
    return bytes(hdr)


def rebuild_one(path: Path) -> Path | None:
    d, key, sections, off = parse_container(str(path))
    meta_root = struct.unpack_from('<I', d, off + 20)[0]
    if d[meta_root:meta_root + 4] != b'BSJB':
        print(f"  [!] {path.name}: 无 BSJB 根 @{meta_root:#x}")
        return None
    streams = parse_streams(d, meta_root)
    if '#~' not in streams or '#Strings' not in streams or '#Blob' not in streams:
        print(f"  [!] {path.name}: 缺少关键流")
        return None

    img, til, strs, counts, tpos, td_row, md_row = build_image(
        d, key, sections, streams, meta_root
    )
    name = module_name(til, counts, tpos, strs, 4 if til[6] & 1 else 2)
    if not name:
        name = path.stem + ".dll"

    # MethodDef.Rva += 0x1000
    md_off = tpos[6]
    til_base = streams['#~'][0]
    for i in range(counts[6]):
        off2 = til_base + md_off + i * md_row
        rva = struct.unpack_from('<I', img, off2)[0]
        if rva:
            struct.pack_into('<I', img, off2, rva + 0x1000)

    # #Blob 结束 = 元数据结束
    blob_end = streams['#Blob'][0] + streams['#Blob'][1]
    meta_size = ((blob_end - meta_root + 3) & ~3)
    total = 0x1000 + len(img)
    out = bytearray(build_headers(total, meta_root, meta_size))
    out += img
    return bytes(out), name


def main() -> int:
    src = Path(sys.argv[1]) if len(sys.argv) > 1 else Path('TextAsset')
    dst = Path(sys.argv[2]) if len(sys.argv) > 2 else Path('DLL')
    dst.mkdir(parents=True, exist_ok=True)
    ok = fail = 0
    for path in sorted(src.glob('*.bytes')):
        if path.read_bytes()[:4] != b'CDPH':
            continue
        try:
            res = rebuild_one(path)
        except Exception as exc:  # noqa: BLE001
            print(f"[!] {path.name}: {exc}")
            fail += 1
            continue
        if res is None:
            fail += 1
            continue
        data, name = res
        (dst / name).write_bytes(data)
        print(f"[*] {path.name} -> {name} ({len(data)} bytes)")
        ok += 1
    print(f"完成: {ok} 成功, {fail} 失败 -> {dst}")
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
