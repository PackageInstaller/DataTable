import bisect
import json
import re
from pathlib import Path

CS = Path("cs/il2cpp.cs")

TEXT_ALIAS_FILES = [
    "Text.Reference.json",
    "Text.Tag.json",
    "Text.de.json",
    "Text.en.json",
    "Text.fr.json",
    "Text.id.json",
    "Text.ja.json",
    "Text.ko.json",
    "Text.th.json",
    "Text.vi.json",
    "Text.zh_CN.json",
    "Text.zh_TW.json",
]


def split_top_level(s: str, sep=",") -> list[str]:
    parts = []
    depth = 0
    cur = []
    for ch in s:
        if ch == "<":
            depth += 1
        elif ch == ">":
            depth -= 1
        if ch == sep and depth == 0:
            parts.append("".join(cur).strip())
            cur = []
        else:
            cur.append(ch)
    if cur:
        parts.append("".join(cur).strip())
    return parts


def clean_base(base: str) -> str:
    base = base.split("//")[0].strip()
    return base


def main() -> None:
    text = CS.read_text(encoding="utf-8", errors="replace")

    # Namespace positions for O(log n) lookup.
    ns_re = re.compile(r"^namespace\s+([\w.]+)", re.M)
    ns_matches = list(ns_re.finditer(text))
    ns_positions = [m.start() for m in ns_matches]

    def namespace_at(pos: int) -> str:
        idx = bisect.bisect_right(ns_positions, pos) - 1
        return ns_matches[idx].group(1) if idx >= 0 else ""

    class_search = re.compile(
        r"\n\s*(?:public|internal|private)\s+"
        r"(?:(?:sealed|abstract|static|partial|readonly|unsafe)\s+)*"
        r"(?:class|struct)\s+(\w+)(?:\s*:\s*([^{]+))?"
    )
    key_re = re.compile(
        r"\[MessagePack\.Key\(\s*(-?\d+)\s*\)\s*\]\s*"
        r"(?:\[[^\]]*\]\s*)*"
        r"public\s+([\w.<>\[\],? ]+?)\s+(\w+)\s*\{"
    )

    class_infos: dict[str, dict] = {}
    for m in re.finditer(r"\[MessagePackObject\(false\)\]", text):
        cm = class_search.search(text, m.end(), m.end() + 300)
        if not cm:
            continue
        name = cm.group(1)
        base = clean_base(cm.group(2) or "")
        open_idx = text.find("{", cm.end())
        if open_idx < 0:
            continue
        depth = 1
        i = open_idx + 1
        while i < len(text) and depth:
            if text[i] == "{":
                depth += 1
            elif text[i] == "}":
                depth -= 1
            i += 1
        block = text[open_idx : i - 1]
        fields = [(int(k), typ.strip(), prop) for k, typ, prop in key_re.findall(block)]
        ns = namespace_at(m.start())
        full = f"{ns}.{name}" if ns else name
        class_infos[full] = {
            "base": base,
            "fields": fields,
            "name": name,
            "ns": ns,
        }

    simple_index: dict[str, list[str]] = {}
    for full, info in class_infos.items():
        simple_index.setdefault(info["name"], []).append(full)

    def resolve_base_full(base: str, ns: str) -> str | None:
        if not base or base == "System.Object" or base == "object":
            return None
        if base.startswith("MasterData.") or base.startswith("System."):
            return base if base in class_infos else None
        for prefix in ("MasterData.Client", "MasterData.Common", "MasterData.Types"):
            cand = f"{prefix}.{base}"
            if cand in class_infos:
                return cand
        cands = simple_index.get(base, [])
        if len(cands) == 1:
            return cands[0]
        cand = f"{ns}.{base}"
        return cand if cand in class_infos else None

    resolve_cache: dict[str, list[tuple[int, str, str]]] = {}

    def resolve(full: str, stack: set[str] | None = None) -> list[tuple[int, str, str]]:
        if full in resolve_cache:
            return resolve_cache[full]
        if full not in class_infos:
            return []
        stack = stack or set()
        if full in stack:
            return []
        stack.add(full)
        info = class_infos[full]
        merged: dict[int, tuple[str, str]] = {}
        base_full = resolve_base_full(info["base"], info["ns"])
        if base_full:
            for key, typ, prop in resolve(base_full, stack):
                merged[key] = (typ, prop)
        for key, typ, prop in info["fields"]:
            merged[key] = (typ, prop)
        out = [(key, merged[key][0], merged[key][1]) for key in sorted(merged)]
        resolve_cache[full] = out
        return out

    resolved = {full: resolve(full) for full in class_infos}

    # ---- Enums ----
    enum_re = re.compile(
        r"(?:(?:public|internal|private|protected)\s+)*(?:enum)\s+"
        r"(\w+)(?:\s*:\s*(\w+))?(?:\s*//[^\n]*)?\s*\{"
    )
    enum_infos: dict[str, dict] = {}
    simple_enums: dict[str, list[str]] = {}

    def parse_enum_value(expr: str) -> int | None:
        expr = expr.strip()
        try:
            return int(expr, 0)
        except ValueError:
            return None

    for m in enum_re.finditer(text):
        enum_name = m.group(1)
        underlying = m.group(2) or "int"
        open_idx = text.find("{", m.start())
        if open_idx < 0:
            continue
        depth = 1
        i = open_idx + 1
        while i < len(text) and depth:
            if text[i] == "{":
                depth += 1
            elif text[i] == "}":
                depth -= 1
            i += 1
        body = text[open_idx + 1 : i - 1]
        values: dict[int, str] = {}
        current = 0
        for raw_line in body.splitlines():
            line = raw_line.split("//")[0].strip().rstrip(",")
            if not line:
                continue
            assign = re.match(r"^(\w+)\s*=\s*([^,]+)$", line)
            if assign:
                val = parse_enum_value(assign.group(2))
                if val is None:
                    continue
                values[val] = assign.group(1)
                current = val + 1
                continue
            plain = re.match(r"^(\w+)$", line)
            if plain:
                values[current] = plain.group(1)
                current += 1
        if not values:
            continue
        ns = namespace_at(m.start())
        full = f"{ns}.{enum_name}" if ns else enum_name
        enum_infos[full] = {
            "underlying_type": underlying,
            "values": values,
            "name": enum_name,
        }
        simple_enums.setdefault(enum_name, []).append(full)

    # Map each [Table("X.json")] to its row class.
    table_re = re.compile(
        r'\[Table\("([^"]+\.json)"\)\]\s+'
        r"(?:public|internal|sealed|abstract|static|partial|readonly|unsafe)\s+"
        r"class\s+(\w+)\s*:\s*Base(List|Dict)<(.+)>"
    )
    tables: dict[str, dict] = {}
    for m in table_re.finditer(text):
        fname = m.group(1)
        args = m.group(4).strip()
        parts = split_top_level(args)
        row_raw = parts[-1]
        # Unwrap List<X> / Dictionary<K, X> to the actual row type.
        while row_raw.startswith("List<") and row_raw.endswith(">"):
            row_raw = row_raw[5:-1].strip()
        while row_raw.startswith("Dictionary<") and row_raw.endswith(">"):
            inner = row_raw[len("Dictionary<") : -1]
            inner_parts = split_top_level(inner)
            row_raw = inner_parts[-1].strip()
        tables[fname] = {"table_class": m.group(2), "row_raw": row_raw}

    # Resolve row raw names to full schema names.
    def row_full(raw: str) -> str | None:
        if not raw:
            return None
        if raw in class_infos:
            return raw
        if raw.startswith("MasterData."):
            return raw if raw in class_infos else None
        cands = simple_index.get(raw, [])
        if len(cands) == 1:
            return cands[0]
        pref = [c for c in cands if c.startswith("MasterData.Client.")]
        return pref[0] if pref else (cands[0] if cands else None)

    table_schema: dict[str, dict] = {}
    unresolved: list[str] = []
    for fname, info in sorted(tables.items()):
        full = row_full(info["row_raw"])
        fields = resolved.get(full, []) if full else []
        if not fields:
            unresolved.append(fname)
        table_schema[fname] = {
            "table_class": info["table_class"],
            "row_type": full,
            "fields": [{"key": k, "type": t, "name": n} for k, t, n in fields],
        }

    # Table names from Crc.txt that we did not see in cs/il2cpp.cs.
    crc_path = Path("masterdata_crc.json")
    if crc_path.exists():
        crc_names = set(json.loads(crc_path.read_text(encoding="utf-8")))
        missing_decl = sorted(crc_names - set(tables))
        print(f"tables in Crc.txt: {len(crc_names)}")
        print(f"table declarations found: {len(tables)}")
        print(f"declarations missing from cs: {len(missing_decl)}")
        if missing_decl:
            print("  " + ", ".join(missing_decl[:40]))

    # Text language files reuse the same MasterData.Client.Text row schema.
    text_schema = table_schema.get("Text.json")
    if text_schema:
        for fname in TEXT_ALIAS_FILES:
            table_schema[fname] = text_schema

    print(
        f"row schemas resolved: {sum(1 for v in table_schema.values() if v['fields'])}"
    )
    if unresolved:
        print(f"tables without row schema: {len(unresolved)}")
        print("  " + ", ".join(unresolved[:40]))
    print(f"enums parsed: {len(enum_infos)}")

    json_out = {
        "classes": {
            full: {
                "base": info["base"],
                "fields": [
                    {"key": k, "type": t, "name": n} for k, t, n in resolved[full]
                ],
            }
            for full, info in class_infos.items()
            if resolved[full]
        },
        "tables": table_schema,
        "enums": {
            full: {
                "underlying_type": info["underlying_type"],
                "values": info["values"],
            }
            for full, info in enum_infos.items()
        },
    }

    with Path("StarseedAsniaTriggerSchema.py").open("w", encoding="utf-8") as f:
        f.write("# Generated by generate_masterdata_schema.py\n\n")
        f.write("TABLE_SCHEMA = {\n")
        for fname, info in sorted(table_schema.items()):
            f.write(f"    {fname!r}: {{\n")
            f.write(f"        'table_class': {info['table_class']!r},\n")
            f.write(f"        'row_type': {info['row_type']!r},\n")
            f.write("        'fields': [\n")
            for field in info["fields"]:
                f.write(
                    f"            ({field['key']}, {field['type']!r}, {field['name']!r}),\n"
                )
            f.write("        ],\n")
            f.write("    },\n")
        f.write("}\n")

        f.write("\nENUM_SCHEMA = {\n")
        for full, info in sorted(enum_infos.items()):
            f.write(f"    {full!r}: {{\n")
            f.write(f"        '__underlying_type': {info['underlying_type']!r},\n")
            for val, name in sorted(info["values"].items()):
                f.write(f"        {val}: {name!r},\n")
            f.write("    },\n")
        f.write("}\n")


if __name__ == "__main__":
    main()
