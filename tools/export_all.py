import json
import os
import shutil
import subprocess
import sys

from google.protobuf import descriptor_pb2, json_format, text_format

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(ROOT, "data")
MD = os.path.join(ROOT, "MasterData")
TOOLS = os.path.dirname(os.path.abspath(__file__))

sys.path.insert(0, TOOLS)
import decrypt_data  # noqa: E402
from deserialize import POOL, get_msg_class, parse_logicproto, parse_xlsx_table  # noqa: E402
from google.protobuf import message_factory  # noqa: E402


def write_json(path, obj):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=1)


def copy_tree(src, dst):
    if not os.path.isdir(src):
        return 0
    n = 0
    for root, _dirs, files in os.walk(src):
        for fn in files:
            p = os.path.join(root, fn)
            rel = os.path.relpath(p, src)
            out = os.path.join(dst, rel)
            os.makedirs(os.path.dirname(out), exist_ok=True)
            shutil.copyfile(p, out)
            n += 1
    return n


def export_xlsx():
    src = os.path.join(DATA, "xlsx")
    dst = os.path.join(MD, "xlsx")
    ok = fail = 0
    for fn in sorted(os.listdir(src)):
        if not fn.endswith(".bytes"):
            continue
        rec, err = parse_xlsx_table(os.path.join(src, fn))
        if err:
            fail += 1
            print("  FAIL xlsx", fn, err)
            continue
        write_json(os.path.join(dst, fn.replace(".bytes", ".json")), rec)
        ok += 1
    print(f"xlsx: {ok} ok, {fail} fail")
    return ok, fail


def export_logicproto():
    src = os.path.join(DATA, "logicproto")
    dst = os.path.join(MD, "logicproto")
    ok = fail = 0
    for root, _dirs, files in os.walk(src):
        for fn in files:
            if not fn.endswith(".bytes"):
                continue
            p = os.path.join(root, fn)
            rec, err = parse_logicproto(p)
            if err:
                fail += 1
                print("  FAIL logicproto", p, err)
                continue
            if not rec["name"]:
                rec["name"] = fn[:-6]  # image/additional 类文件没有 f1 名字字段
            rel = os.path.relpath(p, src).replace(".bytes", ".json")
            write_json(os.path.join(dst, rel), rec)
            ok += 1
    print(f"logicproto: {ok} ok, {fail} fail")
    return ok, fail


def export_configproto():
    src = os.path.join(DATA, "configproto")
    dst = os.path.join(MD, "configproto")
    ok = fail = 0
    for root, _dirs, files in os.walk(src):
        for fn in files:
            if not fn.endswith(".bytes"):
                continue
            name = fn[:-6]
            cls = get_msg_class(name)
            data = open(os.path.join(root, fn), "rb").read()
            if cls is None:
                fail += 1
                print("  FAIL configproto", fn, "no schema")
                continue
            m = cls()
            m.ParseFromString(data)
            write_json(
                os.path.join(dst, name + ".json"),
                json_format.MessageToDict(m, preserving_proto_field_name=True),
            )
            ok += 1
    print(f"configproto: {ok} ok, {fail} fail")
    return ok, fail


def export_localization():
    src = os.path.join(DATA, "localization")
    dst = os.path.join(MD, "localization")
    ok = fail = 0
    for root, _dirs, files in os.walk(src):
        for fn in files:
            data = open(os.path.join(root, fn), "rb").read()
            recs = []
            pos = 0
            err = None
            while pos < len(data):
                if pos + 8 > len(data):
                    err = "tail"
                    break
                key = int.from_bytes(data[pos : pos + 4], "little")
                ln = int.from_bytes(data[pos + 4 : pos + 8], "little")
                if ln < 0 or ln > 100000 or pos + 8 + ln > len(data):
                    err = f"badlen@{pos}"
                    break
                text = data[pos + 8 : pos + 8 + ln].decode("utf-8", "replace")
                recs.append({"key": f"{key:08x}", "text": text})
                pos += 8 + ln
            if err:
                fail += 1
                print("  FAIL localization", fn, err)
                continue
            write_json(os.path.join(dst, fn.replace(".bytes", ".json")), recs)
            ok += 1
    print(f"localization: {ok} ok, {fail} fail ({len(recs)} 条)" if ok else f"localization: {ok} ok, {fail} fail")
    return ok, fail


def export_lua():
    jar = os.path.join(TOOLS, "unluac-fcicv.jar")
    opmap = os.path.join(TOOLS, "fcicv.opmap")
    src = os.path.join(DATA, "lua")
    dst = os.path.join(MD, "lua")
    os.makedirs(dst, exist_ok=True)
    r = subprocess.run(
        ["java", "-cp", jar, "unluac.BatchDecompile", src, dst, opmap],
        capture_output=True,
        text=True,
    )
    print("lua:", r.stdout.strip() or r.stderr.strip())
    return r.returncode == 0


def export_descriptor():
    fds = descriptor_pb2.FileDescriptorSet()
    fds.ParseFromString(open(os.path.join(DATA, "descriptor.bytes"), "rb").read())
    os.makedirs(os.path.join(MD, "descriptor"), exist_ok=True)
    shutil.copyfile(
        os.path.join(DATA, "descriptor.bytes"),
        os.path.join(MD, "descriptor", "descriptor.bytes"),
    )
    with open(os.path.join(MD, "descriptor", "descriptor.proto.txt"), "w", encoding="utf-8") as f:
        f.write(text_format.MessageToString(fds))
    print(f"descriptor: {len(fds.file)} protos")


def main():
    os.makedirs(MD, exist_ok=True)
    decrypt_data.main()
    export_xlsx()
    export_logicproto()
    export_configproto()
    export_localization()
    export_lua()
    for sub in ("ai", "raw", "scenefile", "stagefile"):
        n = copy_tree(os.path.join(DATA, sub), os.path.join(MD, sub))
        print(f"  {sub}: {n}")
    shutil.copyfile(
        os.path.join(DATA, "gamelogo.bytes"),
        os.path.join(MD, "gamelogo.png"),
    )
    export_descriptor()
    print("完成，输出目录:", MD)


if __name__ == "__main__":
    main()
