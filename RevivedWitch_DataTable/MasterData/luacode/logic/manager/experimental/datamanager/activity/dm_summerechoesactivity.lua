-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_summerechoesactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SummerEchoesActivity = class("DM_SummerEchoesActivity")
DM_SummerEchoesActivity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).summerechoesActivity
  self:Clear()
end

DM_SummerEchoesActivity.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).constructions = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).snackRedpoint = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).foodStallsData = {}
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if self._gameTimerIDRes then
    (GameTimer.RemoveTask)(self._gameTimerIDRes)
    self._gameTimerIDRes = nil
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).freeReddot = false
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).challengeModeData = {totalScore = 0, curScore = 0, passTime = 0, rank = -1}
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).receiveAward = {}
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).battleresult = nil
end

DM_SummerEchoesActivity.OnSGetSummerEchoInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).constructions = protocol.constructions
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).snackRedpoint = protocol.snackRedpoint
  self:AddGameTimerForRes()
  if PrintTable then
    PrintTable((self._data).constructions, 3, "self._data.constructions", {"__debug__class"})
    PrintTable((self._data).constructions, 3, "self._data.constructions", {"__debug__class", "event", "abscissa", "vertical", "autoExplore"})
    local a = 0
    local b = {}
    for _,value in pairs((self._data).constructions) do
      if value.fog == 0 then
        a = a + 1
        ;
        (table.insert)(b, value.ID)
      end
    end
    ;
    (table.sort)(b)
    LogError("FFF", tostring(a))
    PrintTable(b, 3, "FFFA")
  end
end

DM_SummerEchoesActivity.OnSUpdateEchoEvent = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  for _,summerevent in pairs(protocol.updates) do
    for _,construction in pairs((self._data).constructions) do
      if construction.ID == summerevent.construction then
        construction.event = summerevent.events
        construction.fog = summerevent.fog
        construction.unlockTime = summerevent.unlockTime
        for _,v in ipairs(summerevent.autoExplore) do
          if not (table.contain)(construction.autoExplore, v) then
            (table.insert)(construction.autoExplore, v)
          end
        end
        for _,v in ipairs(construction.event) do
          local index = (table.indexof)(construction.locked, v)
          if index then
            (table.remove)(construction.locked, index)
          end
        end
        break
      end
    end
  end
  if PrintTable then
    PrintTable(protocol, 3, "OnSUpdateEchoEvent", {"__debug__class"})
    PrintTable((self._data).constructions, 3, "self._data.constructions", {"__debug__class", "event", "abscissa", "vertical", "autoExplore"})
    local a = 0
    local b = {}
    for _,value in pairs((self._data).constructions) do
      if value.fog == 0 then
        a = a + 1
        ;
        (table.insert)(b, value.ID)
      end
    end
    ;
    (table.sort)(b)
    LogError("FFF", tostring(a))
    PrintTable(b, 3, "FFFA")
  end
  do
    self:AddGameTimerForRes()
  end
end

DM_SummerEchoesActivity.OnSSummerEchoEvent = function(self, protocol)
  -- function num : 0_4
end

local AddGameTimer = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if ((self._data).foodStallsData).leftTime and ((self._data).foodStallsData).leftTime ~= -1 then
    self._gameTimerID = (GameTimer.AddTask)((math.ceil)(((self._data).foodStallsData).leftTime / 1000), 0, function()
    -- function num : 0_5_0 , upvalues : _ENV
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copenechosnack")
    if protocol then
      protocol:Send()
      return 
    end
  end
)
  end
end

DM_SummerEchoesActivity.AddGameTimerForRes = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._gameTimerIDRes then
    (GameTimer.RemoveTask)(self._gameTimerIDRes)
    self._gameTimerIDRes = nil
  end
  local minTime = math.maxinteger
  for _,value in pairs((self._data).constructions) do
    if value.unlockTime > 0 and value.unlockTime < minTime then
      minTime = value.unlockTime
    end
  end
  if minTime > 0 then
    self._gameTimerIDRes = (GameTimer.AddTask)((math.ceil)(minTime / 1000), 0, function()
    -- function num : 0_6_0 , upvalues : _ENV
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cupdateechoevent")
    if protocol then
      protocol:Send()
      return 
    end
  end
)
  end
end

DM_SummerEchoesActivity.SOpenEchoSnack = function(self, protocol)
  -- function num : 0_7 , upvalues : AddGameTimer
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.leftTime ~= -1 then
    (self._data).foodStallsData = protocol
    AddGameTimer(self)
  else
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._data).snackRedpoint = 0
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._data).foodStallsData = {}
  end
end

DM_SummerEchoesActivity.OnSEchoShopRedPoint = function(self, protocol)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).freeReddot = true
end

DM_SummerEchoesActivity.OnSOpenChallengeMode = function(self, protocol)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).challengeModeData = protocol
end

DM_SummerEchoesActivity.OnSBattleEvent = function(self, protocol)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).eventList = protocol
end

DM_SummerEchoesActivity.OnSOpenSummerAward = function(self, protocol)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).receiveAward = protocol.receiveAward
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).challengeModeData).totalScore = protocol.score
end

DM_SummerEchoesActivity.OnSBattleScore = function(self, protocol)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).battleresult = protocol
end

return DM_SummerEchoesActivity

