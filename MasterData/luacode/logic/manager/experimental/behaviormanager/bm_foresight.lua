local CActivityForesightMain = BeanManager.GetTableByName("activity.cactivityforesightmain")
local CForesightChatConfig = BeanManager.GetTableByName("dialog.cforesightchatconfig")
local CForesightChatList = BeanManager.GetTableByName("dialog.cforesightchatlist")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local BM_Foresight = class("BM_Foresight")

function BM_Foresight:Ctor()
  self._data = NekoData.Data.foresight
end

function BM_Foresight:GetActivityId()
  return self._data.activityId
end

function BM_Foresight:GetCurLeftTime()
  return self._data.curLeftTime - (ServerGameTimer.GetServerTimeForecast() - self._data.initialTime)
end

function BM_Foresight:GetActLeftTime()
  return self._data.actLeftTime - (ServerGameTimer.GetServerTimeForecast() - self._data.initialTime)
end

function BM_Foresight:GetIsOpen()
  return self:GetActivityId() > 0 and 0 < self:GetActLeftTime()
end

function BM_Foresight:GetUnlockedDay()
  return self._data.unlockedDay
end

function BM_Foresight:GetReceiveAward()
  return self._data.receiveAward
end

function BM_Foresight:GetForesightGoodInfo()
  return self._data.foresightGoodInfo
end

function BM_Foresight:GetHaveRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return self._data.haveRedDot
end

function BM_Foresight:GetRemainTimeStr(endTime)
  local str = ""
  if endTime and 0 < endTime then
    local time = endTime // 1000
    local year = time // 31536000
    local day = time // 86400
    local hour = time // 3600
    local min = time // 60
    local sec = time % 60
    if 0 < year then
      str = TextManager.GetText(CStringRes:GetRecorder(1874).msgTextID)
      str = string.gsub(str, "%$parameter1%$", year)
    elseif 0 < day then
      str = TextManager.GetText(CStringRes:GetRecorder(1875).msgTextID)
      str = string.gsub(str, "%$parameter1%$", day)
    elseif 0 < hour then
      str = TextManager.GetText(CStringRes:GetRecorder(1876).msgTextID)
      str = string.gsub(str, "%$parameter1%$", hour)
    elseif 0 < min then
      str = TextManager.GetText(CStringRes:GetRecorder(1877).msgTextID)
      str = string.gsub(str, "%$parameter1%$", min)
    elseif 0 < sec then
      str = TextManager.GetText(CStringRes:GetRecorder(1877).msgTextID)
      str = string.gsub(str, "%$parameter1%$", 0)
    end
  end
  return str
end

function BM_Foresight:OnSGeneralForesightAct(protocol)
  self._data.haveRedDot = false
  for i = 1, self:GetUnlockedDay() do
    if not self:GetReceiveAward()[i] then
      self._data.haveRedDot = true
      return
    end
  end
  local allIDs = self:GetCActivityForesightMain():GetAllIds()
  local tmpDayIndex = 0
  for _, id in ipairs(allIDs) do
    local recorder = self:GetCActivityForesightMain():GetRecorder(id)
    if recorder.activityId == self:GetActivityId() then
      tmpDayIndex = tmpDayIndex + 1
    end
  end
  local totalDayNum = tmpDayIndex
  local extraIsGet = true
  if totalDayNum == self:GetUnlockedDay() then
    extraIsGet = self:GetReceiveAward()[totalDayNum + 1]
  end
  self._data.haveRedDot = self._data.haveRedDot or not extraIsGet
end

function BM_Foresight:SendCReceiveForesightAct(dayNum)
  if not self:GetIsOpen() then
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceiveforesightact")
  if protocol then
    protocol.activityId = self._data.activityId
    protocol.dayNum = dayNum
    protocol:Send()
  end
end

function BM_Foresight:SendCBuyForesightGift(goodId)
  if not self:GetIsOpen() then
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyforesightgift")
  if protocol then
    protocol.activityId = self._data.activityId
    protocol.goodId = goodId
    protocol:Send()
  end
end

function BM_Foresight:GetCActivityForesightMain()
  return CActivityForesightMain
end

function BM_Foresight:GetCForesightChatConfig()
  return CForesightChatConfig
end

function BM_Foresight:GetCForesightChatList()
  return CForesightChatList
end

return BM_Foresight
