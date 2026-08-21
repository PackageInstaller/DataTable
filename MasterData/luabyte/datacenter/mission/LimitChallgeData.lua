local M = BaseClass("LimitChallgeData")

function M:__init(protoData)
    if protoData.Result ~= 0 then 
        return
    end
    self.m_missions = {}
    for _, protoMission in ipairs(protoData.Missions) do
        -- body
        table.insert( self.m_missions,require("DataCenter.Mission.LimitMissionData").New(protoMission))
    end
    self.m_tasks = {}
    for _, protoMission in ipairs(protoData.Tasks) do
        -- body
        table.insert(self.m_tasks,require("DataCenter.Mission.LimitTaskData").New(protoMission))
    end
    self.m_totalStars = protoData.TotalStars
    self.m_skills = {}
    for _, protoMission in ipairs(protoData.Skills.Groups) do
        -- body
        table.insert(self.m_skills,require("DataCenter.Mission.LimitSkillData").New(protoMission))
    end
    self.m_skillResetTimes = protoData.Skills.ResetTimes
    self.m_newSeason = protoData.NewSeason
    self.m_resetTick = protoData.ResetTick
    self.m_season = protoData.Season
end

function M:GetMissions()
    return self.m_missions
end

function M:GetTasks()
    return self.m_tasks
end

function M:ResetBattleMission(protoData)
    self.m_missions = {}
    for _, protoMission in ipairs(protoData.Missions) do
        -- body
        table.insert( self.m_missions,require("DataCenter.Mission.LimitMissionData").New(protoMission))
    end
    self.m_skills = {}
    for _, protoMission in ipairs(protoData.Skills.Groups) do
        -- body
        table.insert(self.m_skills,require("DataCenter.Mission.LimitSkillData").New(protoMission))
    end
    self.m_skillResetTimes = protoData.Skills.ResetTimes
    self.m_resetTick = protoData.ResetTick
end

function M:UpdateTask(taskId,state)
    for _, task in ipairs(self.m_tasks) do
        -- 全部领
        if taskId == 0 and task:GetState() == 1 then 
            task:SetState(state)
        end
        if taskId ~= 0 and task:GetId() == taskId then 
            task:SetState(state)
        end
    end
end

--获得当前赛季的星
function M:GetTotalSeasonStars()
    return self.m_totalStars
end

--获得当局的星
function M:GetTotalGameStars()
    local total = 0 
    for _, mission in ipairs(self.m_missions) do
        total = total + mission:GetStar()
    end
    return total
end


function M:GetLimitSkills()
    return self.m_skills 
end

--是否有极限技红点
function M:HasRedPointAboutLimitSkills()
    for _, value in ipairs(self.m_skills) do
        -- body
        if value:CanSelectMore() then 
            return true
        end
    end
    return false
end

--极限任务 是否有红点 type 为任务类型
function M:HasRedPointAboutLimitTask(type)
    for _, task in ipairs(self.m_tasks) do
        if type == 0 and task:GetState() == 1 then 
            return true
        end
        if type == task:GetType() and task:GetState() == 1 then 
            return true
        end
    end
    return false
end

function M:SetLimitSkill(groupIdx,skillIds)
    for idx, skillData in ipairs(self.m_skills) do
        -- body
        if idx == groupIdx then 
            skillData:SetSelectIds(skillIds)
        end
    end
end

function M:GetSkillResetTimes()
    return self.m_skillResetTimes
end

function M:SetSkillResetTimes(times)
    self.m_skillResetTimes = times
    for idx, skillData in ipairs(self.m_skills) do
        skillData:SetSelectIds({})
    end
end

--是否为新赛季
function M:GetNewSeason()
    return self.m_newSeason
end

--重置的时间戳
function M:GetResetTick()
    return self.m_resetTick
end

--获取当前赛季
function M:GetSeason()
    return self.m_season
end

return M