import msgpack
import json
import sys

if __name__ == "__main__":
    with open(sys.argv[1], "rb") as f:
        decode = f.read()
    with open("MasterData.json", "w", encoding="utf-8") as f:
        json.dump(msgpack.unpackb(decode), f, indent=4, ensure_ascii=False)
    print("反序列化完成")