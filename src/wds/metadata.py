"""Indexes built from the game's Il2Cpp metadata dumps.

* cs/il2cpp.cs      - classes, [MemoryTable] attributes and [Key(n)] fields
* il2cpp.json       - ApiClient method names and their response types

The MessagePack formatters serialize [Key(n)] fields as an array where the
array index equals the Key value; removed keys keep a nil slot, so the slot
list length is maxKey + 1.
"""

from __future__ import annotations

import json
import re
from typing import Any


TYPE_RE = re.compile(
    r"^\tpublic (?:sealed |abstract |static )?(?:class|struct) (\w+)"
    r"(?:<[^>]+>)?(?:\s*:\s*[^{]+)? // TypeDefIndex",
    re.M,
)
KEY_RE = re.compile(
    r"\[Key\(([^)]*)\)\]\s*(?:\n\s*\[[^\]]*\]\s*)*\n\s*public\s+([\w<>\[\].\?]+)\s+(\w+)"
)
MEMORY_TABLE_RE = re.compile(
    r"\[MemoryTable\(\"([^\"]+)\"\)\]\s*(?:\n\s*\[[^\]]*\]\s*)*"
    r"\n\s*public\s+(?:sealed\s+|abstract\s+|static\s+)?(?:class|struct)\s+(\w+)"
)


KeyField = tuple[int, str, str]  # (key, field name, C# type)
FieldSlots = list[tuple[str, str] | None]


def build_class_field_index(il2cpp_cs: str) -> dict[str, list[KeyField]]:
    """{className: [(key, field name, C# type)]} from [Key(n)] properties."""
    index: dict[str, list[KeyField]] = {}
    for m in TYPE_RE.finditer(il2cpp_cs):
        name = m.group(1)
        if name in index:
            continue
        end = il2cpp_cs.find("\n\t}\n", m.end())
        block = il2cpp_cs[m.end(): end if end > 0 else m.end() + 8000]
        keys: list[KeyField] = []
        for km in KEY_RE.finditer(block):
            key = km.group(1).strip()
            if key.isdigit():
                keys.append((int(key), km.group(3), km.group(2)))
        if keys:
            keys.sort()
            index[name] = keys
    return index


def build_table_type_map(il2cpp_cs: str) -> dict[str, str]:
    """[MemoryTable("Name")] directly above a class -> {tableName: className}."""
    return {m.group(1): m.group(2) for m in MEMORY_TABLE_RE.finditer(il2cpp_cs)}


def expand_fields(triples: list[KeyField]) -> FieldSlots:
    """Expand (key, name, type) triples into position-indexed (name, type)."""
    if not triples:
        return []
    max_key = max(k for k, _, _ in triples)
    slots: FieldSlots = [None] * (max_key + 1)
    for k, name, ctype in triples:
        slots[k] = (name, ctype)
    return slots


def field_names(slots: FieldSlots | None) -> list[str]:
    if not slots:
        return []
    return [s[0] if s else f"field_{i}" for i, s in enumerate(slots)]


def default_for(csharp_type: str) -> Any:
    """CLR default for a C# field type, mirroring game constructors."""
    t = csharp_type.strip()
    if "bool" in t:
        return False
    if re.match(r"^(?:u?int|u?long|short|ushort|byte|sbyte|float|double|decimal)\b", t):
        return 0
    return None


def load_il2cpp_cs(path: str = "cs/il2cpp.cs") -> str:
    with open(path, encoding="utf-8") as f:
        return f.read()


# ------------------------------------------------------------- api methods


def build_method_index(il2cpp_json_path: str) -> dict[str, dict[str, tuple[str, bool]]]:
    """Parse il2cpp.json ApiClient methods.

    Returns {controller: {action: (response_type, is_array)}}.
    """
    with open(il2cpp_json_path, encoding="utf-8") as f:
        jdata = json.load(f)

    index: dict[str, dict[str, tuple[str, bool]]] = {}
    for entry in jdata["addressMap"]["methodDefinitions"]:
        if not isinstance(entry, dict):
            continue
        group = entry.get("group", "") or ""
        if not group.startswith("Sirius.ApiClient.dll/Sirius/Api/ApiClient"):
            continue
        dnet = entry.get("dotNetSignature", "") or ""
        m = re.match(r".*?\b([A-Za-z][A-Za-z0-9]*_[A-Za-z][A-Za-z0-9]*)\(", dnet)
        if not m:
            continue
        mname = m.group(1)
        if "WithRetry" in mname or "Async" in mname or mname in ("", "ctor"):
            continue
        if "_" not in mname:
            continue
        controller, action = mname.split("_", 1)
        if not action:
            continue
        rtype, is_array = extract_return_type(entry.get("signature", "") or "")
        if not rtype:
            continue
        index.setdefault(controller, {})[action] = (rtype, is_array)
    return index


def extract_return_type(signature: str) -> tuple[str | None, bool]:
    """Return (response type name, is_array) from an ApiClient method signature."""
    m = re.match(r"IObservable_1_(.+?) \*", signature)
    if m:
        raw = m.group(1)
    else:
        m = re.match(r"UniTask_1_Sirius_Api_ApiActionResult_1_(.+?) ", signature)
        if not m:
            return None, False
        raw = m.group(1)
    is_array = raw.endswith("__1")
    if is_array:
        raw = raw[:-3]
    name = raw.rstrip("_")
    return name.rsplit("_", 1)[-1], is_array
