local DM_ChristmasCall = class("DM_ChristmasCall")

function DM_ChristmasCall:Ctor()
  self._christmascall = NekoData.Data.activities.chrismascall
  self:Clear()
end

function DM_ChristmasCall:Clear()
  self._christmascall.isOpen = false
  self._christmascall.totalRemainTime = 0
  self._christmascall.startTime = 0
  self._christmascall.callRemainTime = 0
  if self._christmascall.rewardIds then
    for key, _ in pairs(self._christmascall.rewardIds) do
      self._christmascall.rewardIds[key] = nil
    end
  else
    self._christmascall.rewardIds = {}
  end
  self._christmascall.nowScore = 0
  self._christmascall.canCall = 0
  self._christmascall.globalScore = 0
  self._christmascall.settleState = 0
  self._christmascall.shopCanOpen = false
  self._christmascall.redDotList = {}
  self._christmascall.nowGainCallNum = -1
end

function DM_ChristmasCall:OnSOpenChristmasSupportActivity(protocol)
  self._christmascall.isOpen = protocol.state ~= 0
  self._christmascall.totalRemainTime = protocol.activityLeftTime
  self._christmascall.startTime = ServerGameTimer.GetServerTimeForecast()
  self._christmascall.callRemainTime = protocol.supportLeftTime
  for _, value in pairs(protocol.rewardIds) do
    self._christmascall.rewardIds[value] = true
  end
  self._christmascall.nowScore = protocol.score
  self._christmascall.canCall = protocol.canSupport == 1
end

function DM_ChristmasCall:OnSChristmasSupport(protocol)
  self._christmascall.nowScore = self._christmascall.nowScore + protocol.addScore
end

function DM_ChristmasCall:OnSReceiveSupportReward(protocol)
  self._christmascall.rewardIds[protocol.id] = true
end

function DM_ChristmasCall:OnSOpenTotalSupportScore(protocol)
  self._christmascall.globalScore = protocol.score
  for _, value in pairs(protocol.rewardIds) do
    self._christmascall.rewardIds[value] = true
  end
end

function DM_ChristmasCall:OnSSettleChristmasSupport(protocol)
  if protocol.state == 0 then
    self._christmascall.settleState = 0
  elseif protocol.settle == 0 then
    self._christmascall.settleState = 1
  else
    self._christmascall.settleState = 2
  end
end

function DM_ChristmasCall:OnSChristmasSupportShopState(protocol)
  self._christmascall.shopCanOpen = protocol.state == 1
end

function DM_ChristmasCall:OnSChristmasSupportRedpoint(protocol)
  for key, _ in pairs(self._christmascall.redDotList) do
    self._christmascall.redDotList[key] = nil
  end
  for _, value in pairs(protocol.state) do
    self._christmascall.redDotList[value] = true
  end
end

function DM_ChristmasCall:OnSCheckGainNumber(protocol)
  self._christmascall.nowGainCallNum = protocol.number
end

return DM_ChristmasCall
