import os

old_signature = bytes.fromhex('1B 4C 75 61 53 01 19 93 0D 0A 1A 0A 04 04 08 08 78 56')
new_signature = bytes.fromhex('1B 4C 75 61 53 00 19 93 0D 0A 1A 0A 04 08 04 08 08 78 56')

def replace_signature_in_lua_files(directory):
    for root, _, files in os.walk(directory):
        for filename in files:
            if filename.endswith('.lua'):
                file_path = os.path.join(root, filename)
                with open(file_path, 'rb') as f:
                    content = f.read()
                if content.startswith(old_signature):
                    new_content = new_signature + content[len(old_signature):]
                    with open(file_path, 'wb') as f:
                        f.write(new_content)

if __name__ == '__main__':
    replace_signature_in_lua_files("luacode")
