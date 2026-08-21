# DataTable

各游戏数据表快照仓库。`master` 只保留索引和 git 相关文件，每个游戏一个独立的快照分支（`game/<游戏名>`），方便只拉取自己需要的数据。

## 克隆单个游戏

```bash
git clone -b game/AnchorPanic --single-branch --depth 1 https://github.com/PackageInstaller/DataTable.git
```

注意：

- 必须带 `--single-branch`，否则 Git 会把所有分支都拉下来，失去按游戏拆分的意义。
- 仓库使用 Git LFS，请先安装 [git-lfs](https://git-lfs.com)。克隆时只会下载该分支引用到的大文件。
- `MuvLuvGirlsGardenX` 包含 submodule，需要时在 clone 命令后加 `--recurse-submodules`。
- `full` 分支保留拆分前的全量 monorepo（包含所有游戏的历史），一般不需要克隆。

## 分支列表

| 分支 | 游戏 |
|---|---|
| `game/AetherGazer` | AetherGazer |
| `game/AlchemyStars` | AlchemyStars |
| `game/AnchorPanic` | AnchorPanic |
| `game/AngelicaAsterR` | AngelicaAsterR |
| `game/AzurLane` | AzurLane |
| `game/BlackBeacon` | BlackBeacon |
| `game/CounterSide` | CounterSide |
| `game/CuisineDimension` | CuisineDimension |
| `game/DengekiBunkoCROSSINGVOID` | DengekiBunkoCROSSINGVOID |
| `game/DotAbyss` | DotAbyss |
| `game/Echonox24⁄36` | Echonox24⁄36 |
| `game/Embers` | Embers |
| `game/ErrorGameReset` | ErrorGameReset |
| `game/EverSoul` | EverSoul |
| `game/FalloutTamira` | FalloutTamira |
| `game/FyorasSouls` | FyorasSouls |
| `game/GirlsCreationR` | GirlsCreationR |
| `game/GoddessOrder` | GoddessOrder |
| `game/IMYSR` | IMYSR |
| `game/KalpaOfUniverse` | KalpaOfUniverse |
| `game/LostSword` | LostSword |
| `game/MAkeDrama` | MAkeDrama |
| `game/ManasisRefranin` | ManasisRefranin |
| `game/MementoMori` | MementoMori |
| `game/MillenniumWarAigis` | MillenniumWarAigis |
| `game/MirrenStarLegends` | MirrenStarLegends |
| `game/ModelWarGirl` | ModelWarGirl |
| `game/MoeCove` | MoeCove |
| `game/MonmusuTDx` | MonmusuTDx |
| `game/MuvLuvGirlsGardenX` | MuvLuvGirlsGardenX |
| `game/OZRewrite` | OZRewrite |
| `game/OrphansOrder` | OrphansOrder |
| `game/OshiroProjectRE` | OshiroProjectRE |
| `game/OtogiFrontierR` | OtogiFrontierR |
| `game/PathToNowhere` | PathToNowhere |
| `game/ReverseBlue` | ReverseBlue |
| `game/RevivedWitch` | RevivedWitch |
| `game/RezoririX` | RezoririX |
| `game/RlyehShoujotaiX` | RlyehShoujotaiX |
| `game/SakunaHinuka` | SakunaHinuka |
| `game/SonOfShenyin` | SonOfShenyin |
| `game/SoulOfDragon` | SoulOfDragon |
| `game/SoulTide` | SoulTide |
| `game/SphereSeven` | SphereSeven |
| `game/StarResonance` | StarResonance |
| `game/StarSavior` | StarSavior |
| `game/StarseedAsniaTrigger` | StarseedAsniaTrigger |
| `game/TaimaninSquad` | TaimaninSquad |
| `game/Techcronossx` | Techcronossx |
| `game/TenkeiParadox` | TenkeiParadox |
| `game/TrickcalChibiGo` | TrickcalChibiGo |
| `game/TwinkleStarKnights` | TwinkleStarKnights |
| `game/WitchSpring` | WitchSpring |

## 更新数据

每个游戏的数据更新直接提交到对应的 `game/<游戏名>` 分支，`master` 只维护上面的索引。
