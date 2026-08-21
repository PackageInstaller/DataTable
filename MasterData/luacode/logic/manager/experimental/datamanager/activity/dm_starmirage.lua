-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_starmirage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local DM_StarMirage = class("DM_StarMirage")
DM_StarMirage.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).starmirage
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).levelMap = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).accumulateRewardList = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).accumulatePoints = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).nextTypePeriod = nil
end

DM_StarMirage.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self._data).levelMap) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._data).levelMap)[k] = nil
  end
  for k,v in pairs((self._data).accumulatePoints) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

    ((self._data).accumulatePoints)[k] = nil
  end
  do
    while ((self._data).accumulateRewardList)[#(self._data).accumulateRewardList] do
      (table.remove)((self._data).accumulateRewardList, #(self._data).accumulateRewardList)
    end
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._data).nextTypePeriod = nil
    if self._gameTimerID then
      (GameTimer.RemoveTask)(self._gameTimerID)
      self._gameTimerID = nil
    end
  end
end

local AddGameTimer = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  if (self._data).nextTypePeriod > 0 then
    self._gameTimerID = (GameTimer.AddTask)((math.ceil)((self._data).nextTypePeriod / 1000), 0, function()
    -- function num : 0_2_0 , upvalues : _ENV
    local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.cgetactivitybattlelist")
    protocol.activityId = (DataCommon.Activities).StarMirage
    protocol:Send()
  end
)
  end
end

DM_StarMirage.OnSGetActivityBattleList = function(self, protocol)
  -- function num : 0_3 , upvalues : AddGameTimer, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).nextTypePeriod = protocol.time2NextPeriod
  AddGameTimer(self)
  for k,v in pairs((self._data).levelMap) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).levelMap)[k] = nil
  end
  for i,v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_StarMirage", "-OnSGetActivityBattleList- levelId = %s, status = %s, bossLevel = %s, first = %s ---", v.id, v.status, v.bossLevel, v.first)
    local data = {}
    data.levelId = v.id
    data.status = v.status
    data.recommendLevel = v.level
    data.costSpirit = v.spirit
    data.firstGet = v.first == 1
    data.firstItems = v.firstItems
    data.randItems = v.randItems
    data.normalItems = v.normalItems
    data.bossLevel = v.bossLevel
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R8 in 'UnsetPending'

    if not ((self._data).levelMap)[v.battletype] then
      ((self._data).levelMap)[v.battletype] = {}
    end
    ;
    (table.insert)(((self._data).levelMap)[v.battletype], data)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

local GetDataById = function(self, battletype, levelId)
  -- function num : 0_4 , upvalues : _ENV
  local list = ((self._data).levelMap)[battletype]
  if list then
    for i,v in ipairs(list) do
      if v.levelId == levelId then
        return i
      end
    end
  end
end

DM_StarMirage.OnSUpdateActivityBattleList = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, GetDataById
  for i,v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_StarMirage", "-OnSUpdateActivityBattleList- levelId = %s, status = %s, bossLevel = %s, first = %s ---", v.id, v.status, v.bossLevel, v.first)
    local index = GetDataById(self, v.battletype, v.id)
    local data = {}
    data.levelId = v.id
    data.status = v.status
    data.recommendLevel = v.level
    data.costSpirit = v.spirit
    data.firstGet = v.first == 1
    data.firstItems = v.firstItems
    data.randItems = v.randItems
    data.normalItems = v.normalItems
    data.bossLevel = v.bossLevel
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

    if index then
      (((self._data).levelMap)[v.battletype])[index] = data
    else
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

      if not ((self._data).levelMap)[v.battletype] then
        ((self._data).levelMap)[v.battletype] = {}
      end
      ;
      (table.insert)(((self._data).levelMap)[v.battletype], data)
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DM_StarMirage.OnSGetPointsCollection = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV
  while ((self._data).accumulateRewardList)[#(self._data).accumulateRewardList] do
    (table.remove)((self._data).accumulateRewardList, #(self._data).accumulateRewardList)
  end
  for i,v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_StarMirage", "-OnSGetPointsCollection- stageId = %s, status = %s ---", v.id, v.status)
    local data = {}
    data.stageId = v.id
    data.status = v.status
    ;
    (table.insert)((self._data).accumulateRewardList, data)
  end
  for k,v in pairs(protocol.points) do
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).accumulatePoints)[k] = v
    LogInfoFormat("DM_StarMirage", "-OnSGetPointsCollection- itemId = %s, num = %s ---", k, v)
  end
end

DM_StarMirage.OnSRefreshPointsTasks = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  for i,v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_StarMirage", "-OnSRefreshPointsTasks- stageId = %s, status = %s ---", v.id, v.status)
    for _,data in ipairs((self._data).accumulateRewardList) do
      if v.id == data.stageId then
        data.status = v.status
      end
    end
  end
end

return DM_StarMirage

