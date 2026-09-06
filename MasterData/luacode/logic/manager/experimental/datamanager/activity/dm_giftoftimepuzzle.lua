local CBPJigsaw = BeanManager.GetTableByName("activity.cbpjigsaw")
local CBPJigsawReward = BeanManager.GetTableByName("activity.cbpjigsawreward")
local DM_GiftOfTimePuzzle = class("DM_GiftOfTimePuzzle")
DM_GiftOfTimePuzzle.awardStatusEnum = {
  Lock = nil,
  UnlockButNotGet = 1,
  Get = 2
}
DM_GiftOfTimePuzzle.awardStatusUnlockList = {}
DM_GiftOfTimePuzzle.minCanUnlockCurrencyNumList = {}

function DM_GiftOfTimePuzzle:Ctor()
  self._data = NekoData.Data.activities.giftoftimepuzzle
  self:Clear()
  self:CreateStaticCustomDataStruct()
end

function DM_GiftOfTimePuzzle:Clear()
  self._data.rewardGroupID = 0
  self._data.leftTime = 0
  self._data.initialTime = 0
  if self._data.unlockedPuzzle == nil then
    self._data.unlockedPuzzle = {}
  else
    for key, _ in pairs(self._data.unlockedPuzzle) do
      self._data.unlockedPuzzle[key] = nil
    end
  end
  if self._data.awardStatus == nil then
    self._data.awardStatus = {}
  else
    for key, _ in pairs(self._data.awardStatus) do
      self._data.awardStatus[key] = nil
    end
  end
  self._data.minCanUnlockCurrencyNum = math.maxinteger
end

function DM_GiftOfTimePuzzle:CreateStaticCustomDataStruct()
  local allIds = CBPJigsawReward:GetAllIds()
  for _, id in ipairs(allIds) do
    local record = CBPJigsawReward:GetRecorder(id)
    DM_GiftOfTimePuzzle.awardStatusUnlockList[record.id] = {
      [1] = string.split(record.unlockJigsaw[1], ","),
      [2] = string.split(record.unlockJigsaw[2], ","),
      [3] = string.split(record.unlockJigsaw[3], ","),
      [4] = string.split(record.unlockJigsaw[4], ","),
      [5] = string.split(record.unlockJigsaw[5], ","),
      [6] = string.split(record.unlockJigsaw[6], ","),
      [7] = string.split(record.unlockJigsaw[7], ","),
      [8] = string.split(record.unlockJigsaw[8], ","),
      [9] = string.split(record.unlockJigsaw[9], ",")
    }
  end
  local allIds = CBPJigsaw:GetAllIds()
  for _, id in ipairs(allIds) do
    local record = CBPJigsaw:GetRecorder(id)
    DM_GiftOfTimePuzzle.minCanUnlockCurrencyNumList[record.id] = math.min(table.unpack(record.moneyNum))
  end
end

function DM_GiftOfTimePuzzle:OnSOpenBpPuzzle(protocol)
  self._data.rewardGroupID = protocol.Id
  self._data.leftTime = protocol.leftTime
  self._data.initialTime = ServerGameTimer.GetServerTimeForecast()
  if self._data.unlockedPuzzle == nil then
    self._data.unlockedPuzzle = {}
  else
    for key, _ in pairs(self._data.unlockedPuzzle) do
      self._data.unlockedPuzzle[key] = nil
    end
  end
  if self._data.awardStatus == nil then
    self._data.awardStatus = {}
  else
    for key, _ in pairs(self._data.awardStatus) do
      self._data.awardStatus[key] = nil
    end
  end
  for _, value in pairs(protocol.unlockedPuzzle) do
    self._data.unlockedPuzzle[value] = true
  end
  for _, value in pairs(protocol.receivedAward) do
    self._data.awardStatus[value] = DM_GiftOfTimePuzzle.awardStatusEnum.Get
  end
  self:RefreshCanGetAward()
end

function DM_GiftOfTimePuzzle:OnSUnlockBpPuzzle(protocol)
  if PrintTable then
    PrintTable(protocol, 3, "OnSUnlockBpPuzzle")
  end
  self._data.unlockedPuzzle[protocol.puzzleId] = true
  self:RefreshCanGetAward()
end

function DM_GiftOfTimePuzzle:OnSReceivedBpAward(protocol)
  if PrintTable then
    PrintTable(protocol, 3, "OnSReceivedBpAward")
  end
  self._data.awardStatus[protocol.awardId] = DM_GiftOfTimePuzzle.awardStatusEnum.Get
end

function DM_GiftOfTimePuzzle:RefreshCanGetAward()
  if DM_GiftOfTimePuzzle.awardStatusUnlockList[self._data.rewardGroupID] then
    for index, value in ipairs(DM_GiftOfTimePuzzle.awardStatusUnlockList[self._data.rewardGroupID]) do
      if not self._data.awardStatus[index] and table.all(value, function(_, v)
        return self._data.unlockedPuzzle[tonumber(v)]
      end) then
        self._data.awardStatus[index] = DM_GiftOfTimePuzzle.awardStatusEnum.UnlockButNotGet
      end
    end
  end
  if PrintTable then
    PrintTable(self._data.awardStatus, 3, "self._data.awardStatus")
  end
end

return DM_GiftOfTimePuzzle
