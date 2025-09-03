import re
from pathlib import Path

def find(text: str, start_pos: int) -> int:
    if start_pos == -1 or text[start_pos] != '{': return -1
    brace_level = 1
    pos = start_pos + 1
    while pos < len(text):
        char = text[pos]
        if char == '{': brace_level += 1
        elif char == '}':
            brace_level -= 1
            if brace_level == 0: return pos
        pos += 1
    return -1

def extract(type_str: str) -> str:
    return type_str.strip().split('.')[-1]

def generate(cs: Path, o: Path):
    content = cs.read_text(encoding='utf-8')
    lines = content.splitlines()
    id_to_class_map = {}
    interface_line_index = next((i for i, line in enumerate(lines) if "public interface IDataObject" in line), -1)
    if interface_line_index != -1:
        union_pattern = re.compile(r'^\s*\[Union\((\d+),\s*typeof\(([\w\.]+)\)\)\]')
        for i in range(interface_line_index - 1, -1, -1):
            line = lines[i].strip()
            if match := union_pattern.match(line):
                type_id, full_type_name = int(match.group(1)), match.group(2)
                id_to_class_map[type_id] = full_type_name.split('.')[-1]
            elif line and not line.startswith('['): break
    enum_mappings = {}
    enum_start_pattern = re.compile(r'(?:\[Flags\]\s*)?public enum (\w+)')
    for match in enum_start_pattern.finditer(content):
        enum_name = match.group(1)
        start_brace_pos = content.find('{', match.end())
        if start_brace_pos == -1: continue
        end_brace_pos = find(content, start_brace_pos)
        if end_brace_pos == -1: continue
        enum_body = content[start_brace_pos + 1 : end_brace_pos]
        members, last_value = {}, -1
        member_pattern = re.compile(r'(\w+)\s*(?:=\s*(-?\d+|0x[0-9a-fA-F]+))?')
        for line in enum_body.split(','):
            if not (line := line.strip()) or line.startswith('//'): continue
            if member_match := member_pattern.search(line):
                name, value_str = member_match.groups()
                value = int(value_str, 0) if value_str is not None else last_value + 1
                members[value], last_value = name.strip(), value
        enum_mappings[enum_name] = members
    class_definitions = {}
    classes_to_parse = set(id_to_class_map.values())
    parsed_classes = set()
    prop_pattern = re.compile(
        r'\[Key\((\d+)\)\]\s*(?:\[.*?\]\s*)*public\s+([\w\.<>\?`\[\]\s,]+)\s+(\w+)\s*\{', re.DOTALL
    )

    while classes_to_parse:
        class_name = classes_to_parse.pop()
        if class_name in parsed_classes: continue
        parsed_classes.add(class_name)
        class_start_pattern = re.compile(fr'public class {re.escape(class_name)}\s*(?:\/\/.*)?(?::(?:.|\n)*?)?{{')
        class_match = class_start_pattern.search(content)
        if not class_match: continue
        start_brace = class_match.end() - 1
        end_brace = find(content, start_brace)
        if end_brace == -1: continue
        class_body = content[start_brace:end_brace]
        fields, field_types = {}, {}
        for prop_match in prop_pattern.finditer(class_body):
            key, prop_type, prop_name = prop_match.groups()
            base_type = extract(prop_type)
            fields[int(key)] = prop_name.strip()
            field_types[prop_name.strip()] = base_type
            clean_base_type = re.sub(r'\[\]|\?|>', '', base_type).split('<')[-1]
            if clean_base_type not in enum_mappings and clean_base_type not in parsed_classes and clean_base_type and clean_base_type[0].isupper():
                classes_to_parse.add(clean_base_type)
        if fields:
            class_definitions[class_name] = {"fields": dict(sorted(fields.items())), "field_types": field_types}
    
    with o.open('w', encoding='utf-8') as f:
        f.write("# 此文件由 GenerateMasterMap.py 自动生成\n\n")
        f.write("MASTER_SCHEMA_BY_ID = {\n")
        for type_id, class_name in sorted(id_to_class_map.items()):
            if class_name in class_definitions:
                field_list = list(class_definitions[class_name]["fields"].values())
                f.write(f"    {type_id}: (\"{class_name}\", {field_list!r}),\n")
        f.write("}\n\n")
        f.write("MASTER_SCHEMA_BY_NAME = {\n")
        for class_name, definition in sorted(class_definitions.items()):
             field_list = list(definition["fields"].values())
             f.write(f"    \"{class_name}\": {field_list!r},\n")
        f.write("}\n\n")
        f.write("ENUM_MAPPINGS = {\n")
        for enum_name, members in sorted(enum_mappings.items()):
            f.write(f"    \"{enum_name}\": {members!r},\n")
        f.write("}\n\n")
        f.write("FIELD_TYPE_MAP = {\n")
        for class_name, definition in sorted(class_definitions.items()):
            f.write(f"    \"{class_name}\": {{\n")
            for field_name, field_type in definition["field_types"].items():
                 f.write(f"        \"{field_name}\": \"{field_type}\",\n")
            f.write("    },\n")
        f.write("}\n")

if __name__ == "__main__":
    generate(Path("il2cpp.cs"), Path("MasterMap.py"))