local EnumConst = {
    -- 当前阶段状态
    StageState = {
        NotOpen = 1, -- 未开启
        Doing = 2,   -- 进行中
        Over = 3     -- 结束
    },
    -- 票选各个阶段
    VotingTimer = {
        Timer1 = 1, -- 海选时间
        Timer2 = 2, -- 海选时间展示时间
        Timer3 = 3, -- 八强时间
        Timer4 = 4, -- 八强展示时间
        Timer5 = 5, -- 双王时间
        Timer6 = 6  -- 双王展示时间
    },
    -- 显示界面的风格
    TeamConfigStyle = {
        Battle = 0, -- 从战斗来的
        Main = 1    -- 从主界面来的
    },
    -- 英雄品质
    EQuality = {
        N = 1,
        R = 2,
        SR = 3,
        SSR = 4
    },
    --C#枚举
    EAttributeType = {
        EAT_MaxHP = 1,     --最大生命值 1
        EAT_Damage = 2,    --攻击力 2
        EAT_DamageDef = 3, --物理防御 3
        EAT_MagicDef = 4,  --魔法防御 4
        EAT_MaxArmor = 5,  --最大护盾 5
        EAT_Idle = 6,
        EAT_Block = 7,
        EAT_Summon = 8,
    },
    --阿拉伯数字图片地址
    NumPicPath = "UI/SpritePics/common/RomanNum/ui_sidecabin_number_0",
    EMaskType = {
        Light = 0,
        Dark = 1,
    },
    --餐桌状态
    ETableState = {
        Use = 1,      --使用中
        None = 2,     --可以使用
        Lock = 3,     --未解锁状态
        Cleaning = 4, --清理中
    },
    EActivityState = {
        Doing = 0,     --任务进行中
        Finished = 1,  -- 任务完成
        Completed = 2, -- 任务完成并领奖
    },
    --养成头像红点类型
    HeroRedPointType = {
        RoleAction = 1,    --看板娘
        DevelopMain = 2,   --养成主界面
        DevelopToggle = 3, --养成其他页签
        DevelopData = 4    --养成资料页签
    },
    SkillOpenId = {
        --技能开放条件对应的 functionOpen Id
        [1] = 52, -- N技能解锁
        [2] = 53, -- R技能解锁
        [3] = 54, -- SR技能解锁
        [4] = 55, -- SSR技能解锁
    },
    AwakeOpenId = {
        --跃迁开放条件对应的 functionOpen Id
        [3] = 56, -- SR跃迁解锁
        [4] = 57, -- SSR跃迁解锁
    },
    GeneOpenId = {
        --跃迁开放条件对应的 functionOpen Id
        [1] = 58, -- SR基因解锁
        [2] = 59, -- SSR基因解锁
        [3] = 60, -- SR基因解锁
        [4] = 61, -- SSR基因解锁
    },
    EActivityId = {
        LevelFund = -4,    -- 成长基金
        DayEnergy = -3,    -- 每日体力领取
        MonthSign = -2,    -- 月签到
        FirstRecharge = -1 -- 首充
    },
    EInteractActionBehaviorType = {
        Enter_Develop = 9,   -- 养成界面入场
        Develop_StandBy = 2, -- 养成界面待机
    }
}

local TimeMode = {
    GameNormal = 1,     -- 游戏正常速度
    BattleDouble = 2,   -- 战斗双倍速度
    BattleSingle = 3,   -- 战斗单倍速度
    BattleLowSpeed = 4, -- 战斗低倍速度
    BattlePause = 5,    -- 战斗暂停
    Custom = 6          -- 自定义模式
}

local ModuleNotify = {
    Login = 1,
    Main = 2,
    MainScene = 3,
    TrainingHero = 4,
    -- CreateRole = 5,
    GameEnter = 6,
    Mission = 7,
    Battle = 8,
    Challenge = 9,
    Stage = 10
}

local CmdType = {
    None = 0,
    AddItem = 1,
    Recharge = 2,
    AddHeroFavor = 3,
    UnlockHeroStory = 4,
    MonthCard = 5,
    GiftPack = 6,
    UnlockPaidPass = 7
}

local EBattleStyle = {
    Normal = 0,   --常规
    Elite = 1,    --精英
    Resource = 2, --资源
    Encount = 3,  --遭遇战
    Personal = 4, --个人副本
    Reward = 5,   --悬赏模式
    Boss = 6,     --Boss战
    Activity = 7 , --活动副本
    LimitChallge = 8 -- 极限挑战
}

-- 关卡阵容类型
local ETeamType = {
    ETT_Player = 0, -- 0 玩家阵容
    ETT_System = 1, -- 1 系统整容
    ETT_Mix = 2,    -- 2 混合阵容
}

local UnlockState = {
    Unlock = 1,
    Lock = 2
}

local NotesWorkType = {
    NONE = 0,
    ItemJump = 1
}

-- 关卡结束后跳转类型
local PostmissionJumpType = {
    None = 0,
    Jump = 1,
    Url = 2
}

-- 剧情图鉴类型
local StoryBookType = {
    Main = 1,     -- 主线剧情
    Activity = 2, -- 活动剧情
    Personal = 3, -- 个人剧情
    Dorm = 4      -- 宿舍剧情
}

-- 战中任务枚举
local EBattleTaskType =
{
    None = 0,
    PassMissionHasHero = 75,                    --使用指定战员0通关1关卡
    PassMissionHasHeroPersonnNumber = 76,       --编队少于0人携带战员1通关2关卡
    PassMissionHasHeroWithoutProfessional = 77, --编队内不带0职业并携带1通关2关卡
    PassMissionUseBattleLevel = 78,             --指定战员0通关1关卡 战中使用2技能
    HeroKillEmNumber = 79,                      --使用指定战员0击杀1个敌人
    HeroKillTargetEm = 80,                      --使用指定战员0击杀指定的敌人1
    HeroKillEmNumberByBattleLevel = 81,         --战员0使用1战中升级击杀2敌人
    HeroKillTargetEmByBattleLevel = 82          --战员0使用1技能击杀指定2敌人
}

EnumConst.CmdType = CmdType
EnumConst.TimeMode = TimeMode
EnumConst.ETeamType = ETeamType
EnumConst.UnlockState = UnlockState
EnumConst.ModuleNotify = ModuleNotify
EnumConst.EBattleStyle = EBattleStyle
EnumConst.NotesWorkType = NotesWorkType
EnumConst.StoryBookType = StoryBookType
EnumConst.PostmissionJumpType = PostmissionJumpType
EnumConst.EBattleTaskType = EBattleTaskType

return EnumConst
