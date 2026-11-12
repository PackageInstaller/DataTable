from __future__ import annotations

import shutil
import struct
import subprocess
from pathlib import Path
from typing import Any, Optional

try:
    from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM
    from unicorn.arm64_const import (
        UC_ARM64_REG_X0,
        UC_ARM64_REG_X1,
        UC_ARM64_REG_X2,
        UC_ARM64_REG_X3,
        UC_ARM64_REG_X4,
        UC_ARM64_REG_SP,
        UC_ARM64_REG_LR,
    )
    HAS_UNICORN = True
except ImportError:
    HAS_UNICORN = False

DEFAULT_SO_PATH = Path(__file__).resolve().parent / "libil2cpp.so"
VM_FUNC_ADDR = 0x3996C88


class DHEVM:
    def __init__(self, so_path: str | Path | None = None):
        p = Path(so_path) if so_path else DEFAULT_SO_PATH
        if not p.exists():
            raise FileNotFoundError(f"找不到 libil2cpp.so 镜像文件: {p}")

        blob = p.read_bytes()
        self.mu = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
        so_size = (len(blob) + 0xFFF) & ~0xFFF
        self.mu.mem_map(0, so_size)
        self.mu.mem_write(0, blob)

        self.stack = 0x1000000000
        self.prog_a = 0x1000100000
        self.key_a = 0x1000200000
        self.buf_a = 0x1000300000
        self.sent = 0x1000400000

        self.mu.mem_map(self.stack, 0x100000)
        self.mu.mem_map(self.prog_a, 0x100000)
        self.mu.mem_map(self.key_a, 0x100000)
        self.mu.mem_map(self.buf_a, 0x100000)
        self.mu.mem_map(self.sent, 0x1000)

        self._current_prog = None
        self._current_key = None

    def set_program(self, prog: bytes) -> None:
        if self._current_prog != prog:
            self.mu.mem_write(self.prog_a, prog)
            self._current_prog = prog

    def set_key(self, key: bytes) -> None:
        if self._current_key != key:
            self.mu.mem_write(self.key_a, key)
            self._current_key = key

    def run(self, buf: bytearray) -> bytearray:
        n = len(buf)
        if n == 0:
            return buf
        mu = self.mu
        mu.mem_write(self.buf_a, bytes(buf))
        mu.reg_write(UC_ARM64_REG_X0, self.prog_a)
        mu.reg_write(UC_ARM64_REG_X1, len(self._current_prog))
        mu.reg_write(UC_ARM64_REG_X2, self.key_a)
        mu.reg_write(UC_ARM64_REG_X3, self.buf_a)
        mu.reg_write(UC_ARM64_REG_X4, n)
        mu.reg_write(UC_ARM64_REG_SP, self.stack + 0x80000)
        mu.reg_write(UC_ARM64_REG_LR, self.sent)
        mu.emu_start(VM_FUNC_ADDR, self.sent, count=100_000_000)
        buf[:] = mu.mem_read(self.buf_a, n)
        return buf


_VM_CACHE: Optional[DHEVM] = None


def get_dhe_vm(so_path: str | Path | None = None) -> DHEVM:
    global _VM_CACHE
    if _VM_CACHE is None:
        _VM_CACHE = DHEVM(so_path)
    return _VM_CACHE


def decrypt_chunked(data: bytes, prog: bytes, key: bytes, chunk: int = 0x10, vm: DHEVM | None = None) -> bytes:
    if vm is None:
        vm = get_dhe_vm()
    vm.set_program(prog)
    vm.set_key(key)
    buf = bytearray(data)
    for i in range(0, len(buf), chunk):
        c = buf[i : i + chunk]
        vm.run(c)
        buf[i : i + len(c)] = c
    return bytes(buf)


def decrypt_us_entries(us_bytes: bytes, prog: bytes, key: bytes, vm: DHEVM | None = None) -> bytes:
    buf = bytearray(us_bytes)
    if len(buf) <= 1:
        return bytes(buf)

    if vm is None:
        vm = get_dhe_vm()
    vm.set_program(prog)
    vm.set_key(key)

    i = 1

    def rd_compressed(pos: int) -> tuple[int, int]:
        b0 = buf[pos]
        if b0 < 0x80:
            return b0, pos + 1
        if b0 < 0xC0:
            return ((b0 & 0x3F) << 8) | buf[pos + 1], pos + 2
        return (
            ((b0 & 0x1F) << 24) | (buf[pos + 1] << 16) | (buf[pos + 2] << 8) | buf[pos + 3],
            pos + 4,
        )

    while i < len(buf):
        ln, ni = rd_compressed(i)
        if ln == 0 or ni + ln > len(buf):
            break
        c = buf[ni : ni + ln]
        for k in range(0, len(c), 0x10):
            subc = c[k : k + 0x10]
            vm.run(subc)
            c[k : k + len(subc)] = subc
        buf[ni : ni + ln] = c
        i = ni + ln
    return bytes(buf)


def parse_container(d: bytes) -> tuple[bytes, list[bytes], int]:
    key = d[16:272]
    off = 272
    sections: list[bytes] = []
    for _ in range(8):
        ln = struct.unpack_from("<I", d, off)[0]
        sections.append(d[off + 4 : off + 4 + ln])
        off = (off + 4 + ln + 3) & ~3
    return key, sections, off


def parse_streams(d: bytes, meta_root: int) -> dict[str, tuple[int, int]]:
    verlen = struct.unpack_from("<I", d, meta_root + 12)[0]
    p = meta_root + 16 + verlen
    nstreams = struct.unpack_from("<H", d, p + 2)[0]
    p += 4
    streams: dict[str, tuple[int, int]] = {}
    for _ in range(nstreams):
        so, ss = struct.unpack_from("<II", d, p)
        p += 8
        ne = d.index(b"\0", p)
        name = d[p:ne].decode("latin1")
        p = (ne + 1 + 3) & ~3
        streams[name] = (meta_root + so, ss)
    return streams


def parse_til_header(til: bytes) -> tuple[int, list[int], dict[int, int], int]:
    hs = til[6]
    valid = struct.unpack_from("<Q", til, 8)[0]
    bits = [i for i in range(64) if (valid >> i) & 1]
    cp = 0x18
    counts: dict[int, int] = {}
    for b in bits:
        counts[b] = struct.unpack_from("<I", til, cp)[0]
        cp += 4
    return hs, bits, counts, cp


def build_headers(total_len: int, meta_root: int, meta_size: int) -> bytes:
    hdr = bytearray(0x1000)

    def w16(o: int, v: int) -> None:
        struct.pack_into("<H", hdr, o, v)

    def w32(o: int, v: int) -> None:
        struct.pack_into("<I", hdr, o, v)

    hdr[0:2] = b"MZ"
    w32(0x3C, 0x80)
    pe = 0x80
    hdr[pe : pe + 4] = b"PE\0\0"
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

    # 节表
    sh = o + 0xE0
    hdr[sh : sh + 8] = b".clihdr\0"
    w32(sh + 8, 0x100)
    w32(sh + 12, 0x200)
    w32(sh + 16, 0x100)
    w32(sh + 20, 0x200)
    w32(sh + 36, 0x40000040)
    sh += 40

    hdr[sh : sh + 8] = b".text\0\0\0"
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


def rebuild_dhe_dll(dll_bytes: bytes, so_path: str | Path | None = None) -> bytes:
    if not dll_bytes.startswith(b"CDPH"):
        return dll_bytes

    vm = get_dhe_vm(so_path)
    d = dll_bytes
    key, sections, off = parse_container(d)
    meta_root = struct.unpack_from("<I", d, off + 20)[0]
    if d[meta_root : meta_root + 4] != b"BSJB":
        raise ValueError(f"未找到 BSJB @{hex(meta_root)}")

    streams = parse_streams(d, meta_root)
    for req in ("#~", "#Strings", "#Blob"):
        if req not in streams:
            raise ValueError(f"CDPH 容器缺失关键流: {req}")

    til_raw = decrypt_chunked(d[streams["#~"][0] : streams["#~"][0] + streams["#~"][1]], sections[5], key, 0x100, vm)
    strs = decrypt_chunked(d[streams["#Strings"][0] : streams["#Strings"][0] + streams["#Strings"][1]], sections[1], key, 0x100, vm)
    blob = decrypt_chunked(d[streams["#Blob"][0] : streams["#Blob"][0] + streams["#Blob"][1]], sections[2], key, 0x100, vm)

    us = None
    if "#US" in streams:
        us_dec = decrypt_chunked(d[streams["#US"][0] : streams["#US"][0] + streams["#US"][1]], sections[3], key, 0x100, vm)
        us = decrypt_us_entries(us_dec, sections[4], key, vm)

    hs, bits, counts, row_start = parse_til_header(til_raw)
    pos_mod = row_start
    pos_tref = pos_mod + 12
    td_row = 22
    pos_tdef = pos_tref + counts.get(1, 0) * 10
    pos_field = pos_tdef + counts.get(2, 0) * td_row
    method_row = 18
    pos_method = pos_field + counts.get(4, 0) * 10

    til = bytearray(til_raw)
    vm.set_program(sections[6])
    vm.set_key(key)
    for i in range(counts.get(2, 0)):
        row = bytearray(til[pos_tdef + i * td_row : pos_tdef + (i + 1) * td_row])
        vm.run(row)
        til[pos_tdef + i * td_row : pos_tdef + (i + 1) * td_row] = row

    n_methods = counts.get(6, 0)
    sorted_rvas = sorted({
        struct.unpack_from("<I", til, pos_method + i * method_row)[0]
        for i in range(n_methods)
        if struct.unpack_from("<I", til, pos_method + i * method_row)[0]
    })

    img = bytearray(d)
    for idx, rva in enumerate(sorted_rvas):
        if rva >= meta_root:
            continue
        nxt = sorted_rvas[idx + 1] if idx + 1 < len(sorted_rvas) else meta_root
        raw = d[rva:nxt]
        if not raw:
            continue
        h = raw[0]
        if (h & 3) == 2: 
            cs = h >> 2
            code = decrypt_chunked(raw[1 : 1 + cs], sections[7], key, 0x10, vm)
            img[rva + 1 : rva + 1 + cs] = code
        elif (h & 3) == 3 and len(raw) >= 12:
            cs = struct.unpack_from("<I", raw, 4)[0]
            cs = min(cs, max(0, len(raw) - 12))
            if cs > 0:
                code = decrypt_chunked(raw[12 : 12 + cs], sections[7], key, 0x10, vm)
                img[rva + 12 : rva + 12 + cs] = code

    img[streams["#~"][0] : streams["#~"][0] + len(til)] = til
    img[streams["#Strings"][0] : streams["#Strings"][0] + len(strs)] = strs
    img[streams["#Blob"][0] : streams["#Blob"][0] + len(blob)] = blob
    if us is not None:
        img[streams["#US"][0] : streams["#US"][0] + len(us)] = us
    if "#GUID" in streams:
        base, size = streams["#GUID"]
        img[base : base + size] = b"\x00" * size

    til_base = streams["#~"][0]
    for i in range(n_methods):
        off2 = til_base + pos_method + i * method_row
        rva = struct.unpack_from("<I", img, off2)[0]
        if rva:
            struct.pack_into("<I", img, off2, rva + 0x1000)

    blob_end = streams["#Blob"][0] + streams["#Blob"][1]
    meta_size = (blob_end - meta_root + 3) & ~3
    total = 0x1000 + len(img)
    hdr = build_headers(total, meta_root, meta_size)

    out = bytearray(hdr)
    out += img
    return bytes(out)


def decompile_dll_to_csharp(
    dll_path: Path,
    output_dir: Path,
    ref_dir: Path | None = None,
    force: bool = False,
    console: Optional[Any] = None,
) -> bool:


    with open(dll_path, "rb") as f:
        magic = f.read(2)

    if output_dir.exists() and not force:
        existing_cs = list(output_dir.glob("*.cs"))
        if existing_cs:
            return True

    ilspycmd = shutil.which("ilspycmd")
    if not ilspycmd:
        return False

    output_dir.mkdir(parents=True, exist_ok=True)
    cmd = [ilspycmd, "-p"]
    if ref_dir and ref_dir.exists():
        cmd.extend(["-r", str(ref_dir.resolve())])
    cmd.extend(["-o", str(output_dir.resolve()), str(dll_path.resolve())])

    if console:
        console.print(f"[bold cyan]正在调用 ilspycmd 反编译 {dll_path.name} 到 {output_dir.name}/ ...[/bold cyan]")

    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        err_msg = proc.stderr.strip() or f"exit code {proc.returncode}"
        if console:
            console.print(f"[red]ilspycmd 反编译失败: {err_msg}[/red]")
        return False

    cs_count = len(list(output_dir.glob("**/*.cs")))
    if console:
        console.print(f"[bold green]C# 源码反编译成功:[/bold green] {output_dir} (共 {cs_count} 个 .cs 源码文件)")
    return True


def main() -> int:
    import argparse
    parser = argparse.ArgumentParser(description="HybridCLR DHE CDPH DLL 解密还原工具")
    parser.add_argument("input", help="输入加壳 DLL 文件 (CDPH 容器)")
    parser.add_argument("output", nargs="?", help="输出还原 DLL 文件")
    parser.add_argument("--so", help="libil2cpp.so 文件路径")
    args = parser.parse_args()

    inp = Path(args.input)
    if not inp.exists():
        print(f"错误: 找不到输入文件 {inp}")
        return 1

    outp = Path(args.output) if args.output else inp.with_suffix(".rebuilt.dll")
    data = inp.read_bytes()
    print(f"[*] 读取 {inp.name} ({len(data)} 字节)...")

    rebuilt = rebuild_dhe_dll(data, so_path=args.so)
    outp.write_bytes(rebuilt)
    print(f"[+] 重建完成: {outp} ({len(rebuilt)} 字节)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
