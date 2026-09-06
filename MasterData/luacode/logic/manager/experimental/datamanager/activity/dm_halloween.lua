local CHalloweenAward = BeanManager.GetTableByName("mission.challoweenaward")
local CHalloweenExtraAward = BeanManager.GetTableByName("mission.challoweenextraaward")
local CActivityJackpot = BeanManager.GetTableByName("item.cactivityjackpot")
local DM_Halloween = class("DM_Halloween")

function DM_Halloween:Ctor()
  self._halloween = NekoData.Data.activities.halloween
  self._halloween.isOpen = false
end

function DM_Halloween:Clear()
  self._halloween.isOpen = false
  self._halloween.initialRemainTime = nil
  self._halloween.startTime = nil
  if self._halloween.gameTimerId then
    ServerGameTimer.RemoveTask(self._halloween.gameTimerId)
    self._halloween.gameTimerId = nil
  end
  self._halloween.isOpenTask = false
  self._halloween.initialRemainTaskTime = nil
  self._halloween.startTaskTime = nil
  if self._halloween.gameTimerTaskId then
    ServerGameTimer.RemoveTask(self._halloween.gameTimerTaskId)
    self._halloween.gameTimerTaskId = nil
  end
  self._halloween.pumpkinReward = nil
  self._halloween.pumpkinPieReward = nil
  self._halloween.pumpkinPieRewardItemOnceNum = nil
  self._halloween.pumpkinPieRewardItemTotalNum = nil
  self._halloween.pumpkinExistsList = nil
  self._halloween.pumpkinRefreshTime = nil
  if self._halloween.pumpkinRefreshTimeTimer then
    ServerGameTimer.RemoveTask(self._halloween.pumpkinRefreshTimeTimer)
    self._halloween.pumpkinRefreshTimeTimer = nil
  end
  self._halloween.extraHalloweenAwardRecords = nil
  self._pumpkinPieRewardSortTable = nil
end

function DM_Halloween:OnSOpenHalloweenInfo(protocol)
  if self._halloween.gameTimerId then
    ServerGameTimer.RemoveTask(self._halloween.gameTimerId)
    self._halloween.gameTimerId = nil
  end
  self._halloween.initialRemainTime = protocol.leftTime
  self._halloween.startTime = ServerGameTimer.GetServerTimeForecast()
  self._halloween.gameTimerId = ServerGameTimer.AddTask(self._halloween.initialRemainTime / 1000, -1, function()
    self._halloween.isOpen = false
    LuaNotificationCenter.PostNotification(Common.n_OnHalloweenEnd, nil, nil)
  end)
  self._halloween.isOpen = true
  if self._halloween.gameTimerTaskId then
    ServerGameTimer.RemoveTask(self._halloween.gameTimerTaskId)
    self._halloween.gameTimerTaskId = nil
  end
  self._halloween.initialRemainTaskTime = protocol.taskLeftTime
  self._halloween.startTaskTime = ServerGameTimer.GetServerTimeForecast()
  self._halloween.gameTimerTaskId = ServerGameTimer.AddTask(self._halloween.initialRemainTaskTime / 1000, -1, function()
    self._halloween.isOpenTask = false
    LuaNotificationCenter.PostNotification(Common.n_OnHalloweenTaskEnd, nil, nil)
  end)
  self._halloween.isOpenTask = true
  self._halloween.pumpkinReward = protocol.pumpkinReward
  self._halloween.pumpkinPieReward = protocol.pumpkinPieReward
  self._halloween.pumpkinPieRewardItemOnceNum = protocol.itemOnceNum
  self._halloween.pumpkinPieRewardItemTotalNum = protocol.itemRewardTotalNum
end

function DM_Halloween:OnSRefreshHalloweenInfo(protocol)
  if protocol.pumpkinReward then
    for key, value in pairs(protocol.pumpkinReward) do
      self._halloween.pumpkinReward[key] = value
    end
  end
  if protocol.pumpkinPieReward then
    for key, value in pairs(protocol.pumpkinPieReward) do
      if self._halloween.pumpkinPieReward[key] then
        self._halloween.pumpkinPieReward[key] = value
      else
        LogErrorFormat("DM_Halloween", "Try to refresh no exists pumpkinPieReward id %d", key)
      end
    end
  end
end

function DM_Halloween:OnSRefreshPumpkin(protocol)
  LogInfoFormat("DM_Halloween", "SRefreshPumpkin: pumpkinExistsList %s; pumpkinRefreshTime %s", table.concat(protocol.pumpkins, ", "), protocol.refreshTime)
  if self._halloween.pumpkinExistsList == nil then
    self._halloween.pumpkinExistsList = {}
  end
  for key, _ in pairs(self._halloween.pumpkinExistsList) do
    self._halloween.pumpkinExistsList[key] = nil
  end
  for _, value in pairs(protocol.pumpkins) do
    self._halloween.pumpkinExistsList[value] = true
  end
  self._halloween.pumpkinRefreshTime = protocol.refreshTime
  if self._halloween.pumpkinRefreshTimeTimer then
    ServerGameTimer.RemoveTask(self._halloween.pumpkinRefreshTimeTimer)
    self._halloween.pumpkinRefreshTimeTimer = nil
  end
  self._halloween.pumpkinRefreshTimeTimer = ServerGameTimer.AddTask(self._halloween.pumpkinRefreshTime / 1000, -1, function()
    local protocolSend = LuaNetManager.CreateProtocol("protocol.activity.crefreshpumpkin")
    if protocolSend then
      protocolSend:Send()
    end
  end)
end

function DM_Halloween:GetHalloweenAwardRecorder(needID)
  local allIDs1 = CHalloweenAward:GetAllIds()
  local maxIDRecord1 = CHalloweenAward:GetRecorder(allIDs1[#allIDs1])
  local allIDs2 = CHalloweenExtraAward:GetAllIds()
  if needID <= maxIDRecord1.id then
    return CHalloweenAward:GetRecorder(needID)
  end
  if self._halloween.extraHalloweenAwardRecords == nil then
    self._halloween.extraHalloweenAwardRecords = {}
  end
  if self._halloween.extraHalloweenAwardRecords[needID] then
    return self._halloween.extraHalloweenAwardRecords[needID]
  end
  if needID > maxIDRecord1.id then
    local excessID = needID - maxIDRecord1.id
    local i = 1
    local needExtraNum = maxIDRecord1.neednum
    while excessID >= i do
      for j = 1, #allIDs2 do
        local oriRecord = CHalloweenExtraAward:GetRecorder(j)
        needExtraNum = needExtraNum + oriRecord.neednum
        local record = {
          id = maxIDRecord1.id + i,
          neednum = needExtraNum,
          rewarditem = oriRecord.rewarditem,
          rewardquantity = oriRecord.rewardquantity
        }
        self._halloween.extraHalloweenAwardRecords[record.id] = record
        i = i + 1
      end
    end
  end
  return self._halloween.extraHalloweenAwardRecords[needID]
end

function DM_Halloween:GetPumpkinPieRewardSort(itemID)
  if self._pumpkinPieRewardSortTable == nil then
    self._pumpkinPieRewardSortTable = {}
    local recorder = CActivityJackpot:GetRecorder(2)
    local interfaceItems = string.split(recorder.interfaceItems, ",")
    for key, value in ipairs(interfaceItems) do
      local trimVal = string.trim(value)
      local numVal = tonumber(trimVal)
      if numVal then
        self._pumpkinPieRewardSortTable[numVal] = key
      end
    end
  end
  return self._pumpkinPieRewardSortTable[itemID]
end

return DM_Halloween
