# 天地劫 热更 DLL（CDPH/HybridCLR DHE 容器）还原

## 结论

* HybridCLR **DHE（差分混合执行）** 的 `CDPH` 容器；`LoaderUtil.LoadDHEDll` -> `HybridCLR.RuntimeApi.LoadDifferentialHybridAssembly`
  加载（libil2cpp: 0x0A7DCF88）。
* 容器结构：`CDPH` + key[256]@0x10 + 8 个 section 程序 + 水印
  `Hello, HybridCLR`@0x460 + 配置（BSJB 元数据根 0x1003AE4）。
* 壳 VM：libil2cpp `sub_2CEFF80`（256 opcode），本目录用 Unicorn 直接调用
  天地劫自己的 VM（`tdj_vm.py`。
* 分层解密：`#Strings`=sec1、`#Blob`=sec2、`#US`=sec3、`#~`=sec5（块 0x100），
  `#US` 条目=sec4、TypeDef 行=sec6、IL 方法体=sec7（块 0x10）。

## 用法

```bash
python3 run_tdj_rebuild.py
```
