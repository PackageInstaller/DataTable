-- 每日体力领取
local baseClass = require("DataCenter.Cycle.BaseCycleData")
local EnergyData = BaseClass("EnergyData", baseClass)
local M = EnergyData
function M:__init()
    -- body
    self.m_cycleType = protocol.ECycleEvent.ECET_Daily_Gift
end

-- 获取最后领取时间
function M:GetLastGetTimer()
    -- body
    return self.m_cycleData.Value
end

function M:GetRewardValue()
    return self.m_cycleData.Field0
end

return EnergyData
