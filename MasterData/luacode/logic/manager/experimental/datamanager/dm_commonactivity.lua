local DM_CommonActivity = class("DM_CommonActivity")
local CActiveMissionModReward = BeanManager.GetTableByName("mission.cactivemissionmodreward")

function DM_CommonActivity:Ctor()
  self._data = NekoData.Data.taskshopactivity
  self._data.actInfo = {}
  self._data.timer = {}
end

function DM_CommonActivity:Clear()
  for k, v in pairs(self._data.actInfo) do
    self:RemoveTimer(k)
  end
  self._data.actInfo = {}
end

function DM_CommonActivity:RemoveTimer(actId)
  local timerId = self._data.timer[actId]
  if timerId then
    GameTimer.RemoveTask(timerId)
    self._data.timer[actId] = nil
  end
end

function DM_CommonActivity:OnSTaskShopAct(protocol)
  self._data.actInfo = {}
  local actId = protocol.activityId
  self._data.actInfo[actId] = {}
  self._data.actInfo[actId].awardIdList = {}
  self._data.actInfo[actId].receivedList = {}
  for k, v in pairs(protocol.award) do
    table.insert(self._data.actInfo[actId].awardIdList, k)
    if v == 1 then
      self._data.actInfo[actId].receivedList[k] = true
    end
  end
  table.sort(self._data.actInfo[actId].awardIdList, function(a, b)
    local _a = CActiveMissionModReward:GetRecorder(a)
    local _b = CActiveMissionModReward:GetRecorder(b)
    return _a.needNum < _b.needNum
  end)
  self._data.actInfo[actId].leftTime = protocol.leftTime
  self:RemoveTimer(actId)
  if protocol.leftTime > 0 then
    self._data.timer[actId] = GameTimer.AddTask(math.ceil(protocol.leftTime / 1000), 0, function()
      self._data.actInfo[actId] = nil
      LuaNotificationCenter.PostNotification(Common.n_OnSTaskShopActRefresh, nil, "close")
    end)
  else
    self._data.actInfo[actId] = nil
    LuaNotificationCenter.PostNotification(Common.n_OnSTaskShopActRefresh, nil, "close")
  end
end

function DM_CommonActivity:OnSReceiveTaskShop(protocol)
  if table.contain(self._data.actInfo[protocol.activityId].awardIdList, protocol.rewardID) then
    if not self._data.actInfo[protocol.activityId].receivedList[protocol.rewardID] then
      self._data.actInfo[protocol.activityId].receivedList[protocol.rewardID] = true
    else
      LogErrorFormat("DM_CommonActivity", "Repeat pick up: ActivityID:%s,RewardID:%s", protocol.activityId, protocol.rewardID)
    end
  else
    LogErrorFormat("DM_CommonActivity", "non-existent activity data:%s", protocol.activityId)
  end
end

return DM_CommonActivity
