local CStringRes = BeanManager.GetTableByName("message.cstringres")
local MazeAwardBlockDef = LuaNetManager.GetBeanDef("protocol.activity.mazeawardblock")
local CBPLabyrinthStartRewardCfg = BeanManager.GetTableByName("activity.cbplabyrinthstartreward")
local BM_GiftOfTimeMaze = class("BM_GiftOfTimeMaze")

function BM_GiftOfTimeMaze:Ctor()
  self._data = NekoData.Data.activities.giftoftimemaze
end

function BM_GiftOfTimeMaze:GetIsOpen()
  return self:GetRemainTime() > 0
end

function BM_GiftOfTimeMaze:GetRemainTime()
  return self._data.leftTime - (ServerGameTimer.GetServerTimeForecast() - self._data.initialTime)
end

function BM_GiftOfTimeMaze:GetCurrentPos()
  return self._data.currentPos
end

function BM_GiftOfTimeMaze:GetCards()
  return self._data.cards
end

function BM_GiftOfTimeMaze:GetBlocks()
  return self._data.blocks
end

function BM_GiftOfTimeMaze:HaveRedDot()
  return NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.TimeDice) >= 1
end

function BM_GiftOfTimeMaze:ShowRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return not self:HaveRedDot() and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetIsOpen() and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):HasTasksAward()
end

function BM_GiftOfTimeMaze:GetRemainTimeStr(endTime)
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

function BM_GiftOfTimeMaze:GetCBPLabyrinthStartRewardCfg()
  return CBPLabyrinthStartRewardCfg:GetRecorder(1)
end

function BM_GiftOfTimeMaze:GetMazeAwardBlockDef()
  return MazeAwardBlockDef
end

function BM_GiftOfTimeMaze:SendCChooseMazeCard(card)
  self._data.oldCTime = self._data.nowCTime
  self._data.nowCTime = ServerGameTimer.GetServerTimeForecast()
  if self._data.nowCTime - self._data.oldCTime > 1000 then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cchoosemazecard")
    if protocol then
      protocol.card = card
      protocol:Send()
    end
  else
    LogError("BM_GiftOfTimeMaze:SendCChooseMazeCard", "time interval too short: " .. tostring(self._data.oldCTime) .. "|" .. tostring(self._data.nowCTime))
  end
end

return BM_GiftOfTimeMaze
