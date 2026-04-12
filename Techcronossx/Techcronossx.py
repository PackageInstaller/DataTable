import json
import base64
import msgpack
import lz4.block
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

# https://contents.techcronoss.techcross.co.jp/master/1.4.101.0/all.ebin
# 1.4.101.0 是版本号，版本号，key，obkey从 rpc/ws 获取，自己抓包
KEY_B64 = "Q98sMqj5IydFQFS+V74FTZEb/CBgEx1WuCgluE2cRSU="
IV_B64 = "gdAHZpuTubM/VsuK14uJdA=="
INPUT_FILE = "all.ebin"
OUTPUT_FILE = "master.json"

OB_KEYS = {
    30000052: 5580520519231768997,
    30000053: 15683348979544441226,
    30000055: 8288736064016335018,
}


class MsgPackMap(list):
    pass


LIMITS = {
    "max_map_len": 0xFFFFFFFF,
    "max_array_len": 0xFFFFFFFF,
    "max_str_len": 0xFFFFFFFF,
    "max_bin_len": 0xFFFFFFFF,
    "max_ext_len": 0xFFFFFFFF,
}


def xor_in_place(data, ob_key, nonce):
    data = bytearray(data)
    length = len(data)
    if length < 1:
        return data
    v10 = (nonce ^ ob_key) if nonce != ob_key else 0xD1B54A32D192ED03
    v10 &= 0xFFFFFFFFFFFFFFFF
    v9 = 3
    while True:
        v_tmp = (v10 ^ (v10 >> 12)) & 0xFFFFFFFFFFFFFFFF
        v11 = (v_tmp ^ (v_tmp << 25)) & 0xFFFFFFFFFFFFFFFF
        v10 = (v11 ^ (v11 >> 27)) & 0xFFFFFFFFFFFFFFFF
        v12 = (0x2545F4914F6CDD1D * v10) & 0xFFFFFFFFFFFFFFFF
        data[v9 - 3] ^= (0x1D * (v10 & 0xFF)) & 0xFF
        if v9 - 2 >= length:
            break
        data[v9 - 2] ^= (v12 >> 8) & 0xFF
        if v9 - 1 >= length:
            break
        data[v9 - 1] ^= (v12 >> 16) & 0xFF
        if v9 >= length:
            break
        data[v9] ^= ((0x4F6CDD1D * (v10 & 0xFFFFFFFF)) & 0xFFFFFFFF) >> 24
        if v9 + 1 >= length:
            break
        data[v9 + 1] ^= (v12 >> 32) & 0xFF
        if v9 + 2 >= length:
            break
        data[v9 + 2] ^= (v12 >> 40) & 0xFF
        if v9 + 3 >= length:
            break
        data[v9 + 3] ^= (v12 >> 48) & 0xFF
        if v9 + 4 >= length:
            break
        data[v9 + 4] ^= (v12 >> 56) & 0xFF
        v9 += 8
        if v9 - 3 >= length:
            break
    return bytes(data)


def make_json_serializable(obj):
    if isinstance(obj, MsgPackMap):
        return {
            str(make_json_serializable(k)): make_json_serializable(v) for k, v in obj
        }
    elif isinstance(obj, list):
        return [make_json_serializable(v) for v in obj]
    elif isinstance(obj, dict):
        return {
            str(make_json_serializable(k)): make_json_serializable(v)
            for k, v in obj.items()
        }
    elif isinstance(obj, msgpack.ExtType):
        if obj.code == 99:
            try:
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
            except Exception:
                pass
        return f"ExtType(code={obj.code}, len={len(obj.data)})"
    elif isinstance(obj, msgpack.Timestamp):
        return obj.to_datetime().isoformat()
    elif isinstance(obj, bytes):
        try:
            return obj.decode("utf-8")
        except:
            return obj.hex().upper()
    return obj


def decompress_if_needed(obj):
    if isinstance(obj, msgpack.ExtType) and obj.code == 99:
        try:
            unpacker = msgpack.Unpacker(raw=False, strict_map_key=False)
            unpacker.feed(obj.data)
            uncompressed_size = next(unpacker)
            compressed_payload = obj.data[unpacker.tell() :]
            decompressed = lz4.block.decompress(
                compressed_payload, uncompressed_size=uncompressed_size
            )
            return msgpack.unpackb(
                decompressed,
                raw=False,
                strict_map_key=False,
                object_pairs_hook=MsgPackMap,
                **LIMITS,
            )
        except Exception as e:
            print(f"LZ4 解压失败: {e}")
    return obj


def decrypt_and_convert():
    key, iv = base64.b64decode(KEY_B64), base64.b64decode(IV_B64)
    try:
        with open(INPUT_FILE, "rb") as f:
            data = f.read()
        cipher = AES.new(key, AES.MODE_CBC, iv)
        decrypted_data = unpad(cipher.decrypt(data), 16)
        unpacker = msgpack.Unpacker(
            raw=False, strict_map_key=False, object_pairs_hook=MsgPackMap, **LIMITS
        )
        unpacker.feed(decrypted_data)

        header_map = next(unpacker)
        header = {str(k): v for k, v in header_map}
        final_data = {}
        table_names = list(header.keys())

        for table_name in table_names:
            try:
                raw_obj = next(unpacker)
                raw_obj = decompress_if_needed(raw_obj)
                if table_name.startswith("obfuscated_") and isinstance(raw_obj, list):
                    target_name = table_name.replace("obfuscated_", "")
                    print(f"正在解密混淆表: {table_name} -> {target_name}")
                    decoded_list = []
                    for item_map in raw_obj:
                        item = dict(item_map)
                        ob_data = item.get("ObfuscatedData") or item.get(
                            "ObfuscatedData_k__BackingField"
                        )
                        sid = item.get("ScheduleId") or item.get(
                            "ScheduleId_k__BackingField"
                        )
                        nonce = item.get("Nonce") or item.get("Nonce_k__BackingField")

                        if ob_data and sid in OB_KEYS:
                            dec_bytes = xor_in_place(ob_data, OB_KEYS[sid], int(nonce))
                            unpacked_inner = msgpack.unpackb(
                                dec_bytes,
                                raw=False,
                                strict_map_key=False,
                                object_pairs_hook=MsgPackMap,
                                **LIMITS,
                            )
                            decoded_list.append(make_json_serializable(unpacked_inner))
                        else:
                            decoded_list.append(make_json_serializable(item_map))

                    # 合并到主表
                    if target_name in final_data and isinstance(
                        final_data[target_name], list
                    ):
                        final_data[target_name].extend(decoded_list)
                    else:
                        final_data[target_name] = decoded_list
                else:
                    # 普通表处理
                    obj_json = make_json_serializable(raw_obj)
                    if (
                        table_name in final_data
                        and isinstance(final_data[table_name], list)
                        and isinstance(obj_json, list)
                    ):
                        final_data[table_name] = obj_json + final_data[table_name]
                    else:
                        final_data[table_name] = obj_json
            except Exception as e:
                print(f"处理表 '{table_name}' 失败: {e}")

        for k in list(final_data.keys()):
            if (
                k.startswith("obfuscated_")
                and k.replace("obfuscated_", "") in final_data
            ):
                del final_data[k]

        with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
            json.dump(final_data, f, indent=4, ensure_ascii=False)
        print(f"导出成功: {OUTPUT_FILE}")
    except Exception as e:
        print(f"致命错误: {e}")


if __name__ == "__main__":
    decrypt_and_convert()
