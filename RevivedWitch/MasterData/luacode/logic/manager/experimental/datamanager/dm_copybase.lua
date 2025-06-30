-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_copybase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_CopyBase = class("DM_CopyBase")
DM_CopyBase.Ctor = function(self, data, other)
  -- function num : 0_0
  self.__data = data
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).levelMap = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).nextTypePeriod = nil
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).LevelCfg = other.LevelCfg
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).LevelCfgRecords = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).FuncUnlockCfg = other.FunctionUnlockCfg
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).FuncUnlockCfgRecords = {}
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).Type = other.Type
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).Function = other.Function
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__data).activityId = nil
  self.__gameTimerId = nil
end

DM_CopyBase.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self.__data).levelMap) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self.__data).levelMap)[k] = nil
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.__data).nextTypePeriod = nil
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.__data).activityId = nil
  self.__gameTimerId = nil
end

local InitCfgByActivityId = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LogInfoFormat("DM_CopyBase", "-InitCfgByActivityId- activityId = %s", (self.__data).activityId)
  for k,v in pairs((self.__data).LevelCfgRecords) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

    ((self.__data).LevelCfgRecords)[k] = nil
  end
  local allIds = ((self.__data).LevelCfg):GetAllIds()
  for i = 1, #allIds do
    local record = ((self.__data).LevelCfg):GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

    if record.eventid == (self.__data).activityId then
      ((self.__data).LevelCfgRecords)[record.id] = record
    end
  end
  for k,v in pairs((self.__data).FuncUnlockCfgRecords) do
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

    ((self.__data).FuncUnlockCfgRecords)[k] = nil
  end
  allIds = ((self.__data).FuncUnlockCfg):GetAllIds()
  for i = 1, #allIds do
    local record = ((self.__data).FuncUnlockCfg):GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R7 in 'UnsetPending'

    if record.eventid == (self.__data).activityId then
      ((self.__data).FuncUnlockCfgRecords)[record.id] = record
    end
  end
end

local AddGameTimer = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.__gameTimerId then
    (GameTimer.RemoveTask)(self.__gameTimerId)
    self.__gameTimerId = nil
  end
  if (self.__data).nextTypePeriod > 0 then
    self.__gameTimerId = (GameTimer.AddTask)((math.ceil)((self.__data).nextTypePeriod / 1000), 0, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.cgetactivitybattlelist")
    protocol.activityId = (self.__data).activityId
    protocol:Send()
  end
)
  end
end

DM_CopyBase.OnSGetActivityBattleList = function(self, protocol)
  -- function num : 0_4 , upvalues : InitCfgByActivityId, AddGameTimer, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self.__data).activityId = protocol.activityId
  InitCfgByActivityId(self)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.__data).nextTypePeriod = protocol.time2NextPeriod
  AddGameTimer(self)
  for k,v in pairs((self.__data).levelMap) do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

    ((self.__data).levelMap)[k] = nil
  end
  for i,v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_CopyBase", "-OnSGetActivityBattleList- activityId = %s, levelId = %s, status = %s, recommendLevel = %s, difficulty = %s, costSpirit = %s, first = %s, bossLevel = %s, lefttime = %s, lefthp = %s ---", (self.__data).activityId, v.id, v.status, v.level, v.battletype, v.spirit, v.first, v.bossLevel, v.lefttime, v.lefthp)
    local data = {}
    data.levelId = v.id
    data.status = v.status
    data.recommendLevel = v.level
    data.difficulty = v.battletype
    data.costSpirit = v.spirit
    data.firstGet = v.first == 1
    data.firstItems = v.firstItems
    data.randItems = v.randItems
    data.normalItems = v.normalItems
    data.bossLevel = v.bossLevel
    data.leftTime = v.lefttime
    data.leftHP = v.lefthp
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R8 in 'UnsetPending'

    if not ((self.__data).levelMap)[data.difficulty] then
      ((self.__data).levelMap)[data.difficulty] = {}
    end
    -- DECOMPILER ERROR at PC86: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (((self.__data).levelMap)[data.difficulty])[data.levelId] = data
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DM_CopyBase.OnSUpdateActivityBattleList = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  if protocol.activityId ~= (self.__data).activityId then
    LogErrorFormat("DM_CopyBase", "activityId is not match. activityId: %s, initActivityId = %s", protocol.activityId, (self.__data).activityId)
    return 
  end
  for i,v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_CopyBase", "-OnSUpdateActivityBattleList- activityId = %s, levelId = %s, status = %s, recommendLevel = %s, difficulty = %s, costSpirit = %s, first = %s, bossLevel = %s, lefttime = %s, lefthp = %s ---", (self.__data).activityId, v.id, v.status, v.level, v.battletype, v.spirit, v.first, v.bossLevel, v.lefttime, v.lefthp)
    local data = {}
    data.levelId = v.id
    data.status = v.status
    data.recommendLevel = v.level
    data.difficulty = v.battletype
    data.costSpirit = v.spirit
    data.firstGet = v.first == 1
    data.firstItems = v.firstItems
    data.randItems = v.randItems
    data.normalItems = v.normalItems
    data.bossLevel = v.bossLevel
    data.leftTime = v.lefttime
    data.leftHP = v.lefthp
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R8 in 'UnsetPending'

    if not ((self.__data).levelMap)[data.difficulty] then
      ((self.__data).levelMap)[data.difficulty] = {}
    end
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (((self.__data).levelMap)[data.difficulty])[data.levelId] = data
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DM_CopyBase.SetLevelStatus = function(self, type, levelId, status)
  -- function num : 0_6 , upvalues : _ENV
  LogInfoFormat("DM_CopyBase", "-SetLevelStatus- activityId = %s, type = %s, levelId = %s, status = %s", (self.__data).activityId, type, levelId, status)
  local mapInfo = ((self.__data).levelMap)[type]
  if not mapInfo then
    LogError("DM_CopyBase", "data error.")
  else
    local levelInfo = mapInfo[levelId]
    if not levelInfo then
      LogError("DM_CopyBase", "data error.")
    else
      LogInfoFormat("DM_CopyBase", "curStatus = %s, status = %s", levelInfo.status, status)
      levelInfo.status = status
    end
  end
end

return DM_CopyBase

