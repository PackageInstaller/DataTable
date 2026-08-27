from __future__ import annotations

import importlib.util
import os
import sys
from ctypes import (
    POINTER,
    Structure,
    c_char_p,
    c_int,
    c_uint32,
    cdll,
    create_string_buffer,
    pointer,
)

SECRET_KEY = b"D(G+KbPeShVmYq3t"


class _TwofishKey(Structure):
    _fields_ = [("s", (c_uint32 * 4) * 256), ("K", c_uint32 * 40)]


def _twofish_so_candidates():
    import glob
    import sysconfig

    seen: set[str] = set()
    out: list[str] = []

    def add(path: str) -> None:
        if path and os.path.isfile(path) and path not in seen:
            seen.add(path)
            out.append(path)

    ver = f"python{sys.version_info.major}.{sys.version_info.minor}"
    for root in (
        f"/usr/lib/{ver}/site-packages",
        sysconfig.get_paths().get("platlib", ""),
        sysconfig.get_paths().get("purelib", ""),
    ):
        if root:
            for p in sorted(glob.glob(os.path.join(root, "_twofish*.so"))):
                add(p)
    spec = importlib.util.find_spec("_twofish")
    if spec and spec.origin:
        add(spec.origin)
    return out


def _load_twofish_lib():
    last_err: Exception | None = None
    for origin in _twofish_so_candidates():
        try:
            lib = cdll.LoadLibrary(origin)
            lib.exp_Twofish_initialise()
            lib.exp_Twofish_prepare_key.argtypes = [
                c_char_p,
                c_int,
                POINTER(_TwofishKey),
            ]
            lib.exp_Twofish_decrypt.argtypes = [
                POINTER(_TwofishKey),
                c_char_p,
                c_char_p,
            ]
            return lib, origin
        except OSError as e:
            last_err = e
            continue
    raise ImportError(
        "未找到 _twofish 扩展，请安装系统包 python-twofish（paru -S python-twofish）"
    ) from last_err


_lib, _lib_path = _load_twofish_lib()
_key = _TwofishKey()
_lib.exp_Twofish_prepare_key(SECRET_KEY, len(SECRET_KEY), pointer(_key))


def decrypt_bytes(data: bytes) -> bytes:
    if len(data) % 16 != 0:
        raise ValueError(f"长度 {len(data)} 不是 16 的倍数, 可能不是 secret 加密文件")
    out = bytearray()
    for i in range(0, len(data), 16):
        buf = create_string_buffer(16)
        _lib.exp_Twofish_decrypt(pointer(_key), data[i : i + 16], buf)
        out += buf.raw
    n = out[-1]
    if 1 <= n <= 16 and out[-n:] == bytes([n]) * n:
        out = out[:-n]
    else:
        print("可能密钥不对或不是 secret 文件", file=sys.stderr)
    return bytes(out)


def is_plaintext(data: bytes) -> bool:
    head = data[:64]
    return head.lstrip()[:1] in (b"{", b"[")


def main() -> None:
    if len(sys.argv) < 2:
        print("usage: ptn_secret_decrypt.py <file-or-dir> [out_dir]")
        sys.exit(1)
    target = sys.argv[1]
    out_dir = sys.argv[2] if len(sys.argv) > 2 else "decrypted_cfg"
    os.makedirs(out_dir, exist_ok=True)
    if os.path.isdir(target):
        files = [
            os.path.join(root, fn)
            for root, _, fs in os.walk(target)
            for fn in fs
        ]
    else:
        files = [target]
    n = 0
    for fp in files:
        try:
            data = open(fp, "rb").read()
        except Exception as e:
            print(f"[FAIL] {fp}: {e}")
            continue
        if is_plaintext(data):
            print(f"[skip] {fp} (已是明文)")
            continue
        try:
            pt = decrypt_bytes(data)
        except Exception as e:
            print(f"[FAIL] {fp}: {e}")
            continue
        out = os.path.join(out_dir, os.path.basename(fp))
        open(out, "wb").write(pt)
        n += 1
        print(f"[OK] {fp} -> {out} ({len(pt)} 字节)")
    print(f"共解密 {n} 个文件")


if __name__ == "__main__":
    main()
