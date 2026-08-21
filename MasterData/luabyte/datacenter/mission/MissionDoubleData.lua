local M = BaseClass("MissionDoubleData") -- 双倍奖励关卡数据

function M:__init()
    self:Reset()
end

function M:Reset()
    self.m_doubleDic = {}
    self.m_randomDic = {}
    self.m_actData = nil
    self.m_isDouble = false      -- 当前章节是否限时副本
    self.m_isTotalDouble = false -- 章节全关卡双倍
end

-- 首先传入数据
function M:SetDoubleActivity(data, cfg)
    self.m_actData = data
    self.m_isDouble = data ~= nil

    self.m_isTotalDouble = #cfg.includeMissionId == 0

    for _, missionId in ipairs(cfg.includeMissionId) do
        self.m_doubleDic[missionId] = true
    end
    for i, missionId in ipairs(cfg.rewardMissionId) do
        self.m_randomDic[missionId] = cfg.reward[i]
    end
end

function M:IsDouble()
    return self.m_isDouble
end

function M:IsTotalDouble()
    return self.m_isTotalDouble
end

function M:DoubleValue(keyName)
    return self.m_doubleDic[keyName]
end

function M:RandomValue(keyName)
    return self.m_randomDic[keyName]
end

function M:PassLimit()
    if not self.m_actData then return 0 end
    return self.m_actData:PassLimit()
end

function M:RemainTimes()
    if not self.m_actData then return 0 end
    return self.m_actData:RemainTimes()
end

function M:RemainEndTime()
    if not self.m_actData then return 0 end
    return self.m_actData:RemainEndTime()
end

function M:CheckDouble()
    if (self:RemainTimes() == 0) or (self:RemainEndTime() == 0) then
        self.m_isDouble = false
    end
end

return M
