-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_giftoftimepuzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBPJigsaw = (BeanManager.GetTableByName)("activity.cbpjigsaw")
local CBPJigsawReward = (BeanManager.GetTableByName)("activity.cbpjigsawreward")
local DM_GiftOfTimePuzzle = class("DM_GiftOfTimePuzzle")
DM_GiftOfTimePuzzle.awardStatusEnum = {Lock = nil, UnlockButNotGet = 1, Get = 2}
DM_GiftOfTimePuzzle.awardStatusUnlockList = {}
DM_GiftOfTimePuzzle.minCanUnlockCurrencyNumList = {}
DM_GiftOfTimePuzzle.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).giftoftimepuzzle
  self:Clear()
  self:CreateStaticCustomDataStruct()
end

DM_GiftOfTimePuzzle.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).rewardGroupID = 0
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftTime = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).initialTime = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if (self._data).unlockedPuzzle == nil then
    (self._data).unlockedPuzzle = {}
  else
    for key,_ in pairs((self._data).unlockedPuzzle) do
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

      ((self._data).unlockedPuzzle)[key] = nil
    end
  end
  do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    if (self._data).awardStatus == nil then
      (self._data).awardStatus = {}
    else
      for key,_ in pairs((self._data).awardStatus) do
        -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

        ((self._data).awardStatus)[key] = nil
      end
    end
    do
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._data).minCanUnlockCurrencyNum = math.maxinteger
    end
  end
end

DM_GiftOfTimePuzzle.CreateStaticCustomDataStruct = function(self)
  -- function num : 0_2 , upvalues : CBPJigsawReward, _ENV, DM_GiftOfTimePuzzle, CBPJigsaw
  local allIds = CBPJigsawReward:GetAllIds()
  for _,id in ipairs(allIds) do
    local record = CBPJigsawReward:GetRecorder(id)
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (DM_GiftOfTimePuzzle.awardStatusUnlockList)[record.id] = {[1] = (string.split)((record.unlockJigsaw)[1], ","), [2] = (string.split)((record.unlockJigsaw)[2], ","), [3] = (string.split)((record.unlockJigsaw)[3], ","), [4] = (string.split)((record.unlockJigsaw)[4], ","), [5] = (string.split)((record.unlockJigsaw)[5], ","), [6] = (string.split)((record.unlockJigsaw)[6], ","), [7] = (string.split)((record.unlockJigsaw)[7], ","), [8] = (string.split)((record.unlockJigsaw)[8], ","), [9] = (string.split)((record.unlockJigsaw)[9], ",")}
  end
  local allIds = CBPJigsaw:GetAllIds()
  for _,id in ipairs(allIds) do
    local record = CBPJigsaw:GetRecorder(id)
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (DM_GiftOfTimePuzzle.minCanUnlockCurrencyNumList)[record.id] = (math.min)((table.unpack)(record.moneyNum))
  end
end

DM_GiftOfTimePuzzle.OnSOpenBpPuzzle = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, DM_GiftOfTimePuzzle
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).rewardGroupID = protocol.Id
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).leftTime = protocol.leftTime
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).initialTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  if (self._data).unlockedPuzzle == nil then
    (self._data).unlockedPuzzle = {}
  else
    for key,_ in pairs((self._data).unlockedPuzzle) do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

      ((self._data).unlockedPuzzle)[key] = nil
    end
  end
  do
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

    if (self._data).awardStatus == nil then
      (self._data).awardStatus = {}
    else
      for key,_ in pairs((self._data).awardStatus) do
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'

        ((self._data).awardStatus)[key] = nil
      end
    end
    do
      for _,value in pairs(protocol.unlockedPuzzle) do
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

        ((self._data).unlockedPuzzle)[value] = true
      end
      for _,value in pairs(protocol.receivedAward) do
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

        ((self._data).awardStatus)[value] = (DM_GiftOfTimePuzzle.awardStatusEnum).Get
      end
      self:RefreshCanGetAward()
    end
  end
end

DM_GiftOfTimePuzzle.OnSUnlockBpPuzzle = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  if PrintTable then
    PrintTable(protocol, 3, "OnSUnlockBpPuzzle")
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).unlockedPuzzle)[protocol.puzzleId] = true
  self:RefreshCanGetAward()
end

DM_GiftOfTimePuzzle.OnSReceivedBpAward = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, DM_GiftOfTimePuzzle
  if PrintTable then
    PrintTable(protocol, 3, "OnSReceivedBpAward")
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).awardStatus)[protocol.awardId] = (DM_GiftOfTimePuzzle.awardStatusEnum).Get
end

DM_GiftOfTimePuzzle.RefreshCanGetAward = function(self)
  -- function num : 0_6 , upvalues : DM_GiftOfTimePuzzle, _ENV
  if (DM_GiftOfTimePuzzle.awardStatusUnlockList)[(self._data).rewardGroupID] then
    for index,value in ipairs((DM_GiftOfTimePuzzle.awardStatusUnlockList)[(self._data).rewardGroupID]) do
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

      if not ((self._data).awardStatus)[index] and (table.all)(value, function(_, v)
    -- function num : 0_6_0 , upvalues : self, _ENV
    return ((self._data).unlockedPuzzle)[tonumber(v)]
  end
) then
        ((self._data).awardStatus)[index] = (DM_GiftOfTimePuzzle.awardStatusEnum).UnlockButNotGet
      end
    end
  end
  do
    if PrintTable then
      PrintTable((self._data).awardStatus, 3, "self._data.awardStatus")
    end
  end
end

return DM_GiftOfTimePuzzle

