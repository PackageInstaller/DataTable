local baseClass = require("DataCenter.Cycle.BaseCycleData")
local M = BaseClass("OnlineRewardData", baseClass)

local ResetOnlineTime = CS.GameX.Battle.Event.ResetOnlineTime

function M:__init()
    self.m_isSet = false
    self.m_cycleType = protocol.ECycleEvent.ECET_Award_Online
end

function M:GetTimeStamp()
    -- body
    return self.m_cycleData.Value
end

function M:GetID()
    -- body
    return self.m_cycleData.Field0
end

function M:GetIndex()
    -- body
    return self.m_cycleData.Field1
end

function M:GetCumulusTime()
    -- body
    return self.m_cycleData.Field2
end

function M:UpdateData(eventData)
    M.super.UpdateData(self, eventData)
    local time = self:GetCumulusTime()
    if time == 0 and self.m_isSet then
        -- TimeUtil.SetLastOnlineTime(time)
        IGameEventMgr:SendEventByLua(ResetOnlineTime())
        self.m_isSet = false
    end

    if not self.m_isSet then
        -- TimeUtil.SetLastOnlineTime(time)
        self.m_isSet = true
    end
end

return M
