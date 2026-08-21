-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_giftoftimepuzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CBPJigsaw = (BeanManager.GetTableByName)("activity.cbpjigsaw")
local CBPJigsawReward = (BeanManager.GetTableByName)("activity.cbpjigsawreward")
local AwardStatusEnum = (require("logic.manager.experimental.datamanager.activity.dm_giftoftimepuzzle")).awardStatusEnum
local MinCanUnlockCurrencyNumList = (require("logic.manager.experimental.datamanager.activity.dm_giftoftimepuzzle")).minCanUnlockCurrencyNumList
local BM_GiftOfTimePuzzle = class("BM_GiftOfTimePuzzle")
BM_GiftOfTimePuzzle.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).giftoftimepuzzle
end

BM_GiftOfTimePuzzle.GetIsOpen = function(self)
  -- function num : 0_1
  do return self:GetRemainTime() > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_GiftOfTimePuzzle.GetRemainTime = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (self._data).leftTime - ((ServerGameTimer.GetServerTimeForecast)() - (self._data).initialTime)
end

BM_GiftOfTimePuzzle.GetRrewardGroupID = function(self)
  -- function num : 0_3
  return (self._data).rewardGroupID
end

BM_GiftOfTimePuzzle.GetUnlockedPuzzle = function(self)
  -- function num : 0_4
  return (self._data).unlockedPuzzle
end

BM_GiftOfTimePuzzle.GetAwardStatus = function(self)
  -- function num : 0_5
  return (self._data).awardStatus
end

BM_GiftOfTimePuzzle.HaveRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV, AwardStatusEnum, CBPJigsaw
  for _,value in pairs((self._data).awardStatus) do
    if value == AwardStatusEnum.UnlockButNotGet then
      return true
    end
  end
  local nowCurrency = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.WitchSeal)
  local record = CBPJigsaw:GetRecorder((self._data).rewardGroupID)
  if record then
    for index,value in ipairs(record.moneyNum) do
      if not ((self._data).unlockedPuzzle)[index] and value <= nowCurrency then
        return true
      end
    end
  end
  do
    return false
  end
end

BM_GiftOfTimePuzzle.ShowRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self:GetIsOpen() then
    return false
  end
  if not self:HaveRedDot() and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetIsOpen() then
    return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):HasTasksAward()
  end
end

BM_GiftOfTimePuzzle.GetRemainTimeStr = function(self, endTime)
  -- function num : 0_8 , upvalues : _ENV, CStringRes
  local str = nil
  if endTime and endTime > 0 then
    local time = endTime / 1000
    local day = time // 86400
    local hour = (math.ceil)(time / 3600)
    if day > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1935)).msgTextID, (string.format)("%d", day), (string.format)("%d", hour - day * 24))
    else
      str = (TextManager.GetText)((CStringRes:GetRecorder(1936)).msgTextID, hour)
    end
  else
    do
      str = (TextManager.GetText)((CStringRes:GetRecorder(1936)).msgTextID, 0)
      return str
    end
  end
end

BM_GiftOfTimePuzzle.GetAwardStatusEnum = function(self)
  -- function num : 0_9 , upvalues : AwardStatusEnum
  return AwardStatusEnum
end

BM_GiftOfTimePuzzle.GetCBPJigsawCfg = function(self)
  -- function num : 0_10 , upvalues : CBPJigsaw
  return CBPJigsaw
end

BM_GiftOfTimePuzzle.GetCBPJigsawRewardCfg = function(self)
  -- function num : 0_11 , upvalues : CBPJigsawReward
  return CBPJigsawReward
end

BM_GiftOfTimePuzzle.SendCUnlockBpPuzzle = function(self, puzzleId)
  -- function num : 0_12 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cunlockbppuzzle")
  if protocol then
    protocol.puzzleId = puzzleId
    protocol:Send()
  end
end

BM_GiftOfTimePuzzle.SendCReceivedBpAward = function(self, awardId)
  -- function num : 0_13 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivedbpaward")
  if protocol then
    protocol.awardId = awardId
    protocol:Send()
  end
end

return BM_GiftOfTimePuzzle

