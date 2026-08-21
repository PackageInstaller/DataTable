"""
一些响应的解密类似这样
import sys
import json
import base64
import msgpack
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad


if __name__ == "__main__":
    with open(sys.argv[1], "rb") as f:
            enc = f.read()
    with open("Decrypt.json", "w") as f:
        json.dump(msgpack.unpackb(unpad((AES.new(base64.b64decode("Q+PfYqjoChLhhHK5xGok6A=="), AES.MODE_CBC,
            base64.b64decode("xB6nsBcL7xE0p4o+yfdaHA=="))).decrypt(enc), AES.block_size)), f, indent=4, ensure_ascii=False)
"""




import msgpack
import json
import sys

if __name__ == "__main__":
    with open(sys.argv[1], "rb") as f:
        decode = f.read()
    with open("MasterData.json", "w", encoding="utf-8") as f:
        json.dump(msgpack.unpackb(decode), f, indent=4, ensure_ascii=False)
    print("反序列化完成")