-- 遭遇战枚举
local EncountConst = {
    -- 遭遇战难度
    EEncountDifficult = {
        ESimple = 0, -- 简单
        EMedium = 1, -- 中等
        EDifficulty = 2 -- 困难
    },
    -- 遭遇战区域状态
    EEncountZoneState = {
        EFailPass = 0, -- 都没通关
        EFirstPass = 1, -- 第一关过
        ESecondPass = 2, -- 第二关过
        EAllPass = 3 -- 两关都过
    },
    EEncountTeamType = {
        ETeamNone = 0,
        ETeamA = 1,
        EteamB = 2,
    },
    --当前遭遇战获得奖励
    EEncountZoneBattleAward = {
        EFirstPassGain = 1 << 0 , --已获得A关奖励
        ESecondPassGain = 1 << 1 , --已获得B关奖励
        EFirstCanGain = 1 << 8 , -- 可领取A
        ESecondCanGain = 2 << 9 , -- 可领B
    }
}

return EncountConst
