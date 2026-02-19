import json
import base64
import msgpack
import lz4.block
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

KEY_B64 = "BlEcgPYXGZBIpdWu19FxRqFZ4n1Z561HDQI3AbElBL8="
IV_B64 = "gdAHZpuTubM/VsuK14uJdA=="
INPUT_FILE = "master.bin"
OUTPUT_FILE = "master.json"


# 用于区分普通列表和 MsgPack Map
class MsgPackMap(list):
    pass


LIMITS = {
    "max_map_len": 0xFFFFFFFF,
    "max_array_len": 0xFFFFFFFF,
    "max_str_len": 0xFFFFFFFF,
    "max_bin_len": 0xFFFFFFFF,
    "max_ext_len": 0xFFFFFFFF,
}


def make_json_serializable(obj):
    if isinstance(obj, MsgPackMap):
        # 处理 Map，键也需要递归转换并转为字符串
        return {
            str(make_json_serializable(k)): make_json_serializable(v) for k, v in obj
        }
    elif isinstance(obj, list):
        return [make_json_serializable(v) for v in obj]
    elif isinstance(obj, dict):  # 备用
        return {
            str(make_json_serializable(k)): make_json_serializable(v)
            for k, v in obj.items()
        }
    elif isinstance(obj, msgpack.ExtType):
        if obj.code == 99:  # LZ4 压缩块
            try:
                # MessagePack-CSharp LZ4 格式: [未压缩长度(MsgPack Int)][压缩数据]
                unpacker = msgpack.Unpacker(raw=False, strict_map_key=False)
                unpacker.feed(obj.data)
                uncompressed_size = next(unpacker)
                compressed_payload = obj.data[unpacker.tell() :]
                decompressed = lz4.block.decompress(
                    compressed_payload, uncompressed_size=uncompressed_size
                )
                inner_data = msgpack.unpackb(
                    decompressed,
                    raw=False,
                    strict_map_key=False,
                    object_pairs_hook=MsgPackMap,
                    **LIMITS,
                )
                return make_json_serializable(inner_data)
            except Exception as e:
                return f"lz4解压出错{e}"
        return f"ExtType(code={obj.code}, len={len(obj.data)})"
    elif isinstance(obj, msgpack.Timestamp):
        return obj.to_datetime().isoformat()
    elif isinstance(obj, bytes):
        try:
            return obj.decode("utf-8")
        except:
            return obj.hex()
    return obj


def decrypt_and_convert():
    key = base64.b64decode(KEY_B64)
    iv = base64.b64decode(IV_B64)

    try:
        with open(INPUT_FILE, "rb") as f:
            encrypted_data = f.read()

        cipher = AES.new(key, AES.MODE_CBC, iv)
        decrypted_data = unpad(cipher.decrypt(encrypted_data), AES.block_size)
        unpacker = msgpack.Unpacker(
            raw=False,
            strict_map_key=False,
            unicode_errors="replace",
            object_pairs_hook=MsgPackMap,
            **LIMITS,
        )
        unpacker.feed(decrypted_data)

        try:
            header_map = next(unpacker)
            if not isinstance(header_map, MsgPackMap):
                raise ValueError("Header 格式错误，预期为 Map。")
            header = {str(k): v for k, v in header_map}
        except StopIteration:
            raise ValueError("数据流中没有 Header。")

        final_data = {}
        table_names = list(header.keys())

        # 第二层：后续的每一个对象对应 Header 中的一个表
        for table_name in table_names:
            try:
                raw_obj = next(unpacker)
                final_data[table_name] = make_json_serializable(raw_obj)
            except Exception as e:
                print(f"解析表 '{table_name}' 时发生错误: {e}")
                final_data[table_name] = f"ERROR: {e}"

        with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
            json.dump(final_data, f, indent=4, ensure_ascii=False)

    except Exception as e:
        import traceback

        traceback.print_exc()
        print(f"发生致命错误: {str(e)}")


if __name__ == "__main__":
    decrypt_and_convert()
