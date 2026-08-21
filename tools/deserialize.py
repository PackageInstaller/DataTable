import json
import os
import re

from google.protobuf import descriptor_pb2, descriptor_pool, json_format, message_factory

ROOT = "./"
OUT = os.path.join(ROOT, "deserialized")


def build_pool():
    pool = descriptor_pool.DescriptorPool()

    def add_std(modname):
        mod = __import__(modname, fromlist=["x"])
        pool.Add(descriptor_pb2.FileDescriptorProto.FromString(mod.DESCRIPTOR.serialized_pb))

    for m in [
        "google.protobuf.descriptor_pb2",
        "google.protobuf.any_pb2",
        "google.protobuf.timestamp_pb2",
        "google.protobuf.duration_pb2",
        "google.protobuf.struct_pb2",
        "google.protobuf.wrappers_pb2",
        "google.protobuf.empty_pb2",
    ]:
        try:
            add_std(m)
        except Exception:
            pass

    fds = descriptor_pb2.FileDescriptorSet()
    fds.ParseFromString(open(os.path.join(ROOT, "data/descriptor.bytes"), "rb").read())
    files = {f.name: f for f in fds.file}
    remaining = set(files)
    while remaining:
        progress = False
        for name in list(remaining):
            f = files[name]
            if all(d not in remaining for d in f.dependency):
                try:
                    pool.Add(f)
                    remaining.discard(name)
                    progress = True
                except Exception:
                    remaining.discard(name)
        if not progress:
            break
    return pool


POOL = build_pool()


def parse_il2cpp_schema(path=os.path.join(ROOT, "cs/il2cpp.cs")):
    """从 Il2CppInspector 生成的 C# 骨架提取 protobuf 消息 schema。

    返回 {ClassName: {field_number: (field_name, csharp_type)}}。
    C# 里字段号以 `public const int XxxFieldNumber = N;` 出现，类型来自属性声明。
    """
    txt = open(path, encoding="utf-8-sig").read()
    schema = {}
    pat = re.compile(
        r"public sealed class (\w+) : IMessage<\w+>.*?"
        r"(?=public sealed class \w+ : IMessage|public enum \w+|\Z)",
        re.S,
    )
    for m in pat.finditer(txt):
        name, body = m.group(1), m.group(0)
        flds = {
            int(n): fn.replace("FieldNumber", "")
            for fn, n in re.findall(r"public const int (\w+)FieldNumber = (\d+);", body)
        }
        if not flds:
            continue
        # 属性类型：RepeatedField<T> X { get }  /  T X { get; set; }
        types = {}
        for t1, t2, pn in re.findall(
            r"public (?:RepeatedField<(\w+)>|(\w+)) (\w+) \{ get", body
        ):
            types[pn] = t1 or t2
        schema[name] = {num: (fn, types.get(fn, "")) for num, fn in flds.items()}
    return schema


IL2CPP_SCHEMA = parse_il2cpp_schema()


def find_message_class_for_il2cpp(name):
    cls = get_msg_class(name)
    if cls is not None:
        return cls, "descriptor"
    if name in IL2CPP_SCHEMA:
        return None, "il2cpp"
    return None, None


def get_msg_class(type_name):
    try:
        desc = POOL.FindMessageTypeByName(type_name)
    except KeyError:
        return None
    return message_factory.GetMessageClass(desc)


def parse_xlsx_table(path):
    name = os.path.basename(path)
    if name.lower().endswith(".bytes"):
        name = name[:-6]
    cls = get_msg_class(name)
    if cls is None:
        return None, f"descriptor.bytes 中找不到消息类型 {name}"
    data = open(path, "rb").read()
    records = []
    pos = 0
    while pos < len(data):
        if pos + 4 > len(data):
            return None, f"尾部不足 4 字节 @ {pos}"
        ln = int.from_bytes(data[pos : pos + 4], "little")
        pos += 4
        if ln < 0 or pos + ln > len(data):
            return None, f"记录长度越界 @ {pos - 4}: {ln}"
        msg = cls()
        msg.ParseFromString(data[pos : pos + ln])
        records.append(json_format.MessageToDict(msg, preserving_proto_field_name=True))
        pos += ln
    return records, None


def dump_xlsx_tables():
    src_dir = os.path.join(ROOT, "data/xlsx")
    dst_dir = os.path.join(OUT, "xlsx")
    os.makedirs(dst_dir, exist_ok=True)
    ok = fail = 0
    for fn in sorted(os.listdir(src_dir)):
        if not fn.endswith(".bytes"):
            continue
        records, err = parse_xlsx_table(os.path.join(src_dir, fn))
        if err:
            fail += 1
            print("FAIL", fn, err)
            continue
        out_path = os.path.join(dst_dir, fn.replace(".bytes", ".json"))
        with open(out_path, "w", encoding="utf-8") as f:
            json.dump(records, f, ensure_ascii=False, indent=1)
        ok += 1
    print(f"xlsx tables: ok={ok} fail={fail}")


def parse_logicproto(path):
    data = open(path, "rb").read()
    action_cls = get_msg_class("ActionLogicDataProto")
    if action_cls is None:
        return None, "pool 中无 ActionLogicDataProto"
    pos = 0
    name = ""
    actions = []
    while pos < len(data):
        tag, pos = parse_varint(data, pos)
        if tag is None or tag == 0:
            break
        f, wt = tag >> 3, tag & 7
        if wt != 2:
            return None, f"意外 wire type: f{f} wt{wt} @ {pos}"
        ln, pos = parse_varint(data, pos)
        chunk = data[pos : pos + ln]
        pos += ln
        if f == 1:
            name = chunk.decode("utf-8", "replace")
        elif f == 3:
            m = action_cls()
            m.ParseFromString(chunk)
            actions.append(json_format.MessageToDict(m, preserving_proto_field_name=True))
        else:
            pass
    return {"name": name, "actions": actions}, None


def dump_logicproto():
    src_dir = os.path.join(ROOT, "data/logicproto")
    dst_dir = os.path.join(OUT, "logicproto")
    os.makedirs(dst_dir, exist_ok=True)
    ok = fail = 0
    for fn in sorted(os.listdir(src_dir)):
        p = os.path.join(src_dir, fn)
        if os.path.isdir(p) or not fn.endswith(".bytes"):
            continue
        rec, err = parse_logicproto(p)
        if err:
            fail += 1
            print("FAIL", fn, err)
            continue
        with open(os.path.join(dst_dir, fn.replace(".bytes", ".json")), "w", encoding="utf-8") as f:
            json.dump(rec, f, ensure_ascii=False, indent=1)
        ok += 1
    print(f"logicproto: ok={ok} fail={fail}")


def parse_varint(b, pos):
    v = 0
    shift = 0
    while True:
        if pos >= len(b):
            return None, pos
        x = b[pos]
        pos += 1
        v |= (x & 0x7F) << shift
        if not (x & 0x80):
            return v, pos
        shift += 7
        if shift > 70:
            return None, pos


def dump_generic(b, indent=0, max_depth=8):
    if max_depth <= 0:
        return [("...", "")]
    out = []
    pos = 0
    while pos < len(b):
        tag, pos = parse_varint(b, pos)
        if tag is None or tag == 0:
            break
        field, wt = tag >> 3, tag & 7
        if wt == 0:
            val, pos = parse_varint(b, pos)
            out.append((f"{'  '*indent}f{field} varint", str(val)))
        elif wt == 1:
            out.append((f"{'  '*indent}f{field} fixed64", b[pos : pos + 8].hex()))
            pos += 8
        elif wt == 2:
            ln, pos = parse_varint(b, pos)
            chunk = b[pos : pos + ln]
            pos += ln
            text = ""
            try:
                text = chunk.decode("utf-8")
                if not all(c.isprintable() or c in "\n\r\t" for c in text):
                    text = ""
            except Exception:
                text = ""
            if text:
                out.append((f"{'  '*indent}f{field} str", text))
            else:
                sub = dump_generic(chunk, indent + 1, max_depth - 1)
                if len(sub) > 1 or (sub and sub[0][1] != ""):
                    out.append((f"{'  '*indent}f{field} msg", ""))
                    out.extend(sub)
                else:
                    out.append((f"{'  '*indent}f{field} bytes", chunk.hex()))
        elif wt == 5:
            out.append((f"{'  '*indent}f{field} fixed32", b[pos : pos + 4].hex()))
            pos += 4
        else:
            out.append((f"{'  '*indent}f{field} wire{wt}", "?"))
            break
    return out


if __name__ == "__main__":
    dump_xlsx_tables()
    dump_logicproto()
