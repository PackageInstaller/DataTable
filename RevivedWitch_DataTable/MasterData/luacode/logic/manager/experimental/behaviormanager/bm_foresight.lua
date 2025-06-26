-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_foresight.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CActivityForesightMain = (BeanManager.GetTableByName)("activity.cactivityforesightmain")
local CForesightChatConfig = (BeanManager.GetTableByName)("dialog.cforesightchatconfig")
local CForesightChatList = (BeanManager.GetTableByName)("dialog.cforesightchatlist")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local BM_Foresight = class("BM_Foresight")
BM_Foresight.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).foresight
end

BM_Foresight.GetActivityId = function(self)
  -- function num : 0_1
  return (self._data).activityId
end

BM_Foresight.GetCurLeftTime = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (self._data).curLeftTime - ((ServerGameTimer.GetServerTimeForecast)() - (self._data).initialTime)
end

BM_Foresight.GetActLeftTime = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return (self._data).actLeftTime - ((ServerGameTimer.GetServerTimeForecast)() - (self._data).initialTime)
end

BM_Foresight.GetIsOpen = function(self)
  -- function num : 0_4
  do return self:GetActivityId() > 0 and self:GetActLeftTime() > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Foresight.GetUnlockedDay = function(self)
  -- function num : 0_5
  return (self._data).unlockedDay
end

BM_Foresight.GetReceiveAward = function(self)
  -- function num : 0_6
  return (self._data).receiveAward
end

BM_Foresight.GetForesightGoodInfo = function(self)
  -- function num : 0_7
  return (self._data).foresightGoodInfo
end

BM_Foresight.GetHaveRedDot = function(self)
  -- function num : 0_8
  if not self:GetIsOpen() then
    return false
  end
  return (self._data).haveRedDot
end

BM_Foresight.GetRemainTimeStr = function(self, endTime)
  -- function num : 0_9 , upvalues : _ENV, CStringRes
  local str = ""
  if endTime and endTime > 0 then
    local time = endTime // 1000
    local year = time // 31536000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if year > 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1874)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", year)
    else
      if day > 0 then
        str = (TextManager.GetText)((CStringRes:GetRecorder(1875)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", day)
      else
        if hour > 0 then
          str = (TextManager.GetText)((CStringRes:GetRecorder(1876)).msgTextID)
          str = (string.gsub)(str, "%$parameter1%$", hour)
        else
          if min > 0 then
            str = (TextManager.GetText)((CStringRes:GetRecorder(1877)).msgTextID)
            str = (string.gsub)(str, "%$parameter1%$", min)
          else
            if sec > 0 then
              str = (TextManager.GetText)((CStringRes:GetRecorder(1877)).msgTextID)
              str = (string.gsub)(str, "%$parameter1%$", 0)
            end
          end
        end
      end
    end
  end
  do
    return str
  end
end

BM_Foresight.OnSGeneralForesightAct = function(self, protocol)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).haveRedDot = false
  for i = 1, self:GetUnlockedDay() do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

    if not (self:GetReceiveAward())[i] then
      (self._data).haveRedDot = true
      return 
    end
  end
  local allIDs = (self:GetCActivityForesightMain()):GetAllIds()
  local tmpDayIndex = 0
  for _,id in ipairs(allIDs) do
    local recorder = (self:GetCActivityForesightMain()):GetRecorder(id)
    if recorder.activityId == self:GetActivityId() then
      tmpDayIndex = tmpDayIndex + 1
    end
  end
  local totalDayNum = tmpDayIndex
  local extraIsGet = true
  if totalDayNum == self:GetUnlockedDay() then
    extraIsGet = (self:GetReceiveAward())[totalDayNum + 1]
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R6 in 'UnsetPending'

  if not (self._data).haveRedDot then
    (self._data).haveRedDot = not extraIsGet
  end
end

BM_Foresight.SendCReceiveForesightAct = function(self, dayNum)
  -- function num : 0_11 , upvalues : _ENV
  if not self:GetIsOpen() then
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceiveforesightact")
  if protocol then
    protocol.activityId = (self._data).activityId
    protocol.dayNum = dayNum
    protocol:Send()
  end
end

BM_Foresight.SendCBuyForesightGift = function(self, goodId)
  -- function num : 0_12 , upvalues : _ENV
  if not self:GetIsOpen() then
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyforesightgift")
  if protocol then
    protocol.activityId = (self._data).activityId
    protocol.goodId = goodId
    protocol:Send()
  end
end

BM_Foresight.GetCActivityForesightMain = function(self)
  -- function num : 0_13 , upvalues : CActivityForesightMain
  return CActivityForesightMain
end

BM_Foresight.GetCForesightChatConfig = function(self)
  -- function num : 0_14 , upvalues : CForesightChatConfig
  return CForesightChatConfig
end

BM_Foresight.GetCForesightChatList = function(self)
  -- function num : 0_15 , upvalues : CForesightChatList
  return CForesightChatList
end

return BM_Foresight

