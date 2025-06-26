ItemType = {
    ReasureBox = 1, -- 箱子等
    Material = 2, -- 素材
    Invisible = 3, -- 不可见 不在背包中显示
}


ShowType = {
    Card = 1, 
    Equip = 2,
    Item = 3,
    Monster = 4, 
    FightSoul = 5, 
    -- Currency = 6, 
    CardSkin = 7, 
    Power = 8,
    Package = 9,
}

Rarity = {
    R = 1,
    SR = 2,
    SSR = 3
}

RarityName = {
    [Rarity.R] = "R",
    [Rarity.SR] = "SR",
    [Rarity.SSR] = "SSR"
}

RareConfig = {[0] = "N.png",[1] = "R.png",[2] = "SR.png",[3] = "SSR.png",[4] = "UR.png"}

--- 显示属性时, ipairs 遍历这个枚举( 否则遍历其他的表 不好控制属性显示顺序 )
---@type {type:number, IsPct:boolean}[]
PropertySort = {
    {
        type = NumericType.Hp,
    },
    {
        type = NumericType.MaxHpPct,
        IsPct = true,
    },
    {
        type = NumericType.Atk,
    },
    {
        type = NumericType.AtkPct,
        IsPct = true,
    },
    {
        type = NumericType.Def,
    },
    {
        type = NumericType.DefPct,
        IsPct = true,
    },
    {
        type = NumericType.MagicDef,
    },
    {
        type = NumericType.MagicDefPct,
        IsPct = true,
    },
    {
        type = NumericType.Speed,
    },
    {
        type = NumericType.SpeedPct,
        IsPct = true,
    },
    {
        type = NumericType.Cri,
        IsPct = true,
    },
    {
        type = NumericType.CriDamage,
        IsPct = true,
    },
    {
        type = NumericType.EAcc,
        IsPct = true,
    },
    {
        type = NumericType.ERist,
        IsPct = true,
    },
}

FightSoulScreenType = {
    isLevelUp = {
        None = 0, --- 不管
        LevelUp = 1, --- 已经升级
        NotLevelUp = 2, --- 未升级
    },

    isEquip = {
        None = 0,  --- 不管
        Equip = 1, --- 已经装备
        NotEquip = 2, --- 未装备
    },

    isMerge = {
        None = 0,  --- 不管
        Merge = 1, --- 已经升星
        NotMerge = 2, --- 未升星
    },
}


FormationOpenType = {
    Normal = 1,
    Battle = 2,
    Competition = 3,
    Bossraid = 4,
}

ChallengeType = {
    Dragon = 1,
    Gold = 2,
    Exp = 3
}

RECRUIT_COUNT = {
    ONE = 1,
    TEN = 11
}


EquipmentKind = {
    weapon = 1, --武器
    armor = 2, -- 防具
    decoration = 3, -- 饰品
}

StoreType = {
    Commmon = 1, --普通商店
    StarStone = 2, --星砂商店
    Arena = 3, --星皇（竞技场）商店
    Shard = 4, --魔晶商店
    Ticket = 5, --黄绿票商店
    StarDust = 6, --星尘商店
    Skin = 7, --皮肤商店
    Power = 8, --体力商店
    GiftPackage = 9, --非现金付费礼包商店
    Pass = 11, -- 通行证商店
    Bossraid = 12, -- 总力战商店
    GameEventLevel = 101,
}

RecordType = {
    Character = 1,
    FightSoul = 2,
    Equip = 3,
    Monster = 4,
    Story = 5,
    CG = 6,
    Bgm = 7,
}

UseItemType = {
    Shop = 1,
    Bag = 2,
    Power = 3,
    Item = 4,
}

ShowGirlUIType = {
    PosAndScale = 1,
    Character = 2,
    PlayerInfo = 3
}

ShowGirlShowType = {
    Original = 1,
    Customize = 2,
    Nochange = 3,
    Marry = 4
}

ShopCondition = {
    PlayerLevel = 1,
    BuyGoods = 2,
    BuyPaymentGoods = 3,
    PassLevel = 4,
    UnlockModel = 5,
    MonthlyCardLeftTimeOver = 6,
    MonthlyCardLeftTimeNotOver = 7,
    ItemCount =13,
}

LevelJumpType = {
    DetailView = 1,
    Preview =2
}

SkillType = {
    Attack = 1,
    Skill = 2,
    Ultimate = 3,
    PassiveSkill = 4
}

SkinUnlockType = {
    Original = 1,
    ThreeStar = 2,
    FiveStar = 3,
    Marry = 4,
    Shop = 5,
    Newbie = 6,
    BattlePass = 7
}

--- 只有一个助战单位, 所以设置默认值
SupportUnitIndex = 1

--- 竞技场编队 目前是默认队伍id
ArenaFormationIndex = 1

--- 竞技场默认关卡id
ArenaLevelId = 101



FirstGuideId = 1
BattleGuideId = 1001
BattleGuideEndStep = 24

--- c活动类型, 仅用于显示
GameEventType = {
    None = 0,
    Special = 1,
    Normal = 2,
    HomeBanner = 3,
    RechargePop= 4
}

GameEventTypeNameSysKey = {
    [GameEventType.Special] = 1324,
    [GameEventType.Normal] = 1325,
}

ClickTimeInterval = 0.3 -- 点击时间间隔( 切换列表等, 需要控制一下 不能点太快了, 防止出现加载问题 )