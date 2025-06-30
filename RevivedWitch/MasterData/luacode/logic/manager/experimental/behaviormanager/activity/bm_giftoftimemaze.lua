-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_giftoftimemaze.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local MazeAwardBlockDef = (LuaNetManager.GetBeanDef)("protocol.activity.mazeawardblock")
local CBPLabyrinthStartRewardCfg = (BeanManager.GetTableByName)("activity.cbplabyrinthstartreward")
local BM_GiftOfTimeMaze = class("BM_GiftOfTimeMaze")
BM_GiftOfTimeMaze.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).giftoftimemaze
end

BM_GiftOfTimeMaze.GetIsOpen = function(self)
  -- function num : 0_1
  do return self:GetRemainTime() > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_GiftOfTimeMaze.GetRemainTime = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (self._data).leftTime - ((ServerGameTimer.GetServerTimeForecast)() - (self._data).initialTime)
end

BM_GiftOfTimeMaze.GetCurrentPos = function(self)
  -- function num : 0_3
  return (self._data).currentPos
end

BM_GiftOfTimeMaze.GetCards = function(self)
  -- function num : 0_4
  return (self._data).cards
end

BM_GiftOfTimeMaze.GetBlocks = function(self)
  -- function num : 0_5
  return (self._data).blocks
end

BM_GiftOfTimeMaze.HaveRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  do return ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.TimeDice) >= 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_GiftOfTimeMaze.ShowRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self:GetIsOpen() then
    return false
  end
  if not self:HaveRedDot() and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetIsOpen() then
    return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):HasTasksAward()
  end
end

BM_GiftOfTimeMaze.GetRemainTimeStr = function(self, endTime)
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

BM_GiftOfTimeMaze.GetCBPLabyrinthStartRewardCfg = function(self)
  -- function num : 0_9 , upvalues : CBPLabyrinthStartRewardCfg
  return CBPLabyrinthStartRewardCfg:GetRecorder(1)
end

BM_GiftOfTimeMaze.GetMazeAwardBlockDef = function(self)
  -- function num : 0_10 , upvalues : MazeAwardBlockDef
  return MazeAwardBlockDef
end

BM_GiftOfTimeMaze.SendCChooseMazeCard = function(self, card)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).oldCTime = (self._data).nowCTime
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).nowCTime = (ServerGameTimer.GetServerTimeForecast)()
  if (self._data).nowCTime - (self._data).oldCTime > 1000 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cchoosemazecard")
    if protocol then
      protocol.card = card
      protocol:Send()
    end
  else
    do
      LogError("BM_GiftOfTimeMaze:SendCChooseMazeCard", "time interval too short: " .. tostring((self._data).oldCTime) .. "|" .. tostring((self._data).nowCTime))
    end
  end
end

return BM_GiftOfTimeMaze

