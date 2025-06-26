-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_summeractivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSwimSuitTimeCfg = (BeanManager.GetTableByName)("activity.cswimsuittimecfg")
local DM_SummerActivity = class("DM_SummerActivity")
DM_SummerActivity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).summerActivity
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).constructions = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).shopConstructionList = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).storageConstructionList = {}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).foodStallsData = {}
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).missions = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).Timer = nil
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).freeReddot = false
end

DM_SummerActivity.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((NekoData.Data).activities).summerActivity = {}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).constructions = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).shopConstructionList = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).storageConstructionList = {}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).foodStallsData = {}
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).missions = {}
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).freeReddot = false
end

DM_SummerActivity.OnSGetSummerActivityInfo = function(self, protocol)
  -- function num : 0_2 , upvalues : CSwimSuitTimeCfg
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if (self._data).state then
    (self._data).state_Old = (self._data).state
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).timeProgress = protocol.sunlight
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).state = protocol.state
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).constructions = protocol.constructions
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).missions = protocol.missions
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).constructionRedpoint = protocol.constructionRedpoint
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).snackRedpoint = protocol.snackRedpoint
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).timeRecorder = CSwimSuitTimeCfg:GetRecorder((self._data).state)
end

DM_SummerActivity.OnSUpdateSummerConstruction = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  if protocol.result == 1 then
    if (protocol.construction).level == 1 then
      (table.insert)((self._data).constructions, protocol.construction)
      return 
    end
    for i,v in ipairs((self._data).constructions) do
      if v.ID == (protocol.construction).ID then
        v.level = (protocol.construction).level
        v.vertical = (protocol.construction).vertical
        v.abscissa = (protocol.construction).abscissa
        v.event = (protocol.construction).event
        v.canlvup = (protocol.construction).canlvup
        v.event2lock = (protocol.construction).event2lock
        v.locked = (protocol.construction).locked
        break
      end
    end
  end
end

DM_SummerActivity.OnSGetSummerConstructionUpdateList = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).shopConstructionList = protocol.constructionList
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).storageConstructionList = protocol.constructionList
end

DM_SummerActivity.OnSMoveSummerConstruction = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  if protocol.result == 1 then
    for i,v in ipairs((self._data).constructions) do
      if v.ID == protocol.ID then
        v.level = protocol.level
        v.vertical = protocol.vertical
        v.abscissa = protocol.abscissa
        break
      end
    end
  end
end

DM_SummerActivity.OnSUpdateConstructionEvent = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV
  for i,summerevent in ipairs(protocol.updates) do
    for i,construction in ipairs((self._data).constructions) do
      if construction.ID == summerevent.construction then
        construction.event = summerevent.events
        for i,v in ipairs(summerevent.autoExplore) do
          (table.insert)(construction.autoExplore, v)
        end
        for i,v in ipairs(construction.event) do
          local index = (table.indexof)(construction.locked, v)
          if index then
            (table.remove)(construction.locked, index)
          end
        end
        break
      end
    end
  end
  for i,summerevent in ipairs(protocol.updateConstructions) do
    for i,construction in ipairs((self._data).constructions) do
      if construction.ID == summerevent.construction then
        construction.canlvup = summerevent.canlvup
        construction.event2lock = summerevent.unlockEvent
        break
      end
    end
  end
end

DM_SummerActivity.OnSUpdateSummerMissions = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  for i,v in ipairs(protocol.missions) do
    for j,mission in ipairs((self._data).missions) do
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R12 in 'UnsetPending'

      if v.ID == mission.ID then
        ((self._data).missions)[j] = v
        break
      end
    end
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).timeProgress = protocol.sunlight
end

local AddGameTimer = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if ((self._data).foodStallsData).leftTime and ((self._data).foodStallsData).leftTime ~= -1 then
    self._gameTimerID = (GameTimer.AddTask)((math.ceil)(((self._data).foodStallsData).leftTime / 1000), 0, function()
    -- function num : 0_8_0 , upvalues : _ENV
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copensnackshop")
    if protocol then
      protocol:Send()
      return 
    end
  end
)
  end
end

DM_SummerActivity.OnRefreshFoodStallsStatus = function(self, protocol)
  -- function num : 0_9 , upvalues : AddGameTimer
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

DM_SummerActivity.OnSActivityShopRedDot = function(self, protocol)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).freeReddot = true
end

return DM_SummerActivity

