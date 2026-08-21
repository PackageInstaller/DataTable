local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("RoleMaskData", baseClass)

function M:__init()
    self.m_cycleType = protocol.ECycleEvent.ECET_ROLE_MASK
end

function M:IsExistMask(index)
    if index < 32 then
        return ((1 << index) & self.m_cycleData.Field0) ~= 0
    end
    if index < 64 then
        return ((1 << index) & self.m_cycleData.Field1) ~= 0
    end
    if index < 96 then
        return ((1 << index) & self.m_cycleData.Field2) ~= 0
    end
    return false
end

return M
