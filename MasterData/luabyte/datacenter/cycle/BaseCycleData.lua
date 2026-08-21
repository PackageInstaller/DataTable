local M = BaseClass("BaseCycleData")

function M:__init()
    self.m_cycleData = {
        TypeId = 0,
        Value = 0,
        Field0 = 0,
        Field1 = 0,
        Field2 = 0
    }
    self.m_cycleType = protocol.ECycleEvent.None
end

function M:UpdateData(eventData)
    self.m_cycleData.TypeId = eventData.TypeId
    self.m_cycleData.Value = eventData.Value
    self.m_cycleData.Field0 = eventData.Field0
    self.m_cycleData.Field1 = eventData.Field1
    self.m_cycleData.Field2 = eventData.Field2
end

-- CycleEventType
function M:GetCycleType()
    return self.m_cycleType
end

function M:GetValue()
    return self.m_cycleData.Value
end

function M:GetField0()
    return self.m_cycleData.Field0
end

function M:GetField1()
    return self.m_cycleData.Field1
end

function M:GetField2()
    return self.m_cycleData.Field2
end

return M
