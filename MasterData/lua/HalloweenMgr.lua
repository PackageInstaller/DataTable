HalloweenMgr = MgrRegister("HalloweenMgr")
local this = HalloweenMgr;

function this:Init()
    self:Clear()
    OperateActiveProto:GetHalloweenGameData()
end

function this:Clear()
    self.rewardNum = 0
    self.cur = 0
    self.score = 0
end

function this:SetDatas(proto)
    if proto then
        self.cur = proto.remainCnt or 0
        self.rewardNum = proto.cnt or 0
        self.score = proto.maxScore or 0
    end
    EventMgr.Dispatch(EventType.Halloween_data_Update)
    self:CheckRedPointData()
end

function this:GetNum()
    return self.cur
end

--获取当前奖励
function this:GetRewardNum()
    return self.rewardNum
end

function this:GetScore()
    return self.score
end

--红点检测
function this:CheckRedPointData()
    RedPointMgr:UpdateData(RedPointType.Halloween, self.cur > 0 and 1 or nil)
end

return this