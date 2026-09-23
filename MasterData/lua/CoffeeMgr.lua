local this = MgrRegister("CoffeeMgr")

function this:Init()
    self:Clear()
    local id = self:GetID()
    if (id) then
        OperateActiveProto:GetMaidCoffeeData(id)
    end
end

function this:Clear()
    self.cnt = 0 -- 已领取次数
    self.remainCnt = 0 -- 可领取次数
    self.maxScore = 0 -- 最高历史积分
end

-- 剩余奖励次数
function this:GetRemainCnt()
    return self.remainCnt
end

function this:GetCnt()
    return self.cnt
end

-- 当前活动天数
function this:GetDay()
    return self.cnt + self.remainCnt
end

function this:GetMaxScore()
    return self.maxScore or 0
end

-- 最大领取次数
function this:GetMaxCnt()
    return CfgCoffeeReward[#CfgCoffeeReward] or 0
end

function this:GetCurReward()
    local cnt = self.cnt
    if (self.remainCnt and self.remainCnt > 0) then
        cnt = cnt + 1
    end
    return cnt, self.remainCnt <= 0 -- 当前展示，当前是否已领
end

-- 当前id，id不存在时的刷新时间
function this:GetID()
    local id, refreshTime = nil, nil
    local curTime = TimeUtil:GetTime()
    local cfgs = Cfgs.CfgCoffeeMain:GetAll()
    for k, v in ipairs(cfgs) do
        local begTime = TimeUtil:GetTimeStampBySplit(v.begTime) or nil
        local endTime = TimeUtil:GetTimeStampBySplit(v.endTime) or nil
        if (curTime < begTime) then
            refreshTime = begTime
            break
        elseif (curTime < endTime) then
            id = k
            break
        end
    end
    return id, refreshTime
end

function this:GetCurCfg()
    local id, refreshTime = self:GetID()
    if (id) then
        return Cfgs.CfgCoffeeMain:GetByID(id)
    end
    return nil, refreshTime
end

function this:GetActivityTime()
    local mainCfg, refreshTime = self:GetCurCfg()
    if (mainCfg) then
        local begTime = mainCfg and TimeUtil:GetTimeStampBySplit(mainCfg.begTime) or nil
        local endTime = mainCfg and TimeUtil:GetTimeStampBySplit(mainCfg.endTime) or nil
        return begTime, endTime
    end
    return refreshTime, nil
end

function this:GetMaidCoffeeDataRet(proto)
    self.cnt = proto.cnt or 0
    self.remainCnt = proto.remainCnt or 0
    self.maxScore = proto.maxScore or 0
    self:CheckRed()
end

function this:GetMinRewardScore()
    local mainCfg = self:GetCurCfg()
    if (mainCfg) then
        return mainCfg.minRewardScore
    end
    return 0
end

function this:CheckRed()
    local cnt = self:GetRemainCnt() > 0 and self:GetRemainCnt() or nil
    RedPointMgr:UpdateData(RedPointType.Coffee, cnt)
end

function this:GetMissPoints()
    if (not self.missPoints) then
        local mainCfg = self:GetCurCfg()
        if (mainCfg) then
            self.missPoints = mainCfg.missPoints or 0
        end
    end
    return self.missPoints or 0
end

return this
