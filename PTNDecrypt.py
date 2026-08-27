import os
import struct
import sys
from concurrent.futures import ProcessPoolExecutor

ASSET_KEY = bytes(
    [
        50, 114, 53, 117, 56, 120, 47, 65, 37, 68, 42, 71, 45, 75, 97, 80,
        100, 83, 103, 86, 107, 89, 112, 51, 115, 54, 118, 57, 121, 36, 66, 38,
    ]
)  # b"2r5u8x/A%D*G-KaPdSgVkYp3s6v9y$B&"

ENTRY_HDR_LEN = 50
SIG = b"UnityFS"


def try_entry_header(buf, pos, key):
    if pos + ENTRY_HDR_LEN > len(buf):
        return None
    hdr = bytes(b ^ key for b in buf[pos:pos + ENTRY_HDR_LEN])
    if hdr[:8] != b"UnityFS\x00":
        return None
    if hdr[8:12] != b"\x00\x00\x00\x07":
        return None
    if hdr[12:18] != b"5.x.x\x00":
        return None
    if hdr[18:30] != b"2019.4.40f1\x00":
        return None
    size = struct.unpack(">Q", hdr[30:38])[0]   # = S = 50 + len(payload)
    if hdr[38:46] != b"\xff" * 8:
        return None
    if size < ENTRY_HDR_LEN:
        return None
    return size


def walk_entries(buf):
    entries = []
    pos = 0
    n = len(buf)
    while pos < n:
        if n - pos < ENTRY_HDR_LEN:
            raise ValueError(f"0x{pos:x}: 剩余 {n - pos} 字节不足一个 entry 头")
        found = None
        for j in range(32):
            size = try_entry_header(buf, pos, ASSET_KEY[j])
            if size is not None:
                if size % 32 == j:      # 自洽校验: key 下标必须等于 S%32
                    found = (j, size)
                    break
                found = found or (j, size)  # 弱匹配, 记下但继续找更强的
        if found is None:
            raise ValueError(f"0x{pos:x}: 无法识别 entry 头")
        j, size = found
        if pos + size > n:
            raise ValueError(f"0x{pos:x}: entry 长度 {size} 超出文件尾")
        entries.append((pos, size, j))
        pos += size
    return entries


def decrypt_entries(buf, entries):
    out = bytearray(buf)
    for pos, size, j in entries:
        hdr_key = ASSET_KEY[j]
        pay_key = ASSET_KEY[j] ^ ASSET_KEY[(j + 1) % 32]
        for i in range(pos, pos + ENTRY_HDR_LEN):
            out[i] ^= hdr_key
        for i in range(pos + ENTRY_HDR_LEN, pos + size):
            out[i] ^= pay_key
    return bytes(out)


def process_file(path, out_dir, inplace):
    with open(path, "rb") as f:
        buf = f.read()
    entries = walk_entries(buf)
    results = []
    for idx, (pos, size, j) in enumerate(entries):
        pay_key = ASSET_KEY[j] ^ ASSET_KEY[(j + 1) % 32]
        payload = bytes(b ^ pay_key for b in buf[pos + ENTRY_HDR_LEN:pos + size])
        results.append((idx, pos, size, j, payload))
    if inplace:
        tmp = path + ".tmp"
        with open(tmp, "wb") as f:
            f.write(decrypt_entries(buf, entries))
        os.replace(tmp, path)
    else:
        base = os.path.splitext(os.path.basename(path))[0]
        for idx, pos, size, j, payload in results:
            outp = os.path.join(out_dir, f"{base}.entry{idx}.bundle")
            with open(outp, "wb") as f:
                f.write(payload)
    return path, results


def main():
    args = sys.argv[1:]
    inplace = False
    if args and args[0] == "--inplace":
        inplace = True
        args = args[1:]
    if not args:
        print(__doc__)
        sys.exit(1)
    target = args[0]
    out_dir = args[1] if len(args) > 1 else "decrypted"
    if not inplace:
        os.makedirs(out_dir, exist_ok=True)

    files = []
    if os.path.isdir(target):
        for root, _, fs in os.walk(target):
            for fn in fs:
                if fn.endswith((".bundle", ".bin")):
                    files.append(os.path.join(root, fn))
    else:
        files = [target]

    total_entries = 0
    for fp in files:
        try:
            path, results = process_file(fp, out_dir, inplace)
        except Exception as e:
            print(f"[FAIL] {fp}: {e}")
            continue
        total_entries += len(results)
        for idx, pos, size, j, payload in results:
            head = payload[:16].hex(" ")
            print(f"[OK] {os.path.basename(path)} entry{idx}: "
                  f"off=0x{pos:x} S={size} key_idx={j} "
                  f"(hdr={chr(ASSET_KEY[j])}, pay={ASSET_KEY[j] ^ ASSET_KEY[(j + 1) % 32]:#04x}) "
                  f"payload={len(payload)} head={head}")
    print(f"共 {len(files)} 个文件, {total_entries} 个 entry")


if __name__ == "__main__":
    main()
