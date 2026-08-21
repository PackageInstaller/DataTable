# Config 二进制格式

## 行数据（protobuf）

行数据为 `Google.Protobuf` 编码的消息：

- wire type 0：varint
- wire type 2：length-delimited（嵌套消息 / 字符串 / packed 数组）
- wire type 5：fixed32
- wire type 1：fixed64

字段号 → 字段名/类型映射见 `config_schema.json`。

## 嵌套子表

部分表（如 `AttackApproachInfo → LinkFunction → public_attrib`）以
扁平化块形式存在于顶层表之间，块头为
`[父行 id][rowCount][nameLen][name]`，随后是该子表的行数据。
解析器将其作为独立表输出。

## 运行时加载逻辑（GameAssembly.dll）

| 逻辑                                      | 地址            |
| ----------------------------------------- | --------------- |
| `ConfigHelper.Initialize(string)`       | `0x180826110` |
| `ConfigHelper.Initialize(BinaryReader)` | `0x180825DF0` |
| `ConfigHelper.ParseTargetType(Type)`    | `0x180826220` |
| `ConfigHelper.GetAllConfig`             | `0x1808259D0` |
| `LineData.GetMessage`                   | `0x180827D60` |
| `ConfigReflection.get_Descriptor`       | `0x18086EA50` |
| `BlackboardReflection.cctor`            | `0x1808245D0` |

消息描述符（`ConfigReflection.cctor` 构建的 FileDescriptor）由
HybridCLR 热更 DLL（`common.dll`）提供，字段定义已提取到
`config_schema.json`。
