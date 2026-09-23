local this = MgrRegister("PhysicalRewardMgr")

function this:Init()
    self:Clear()
end

function this:Clear()
    self.nums = {} -- 当前剩余
    self.reward = nil -- 准备弹
end

function this:PhysicalRewardInfoRet(proto)
    self.nums = proto.nums
end

function this:GetNums()
    return self.nums
end

function this:GetID()
    local id = nil
    local alData = ActivityMgr:GetALData(ActivityListType.PhysicalReward)
    if (alData and alData:IsOpen()) then
        id = alData:GetInfo().id
    end
    return id
end

-- 主项 
function this:GetMainCfg()
    local id = self:GetID()
    if (id) then
        local mainCfg = Cfgs.cfgPhysicalReward:GetByID(id)
        local endTime = TimeUtil:GetTimeStampBySplit(mainCfg.endTime)
        local begTime = TimeUtil:GetTimeStampBySplit(mainCfg.beginTime)
        return mainCfg, endTime, begTime
    end
    return nil
end

-- 子项(要在时间内)
function this:GetChildCfg()
    local mainCfg = self:GetMainCfg()
    if (mainCfg) then
        local curTime = TimeUtil:GetTime()
        for k, v in ipairs(mainCfg.infos) do
            local begTime = TimeUtil:GetTimeStampBySplit(v.bTime)
            local endTime = TimeUtil:GetTimeStampBySplit(v.eTime)
            if (curTime >= begTime and curTime < endTime) then
                return v, endTime
            end
        end
    end
    return nil
end

function this:GetActivityTime()
    local alData = ActivityMgr:GetALData(ActivityListType.PhysicalReward)
    if (alData) then
        local begTime = alData:GetStartTime()
        local endTime = alData:GetEndTime()
        return begTime, endTime
    end
    return nil, nil
end

-- 该卡池是否参与活动
function this:CheckCardPoolIsShow(poolID)
    local mainCfg, endTime, beginTime = self:GetMainCfg()
    if (mainCfg) then
        for k, v in ipairs(mainCfg.rewardPoolId) do
            if (v == poolID) then
                return beginTime, endTime
            end
        end
    end
    return nil
end

-- 通知
function this:NoticePhysicalReward(proto)
    if (proto) then
        self.reward = proto
    end
end

-- 检测实物奖励弹窗
function this:CheckShowReward()
    local reward = self.reward
    self.reward = nil
    if (reward) then
        CSAPI.OpenView("PhysicalRewardShow", reward)
    end
end

return this
