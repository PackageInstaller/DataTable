local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("AtmosphereData", baseClass)

function M:__init()
    -- body
    self.m_cycleType = protocol.ECycleEvent.ECET_AtmosphereCount
end

function M:GetAtmosphereCount()
    -- body
    return self.m_cycleData.Value
end

return M
