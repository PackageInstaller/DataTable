# PixelNeko FileSystem（NekoFS）

本文档依据 `libnekofs.so` 中的符号、RTTI 与反编译结果，记述 PixelNeko 客户端文件系统的结构与行为。分析入口包括 `NekoDataFileSystem::init`、`CentralDirectory`、`NekoDataLZ4Block`、`Merger::writeNekodata`，以及 Overlay / Update 相关类型。

---

## 1. 命名空间与类型

实现位于 C++ 命名空间 `PixelNeko::FileSystem`。与容器及叠加相关的主要类型：

| 类型 | 角色 |
| --- | --- |
| `NekoData::NekoDataFileSystem` | 单个 `.nekodata` 包的文件系统视图 |
| `NekoData::NekoDataFile` | 包内逻辑文件 |
| `NekoData::NekoDataRawFileStream` | 未压缩内容的流 |
| `NekoData::NekoDataLZ4Block` | LZ4 块缓冲 / 解压单元 |
| `NekoData::NekoDataLZ4StreamingFileStream` | 按块流式解压读取 |
| `NekoData::CentralDirectory` | 包尾目录；`init` 时从文件末尾装载 |
| `Overlay::OverlayFileSystem` | 多层叠加 |
| `Overlay::BasicOverlayFileSystem` | Overlay 的基础实现 |
| `Overlay::BasicLayerFileSystem` | 单层 |
| `Native::NativeFileSystem` | 宿主路径上的展开文件 |
| `AssetManager::AssetManagerFileSystem` | Android AssetManager 底座 |
| `Update::UpdateState` | 热更状态机 |
| `Update::Merger` | 合并 patch / 写出 nekodata（含 `writeNekodata`） |
| `Memory::MemoryFile` 等 | 内存文件与流 |
| `Exception` | 文件系统异常 |

导出的 C API 前缀为 `nekofs_`，例如 `nekofs_nekodatafilesystem_create`、`nekofs_overlayfilesystem_addlayer`、`nekofs_overlayfilesystem_getVersionMeta`、`nekofs_overlayfilesystem_refreshFileList`、`nekofs_filestream_read` / `seek` 等。

---

## 2. `.nekodata` 文件头

构造头对象时（反编译可见）将缓冲区布局为：

| 偏移 | 长度 | 内容 |
| --- | --- | --- |
| `0x00` | 20 | ASCII 魔数 `pixelneko filesystem`（无尾随 `NUL`） |
| `0x14` | 4 | 清零字段（观测为小端 `0`） |
| `0x18` | 1 | 版本字节，写死为 `1` |

头总长 **25 字节（`0x19`）**。其后为正文；正文由 CentralDirectory 索引的条目组成，条目内容可为原始字节或 LZ4 压缩块流。

扩展名字符串在库中出现为 `.nekodata`。热更合并失败时的日志含 `patchNekodataFS->init()`，表明 patch 包与普通包共用同一 `NekoDataFileSystem::init` 路径。

---

## 3. `NekoDataFileSystem::init` 与包尾尺寸字段

`init`（分析地址约 `0x91530`）在打开底层流之后执行：

1. 对底层流 `seek(offset = -10, seekdir = end)`。
2. 读取 **恰好 10 字节**；读长不足则失败。  
   （10 是 BinaryReader 一次最多预读的 varint 窗口，与 `sub_90F68` 等一致；**不是**「包尾固定有 10 字节独立结构」。）
3. 将该 10 字节缓冲 **整体按字节反转**。
4. 从缓冲起点读 `cd_size` 的 varint（见下），记下已消费字节数 `varint_len`；**其后字节一律忽略**。
5. `seek(END, -(cd_size + varint_len))`，读出 `cd_size` 字节的目录密文。
6. ChaCha20 解密后装入 `CentralDirectory`，再枚举目录项、建立路径映射。

### 3.1 真正写到盘上的包尾

写出路径（`Merger::writeNekodata` ≈ `sub_C9650`）：

1. 将 CentralDirectory **明文**写入内存流，记长度 `cd_size`。
2. 向同一内存流追加 `varint(ROL1(cd_size))`（1～5 字节）。
3. 对前 `cd_size` 字节做 ChaCha20，写入输出文件。
4. 把剩余的 size-varint 字节 **按字节反序** 写到文件末尾。

因此物理布局是：

```
[25 字节头][文件正文…][CD 密文 cd_size 字节][reverse(varint(ROL1(cd_size)))]
```

包尾真实长度 = `varint_len`（通常 1～5），**没有**额外的 CRC/Adler 尾字段。

### 3.2 为何 init 要读 10 字节

`seek(END,-10)` 读出的窗口会 **叠进 CD 密文末尾**：

| 反转后缓冲 | 含义 |
| --- | --- |
| 前 `varint_len` 字节 | `varint(ROL1(cd_size))`（唯一有意义的包尾） |
| 后 `10 - varint_len` 字节 | `reverse(CD密文的最后 10-varint_len 字节)`，读路径不消费；**不是**完整性校验 |

样例（`cfg.nekodata`）：反转后 `c0 09 23 ce a4 ff 74 83 ea f5` → varint `0x4c0` → `ROR1` → `cd_size = 608`，`varint_len = 2`；盘上仅在 CD 之后还有 `09 c0`（= `reverse(c0 09)`）；`23…f5` 等于 `reverse(CD[-8:])`。

### 3.3 目录密文定位

```
cd_off = file_size - varint_len - cd_size
# 等价于 seek(END, -(cd_size + varint_len)) 后再 read(cd_size)
```

回退量是 **`cd_size + varint_len`**，不是 `cd_size + 10`。CD 之后紧跟的只有反转后的 size-varint。

---

## 4. CentralDirectory

RTTI 名称：`PixelNeko::FileSystem::NekoData::CentralDirectory`。

### 4.1 加密：ChaCha20（DJB 布局）

目录正文为 **ChaCha20 流密码** 异或，非常量 LZ4。

| 项 | 值 |
| --- | --- |
| 算法 | ChaCha20，20 轮（10 次 double-round），常量 `"expand 32-byte k"` |
| Key（32 B） | `a5 05 7f 03 aa 62 82 9a c7 dc 4c 64 f9 f7 f4 28 b4 14 e7 15 16 e2 c3 a8 de 9c 77 f9 88 0f 2e d4`（`libnekofs.so` 内嵌） |
| Nonce（8 B） | `02 00 01 09 01 00 01 00` |
| Counter | 64-bit，**初值 = `cd_size`**（与密文长度相同）；每 64 字节 keystream 块加一 |
| 状态字布局 | words 0–3 常量，4–11 key，12–13 counter，14–15 nonce |

实现上可用 OpenSSL / `cryptography` 的 ChaCha20：16 字节 IV = `pack('<Q', counter) \|\| nonce8`，按块递增 counter。

### 4.2 明文目录格式

BinaryReader 对整数使用两套编码：

- **ROL1 + varint**：写入 `ROL1(n)`，读出后再 `ROR1`（32/64 位变体）。
- **原始 varint**：不旋转。

明文结构：

1. `entry_count`：`ROR1(varint64)`  
2. 重复 `entry_count` 次：
   - `name`：`ROR1(varint32)` 长度 + UTF-8 字节（长度上限 16384）
   - `flags`：`u8`（见下表；**非位域**，写出路径只写这两种值）
   - `uncomp_size`：`ROR1(varint64)`
   - 若 `flags != 0`：`stored_size`：`ROR1(varint64)`；否则 `stored_size = uncomp_size`
   - `crc32`：**原始** varint32（对 **磁盘上 stored 字节** 的 IEEE CRC-32）
   - `offset`：**原始** varint64（相对包起始的绝对偏移）
   - `nblocks`：`ROR1(varint32)`（可为 `0`：整段 `[offset, offset+stored_size)`，无 `(x,y)`；写出 raw 拷贝路径常见）
   - 若 `nblocks > 0`：`nblocks` 组 `(x, y)`，各为 `ROR1(varint64)`（见 §4.3）

#### `flags` 枚举（写出侧 `sub_93844`）

| 值 | 写出位置 | 含义 |
| --- | --- | --- |
| `0` | `writeNekodata` 原样拷贝路径 | Raw：`stored_size = uncomp_size`，无第二尺寸字段；`NekoDataRawFileStream` |
| `2` | `sub_CBC0C` LZ4 写出 | LZ4：随后有 `stored_size`；`NekoDataLZ4StreamingFileStream` |

读路径对 flags 的判定是 `flags != 0`（有无第二尺寸 / 是否走 LZ4），与写出枚举一致；库内未见其它写入值。

### 4.3 目录项 → 物理范围与块表

```
file_bytes = package[offset : offset + stored_size]
assert crc32(file_bytes) == entry.crc32
```

- `flags == 0`：`file_bytes` 即明文。
- `flags == 2`：`file_bytes` 为 raw LZ4 块流（每块输出上限 `0x8000`，块间字典不延续）。

#### 块表 `(x, y)`（磁盘）与内存尺寸（读入后）

写出（`sub_9385C` / `sub_93498`）在内存里为每块保存 `(comp_off, comp_size, uncomp_off, uncomp_size)`，但 **序列化只写起点** `(x, y) = (comp_off, uncomp_off)`。`nblocks == 0` 时无序列化对，语义等同整段单一区间（与 `(0,0)` 单块相同）。

- `x`：本块压缩数据相对 `file_bytes` 起点的字节偏移  
- `y`：本块解压数据相对逻辑文件起点的字节偏移  

读入（`sub_93588`）在 `nblocks >= 1` 时用相邻差分补回尺寸：

```
# 磁盘：blocks[i] = (x_i, y_i)，且 x、y 单调不减；首块常为 (0, 0)
for i in 0 .. nblocks-2:
    comp_size[i]   = x[i+1] - x[i]
    uncomp_size[i] = y[i+1] - y[i]
comp_size[nblocks-1]   = stored_size - x[nblocks-1]
uncomp_size[nblocks-1] = uncomp_size_total - y[nblocks-1]

# 第 i 块切片
comp_slice   = file_bytes[x[i] : x[i] + comp_size[i]]
# 独立 raw LZ4 → 恰好 uncomp_size[i] 字节（通常为 0x8000，末块可更短）
```

单块且 `(0,0)` 时：整段 `file_bytes` 即唯一 LZ4 流（内部仍按每 `0x8000` 输出重置字典）。  
等价实现：不读块表，对整段 stored 做「每产出 `0x8000` 字节就结束当前块、从下一字节起新块」的流式解压，结果与块表一致。

---

## 5. 压缩：`NekoDataLZ4Block`

### 5.1 块大小

`NekoDataLZ4BlockMemoryPool` 构造时以 **`0x8000`（32768）** 作为池块参数传入分配例程。解压路径上存在量级同为 `0x8000` 的栈/堆缓冲（例如解压例程旁约 `0x8000` 量级暂存区）。

含义：压缩内容按 **最大输出 0x8000 字节** 的 LZ4 块组织；块与块之间字典不延续（新块重新开始）。这与「标准 LZ4 Frame（带 frame 魔数与 block header 表）」不同：实现侧是 **自管的 raw LZ4 sequence 流**，由包格式与流对象解释边界。

### 5.2 解压

`NekoDataLZ4StreamingFileStream` 在需要时从底层读取压缩数据，调用内部解压例程（失败文案 `decompress error 2`）。解压器实现为典型 LZ4 sequence 循环（token、literal、match offset、扩展长度等），而非调用系统 `liblz4` 导出符号。

未压缩条目走 `NekoDataRawFileStream`，直接按目录给出的偏移与长度读取。

---

## 6. 完整性：CRC32 与 Adler32

库内自带两个滚动校验例程（分析地址约 `0x7E064`、`0x7E0A4`）：

| 算法 | 行为摘要 |
| --- | --- |
| CRC32 | 初值按 `~crc` 进入，查表 `dword_5036C`，按字节 `(crc ^ b)` 更新后右移，结束再取反——即常见 **ISO-HDLC / zlib / IEEE** 风格 CRC-32 |
| Adler32 | 低 16 位与高 16 位分别对 `0xFFF1` 取模累加，再拼回 32 位——即 **Adler-32** |

写出路径（例如带校验的输出流）在写入缓冲区时同时更新对象上的 CRC32 与 Adler32 字段。清单与元数据 JSON 中对应键名在字符串表中为：

- `crc32`
- `adler32`
- `packageadler`（包级 Adler，出现在 Update / 校验相关逻辑）

---

## 7. 清单与元数据（JSON 键）

### 7.1 文件清单

解析文件列表时使用的键（`files` 映射下每条含大小与双校验）：

- `files`
- `size`
- `crc32`
- `adler32`
- `deletes`

该类清单既可作为包内逻辑文件存在，也可在 Overlay 层以 **`files.meta`** 为路径名暴露。Overlay 取文件时对路径名 `files.meta`（长度 10）与 `version.meta`（长度 12）有专门分支。

### 7.2 版本元数据 `version.meta`

字符串表与合并逻辑中出现的键包括：

- `version`
- `fromversion`
- `versionserver`
- `downloadserver`
- `subresource`
- `require`
- `cleanexternal`
- `name`

`Merger` 在合并前校验底座版本与 patch 的 `fromversion` 关系；失败日志形如：

`versionMeta_base.getVersion() < versionMeta_patches.getFromVersion() fail!`

以及 `version < fromVersion_new`。

`subresource` 用于描述从属资源集；`require` 标记是否必需；`downloadserver` / `versionserver` 为 URL 列表字段名。

---

## 8. Overlay 与 Update 模型

逻辑模型：

1. **底座层**：`AssetManagerFileSystem`（APK 内资产）和/或已展开的 `NativeFileSystem`。
2. **NekoData 层**：一个或多个 `.nekodata`（含 patch）经 `NekoDataFileSystem` 挂入。
3. **`OverlayFileSystem` / `BasicOverlayFileSystem`**：按添加顺序叠加；后者覆盖前者。对外查询走 `getfile` / `exist`；`refreshFileList` 重建可见文件表；`getVersionMeta` 取当前版本元数据。
4. **`UpdateState`**：登记版本 URL、检查资源、下载 patch，再交给 `Merger` 与新的 `NekoDataFileSystem::init` 合并。

因此运行时「一个逻辑路径」可能来自底座包、某次 patch 包或已落地的原生文件；Overlay 负责解析优先级与列表刷新。

---

## 9. 流与 I/O 抽象

面向调用方的流操作由 `nekofs_filestream_*` 导出：`read`、`seek`、`getposition`、`getlength`、`release`。内部按文件条目类型分派到 Raw 或 LZ4 Streaming 实现。

异常统一为 `PixelNeko::FileSystem::Exception`；常见文案包括 `stream error`、`count < 0`、`outputstream not exist`、`decompress error 2`、`endoffset < 0`。

Android 侧另有 JNI：`Java_com_pixelneko_FileSystem_initAssetManager`，用于从 Java AssetManager 构造底座文件系统（失败时还有 Zip 解析相关错误串，属 Asset/Zip 底座路径，与 `.nekodata` 正文格式正交）。

---

## 10. 已确认边界

**已由反编译与样例包交叉确认：**

- 25 字节魔数头及版本字节 `1`
- 包尾：写出仅为 `reverse(varint(ROL1(cd_size)))`；`init` 用固定 10 字节窗口反转后取 varint，窗口内多余字节是 CD 密文重叠，无独立 CRC/Adler 尾
- CentralDirectory：ChaCha20（DJB，key/nonce 内嵌，counter 初值 = `cd_size`）
- 目录项：路径、`flags ∈ {0,2}`、uncomp/stored、CRC32（stored）、绝对 `offset`、块表
- 块表：磁盘存绝对起点 `(x,y)`；尺寸由相邻差分与 `stored_size` / `uncomp_size` 闭合
- LZ4 块池大小 `0x8000`；Raw / LZ4 两种文件流
- CRC-32（IEEE）与 Adler-32 实现（用于写出流累计与清单 JSON，**不是**包尾字段）；清单 JSON 键名
- Overlay / Update / Merger 关系

包级 Adler（JSON 键 `packageadler`）属于 Update / 校验元数据，与 `.nekodata` 包尾格式无关。