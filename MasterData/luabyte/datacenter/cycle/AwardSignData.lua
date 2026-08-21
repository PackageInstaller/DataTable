-- 月签到数据
local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("AwardSignData", baseClass)

function M:__init()
    self.m_cycleType = protocol.ECycleEvent.ECET_Award_Sign
end

-- 已经签到的数量
function M:GetSignNum()
    return self.m_cycleData.Field0
end

-- 上次签到时间戳
function M:GetLastSignTimer()
    return self.m_cycleData.Field1
end

-- 今日是否签到
function M:IsSigned()
    local lastSignTimer = self.m_cycleData.Field1 -- 最后一次签到时间
    local nowTimer = TimeUtil.GetNowTimeStamp()
    return TimeUtil.IsOneDay(nowTimer - 18000, lastSignTimer - 18000)
end

return M
