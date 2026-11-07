# DataTable，也许不只是数据表，谁知道呢

`master` 只保留索引和 git 相关文件，每个游戏一个独立的快照分支（`game/<游戏名>`），方便只拉取自己需要的数据。

## 内容移除说明

2026 年 11 月 4 日，本仓库依据日期为 2026 年 11 月 3 日的 DMCA 提交通知，移除 `game/AzurPromilia` 分支，停止提供 Azur Promilia（蓝色星原）的数据快照及相关工具，也不再维护或重新发布该分支，具体请看[removed](https://github.com/PackageInstaller/DataTable/tree/master/removed)以及 [github开放的dmca](https://github.com/github/dmca/blob/master/2026/11/2026-11-03-manjuu.md)。

### 致 fork 仓库维护者

各 fork 仓库维护者检查并删除 `game/AzurPromilia` 分支，停止维护和重新发布这些内容。

如收到 GitHub 的通知，请按通知要求与 GitHub 沟通。各 fork 的具体处理范围由 GitHub 按其 [DMCA 政策](https://docs.github.com/en/site-policy/content-removal-policies/dmca-takedown-policy)及有效通知核实确定。

## 克隆单个游戏

```bash
git clone -b game/xxxxx --single-branch --depth 1 https://github.com/PackageInstaller/DataTable.git
```

## 分支列表

| 分支                              | 游戏                     | 中文名                                                |
| --------------------------------- | ------------------------ | ----------------------------------------------------- |
| `game/AetherGazer`              | AetherGazer              | 大眼(深空之眼)                                        |
| `game/AlchemyStars`             | AlchemyStars             | 白鸡                                                  |
| `game/AnchorPanic`              | AnchorPanic              | 锚点降临                                              |
| `game/AngelicaAsterR`           | AngelicaAsterR           | 当归紫苑                                              |
| `game/AshArms`                  | AshArms                  | 灰烬战线                                              |
| `game/AssaultLilyLastBullet`    | AssaultLilyLastBullet    | 突击莉莉                                              |
| `game/AstraeOratio`             | AstraeOratio             | 阿索拉：星之祈愿                                      |
| `game/AtelierResleriana`        | AtelierResleriana        | 红色的炼金术士和白色的守护者 ～蕾斯莱莉娅娜的炼金工房 |
| `game/AzurLane`                 | AzurLane                 | 碧蓝航线                                              |
| `game/BanGDreamOurNotes`        | BanGDreamOurNotes        | BanG Dream! 交织的乐章                                |
| `game/BlackBeacon`              | BlackBeacon              | 黑色信标                                              |
| `game/CatFantasy`               | CatFantasy               | 猫之城                                                |
| `game/CounterSide`              | CounterSide              | 未来战                                                |
| `game/CuisineDimension`         | CuisineDimension         | 料理次元                                              |
| `game/DaiblosCore`              | DaiblosCore              | 交错战线                                              |
| `game/DengekiBunkoCROSSINGVOID` | DengekiBunkoCROSSINGVOID | 电击文库灵境交错                                      |
| `game/DotAbyss`                 | DotAbyss                 | 鸡渊                                                  |
| `game/Echocalypse`              | Echocalypse              | 绯红神约                                              |
| `game/Echonox24⁄36`            | Echonox24⁄36            | 时序残响                                              |
| `game/Embers`                   | Embers                   | 辉烬                                                  |
| `game/ErrorGameReset`           | ErrorGameReset           | 404错误游戏                                           |
| `game/EternalTree`              | EternalTree              | 树游                                                  |
| `game/EverSoul`                 | EverSoul                 | 永远之魂(误)                                          |
| `game/FalloutTamira`            | FalloutTamira            | 异尘：达米拉                                          |
| `game/FyorasSouls`              | FyorasSouls              | 芙娅之魂                                              |
| `game/GirlsCreationR`           | GirlsCreationR           | 草画                                                  |
| `game/GoddessOrder`             | GoddessOrder             | 最速关服二游                                          |
| `game/HorcruxCollege`           | HorcruxCollege           | 魂器学院                                              |
| `game/IMYSR`                    | IMYSR                    | 爱丽丝圣礼                                            |
| `game/IllusionConnect`          | IllusionConnect          | 梦境链接                                              |
| `game/IronSaga`                 | IronSaga                 | 机动战队大作战                                        |
| `game/KalpaOfUniverse`          | KalpaOfUniverse          | 天地劫                                                |
| `game/LegendOfAoqi`             | LegendOfAoqi             | 奥奇传说                                              |
| `game/LostSword`                | LostSword                | 丢剑                                                  |
| `game/Lumin`                    | Lumin                    | 绿梦：时空之声                                        |
| `game/MAkeDrama`                | MAkeDrama                | MAkeDrama                                             |
| `game/ManasisRefranin`          | ManasisRefranin          | 麻辣鸡丝                                              |
| `game/MementoMori`              | MementoMori              | 妹妹头                                                |
| `game/MillenniumWarAigis`       | MillenniumWarAigis       | 千年战争                                              |
| `game/MirrenStarLegends`        | MirrenStarLegends        | 碳猫语录                                              |
| `game/ModelWarGirl`             | ModelWarGirl             | 高能手办团                                            |
| `game/MoeCove`                  | MoeCove                  | 苍蓝避风港                                            |
| `game/MonmusuTDx`               | MonmusuTDx               | 草正太                                                |
| `game/Morimens`                 | Morimens                 | 忘却前夜                                              |
| `game/MuvLuvGirlsGardenX`       | MuvLuvGirlsGardenX       | 抹布                                                  |
| `game/NeoArtifacts`             | NeoArtifacts             | 来古（物华）弥新                                      |
| `game/NeuralCloud`              | NeuralCloud              | 云图计划                                              |
| `game/OZRewrite`                | OZRewrite                | OZRewrite                                             |
| `game/Orisries`                 | Orisries                 | 万源圣魔录                                            |
| `game/OrphansOrder`             | OrphansOrder             | 孤儿的工作                                            |
| `game/OshiroProjectRE`          | OshiroProjectRE          | 我去没r18(御城)                                       |
| `game/OtogiFrontierR`           | OtogiFrontierR           | 村人                                                  |
| `game/OverRush`                 | OverRush                 | OverRush                                              |
| `game/PathToNowhere`            | PathToNowhere            | 无期迷途                                              |
| `game/Resonance`                | Resonance                | 雷索纳斯                                              |
| `game/Reverse1999`              | Reverse1999              | 重返未来1999                                          |
| `game/ReverseBlue`              | ReverseBlue              | 反向蓝                                                |
| `game/RevivedWitch`             | RevivedWitch             | 复苏的魔女                                            |
| `game/RezoririX`                | RezoririX                | レゾリリ                                              |
| `game/RlyehShoujotaiX`          | RlyehShoujotaiX          | 邪神酱(误)                                            |
| `game/SakunaHinuka`             | SakunaHinuka             | 天穗手游                                              |
| `game/Seer`                     | Seer                     | 赛尔号                                                |
| `game/SonOfShenyin`             | SonOfShenyin             | 神隐之子                                              |
| `game/SoulOfDragon`             | SoulOfDragon             | 龙魂旅人                                              |
| `game/SoulTide`                 | SoulTide                 | 灵魂潮汐                                              |
| `game/SphereSeven`              | SphereSeven              | 七星传                                                |
| `game/StarHealer`               | StarHealer               | 弹力果冻                                              |
| `game/StarResonance`            | StarResonance            | 我去星批                                              |
| `game/StarSavior`               | StarSavior               | 你也是救援者？                                        |
| `game/StarseedAsniaTrigger`     | StarseedAsniaTrigger     | 星链计划：未来少女                                    |
| `game/TaimaninSquad`            | TaimaninSquad            | 对魔忍特遣队                                          |
| `game/Techcronossx`             | Techcronossx             | 铁扣连接                                              |
| `game/TenkeiParadox`            | TenkeiParadox            | 天启                                                  |
| `game/TrickcalRevive`           | TrickcalRevive           | 坨坨可爱捏                                            |
| `game/TwinkleStarKnights`       | TwinkleStarKnights       | 闪耀星骑士                                            |
| `game/WarshipGirlsR`            | WarshipGirlsR            | 战舰少女R                                             |
| `game/WitchSpring`              | WitchSpring              | 第五部啥时候出？                                      |
| `game/WorldDaiStar`             | WorldDaiStar             | 梦想星座盘                                            |
