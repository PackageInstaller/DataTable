local TaskConst = {}

ConfigHelper = require "Config.ConfigHelper"

local TaskType = {
    Menu = 0,
    Guide = 1,          -- 引导
    Daily = 2,          -- 日常
    Weekly = 3,         -- 周常
    Challenge = 4,      -- 挑战
    Achievement = 5,    -- 成就(例外)
    Expedition = 6,     -- 远征(例外)
    Dormitory = 7,      -- 宿舍入住
    Theater = 8,        -- 剧场接取
    Awake = 9,          -- 觉醒
    Aciton = 10         -- 动作解锁
}

local TaskJumpId =
{
    [1] = 81,          -- 引导
    [2] = 82,          -- 日常
    [3] = 83,         -- 周常
    [4] = 84,      -- 挑战
}

local Tab = {
    -- Main = {
    --     Index = TaskType.Main,
    --     labels = ConfigHelper.GetLocalString(276)
    -- },
    Daily = {
        Index = TaskType.Daily,
        labels = ConfigHelper.GetLocalString(277)
    },
    Weekly = {
        Index = TaskType.Weekly,
        labels = ConfigHelper.GetLocalString(278)
    },
    Challenge = {
        Index = TaskType.Challenge,
        labels = ConfigHelper.GetLocalString(279)
    },
    Achievement = {
        Index = TaskType.Achievement,
        labels = ConfigHelper.GetLocalString(280)
    }
}

local TaskState = {
    Doing = 0,           --任务未完成
    MissionComplete = 1, --任务完成但未领取奖励
    TaskComplete = 2,    --任务完成并已领取奖励
}

local BtnColor = {
    Red = {r = 255, g = 0, b = 0, a = 255},
    Yellow = {r = 255, g = 183, b = 0, a = 255},
    Green = {r = 87, g = 255, b = 0, a = 255}
}

local TaskColor = {
    White = {r = 255, g = 255, b = 255, a = 255},
    Blue = {r = 81, g = 130, b = 255, a = 255},
    Black = {r = 63, g = 63, b = 63, a = 255}
}

local AnimName = {
    Menu = "Menu",
    GuideBook = "GuideBook",
    DailyBook = "DailyBook",
    WeeklyBook = "WeeklyBook",
    ChallengeBook = "ChallengeBook",
    GuidePanel = "GuidePanel",
    DailyPanel = "DailyPanel",
    WeeklyPanel = "WeeklyPanel",
    ChallengePanel = "ChallengePanel",
    GuideOut = "GuideOut",
    DailyOut = "DailyOut",
    WeeklyOut = "WeeklyOut",
    ChallengeOut = "ChallengeOut"
}

local Opt = {
    DB_UPDATE = "DB_UPDATE",
    DB_ADD = "DB_ADD",
    DB_COMPLETE = "DB_COMPLETE"
}

local TaskUIState = {
    Lock = 0,
    Unlock = 1,
    Complete = 2,
    Lock_PreTaskNotComplete = 3,
    Lock_Level = 4
}

local EACTType = {
    EACT_Daily = "EACT_Daily",
    EACT_Weekly = "EACT_Weekly"
}

TaskConst.Tab = Tab
TaskConst.TaskType = TaskType
TaskConst.TaskState = TaskState
TaskConst.AnimName = AnimName
TaskConst.TaskColor = TaskColor
TaskConst.TaskUIState = TaskUIState
TaskConst.Opt = Opt
TaskConst.EACTType = EACTType
TaskConst.TaskJumpId = TaskJumpId
return TaskConst
