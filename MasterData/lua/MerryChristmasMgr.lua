local this = MgrRegister("MerryChristmasMgr")

function this:Init()
    self:Clear()
    OperateActiveProto:GetChristmasGiftData()
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
    return CfgChristReward[#CfgChristReward] or 0
end

function this:GetCurReward()
    local cnt = self.cnt
    if (self.remainCnt and self.remainCnt > 0) then
        cnt = cnt + 1
    end
    return cnt, self.remainCnt <= 0 -- 当前展示，当前是否已领
end

-- 当前id
function this:GetID()
    local id = nil
    local curTime = TimeUtil:GetTime()
    local cfgs = Cfgs.CfgChristMain:GetAll()
    for k, v in ipairs(cfgs) do
        local begTime = TimeUtil:GetTimeStampBySplit(v.begTime)
        local endTime = TimeUtil:GetTimeStampBySplit(v.endTime)
        if (curTime >= begTime and curTime < endTime) then
            return v.id
        end
    end
    return nil
end

function this:GetMainCfg()
    local id = self:GetID()
    if (id) then
        return Cfgs.CfgChristMain:GetByID(id)
    end
    return nil
end

function this:GetActivityTime()
    local mainCfg = self:GetMainCfg()
    if (mainCfg) then
        local begTime = TimeUtil:GetTimeStampBySplit(mainCfg.begTime)
        local endTime = TimeUtil:GetTimeStampBySplit(mainCfg.endTime)
        return begTime, endTime
    end
    return nil, nil
end

function this:GetChristmasGiftDataRet(proto)
    self.cnt = proto.cnt or 0
    self.remainCnt = proto.remainCnt or 0
    self.maxScore = proto.maxScore or 0
    self:CheckRed()
end

function this:GetMinRewardScore()
    local mainCfg = self:GetMainCfg()
    if (mainCfg) then
        return mainCfg.minRewardScore
    end
    return 0
end

function this:CheckRed()
    local cnt = self:GetRemainCnt() > 0 and self:GetRemainCnt() or nil
    RedPointMgr:UpdateData(RedPointType.MerryChristmas, cnt)
end

return this
