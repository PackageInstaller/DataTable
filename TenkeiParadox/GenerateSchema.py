import re, os

_HERE = os.path.dirname(os.path.abspath(__file__))

RE_TYPE = re.compile(r'^\s*(?:public|internal|private|protected)?\s*(?:static\s+|sealed\s+|abstract\s+|readonly\s+|partial\s+)*(class|struct)\s+([A-Za-z0-9_]+)(?:<[^>]*>)?\s*(?::\s*(.*?))?\s*//\s*TypeDefIndex')
RE_ENUM = re.compile(r'^\s*(?:public|internal)?\s*enum\s+([A-Za-z0-9_]+)\s*(?::\s*[A-Za-z0-9_]+)?\s*//\s*TypeDefIndex')
RE_IFACE = re.compile(r'^\s*public\s+interface\s+([A-Za-z0-9_]+)')
RE_MPO = re.compile(r'\[MessagePackObject\((true|false)\)\]')
RE_KEY = re.compile(r'\[Key\((\d+)\)\]')
RE_STRKEY = re.compile(r'\[Key\("([^"]+)"\)\]')
RE_UNION = re.compile(r'\[Union\((\d+),\s*typeof\(([^)]+)\)\)\]')
RE_IGNORE = re.compile(r'\[IgnoreMember\]')
RE_PROP = re.compile(r'^\s*public\s+(.+?)\s+([A-Za-z0-9_]+)\s*\{')
RE_ENUMVAL = re.compile(r'^\s*(?:public\s+const\s+\S+\s+)?([A-Za-z0-9_]+)\s*=\s*(-?(?:0x[0-9A-Fa-f]+|\d+))\s*,?\s*$')


def last_ident(name):
    return name.split('.')[-1]


def parse(cs_path):
    lines = open(cs_path, encoding='utf-8', errors='replace').read().splitlines()
    n = len(lines)
    classes, enums, unions = {}, {}, {}

    i = 0
    while i < n:
        line = lines[i]

        me = RE_ENUM.search(line)
        if me:
            ename = me.group(1)
            members = {}
            j = i + 1
            while j < n and '{' not in lines[j]:
                j += 1
            j += 1
            while j < n:
                if RE_TYPE.search(lines[j]) or RE_ENUM.search(lines[j]) or RE_IFACE.search(lines[j]):
                    break
                if lines[j].strip() == '}':
                    break
                mv = RE_ENUMVAL.search(lines[j])
                if mv and mv.group(1) != 'value__':
                    members[int(mv.group(2), 0)] = mv.group(1)
                j += 1
            enums[ename] = members
            i += 1
            continue

        mi = RE_IFACE.search(line)
        if mi:
            iface = mi.group(1)
            umap = {}
            k = i - 1
            while k >= 0:
                s = lines[k].strip()
                mu = RE_UNION.search(s)
                if mu:
                    umap[int(mu.group(1))] = last_ident(mu.group(2))
                    k -= 1
                    continue
                if s == '' or s.startswith('['):
                    k -= 1
                    continue
                break
            if umap:
                unions[iface] = umap
            i += 1
            continue

        mt = RE_TYPE.search(line)
        if mt:
            cname = mt.group(2)
            mpo = None
            for b in range(1, 5):
                if i - b < 0:
                    break
                mm = RE_MPO.search(lines[i - b])
                if mm:
                    mpo = 'map' if mm.group(1) == 'true' else 'array'
                    break
                if lines[i - b].strip() and not lines[i - b].strip().startswith('['):
                    break
            fields, strfields = {}, {}
            j = i + 1
            while j < n and '{' not in lines[j]:
                j += 1
            depth = lines[j].count('{') - lines[j].count('}')
            j += 1
            pending_key = pending_strkey = None
            pending_ignore = False
            while j < n and depth > 0:
                s = lines[j]
                depth += s.count('{') - s.count('}')
                st = s.strip()
                if RE_IGNORE.search(st):
                    pending_ignore = True
                mk = RE_KEY.search(st)
                if mk:
                    pending_key = int(mk.group(1)); pending_ignore = False
                msk = RE_STRKEY.search(st)
                if msk:
                    pending_strkey = msk.group(1); pending_ignore = False
                mp = RE_PROP.search(s)
                if mp and (pending_key is not None or pending_strkey is not None) and not pending_ignore:
                    ptype = mp.group(1).strip()
                    pname = mp.group(2).strip()
                    if pending_key is not None:
                        fields[pending_key] = (pname, ptype)
                    if pending_strkey is not None:
                        strfields[pending_strkey] = (pname, ptype)
                    pending_key = pending_strkey = None; pending_ignore = False
                elif mp and st.startswith('public'):
                    pending_ignore = False
                j += 1
            if mpo or fields or strfields:
                entry = {"mpo": mpo, "fields": dict(sorted(fields.items()))}
                if strfields:
                    entry["strfields"] = strfields
                classes[cname] = entry
            i = j
            continue

        i += 1

    return unions, enums, classes


def emit(out_path, unions, enums, classes):
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write('"""本文件由 GenerateSchema.py 从 cs/il2cpp.cs 自动生成"""\n\n')
        f.write("UNIONS = {\n")
        for k, v in unions.items():
            f.write("    %r: %r,\n" % (k, dict(sorted(v.items()))))
        f.write("}\n\n")
        f.write("ENUMS = {\n")
        for k in sorted(enums):
            f.write("    %r: %r,\n" % (k, enums[k]))
        f.write("}\n\n")
        f.write("CLASSES = {\n")
        for k in sorted(classes):
            f.write("    %r: %r,\n" % (k, classes[k]))
        f.write("}\n")



if __name__ == "__main__":
    unions, enums, classes = parse("cs/il2cpp.cs")
    emit("TenkeiParadoxSchema.py", unions, enums, classes)