# Aether Gazer PC Resource Tools

深空之眼（Aether Gazer）PC 版资源研究与数据表解析工具集。

> **免责声明**：本项目仅用于个人学习与逆向研究。所有资源版权归
> 发行方（Yostar / 勇仕网络）所有。请勿将本工具用于任何商业用途或
> 违反游戏服务条款的行为。

---

## 目录结构

```text
DataTable/
├── README.md
├── AetherGazer.py              # 子命令入口：资产下载 / 数据表 / Lua / 立绘
│                               # （原 updater/aethergazer_updater.py、scripts/fetch_*.py 已并入）
├── Schema.json                 # 180 个 protobuf 消息字段映射（数据表解析用）
├── MasterData/                 # 数据表 JSON、Lua/x64、Lua/x86、DLL 反编译源码
├── docs/
│   ├── updater.md              # 下载更新器使用文档
│   ├── masterdata.md           # 数据表解析文档
│   ├── config-format.md        # Config 容器/行/字段格式说明
│   ├── lua-bridge.md           # Lua 脚本桥（ToLua）与反编译
│   └── reverse-engineering.md  # 热更 DLL 逆向还原全记录
├── scripts/
│   ├── decrypt_metadata.py     # global-metadata.dat 解密（CDPH）
│   ├── fetch_masterdata.py     # 旧脚本：数据表一键下载+解析（已并入 masterdata 子命令）
│   ├── fetch_lua.py            # 旧脚本：Lua 下载/提取/反编译（已并入 lua 子命令）
│   └── extract_schema.py       # 旧脚本：il2cpp.cs -> Schema.json（已并入 schema 子命令）
└── research/
    ├── cdph_vm.py              # CDPH 壳 VM 解释器
    ├── decrypt_il.py           # IL 方法体解密
    ├── rebuild_dll.py          # 完整 DLL 重建
    ├── rebuild_all_dlls.py     # 批量重建 TextAsset/ 下全部热更 DLL
    ├── build_all.py            # 一站式：重建 + 反编译全部热更 DLL
    └── patch_system_refs.py    # 引用修补（ilspycmd 0 警告用）
```

## 快速开始

```bash
python AetherGazer.py --help
```

### 1. 资产全量下载 / 增量更新

```bash
python AetherGazer.py assets --output ./AetherGazer --jobs 8
```

首次运行全量下载到 `Assets/`；之后再次运行只下载差异到 `Updates/`。
常用参数：

```bash
# 只下载数据表与配置
python AetherGazer.py assets --output ./AetherGazer --only all --voice-lang ''

# 只下载 Lua 相关资源
python AetherGazer.py assets --output ./AetherGazer --only lua

# 只下载立绘（portrait / portraitdlc）
python AetherGazer.py painting --output ./AetherGazer

# 只生成清单与下载链接，不下载
python AetherGazer.py assets --output ./AetherGazer --list-only
```

### 2. 数据表模式（只下载数据表资产 + Lua，解析到 MasterData/）

```bash
python AetherGazer.py masterdata
```

数据表模式只拉取数据表资产 `config.ys` 与 Lua bundle（`scripts64` /
`scripts32`），不会下载整包资源：按字段映射反序列化全部 89 张表到
`MasterData/*.json`，并把 Lua 反编译到 `MasterData/Lua/x64`、
`MasterData/Lua/x86`。

```bash
# 只解析数据表，不下载 Lua
python AetherGazer.py masterdata --no-lua

# 只要 LuaJIT 字节码，不调用 luajit-decompiler
python AetherGazer.py masterdata --no-decompile

# 只处理单个架构
python AetherGazer.py lua --arch 64
```

### 2.5 只下载并提取 Lua 脚本

```bash
python AetherGazer.py lua                       # Lua/x64 + Lua/x86（默认反编译）
python AetherGazer.py lua --arch 64 --force     # 强制重新下载/反编译
python AetherGazer.py lua --keep-bytecode       # 额外保留字节码到 LuaBytecode/
```

反编译依赖系统命令 `luajit-decompiler`；没有该命令时保留 LuaJIT
字节码（`*.lua.bytes`）。

### 3. 反编译HybridCLR DLL

```bash
cd research
python rebuild_dll.py                       # 重建 P08.FlipCardGame.rebuilt.dll
python patch_system_refs.py                 # 生成引用修补版
cp P08.FlipCardGame.decompile.dll <游戏 Managed 目录>/   # 与引用程序集同目录
cd <游戏 Managed 目录>
ilspycmd P08.FlipCardGame.decompile.dll -p -o DLL   # 1025 个 .cs，0 警告
```

### 4. 批量重建并反编译全部HybridCLR DLL

```bash
cd research
python build_all.py
```

## 文档

- [docs/updater.md](docs/updater.md) —— 下载更新器原理与参数
- [docs/masterdata.md](docs/masterdata.md) —— 数据表提取/解析/字段映射
- [docs/config-format.md](docs/config-format.md) —— Config 二进制格式
- [docs/lua-bridge.md](docs/lua-bridge.md) —— Lua 脚本桥（ToLua）使用情况
- [docs/reverse-engineering.md](docs/reverse-engineering.md) —— CDPH 容器、
  壳 VM、四流解密、DLL 重建与反编译全过程
