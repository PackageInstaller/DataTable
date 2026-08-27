# 无期迷途 Lua 提取

`game/PathToNowhere` 分支：从 APK / `assets/blocks` 抽出 `libxlua` 字节码，转成标准 Lua 5.4 容器，再用本目录的 `unluac-ptn.jar` 反编译。

## 依赖

- Python 3（`requests`、`rich`、`twofish`；立绘模式另需 `UnityPy`、`Pillow`）
- Java 8+（跑 `unluac/unluac-ptn.jar`）

## 从本目录 APK 出源码

把 APK 放到仓库根目录，然后：

```bash
python3 PathToNowhere.py \
  --skip-download --apk-only --to-lua \
  --outdir apk_out
```

省略 `--apk` 时，会用目录下第一个 `.apk`。产物：

| 目录                     | 内容                                  |
| ------------------------ | ------------------------------------- |
| `apk_out/apk_blocks/`  | 从 APK 抽出的`blocks`               |
| `apk_out/lua_scripts/` | 原始`\x1bXX` dump（`.luac`）      |
| `apk_out/lua54_ptn/`   | 标准 5.4 头 +**保留 88 槽编号** |
| `apk_out/lua/`         | `unluac --ptn` 反编译出的 `.lua`  |

只要标准 luac（给 `luac -p` / `loadfile`，**不要**跟 `--ptn` 混用）：

```bash
python3 PathToNowhere.py --skip-download --apk-only --to-luac --outdir apk_out
```

两个都要就同时加 `--to-luac --to-lua`。

## 单文件

```bash
python3 PathToNowhereConvert.py --keep-opcodes script.luac out.ptn.luac
java -jar unluac/unluac-ptn.jar --ptn --rawstring --output out.lua out.ptn.luac
```

## unluac `--ptn`

源码在 `unluac/`，基于 [Jeong-Min-Cho/unluac](https://github.com/Jeong-Min-Cho/unluac)，版本字符串 `1.2.3.569-ptn`。

这套 `libxlua` 是 Lua 5.4 + **5 个自定义指令（共 88 个）** + Q16.16 `fix32`（常量 tag 35）：

| opcode        | 编号 | 反编译                           |
| ------------- | ---- | -------------------------------- |
| `LOADFIX32` | 3    | `fix32(<sBx>)`                 |
| `FIX32`     | 52   | `fix32(x)`                     |
| `ASFIX32`   | 53   | `asfix32(x)`                   |
| `GETVARG`   | 84   | `select(R(C), ...)`            |
| `ERRNNIL`   | 85   | 全局已定义检查（几乎不输出语句） |

另外：`SELF` 的 C 永远是方法名常量（Lua 5.5 编码）；`NEWTABLE` 在 VM 里总是后跟 `EXTRAARG`。转换脚本会把 10bit C 收成 unluac 能读的 5.4 `NEWTABLE`。

重新编译 jar：

```bash
sh unluac/build.sh
```

## 立绘

从 APK 的 `portrait_res` / `hero` / `skin_config` 收集 `images/paintings/` 全身立绘（排除 `dialog/`，以及 600×600 截取：战姿2、默认3、皮肤名3），只下载相关 chunk，导出到 `Painting/无期迷途_{角色}_{皮肤}.png`。

```bash
python PathToNowhere.py --painting
python PathToNowhere.py --painting --skip-download
python PathToNowhere.py --painting --dry-run
```

省略 `--apk` 时用本目录下最新 `.apk`。配置从 APK 解密到 `downloads/apk_cfg/`，无需事先准备 `decrypted_cfg/`。

## 热更资源

Lua 热更仍在包体内；美术/音频 chunk 走 CDN。完整下载：

```bash
python3 PathToNowhere.py --outdir downloads --to-lua --apk 无期迷途_2.4.67.0.apk
```

## 限制

- 部分 UI / 战斗脚本会转换失败
