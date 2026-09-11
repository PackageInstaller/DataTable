#!/usr/bin/env python3
"""深空之眼 v5.2.1 热更 DLL（CDPH 容器）IL 方法体解密工具

解密管线（对应 GameAssembly.dll 逆向，详见 CDPH_分析.md / CDPH_元数据表反推记录.md）:

  CDPH 容器
  ├─ key[256] @0x10
  ├─ 8 个 section 程序（0x110 起，长度前缀）
  ├─ 水印 "Hello, HybridCLR"（用 ~i 程序 + key 校验）
  ├─ BSJB 元数据根（明文，含 5 个流头）
  ├─ 四流整段解密: #Strings=sec1, #Blob=sec2, #US=sec3, #~=sec5 (chunk 0x100)
  └─ IL 代码区 0x14f48..0x10dc14: **section 7, chunk 0x10**（关键）
       运行时: InterpreterImage::GetMethodBody -> sub_1804D94E0 (ReadMethodBody)
       -> raw image vtable+0x28 (sub_1804CDD10, #Blob 懒解密器)
       -> sub_1804FF5D0(prog=section7, chunk=0x10) 逐块解密 IL 码

方法体布局: tiny 头(1B: flag2|size<<2) 或 fat 头(12B)，IL 码紧接其后；
           方法体按 RVA 连续排列；共享 RVA 的 MethodDef 行不重复计体。
输出:
  cdph_methods_decrypted.json - 全部 9000 个方法体（RVA/名称/头类型/IL hex）
  cdph_il_dump.txt            - 可读转储
"""
import sys
import struct
import json

sys.path.insert(0, '/home/rikka/Games/深空之眼')
from cdph_vm import parse_container, run_vm

ASSET = 'TextAsset/1cabbf636215d06aa12521cda5daedfb.bytes'
TIL_PATH = 'cdph_decrypted_TIL.bin'
STR_PATH = 'cdph_decrypted_Strings.bin'

METHODDEF_TABLE_OFF = 0x24474  # MethodDef 表行数据在 #~ 流中的偏移
METHODDEF_ROWS = 10641
METHODDEF_ROW = 18
CODE_END = 0x10dc14  # 代码区结束 = BSJB 元数据根


def load():
    d, key, sections, off = parse_container(ASSET)
    til = open(TIL_PATH, 'rb').read()
    strings = open(STR_PATH, 'rb').read()
    return d, key, sections, til, strings


def sstr(strings, v):
    if v >= len(strings):
        return ''
    e = strings.find(b'\0', v)
    return strings[v:e].decode('utf-8', 'replace') if e >= 0 else ''


def decrypt_chunked(data, prog, key, chunk=0x10):
    """sub_1804FF5D0 语义: 每 chunk 独立喂 VM（VM 内 n=len(块)，尾块按实际长度）。"""
    buf = bytearray(data)
    for i in range(0, len(buf), chunk):
        c = buf[i:i + chunk]
        run_vm(prog, key, c)
        buf[i:i + len(c)] = c
    return bytes(buf)


def parse_methoddefs(til, strings):
    rows = []
    for i in range(METHODDEF_ROWS):
        p = METHODDEF_TABLE_OFF + i * METHODDEF_ROW
        rva, implflags, flags, name, sig, paramlist = struct.unpack('<IHHIIH', til[p:p + 18])
        rows.append({
            'idx': i + 1,
            'rva': rva,
            'implflags': implflags,
            'flags': flags,
            'name': sstr(strings, name),
            'sig': sig,
            'paramlist': paramlist,
        })
    return rows


def decrypt_bodies(d, key, sections, rows):
    with_body = sorted([r for r in rows if r['rva'] != 0], key=lambda r: r['rva'])
    distinct = []
    seen = set()
    for r in with_body:
        if r['rva'] not in seen:
            seen.add(r['rva'])
            distinct.append(r)

    out = []
    for i, m in enumerate(distinct):
        nxt = distinct[i + 1]['rva'] if i + 1 < len(distinct) else CODE_END
        size = nxt - m['rva']
        raw = d[m['rva']:m['rva'] + size]
        if not raw:
            continue
        h = raw[0]
        entry = dict(m)
        entry['body_size'] = size
        if (h & 3) == 2:  # tiny
            entry['header'] = 'tiny'
            entry['code_size'] = h >> 2
            entry['code'] = decrypt_chunked(raw[1:1 + entry['code_size']], sections[7], key).hex()
        elif (h & 3) == 3:  # fat
            entry['header'] = 'fat'
            entry['code_size'] = struct.unpack('<I', raw[4:8])[0]
            entry['code'] = decrypt_chunked(raw[12:12 + entry['code_size']], sections[7], key).hex()
        else:
            entry['header'] = '?'
            entry['code'] = ''
        out.append(entry)
    return out


def main():
    d, key, sections, til, strings = load()
    rows = parse_methoddefs(til, strings)
    bodies = decrypt_bodies(d, key, sections, rows)
    print(f'MethodDef 行: {len(rows)}，RVA>0: {sum(1 for r in rows if r["rva"])}，去重后方法体: {len(bodies)}')
    with open('cdph_methods_decrypted.json', 'w', encoding='utf-8') as f:
        json.dump(bodies, f, ensure_ascii=False, indent=1)
    with open('cdph_il_dump.txt', 'w', encoding='utf-8') as f:
        for b in bodies:
            f.write(f'0x{b["rva"]:06x} [{b["idx"]:5d}] {b["name"]}\n')
            f.write(f'  header={b["header"]} code_size={b["code_size"]} body_size={b["body_size"]}\n')
            f.write(f'  code={b["code"]}\n')
    print('写出 cdph_methods_decrypted.json / cdph_il_dump.txt')
    for b in bodies[:6]:
        print(f'{b["idx"]:5d} {b["name"]:24s} rva={b["rva"]:#x} {b["header"]} cs={b["code_size"]} code={b["code"][:56]}...')


if __name__ == '__main__':
    main()
