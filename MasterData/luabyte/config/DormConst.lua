local DormConst = {}
ConfigHelper = require "Config.ConfigHelper"
local FurnitureType = {
    Bed = 1, --床
    Console = 2, --桌子
    MainSofa = 3, --主沙发
    MinorSofa = 4, --副沙发
    EndTable = 5, --茶几
    SpecialFurniture = 6, --特殊家具
    Shower = 7, --浴室
    DefaultStandPoint = 8, --默认站立点
    AccessoryFurniture = 9, --附属家具
    Closet = 10, --衣柜
    Wall = 11, --墙
    Ground = 12, --地面
    BookCase = 13, --书柜
    PhotoWall = 14, --照片墙
    PosterWall = 15, --海报墙
    GroupPhotoWall = 16, --合影墙
    Shelf = 19, --展示柜
    NightTable = 20, --床头柜
}

local HeroType = {}
HeroType.All = 0
HeroType.Tank = 1 --坦克
HeroType.Shot = 2 --射手
HeroType.Warrior = 3 --战士
HeroType.Master = 4 --法师
HeroType.Summon = 5 --召唤
HeroType.Cure = 6 --治疗

local PlantType = {}
PlantType.Small = 0
PlantType.Big = 1
PlantType.Complete = 2
PlantType.Water = 3
PlantType.Reward = 4
PlantType.Fall = 5

local DressUpType = {}
DressUpType.Console = { type = 2, text = 894 }
DressUpType.MainSofa = { type = 3, text = 890 }
DressUpType.MinorSofa = { type = 4, text = 891 }
DressUpType.EndTable = { type = 5, text = 892 }
DressUpType.AccessoryFurniture = { type = 9, text = 893 }

local ActionType = {}
ActionType.SofaClickAction = 1
ActionType.SofaAutoAction = 2
ActionType.PhotoWallClickAction = 3
ActionType.PhotoWallAutoAction = 4
ActionType.ConsoleClickAction = 5
ActionType.ConsoleAutoAction = 6
ActionType.BookCaseClickAction = 7
ActionType.BookCaseAutoAction = 8
ActionType.BedClickAction = 9
ActionType.BedAutoAction = 10
ActionType.OnBedClickAction = 11
ActionType.OnBedAutoAction = 12
ActionType.PosterWallClickAction = 13
ActionType.PosterWallAutoAction = 14
ActionType.MainClickAction = 15
ActionType.MainAutoAction = 16

local RoleState = {}
RoleState.None = 0
RoleState.Gift = 1
RoleState.DressUp = 2
RoleState.Command = 3
RoleState.Interact = 4
RoleState.Favor = 5
RoleState.Story = 6

local EmojiType = {}
EmojiType.Amazed = 165
EmojiType.Angry = 166
EmojiType.Worry = 167
EmojiType.Happy = 168
EmojiType.Sad = 169
EmojiType.Doubt = 170

local EventType = {}
EventType.None = 0
EventType.LevelDo = 1 --等级小剧场未接取任务
EventType.LevelDoing = 2 --等级小剧场已接取任务

local StoryType = {}
StoryType.roomStory = 1 --好感度等级剧场
StoryType.StageStory = 2 --好感度阶段剧场
StoryType.TheatTaskStory = 3 --小剧场任务剧情
StoryType.TheatRewardStory = 4 --小剧场领奖剧情
StoryType.SpecialEventStory = 5 --特殊表演剧情
StoryType.TheatTaskWithoutStory = 6 --小剧场任务无剧情
StoryType.InteractStory = 7 --互动表演剧情
StoryType.SpecialEventTalkStory = 8 --特殊剧情对话剧情
StoryType.PresentReturnStory = 9 --回礼剧情
StoryType.InteractRewardStory = 10 --互动表演奖励剧情
StoryType.PresentFixedStory = 11 --固定时段触发剧情2
StoryType.TheatRewardWithoutStory = 12 --小剧场领奖无剧情
StoryType.ActivityStory = 13 --活动剧情
StoryType.ActivityRewardStory = 14 --活动领奖无剧情
StoryType.ActivityRewardWithoutStory = 15 --活动领奖剧情

local SpecialEventUIType = {}
SpecialEventUIType.Normal = 1 --普通模式
SpecialEventUIType.Single = 2 --单独模式

local SpecialEventExpressiveType = {}
SpecialEventExpressiveType.Timeline = 1 --timeline模式
SpecialEventExpressiveType.Story = 2 --剧情模式
SpecialEventExpressiveType.Action = 3 --行为模式

local FurnitureName = {}
FurnitureName.Sofa = "Sofa"
FurnitureName.Console = "Console"
FurnitureName.Bed = "Bed"
FurnitureName.Photowall = "Photowall"
FurnitureName.Bookcase = "Bookcase"
FurnitureName.Main = "Main"
FurnitureName.Photowall3 = "Photowall3"

local RandomClickType = {}
RandomClickType.Story = 1
RandomClickType.Action = 2
RandomClickType.Timeline = 3
RandomClickType.RewardStory = 4
RandomClickType.RepetitionAction = 5

local RolePointType = {}
RolePointType.NavMesh1 = 0
RolePointType.NavMesh2 = 1
RolePointType.Player1 = 2
RolePointType.Player2 = 3
RolePointType.Player3 = 4

local SkipType = {}
SkipType.None = 0
SkipType.Gift = 1

local TimelineParms = {}
TimelineParms.Sofa = { type = 1, furniture = "Sofa", watchPoint = "SofaEaseInOut" }
TimelineParms.Console = { type = 2, furniture = "Console", watchPoint = "Console" }
TimelineParms.Bed = { type = 3, furniture = "Bed", watchPoint = "Bed" }
TimelineParms.Main = { type = 4, furniture = "Main", watchPoint = "Main" }

local DormArea = {}
DormArea.MainArea = { type = 4, areaName = "Main", text = 5438, tables = { 1, 2 } }
DormArea.SofaArea = { type = 1, areaName = "Sofa", text = 5435, tables = { 1, 2 } }
DormArea.BedArea = { type = 2, areaName = "Bed", text = 5436, tables = { 1, 2 } }
DormArea.ConsoleArea = { type = 3, areaName = "Console", text = 5437, tables = { 1, 2 } }
DormArea.ShelfArea = { type = 6, areaName = "Shelf", text = 5894, tables = { 1 } }
DormArea.PhotowallArea = { type = 7, areaName = "Photowall", text = 5441, tables = { 1 } }
DormArea.Photowall2Area = { type = 8, areaName = "Photowall2", text = 5442, tables = { 1 } }
DormArea.Photowall3Area = { type = 9, areaName = "Photowall3", text = 5443, tables = { 1 } }

local DressupTableType = {}
DressupTableType.AccessoryFurniture = 1 --附属家具
DressupTableType.ParentFurniture = 2 --父家具

local DressUpOperationType = {}
DressUpOperationType.None = 0
DressUpOperationType.SelectAccessoryFurniture = 1 --选择附属家具
DressUpOperationType.SelectSlot = 2 --选择附属家具槽位
DressUpOperationType.SelectParentFurniture = 3 --选择父家具
DressUpOperationType.SelectParentSlot = 4 --选择父家具槽位

local DormRouletteType = {}
DormRouletteType.Greet = 1
DormRouletteType.Gift = 2
DormRouletteType.DressUp = 3
DormRouletteType.Main = 4
DormRouletteType.ChangeRoom = 5

local SpecialEventTriggerType = {}
SpecialEventTriggerType.Click = 1
SpecialEventTriggerType.EnterDorm = 2

local RoleActionType = {}
RoleActionType.Enter = 0
RoleActionType.Stay = 1
RoleActionType.Exit = 2
RoleActionType.Show = 3
RoleActionType.ShortShow = 4
RoleActionType.Timeline = 5

DormConst.ActionType = ActionType
DormConst.DressUpType = DressUpType
DormConst.PlantType = PlantType
DormConst.HeroType = HeroType
DormConst.FurnitureType = FurnitureType
DormConst.RoleState = RoleState
DormConst.EmojiType = EmojiType
DormConst.EventType = EventType
DormConst.StoryType = StoryType
DormConst.SpecialEventUIType = SpecialEventUIType
DormConst.SpecialEventExpressiveType = SpecialEventExpressiveType
DormConst.DormArea = DormArea
DormConst.FurnitureName = FurnitureName
DormConst.RandomClickType = RandomClickType
DormConst.RolePointType = RolePointType
DormConst.SkipType = SkipType
DormConst.TimelineParms = TimelineParms
DormConst.DressupTableType = DressupTableType
DormConst.DressUpOperationType = DressUpOperationType
DormConst.DormRouletteType = DormRouletteType
DormConst.SpecialEventTriggerType = SpecialEventTriggerType
DormConst.RoleActionType = RoleActionType

return DormConst
