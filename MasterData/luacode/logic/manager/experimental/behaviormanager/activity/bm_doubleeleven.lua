local ProtocolDef = LuaNetManager.GetProtocolDef("protocol.activity.sopendoubleelevencard")
local BM_DoubleEleven = class("BM_DoubleEleven")

function BM_DoubleEleven:Ctor()
  self._doubleeleven = NekoData.Data.activities.doubleeleven
end

function BM_DoubleEleven:GetIsOpen()
  return self._doubleeleven.isOpen
end

function BM_DoubleEleven:GetStartTime()
  return self._doubleeleven.startTime
end

function BM_DoubleEleven:GetEndTime()
  return self._doubleeleven.endTime
end

function BM_DoubleEleven:GetIsOpenTask()
  return self._doubleeleven.isOpenTask
end

function BM_DoubleEleven:HaveRedDot()
  return false
end

function BM_DoubleEleven:ShowRedDot()
  return self:HaveRedDot() or NekoData.BehaviorManager.BM_ActivityTasks:DoubleElevenRedDot() or self:GetFreeRedDot()
end

function BM_DoubleEleven:GetOpenCards()
  return self._doubleeleven.openCards
end

function BM_DoubleEleven:ClearCardsData()
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.DoubleElevenActivityID):ClearCardsData()
end

function BM_DoubleEleven:GetCardIsGoldCard(cardType)
  return cardType == ProtocolDef.GOLD_CARD
end

function BM_DoubleEleven:SendOpenCardSheetProtocol()
  local protocolSend = LuaNetManager.CreateProtocol("protocol.activity.copendoubleelevenactivity")
  if protocolSend then
    protocolSend:Send()
  end
end

function BM_DoubleEleven:SendOpenOneCardProtocol(position)
  local protocolSend = LuaNetManager.CreateProtocol("protocol.activity.copendoubleelevencard")
  if protocolSend then
    protocolSend.poolId = self._doubleeleven.cardPoolID
    protocolSend.position = position
    protocolSend:Send()
  end
end

function BM_DoubleEleven:SendGetTasksProtocol()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
  local activityIDForTask = protocol.DOUBLE_ELEVEN
  if protocol then
    protocol.activityID = activityIDForTask
    protocol:Send()
  end
  return activityIDForTask
end

function BM_DoubleEleven:GetFreeRedDot()
  return self._doubleeleven.freeReddot
end

function BM_DoubleEleven:KillFreeRedDot()
  self._doubleeleven.freeReddot = false
end

return BM_DoubleEleven
