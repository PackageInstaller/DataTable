import json
import base64
import msgpack
import lz4.block
import urllib.request
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

# https://contents.techcronoss.techcross.co.jp/master/1.7.1.0/all.ebin
# 在此修改版本号，版本号，key，obkey从 rpc/ws 获取，自己抓包
VERSION = "1.7.1.0"
KEY_B64 = "hF0P0LiTSHfpPABgQJrUX6qHAm1xF/1w+7EWQeUnpeg="
IV_B64 = "gdAHZpuTubM/VsuK14uJdA=="
OUTPUT_FILE = "MasterData.json"

OB_KEYS = {
    1260405: 10746667144567614155,
    1260408: 6021815182603664266,
    1260412: 11898543589325694410,
    1260501: 12682691888073943749,
    1260504: 7815547092966137656,
    1260507: 5147868833818134339,
    30000052: 5580520519231768997,
    30000053: 15683348979544441226,
    30000055: 8288736064016335018,
    30000073: 4933400004858885789,
    30000077: 8514926492287190850
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


def decrypt_and_convert(data):
    key, iv = base64.b64decode(KEY_B64), base64.b64decode(IV_B64)
    try:
        cipher = AES.new(key, AES.MODE_CBC, iv)
        decrypted_data = unpad(cipher.decrypt(data), 16)
        unpacker = msgpack.Unpacker(
            raw=False, strict_map_key=False, object_pairs_hook=MsgPackMap, **LIMITS
        )
        unpacker.feed(decrypted_data)

        header_map = next(unpacker)
        header = {str(k): v for k, v in header_map}
        final_data = {}
        missing_obkey_sids = set()
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
                        elif ob_data and sid is not None and sid not in OB_KEYS:
                            missing_obkey_sids.add(sid)
                            decoded_list.append(make_json_serializable(item_map))
                        else:
                            # 无 ObfuscatedData 则为明文；无 ScheduleId 等有混淆数据的情况另行排查
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

        if missing_obkey_sids:
            print(
                f"缺少 OB_KEYS 的 ScheduleId:"
            )
            for sid in sorted(missing_obkey_sids):
                print(sid)
    except Exception as e:
        print(f"错误: {e}")


def download_master_data():
    url = f"https://contents.techcronoss.techcross.co.jp/master/{VERSION}/all.ebin"
    print(f"正在下载加密数据表...")
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response:
            data = response.read()
        return data
    except Exception as e:
        print(f"下载失败: {e}")
        return None

if __name__ == "__main__":
    data = download_master_data()
    if data:
        decrypt_and_convert(data)
