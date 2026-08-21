-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_doubleeleven.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.activity.sopendoubleelevencard")
local BM_DoubleEleven = class("BM_DoubleEleven")
BM_DoubleEleven.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._doubleeleven = ((NekoData.Data).activities).doubleeleven
end

BM_DoubleEleven.GetIsOpen = function(self)
  -- function num : 0_1
  return (self._doubleeleven).isOpen
end

BM_DoubleEleven.GetStartTime = function(self)
  -- function num : 0_2
  return (self._doubleeleven).startTime
end

BM_DoubleEleven.GetEndTime = function(self)
  -- function num : 0_3
  return (self._doubleeleven).endTime
end

BM_DoubleEleven.GetIsOpenTask = function(self)
  -- function num : 0_4
  return (self._doubleeleven).isOpenTask
end

BM_DoubleEleven.HaveRedDot = function(self)
  -- function num : 0_5
  return false
end

BM_DoubleEleven.ShowRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self:HaveRedDot() and not ((NekoData.BehaviorManager).BM_ActivityTasks):DoubleElevenRedDot() then
    return self:GetFreeRedDot()
  end
end

BM_DoubleEleven.GetOpenCards = function(self)
  -- function num : 0_7
  return (self._doubleeleven).openCards
end

BM_DoubleEleven.ClearCardsData = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DoubleElevenActivityID)):ClearCardsData()
end

BM_DoubleEleven.GetCardIsGoldCard = function(self, cardType)
  -- function num : 0_9 , upvalues : ProtocolDef
  do return cardType == ProtocolDef.GOLD_CARD end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_DoubleEleven.SendOpenCardSheetProtocol = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local protocolSend = (LuaNetManager.CreateProtocol)("protocol.activity.copendoubleelevenactivity")
  if protocolSend then
    protocolSend:Send()
  end
end

BM_DoubleEleven.SendOpenOneCardProtocol = function(self, position)
  -- function num : 0_11 , upvalues : _ENV
  local protocolSend = (LuaNetManager.CreateProtocol)("protocol.activity.copendoubleelevencard")
  if protocolSend then
    protocolSend.poolId = (self._doubleeleven).cardPoolID
    protocolSend.position = position
    protocolSend:Send()
  end
end

BM_DoubleEleven.SendGetTasksProtocol = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
  local activityIDForTask = protocol.DOUBLE_ELEVEN
  if protocol then
    protocol.activityID = activityIDForTask
    protocol:Send()
  end
  return activityIDForTask
end

BM_DoubleEleven.GetFreeRedDot = function(self)
  -- function num : 0_13
  return (self._doubleeleven).freeReddot
end

BM_DoubleEleven.KillFreeRedDot = function(self)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._doubleeleven).freeReddot = false
end

return BM_DoubleEleven

