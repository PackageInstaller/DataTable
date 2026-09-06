local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CBPJigsaw = BeanManager.GetTableByName("activity.cbpjigsaw")
local CBPJigsawReward = BeanManager.GetTableByName("activity.cbpjigsawreward")
local AwardStatusEnum = require("logic.manager.experimental.datamanager.activity.dm_giftoftimepuzzle").awardStatusEnum
local MinCanUnlockCurrencyNumList = require("logic.manager.experimental.datamanager.activity.dm_giftoftimepuzzle").minCanUnlockCurrencyNumList
local BM_GiftOfTimePuzzle = class("BM_GiftOfTimePuzzle")

function BM_GiftOfTimePuzzle:Ctor()
  self._data = NekoData.Data.activities.giftoftimepuzzle
end

function BM_GiftOfTimePuzzle:GetIsOpen()
  return self:GetRemainTime() > 0
end

function BM_GiftOfTimePuzzle:GetRemainTime()
  return self._data.leftTime - (ServerGameTimer.GetServerTimeForecast() - self._data.initialTime)
end

function BM_GiftOfTimePuzzle:GetRrewardGroupID()
  return self._data.rewardGroupID
end

function BM_GiftOfTimePuzzle:GetUnlockedPuzzle()
  return self._data.unlockedPuzzle
end

function BM_GiftOfTimePuzzle:GetAwardStatus()
  return self._data.awardStatus
end

function BM_GiftOfTimePuzzle:HaveRedDot()
  for _, value in pairs(self._data.awardStatus) do
    if value == AwardStatusEnum.UnlockButNotGet then
      return true
    end
  end
  local nowCurrency = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.WitchSeal)
  local record = CBPJigsaw:GetRecorder(self._data.rewardGroupID)
  if record then
    for index, value in ipairs(record.moneyNum) do
      if not self._data.unlockedPuzzle[index] and value <= nowCurrency then
        return true
      end
    end
  end
  return false
end

function BM_GiftOfTimePuzzle:ShowRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return not self:HaveRedDot() and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetIsOpen() and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):HasTasksAward()
end

function BM_GiftOfTimePuzzle:GetRemainTimeStr(endTime)
  local str
  if endTime and 0 < endTime then
    local time = endTime / 1000
    local day = time // 86400
    local hour = math.ceil(time / 3600)
    if 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(1935).msgTextID, string.format("%d", day), string.format("%d", hour - day * 24))
    else
      str = TextManager.GetText(CStringRes:GetRecorder(1936).msgTextID, hour)
    end
  else
    str = TextManager.GetText(CStringRes:GetRecorder(1936).msgTextID, 0)
  end
  return str
end

function BM_GiftOfTimePuzzle:GetAwardStatusEnum()
  return AwardStatusEnum
end

function BM_GiftOfTimePuzzle:GetCBPJigsawCfg()
  return CBPJigsaw
end

function BM_GiftOfTimePuzzle:GetCBPJigsawRewardCfg()
  return CBPJigsawReward
end

function BM_GiftOfTimePuzzle:SendCUnlockBpPuzzle(puzzleId)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cunlockbppuzzle")
  if protocol then
    protocol.puzzleId = puzzleId
    protocol:Send()
  end
end

function BM_GiftOfTimePuzzle:SendCReceivedBpAward(awardId)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceivedbpaward")
  if protocol then
    protocol.awardId = awardId
    protocol:Send()
  end
end

return BM_GiftOfTimePuzzle
