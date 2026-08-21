local M = BaseClass("DayEnergyRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local ECycleEvent = protocol.ECycleEvent
local sSplit = string.split
local ONEHOUR = 3600
local ONEMINUTE = 60

function M:Check()
    local EnergyData = CycleDataMgr:GetInstance():GetCycleDataByType(ECycleEvent.ECET_Daily_Gift)
    local lastTimer = EnergyData:GetLastGetTimer()
    local rewardValue = EnergyData:GetRewardValue()
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local isOneDay = TimeUtil.IsOneDay(lastTimer - 5 * ONEMINUTE, nowTimer - 5 * ONEMINUTE)
    rewardValue = isOneDay and rewardValue or 0
    self.activityenergys = ConfigHelper.GetCfgs("activityenergy")
    local nowS = TimeUtil.GetSecondIndexInDay()
    local tempActivityenergys = {}
    local index = 1
    for _, activityenergy in pairs(self.activityenergys) do
        local timerStar = self:GetTimeS(activityenergy.startTime)
        local timerEnd = self:GetTimeS(activityenergy.endTime)
        if timerStar <= nowS and timerEnd >= nowS then
            local isReward = self:IsReward(rewardValue, activityenergy.id)
            if not isReward then
                tempActivityenergys[index] = activityenergy
                index = index + 1
            end
        end
    end
    self.checkResult = #tempActivityenergys > 0 and 1 or 0
end

function M:IsReward(rewardValue, id)
    return 1 << id & rewardValue > 0
end

function M:GetTimeS(timer)
    local tabTimer = sSplit(timer, ":")
    local s = tonumber(tabTimer[1]) * ONEHOUR + tonumber(tabTimer[2]) * ONEMINUTE
    return s
end

return M
