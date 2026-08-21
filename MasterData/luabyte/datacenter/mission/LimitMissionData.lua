local M = BaseClass("LimitMissionData")

function M:__init(protoData)
    self.m_missionId = protoData.MissionId
    self.m_conditionWords = protoData.Conditions
    self.m_selectedConditionsWords = protoData.SelectedConditions
    self.m_star = protoData.Stars
end

function M:GetMissionId()
    return self.m_missionId
end

function M:GetConditionWords()
    return self.m_conditionWords
end

function M:GetSelectConditionWords()
    return self.m_selectedConditionsWords
end

function M:GetStar()
    return self.m_star
end

return M