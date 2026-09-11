# UnityCN 位置与逆向分析记录

| 地址 | 内容/作用 |
|---|---|
| `0x1328B34` | 字符串 `UnityEngine.AssetBundle::SetAssetBundleKey` |
| `0x13575CF` | 字符串 `#$unity3dchina!@AssetBundle %s Key length is wrong. It should be 16 bytes and now is %d` |
| `0x13575D1` | 参与校验的 16 字节 magic：`unity3dchina!@A` |
| `0x3ABF60` | `SetAssetBundleKey` 相关实现/包装，内部调用 `sub_5DB6E8` |
| `0x5DB6E8` | 写入 16 字节 key 的函数 |
| `0x5DB840` | 读取当前 key 的 getter |
| `0x5DA9D0` | UnityCN 保护 archive 的 key 校验 / 解码表派生 |
| `0x5DB104` | key schedule / 初始化相关 |
| `0x5DAFBC` | key 相关辅助函数 |
| `0x5D1E18` | archive 打开入口，调用 `0x5D7D30` |
| `0x5D7D30` | UnityCN 保护 archive 解密流程关键函数 |
| `0x5D7E9C` | `sub_5D7D30` 内调用 `sub_5DA9D0` 的位置 |
| `0x183CD69` | 全局加密 key（16 字节） |
| `0x183CD7C` | 加密 key 是否已设置标志 |
| `0x183CD7D` | 全局解密 key（16 字节） |
| `0x183CD90` | 解密 key 是否已设置标志 |

