import glob
import os
import struct
import sys


def parse_pkg(pt):
    root = struct.unpack_from("<I", pt, 0)[0]
    if root < 4 or root >= len(pt):
        return None
    so = struct.unpack_from("<i", pt, root)[0]
    vt = root - so
    if vt < 4 or vt + 4 > len(pt):
        return None
    vts = struct.unpack_from("<H", pt, vt)[0]

    def field(tbl, vtab, idx):
        fo = struct.unpack_from("<H", pt, vtab + 4 + 2 * idx)[0]
        return (tbl + fo) if fo else None

    files_p = field(root, vt, 1)  # LuaPackage.files
    if not files_p:
        return None
    rel = struct.unpack_from("<I", pt, files_p)[0]
    vec = files_p + rel
    n = struct.unpack_from("<I", pt, vec)[0]
    out = []
    for i in range(min(n, 10000)):
        elem_p = vec + 4 + 4 * i
        if elem_p + 4 > len(pt):
            break
        rel2 = struct.unpack_from("<I", pt, elem_p)[0]
        t = elem_p + rel2
        if t < 4 or t + 4 > len(pt):
            continue
        so2 = struct.unpack_from("<i", pt, t)[0]
        vt2 = t - so2
        if vt2 < 4 or vt2 + 6 > len(pt):
            continue
        bc_p = field(t, vt2, 0)  # LuaFile.byte_code
        if not bc_p:
            continue
        rel3 = struct.unpack_from("<I", pt, bc_p)[0]
        bvec = bc_p + rel3
        blen = struct.unpack_from("<I", pt, bvec)[0]
        out.append((i, pt[bvec + 4:bvec + 4 + blen]))
    return out


def main():
    outdir = sys.argv[1] if len(sys.argv) > 1 else "lua_scripts"
    os.makedirs(outdir, exist_ok=True)
    files = sorted(glob.glob("assets/blocks/*/*.bundle"))
    total_files = 0
    n_pkg = 0
    fails = []
    for p in files:
        data = open(p, "rb").read()
        pt = bytes(b ^ 0x65 for b in data)
        lua_files = parse_pkg(pt)
        if lua_files is None:
            fails.append(p)
            continue
        n_pkg += 1
        prefix = f"{os.path.basename(os.path.dirname(p))}_{os.path.basename(p)[:8]}"
        for i, bc in lua_files:
            ext = ".lua" if bc[:1] in (b"\n", b"-", b"--") else ".luac"
            open(os.path.join(outdir, f"{prefix}_{i}{ext}"), "wb").write(bc)
            total_files += 1
    print(f"{n_pkg}/{len(files)} 个包解析成功, 提取 {total_files} 个文件 -> {outdir}/")
    if fails:
        print(f"解析失败 {len(fails)} 个: {fails[:5]}...")


if __name__ == "__main__":
    main()
