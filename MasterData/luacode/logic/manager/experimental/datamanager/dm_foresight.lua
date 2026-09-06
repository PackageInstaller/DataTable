local DM_Foresight = class("DM_Foresight")

function DM_Foresight:Ctor()
  self._data = NekoData.Data.foresight
  self:Clear()
end

function DM_Foresight:Clear()
  self._data.activityId = -1
  self._data.initialTime = 0
  self._data.curLeftTime = 0
  self._data.actLeftTime = 0
  self._data.unlockedDay = 0
  if self._data.receiveAward == nil then
    self._data.receiveAward = {}
  else
    for key, _ in pairs(self._data.receiveAward) do
      self._data.receiveAward[key] = nil
    end
  end
  self._data.foresightGoodInfo = {}
  self._data.haveRedDot = false
end

function DM_Foresight:OnSGeneralForesightAct(protocol)
  self._data.activityId = protocol.activityId
  self._data.initialTime = ServerGameTimer.GetServerTimeForecast()
  self._data.curLeftTime = protocol.curLeftTime
  self._data.actLeftTime = protocol.actLeftTime
  self._data.unlockedDay = protocol.unlockedTimes
  for _, value in pairs(protocol.receiveAward) do
    self._data.receiveAward[value] = true
  end
  self._data.foresightGoodInfo = protocol.foresightGoodInfo
end

return DM_Foresight
