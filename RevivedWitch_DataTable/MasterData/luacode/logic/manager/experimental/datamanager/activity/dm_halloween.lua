-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_halloween.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CHalloweenAward = (BeanManager.GetTableByName)("mission.challoweenaward")
local CHalloweenExtraAward = (BeanManager.GetTableByName)("mission.challoweenextraaward")
local CActivityJackpot = (BeanManager.GetTableByName)("item.cactivityjackpot")
local DM_Halloween = class("DM_Halloween")
DM_Halloween.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._halloween = ((NekoData.Data).activities).halloween
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).isOpen = false
end

DM_Halloween.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._halloween).isOpen = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).initialRemainTime = nil
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).startTime = nil
  if (self._halloween).gameTimerId then
    (ServerGameTimer.RemoveTask)((self._halloween).gameTimerId)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._halloween).gameTimerId = nil
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).isOpenTask = false
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).initialRemainTaskTime = nil
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).startTaskTime = nil
  if (self._halloween).gameTimerTaskId then
    (ServerGameTimer.RemoveTask)((self._halloween).gameTimerTaskId)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._halloween).gameTimerTaskId = nil
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).pumpkinReward = nil
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).pumpkinPieReward = nil
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).pumpkinPieRewardItemOnceNum = nil
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).pumpkinPieRewardItemTotalNum = nil
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).pumpkinExistsList = nil
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).pumpkinRefreshTime = nil
  if (self._halloween).pumpkinRefreshTimeTimer then
    (ServerGameTimer.RemoveTask)((self._halloween).pumpkinRefreshTimeTimer)
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._halloween).pumpkinRefreshTimeTimer = nil
  end
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._halloween).extraHalloweenAwardRecords = nil
  self._pumpkinPieRewardSortTable = nil
end

DM_Halloween.OnSOpenHalloweenInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  if (self._halloween).gameTimerId then
    (ServerGameTimer.RemoveTask)((self._halloween).gameTimerId)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._halloween).gameTimerId = nil
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).initialRemainTime = protocol.leftTime
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).startTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).gameTimerId = (ServerGameTimer.AddTask)((self._halloween).initialRemainTime / 1000, -1, function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (self._halloween).isOpen = false
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnHalloweenEnd, nil, nil)
  end
)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).isOpen = true
  if (self._halloween).gameTimerTaskId then
    (ServerGameTimer.RemoveTask)((self._halloween).gameTimerTaskId)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._halloween).gameTimerTaskId = nil
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).initialRemainTaskTime = protocol.taskLeftTime
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).startTaskTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).gameTimerTaskId = (ServerGameTimer.AddTask)((self._halloween).initialRemainTaskTime / 1000, -1, function()
    -- function num : 0_2_1 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (self._halloween).isOpenTask = false
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnHalloweenTaskEnd, nil, nil)
  end
)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).isOpenTask = true
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).pumpkinReward = protocol.pumpkinReward
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).pumpkinPieReward = protocol.pumpkinPieReward
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).pumpkinPieRewardItemOnceNum = protocol.itemOnceNum
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).pumpkinPieRewardItemTotalNum = protocol.itemRewardTotalNum
end

DM_Halloween.OnSRefreshHalloweenInfo = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  if protocol.pumpkinReward then
    for key,value in pairs(protocol.pumpkinReward) do
      -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

      ((self._halloween).pumpkinReward)[key] = value
    end
  end
  do
    if protocol.pumpkinPieReward then
      for key,value in pairs(protocol.pumpkinPieReward) do
        -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

        if ((self._halloween).pumpkinPieReward)[key] then
          ((self._halloween).pumpkinPieReward)[key] = value
        else
          LogErrorFormat("DM_Halloween", "Try to refresh no exists pumpkinPieReward id %d", key)
        end
      end
    end
  end
end

DM_Halloween.OnSRefreshPumpkin = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  LogInfoFormat("DM_Halloween", "SRefreshPumpkin: pumpkinExistsList %s; pumpkinRefreshTime %s", (table.concat)(protocol.pumpkins, ", "), protocol.refreshTime)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  if (self._halloween).pumpkinExistsList == nil then
    (self._halloween).pumpkinExistsList = {}
  end
  for key,_ in pairs((self._halloween).pumpkinExistsList) do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

    ((self._halloween).pumpkinExistsList)[key] = nil
  end
  for _,value in pairs(protocol.pumpkins) do
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

    ((self._halloween).pumpkinExistsList)[value] = true
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).pumpkinRefreshTime = protocol.refreshTime
  if (self._halloween).pumpkinRefreshTimeTimer then
    (ServerGameTimer.RemoveTask)((self._halloween).pumpkinRefreshTimeTimer)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._halloween).pumpkinRefreshTimeTimer = nil
  end
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._halloween).pumpkinRefreshTimeTimer = (ServerGameTimer.AddTask)((self._halloween).pumpkinRefreshTime / 1000, -1, function()
    -- function num : 0_4_0 , upvalues : _ENV
    local protocolSend = (LuaNetManager.CreateProtocol)("protocol.activity.crefreshpumpkin")
    if protocolSend then
      protocolSend:Send()
    end
  end
)
end

DM_Halloween.GetHalloweenAwardRecorder = function(self, needID)
  -- function num : 0_5 , upvalues : CHalloweenAward, CHalloweenExtraAward
  local allIDs1 = CHalloweenAward:GetAllIds()
  local maxIDRecord1 = CHalloweenAward:GetRecorder(allIDs1[#allIDs1])
  local allIDs2 = CHalloweenExtraAward:GetAllIds()
  if needID <= maxIDRecord1.id then
    return CHalloweenAward:GetRecorder(needID)
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  if (self._halloween).extraHalloweenAwardRecords == nil then
    (self._halloween).extraHalloweenAwardRecords = {}
  end
  if ((self._halloween).extraHalloweenAwardRecords)[needID] then
    return ((self._halloween).extraHalloweenAwardRecords)[needID]
  end
  if maxIDRecord1.id < needID then
    local excessID = needID - maxIDRecord1.id
    local i = 1
    local needExtraNum = maxIDRecord1.neednum
    while i <= excessID do
      for j = 1, #allIDs2 do
        local oriRecord = CHalloweenExtraAward:GetRecorder(j)
        needExtraNum = needExtraNum + oriRecord.neednum
        local record = {id = maxIDRecord1.id + i, neednum = needExtraNum, rewarditem = oriRecord.rewarditem, rewardquantity = oriRecord.rewardquantity}
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R14 in 'UnsetPending'

        ;
        ((self._halloween).extraHalloweenAwardRecords)[record.id] = record
        i = i + 1
      end
    end
  end
  do
    return ((self._halloween).extraHalloweenAwardRecords)[needID]
  end
end

DM_Halloween.GetPumpkinPieRewardSort = function(self, itemID)
  -- function num : 0_6 , upvalues : CActivityJackpot, _ENV
  if self._pumpkinPieRewardSortTable == nil then
    self._pumpkinPieRewardSortTable = {}
    local recorder = CActivityJackpot:GetRecorder(2)
    local interfaceItems = (string.split)(recorder.interfaceItems, ",")
    for key,value in ipairs(interfaceItems) do
      local trimVal = (string.trim)(value)
      local numVal = tonumber(trimVal)
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R11 in 'UnsetPending'

      if numVal then
        (self._pumpkinPieRewardSortTable)[numVal] = key
      end
    end
  end
  do
    return (self._pumpkinPieRewardSortTable)[itemID]
  end
end

return DM_Halloween

