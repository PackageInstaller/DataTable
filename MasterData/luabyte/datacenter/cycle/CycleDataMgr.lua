local M = BaseClass("CycleDataMgr", Singleton)
local MessageId = Proto.MessageId

function M:__init()
    self:_InitData()
    self:_InitEvent()
end

function M:_InitData()
    self.m_cycleDataDic = {}
    local path = "DataCenter.Cycle."
    self:_AddCustomCycleData(require(path .. "AwardSignData").New())
    -- self:_AddCustomCycleData(require(path .. "GuideStateData").New())
    self:_AddCustomCycleData(require(path .. "AtmosphereData").New())
    self:_AddCustomCycleData(require(path .. "FastCollectData").New())
    self:_AddCustomCycleData(require(path .. "OnlineRewardData").New())
    self:_AddCustomCycleData(require(path .. "ActivityDailyData").New())
    self:_AddCustomCycleData(require(path .. "ActivityWeeklyData").New())
    self:_AddCustomCycleData(require(path .. "ActivityDailyElite").New())
    self:_AddCustomCycleData(require(path .. "HeroSpecialDailyData").New())
    self:_AddCustomCycleData(require(path .. "RoleMaskData").New())
    self:_AddCustomCycleData(require(path .. "EnergyData").New())
end

function M:_InitEvent()
    local roleMsgId = MessageId.NotifyRoleCycleEvent
    local roleHandler = Bind(self, self.OnNotifyRoleCycleEvent)
    self.m_rsRoleCycle = NetPack:RegistResponse(roleMsgId, roleHandler)
    local loadMsgId = MessageId.ResponseLoadCycleEvent
    local loadHandler = Bind(self, self.OnResponseLoadCycleEvent)
    self.m_rsLoadCycle = NetPack:RegistResponse(loadMsgId, loadHandler)
    local updateMsgId = MessageId.NotifyUpdateCycleEvent
    local updateHandler = Bind(self, self.OnNotifyUpdateCycleEvent)
    self.m_rsUpdateCycle = NetPack:RegistResponse(updateMsgId, updateHandler)
end

function M:Cleanup()
end

function M:Dispose()
    local roleMsgId = MessageId.NotifyRoleCycleEvent
    NetPack:UnRegistResponse(roleMsgId, self.m_rsRoleCycle)
    local loadMsgId = MessageId.ResponseLoadCycleEvent
    NetPack:UnRegistResponse(loadMsgId, self.m_rsLoadCycle)
    local updateMsgId = MessageId.NotifyUpdateCycleEvent
    NetPack:UnRegistResponse(updateMsgId, self.m_rsUpdateCycle)
end

function M:OnNotifyRoleCycleEvent(_, result, msg)
    if result ~= 0 then
        return
    end
    for _, value in ipairs(msg.data or {}) do
        self:_UpdateCycleData(value)
    end
end

function M:OnNotifyUpdateCycleEvent(_, result, msg)
    if result ~= 0 then
        return
    end
    self:_UpdateCycleData(msg.Event)
end

function M:OnResponseLoadCycleEvent(_, result, msg)
    if result ~= 0 then
        return
    end
    for _, value in ipairs(msg.Data or {}) do
        self:_UpdateCycleData(value)
    end
end

-- 获取CycleData对象
function M:GetCycleDataByType(cycleType)
    return self.m_cycleDataDic[cycleType]
end

function M:_UpdateCycleData(cycleData)
    local data = self.m_cycleDataDic[cycleData.TypeId]
    if data then
        data:UpdateData(cycleData)
    end
end

function M:_AddCustomCycleData(data)
    local cycleType = data:GetCycleType()
    self.m_cycleDataDic[cycleType] = data
end

return M
