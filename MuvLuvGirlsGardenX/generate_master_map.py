import re

def find_matching_brace(text: str, start_pos: int) -> int:
    brace_level = 1
    for i in range(start_pos + 1, len(text)):
        char = text[i]
        if char == '{':
            brace_level += 1
        elif char == '}':
            brace_level -= 1
            if brace_level == 0:
                return i
    return -1

def generate_map(cs_file_path: str, output_py_path: str):
    with open(cs_file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    namespace_pattern = re.compile(r'namespace Assets\.Api\.Client\s*\{(.*)\}', re.DOTALL)
    namespace_match = namespace_pattern.search(content)
    if not namespace_match:
        print("错误：未找到命名空间")
        return
    namespace_content = namespace_match.group(1)

    class_header_pattern = re.compile(
        r"\[MessagePackObject\(false\)\](?:.|\n)*?public class (\w+)",
        re.MULTILINE
    )
    
    prop_pattern = re.compile(
        r'\[Key\((\d+)\)\]\s*'
        r'(?:\[.*?\]\s*)*'
        r'public\s+([\w`\[\]<>.?]+)\s+(\w+)\s*\{',
        re.DOTALL
    )
    
    all_class_maps = {}

    for header_match in class_header_pattern.finditer(namespace_content):
        class_name = header_match.group(1)
        
        class_body_start_brace = namespace_content.find('{', header_match.end())
        if class_body_start_brace == -1:
            continue
            
        class_body_end_brace = find_matching_brace(namespace_content, class_body_start_brace)
        if class_body_end_brace == -1:
            continue

        class_body = namespace_content[class_body_start_brace + 1 : class_body_end_brace]

        field_map = {}
        for prop_match in prop_pattern.finditer(class_body):
            key_index = int(prop_match.group(1))
            prop_type = prop_match.group(2)
            prop_name = prop_match.group(3)
            field_map[key_index] = (prop_name, prop_type)
        
        if field_map:
            map_name = f"{class_name.upper()}_MAP"
            all_class_maps[class_name] = (map_name, field_map)

    with open(output_py_path, 'w', encoding='utf-8') as f:
        all_map_names = []
        
        for class_name, (map_name, field_map) in all_class_maps.items():
            all_map_names.append(map_name)
            f.write(f"{map_name} = {{\n")
            for index, (name, type) in sorted(field_map.items()):
                f.write(f"    {index}: \"{name}\",\n")
            f.write("}\n\n")

        if "MasterResult" in all_class_maps:
            f.write("MASTER_RESULT_STRUCTURE = {\n")
            
            _, master_result_map = all_class_maps["MasterResult"]
            for index, (prop_name, prop_type) in sorted(master_result_map.items()):
                type_match = re.search(r'(\w+)(?:\[\])?$', prop_type)
                base_type_name = type_match.group(1) if type_match else None

                target_map_name = "None"
                if base_type_name and base_type_name in all_class_maps:
                    target_map_name = all_class_maps[base_type_name][0]

                f.write(f"    {index}: (\"{prop_name}\", {target_map_name}),\n")

            f.write("}\n")
        else:
            print("MasterResult 类未找到或解析不正确")

if __name__ == "__main__":
    generate_map("types.cs", "MasterMap.py")