local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("ActivityDailyElite", baseClass)

function M:__init()
    self.m_cycleData.Field1 = GameHelper.GetParamter(116)
    self.m_cycleType = protocol.ECycleEvent.ECET_Daily_Elite
end

-- 精英副本当前挑战次数
function M:GetPassTimes()
    -- body
    return self.m_cycleData.Field0
end

-- 精英副本最大挑战次数
function M:GetMaxPassTimes()
    -- body
    return self.m_cycleData.Field1
end

return M
