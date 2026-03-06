import os
import json
import msgpack
import binascii
import hashlib
from Crypto.Cipher import AES

FILE_KEY = "white-master-data-hash-key".encode("utf-8").ljust(32, b"\x00")[:32]
FILE_IV = binascii.unhexlify("a1a753d0f4d5f9a1259fc5ecf9ad649e")
DATA_KEY = "white-master-data-encrypt-key".encode("utf-8").ljust(32, b"\x00")[:32]


def decrypt_filename(hex_name):
    ciphertext = binascii.unhexlify(hex_name)
    cipher = AES.new(FILE_KEY, AES.MODE_CBC, iv=FILE_IV)
    decrypted = cipher.decrypt(ciphertext)
    padding_len = decrypted[-1]
    return decrypted[:-padding_len].decode("utf-8")


def decrypt_and_export(input_file_path, output_dir):
    base_name = os.path.basename(input_file_path)

    # 排除解密前的文件名是 master_catalog.json 的情况
    if base_name == "master_catalog.json":
        return

    try:
        real_name = decrypt_filename(base_name)
    except Exception:
        # 非加密 hex 文件名，跳过
        return

    with open(input_file_path, "rb") as f:
        data = f.read()

    if len(data) <= 16:
        return

    iv = data[:16]
    ciphertext = data[16:]
    cipher = AES.new(DATA_KEY, AES.MODE_CBC, iv=iv)

    decrypted_data = cipher.decrypt(ciphertext)
    padding_len = decrypted_data[-1]
    decrypted_data = decrypted_data[:-padding_len]
    unpacked_data = msgpack.unpackb(decrypted_data, raw=False, strict_map_key=False)

    if not real_name.lower().endswith(".json"):
        real_name += ".json"

    output_path = os.path.join(output_dir, real_name)
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(unpacked_data, f, ensure_ascii=False, indent=4)
    print(f"解密成功: {real_name}")


def batch_process(input_folder):
    output_folder = "MasterData"
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    for filename in os.listdir(input_folder):
        file_path = os.path.join(input_folder, filename)
        if os.path.isfile(file_path):
            decrypt_and_export(file_path, output_folder)


if __name__ == "__main__":
    batch_process(
        hashlib.md5(hashlib.md5("MasterCache".encode("utf-8")).digest()).hexdigest()
    )
