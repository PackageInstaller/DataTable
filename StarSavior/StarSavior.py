import os
import sys
import json
import lz4.frame
import bson # pymongo

def process(data: bytes) -> str:
    try:
        return json.dumps(bson.decode_all(data), indent=4, ensure_ascii=False)
    except:
        return data.decode('utf-8-sig')

def deserialize(ip, op):
    with open(ip, 'rb') as f:
        content = f.read()

    header = content[:4]

    if len(header) == 4 and header[1:4] == b'\xDE\x21\x2B':
        if header[0:1] == b'\x01':
            str = process(lz4.frame.decompress(content[4:]))
        else:
            return False
    elif len(header) == 4 and header == b'\x04\x22\x4d\x18':
        str = process(lz4.frame.decompress(content))
    else:
        str = content.decode('utf-8-sig')

    with open(op, 'w', encoding='utf-8-sig') as f_out:
        f_out.write(str)
    return True


if __name__ == "__main__":
    ip = sys.argv[1]

    if not os.path.isdir(ip):
        sys.exit(1)
        
    op = os.path.join(os.getcwd(), "MasterData")

    if not os.path.exists(op):
        os.makedirs(op)

    fc = 0
    sc = 0

    for fn in [f for f in os.listdir(ip) if os.path.isfile(os.path.join(ip, f))]:
        fc += 1
        if deserialize(os.path.join(ip, fn), os.path.join(op, f"{os.path.splitext(fn)[0]}.json")):
            sc += 1

    print(f"{sc}个")