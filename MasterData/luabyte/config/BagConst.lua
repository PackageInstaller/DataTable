local BagConst = {}

local TabType = {}
TabType.ITEM = 1
TabType.NURTURE = 2
TabType.Nameplate = 3
TabType.FOODS = 4
TabType.PLOT = 5
TabType.FURNITURE = 6
TabType.CHIPS = 7
TabType.FAVOR = 8

local Tab = {
    -- 道具页签 type=1/5/8/13/19
    ITEM = {
        Index = TabType.ITEM,
        types = { 1, 5, 8, 13, 19, 20 },
        labels = 419,
        labelsEn = 5299,
    },
    -- 养成材料 type=2/4
    NURTURE = {
        Index = TabType.NURTURE,
        types = { 2, 4 },
        labels = 4201,
        labelsEn = 4201,
    },
    -- 铭牌 type=9
    Nameplate = {
        Index = TabType.Nameplate,
        types = { 9 },
        labels = 421,
        labelsEn = 5301,
    },
    -- 食材相关 type=14/15/16
    FOODS = {
        Index = TabType.FOODS,
        types = { 14, 15, 16 },
        labels = 4202,
        labelsEn = 4202,
    },
    -- 剧情道具 type=18
    PLOT = {
        Index = TabType.PLOT,
        types = { 18 },
        labels = 4203,
        labelsEn = 4203,
    },
    -- 家具道具 type=10/17
    FURNITURE = {
        Index = TabType.FURNITURE,
        types = { 10, 17 },
        labels = 4204,
        labelsEn = 4204,
    },
    -- 战员碎片 type=11
    CHIPS = {
        Index = TabType.CHIPS,
        types = { 11 },
        labels = 4205,
        labelsEn = 4205,
    },
    -- 好感度道具   type=12
    FAVOR = {
        Index = TabType.FAVOR,
        types = { 12 },
        labels = 4206,
        labelsEn = 4206,
    }
}

-- 剧情道具子类型
local ItemPlotType = {}
ItemPlotType.MAIN = { { 1801 }, 4304 }
ItemPlotType.MASK = { { 1802 }, 4305 }
ItemPlotType.BRANCH = { { 1803 }, 6295 }


local ItemEffectType = {}
ItemEffectType.None = 0
ItemEffectType.ItemGroup = 1       --获得包裹
ItemEffectType.RestaurantMenu = 2  --餐厅菜单
ItemEffectType.Weapon = 3          --获得武器
ItemEffectType.Hero = 4            --获得英雄
ItemEffectType.Feeling = 5         --好感度
ItemEffectType.WeaponExp = 6       --武器升级经验
ItemEffectType.Frag = 7            --碎片合成
ItemEffectType.Combine = 8         --直接合成
ItemEffectType.OnlineItem = 9      --在线奖励
ItemEffectType.FreeChooseItem = 10 --自选道具
ItemEffectType.FreeChooseHero = 11 --自选英雄
ItemEffectType.Exchange = 12       --兑换功能
ItemEffectType.Expire = 13         --过期道具
ItemEffectType.AddEnergy = 14      --增加体力
ItemEffectType.ChangeNick = 15     --修改昵称
ItemEffectType.UniqueItem = 16     --道具转换
ItemEffectType.MonthCard = 17      --获得月卡
ItemEffectType.Passport = 18       --获得通行证
ItemEffectType.BookStory = 19      --解锁剧情

local ItemType = {}
ItemType.EIT_Currency = 1           -- 资产类（进背包）
ItemType.EIT_Normal = 2             -- 普通道具（进背包）
ItemType.EIT_Hero = 3               -- 英雄
ItemType.EIT_Equip = 4              -- 装备
ItemType.EIT_Fitting = 5            -- 配件
ItemType.EIT_Weapon = 6             -- 超级武器
ItemType.EIT_Fashion = 7            -- 时装
ItemType.EIT_Chest = 8              -- 宝箱
ItemType.EIT_Token = 9              -- 英雄信物
ItemType.EIT_Furniture = 10         -- 家具
ItemType.EIT_Fragment = 11          -- 碎片
ItemType.EIT_Gift = 12              -- 礼物(好感度道具)
ItemType.EIT_LimitItem = 13         -- 限时道具
ItemType.EIT_ingredients = 14       -- 食材
ItemType.EIT_Food = 15              -- 菜品
ItemType.EIT_Menu = 16              -- 菜谱
ItemType.EIT_FurnitureMaterial = 17 -- 家具合成材料
ItemType.EIT_Show = 18              -- 剧情类道具
ItemType.EIT_EnergyItem = 19        -- 永久体力道具
ItemType.EIT_Energy = 20            -- 体力
ItemType.EIT_Head = 21              -- 头像
ItemType.EIT_OnlyOne = 22           -- 道具唯一，多余的自动转换为指定数量的其它道具

local ItemSubType = {}
ItemSubType.EIST_None = 0                 -- 0 无功能
ItemSubType.EIST_FavorReward = 1201       -- 1201 好感度奖励类型
ItemSubType.EIST_FavorStoryReward = 1202  -- 1202 好感度剧情奖励类型
ItemSubType.EIST_NormalEnergyItem = 1901  -- 1901 永久体力药水
ItemSubType.EIST_LimitEnergyItem = 1902   -- 1902 限时体力药水
ItemSubType.EIST_DynamicEnergyItem = 1903 -- 1903 动态失效体力药水
ItemSubType.EIST_NormalStoryItem = 1801   -- 1801 主线剧情奖励道具
ItemSubType.EIST_DormStoryItem = 1802

local CommonType = {}
CommonType.E_Noraml_Item = "E_Noraml_Item" --0道具，
CommonType.E_Hero = "E_Hero"               -- 1英雄，

BagConst.filters = { 2, 25, 26, 28 }
BagConst.Tab = Tab
BagConst.TabType = TabType
BagConst.ItemType = ItemType
BagConst.CommonType = CommonType
BagConst.ItemSubType = ItemSubType
BagConst.ItemPlotType = ItemPlotType
BagConst.ItemEffectType = ItemEffectType
return BagConst
