"""将重建 DLL 中指向 System 但实际位于 mscorlib 的泛型集合 TypeRef 改指 mscorlib。

背景：v5.2.1 热更 DLL（P08.FlipCardGame）把 System.Collections.Generic.Queue`1 /
Stack`1 的 TypeRef 指向 AssemblyRef System（本机 dll/System.dll 副本里没有这两个类型，
而 dll/mscorlib.dll 有完整的 Queue`1/Enumerator、Stack`1/Enumerator）。
ilspycmd 解析引用时找不到 → “Unknown result type” 警告。
把这两个 TypeRef 的 ResolutionScope 从 System 改为 mscorlib 后，全量反编译 0 警告。

用法：python3 patch_system_refs.py [输入.dll] [输出.dll]
默认：P08.FlipCardGame.rebuilt.dll -> P08.FlipCardGame.decompile.dll
"""
import shutil
import struct
import sys

# TypeRef 行布局（该 DLL 为自定义）：ResolutionScope(2) @0, Name(4) @2, Namespace(4) @6
# AssemblyRef 1 = mscorlib, AssemblyRef 6 = System（AssemblyRef coded index = row<<2|2）
MS = (1 << 2) | 2
SY = (6 << 2) | 2

# 需要重定向的 TypeRef 行（由 dnfile 锚定，见 REVERSE_ENGINEERING.md）
PATCH_ROWS = (85, 87)  # Queue`1, Stack`1
TYPEDEF_ROW = 10       # TypeRef 行宽


def scope_offset(til, type_ref_row):
    """返回该 TypeRef 行 ResolutionScope 在 #~ 流内的偏移。"""
    # TypeRef 表起点 = 0x80 (Module 12B) + 12
    base = 0x80 + 12
    return base + (type_ref_row - 1) * TYPEDEF_ROW


def main():
    src = sys.argv[1] if len(sys.argv) > 1 else 'P08.FlipCardGame.rebuilt.dll'
    dst = sys.argv[2] if len(sys.argv) > 2 else 'P08.FlipCardGame.decompile.dll'
    shutil.copyfile(src, dst)
    d = bytearray(open(dst, 'rb').read())
    # 定位 #~ 流起点（BSJB 根 + 流头 #~ 偏移）
    root = d.find(b'BSJB')
    verlen = struct.unpack_from('<I', d, root + 12)[0]
    p = root + 16 + verlen
    nstreams = struct.unpack_from('<H', d, p + 2)[0]
    p += 4
    til_off = None
    for _ in range(nstreams):
        so = struct.unpack_from('<I', d, p)[0]
        p += 8
        ne = d.index(b'\0', p)
        name = d[p:ne].decode('latin1')
        p = (ne + 1 + 3) & ~3
        if name == '#~':
            til_off = root + so
    assert til_off is not None
    n = 0
    for row in PATCH_ROWS:
        off = til_off + scope_offset(None, row)
        cur = struct.unpack_from('<H', d, off)[0]
        assert cur == SY, f'TR{row} scope=0x{cur:X} 期望 0x{SY:X}'
        struct.pack_into('<H', d, off, MS)
        n += 1
    open(dst, 'wb').write(d)
    print(f'已修补 {dst}: {n} 个 TypeRef 重定向到 mscorlib')


if __name__ == '__main__':
    main()
