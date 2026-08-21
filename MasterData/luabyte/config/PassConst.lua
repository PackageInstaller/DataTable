local PassConst = {}

local State = {
    Free = 0,
    Paid = 1
}

local RewardType = {
    None = 0, -- 都已领取
    Free = 1,
    Paid = 2,
    All = 3 -- 免费+付费奖励
}

local TaskState = {
    Doing = 0, --任务未完成
    MissionComplete = 1, --任务完成但未领取奖励
    TaskComplete = 2, --任务完成并已领取奖励
}

--通行证类型
local ShopPackType = {
    Normal = 1, -- 普通礼包
    Higher = 2, -- 高级礼包
    NormalReduced = 3,  --普通折扣
    HigherReduced = 4,  --高级折扣
    UpNormal = 5,   --普通升级
    UpHigher = 6,   --折扣升级
}

local PassTaskType = {
    Daily = 1, -- 日常任务
    Weekly = 2, -- 周常任务
    Current = 3 -- 本期任务
}

local RewardShowNum = 7

PassConst.State = State
PassConst.RewardType = RewardType
PassConst.TaskState = TaskState
PassConst.ShopPackType = ShopPackType
PassConst.PassTaskType = PassTaskType
PassConst.RewardShowNum = RewardShowNum

return PassConst
