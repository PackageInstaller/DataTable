-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_anniversary.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Anniversary = class("DM_Anniversary")
DM_Anniversary.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = (NekoData.Data).anniversary
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).levelMap = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).nextTypePeriod = nil
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dailySupplyData = nil
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dailytaskData = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).cumulativeTaskData = nil
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).firstDrama = nil
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).package = nil
end

DM_Anniversary.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self._data).levelMap) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._data).levelMap)[k] = nil
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).nextTypePeriod = nil
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dailySupplyData = nil
  for k,v in pairs((self._data).dailytaskData) do
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

    ((self._data).dailytaskData)[k] = nil
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).cumulativeTaskData = nil
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).firstDrama = nil
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).package = nil
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
    protocol.activityId = (DataCommon.Activities).Anniversary
    protocol:Send()
  end
)
  end
end

DM_Anniversary.OnSGetActivityBattleList = function(self, protocol)
  -- function num : 0_3 , upvalues : AddGameTimer, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).nextTypePeriod = protocol.time2NextPeriod
  AddGameTimer(self)
  for k,v in pairs((self._data).levelMap) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).levelMap)[k] = nil
  end
  for i,v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_Anniversary", "-OnSGetActivityBattleList- levelId = %s, status = %s, bossLevel = %s, first = %s, lefttime = %s, lefthp = %s, level = %s ---", v.id, v.status, v.bossLevel, v.first, v.lefttime, v.lefthp, v.level)
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
    data.leftTime = v.lefttime
    data.leftHP = v.lefthp
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

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

DM_Anniversary.OnSUpdateActivityBattleList = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV, GetDataById
  for i,v in ipairs(protocol.battleNodes) do
    LogInfoFormat("DM_Anniversary", "-OnSUpdateActivityBattleList- levelId = %s, status = %s, bossLevel = %s, first = %s, lefttime = %s, lefthp = %s ---", v.id, v.status, v.bossLevel, v.first, v.lefttime, v.lefthp)
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
    data.leftTime = v.lefttime
    data.leftHP = v.lefthp
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R9 in 'UnsetPending'

    if index then
      (((self._data).levelMap)[v.battletype])[index] = data
    else
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R9 in 'UnsetPending'

      if not ((self._data).levelMap)[v.battletype] then
        ((self._data).levelMap)[v.battletype] = {}
      end
      ;
      (table.insert)(((self._data).levelMap)[v.battletype], data)
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DM_Anniversary.OnSAnniversarySupply = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).dailySupplyData = protocol.supply
end

DM_Anniversary.OnSActivityTasks = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  for k,v in pairs((self._data).dailytaskData) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).dailytaskData)[k] = nil
  end
  for i,v in ipairs(protocol.activityTasks) do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).dailytaskData)[v.taskid] = {taskId = v.taskid, taskStatus = v.taskstatus, taskCurProgress = ((v.conditions)[1]).value, taskDestProgress = ((v.conditions)[1]).destValue}
  end
end

DM_Anniversary.OnSRefreshActivityTask = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV
  local data = ((self._data).dailytaskData)[(protocol.taskinfo).taskid]
  if data then
    data.taskStatus = (protocol.taskinfo).taskstatus
  else
    LogInfoFormat("DM_Anniversary", "no id %s in tasks", (protocol.taskinfo).taskid)
  end
end

DM_Anniversary.OnSTaskFinishProgress = function(self, protocol)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).cumulativeTaskData = nil
  for k,v in pairs(protocol.tasks) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

    (self._data).cumulativeTaskData = {status = v.status, num = v.num, taskId = k}
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).firstDrama = protocol.firstDrama ~= 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_Anniversary.SetLevelStatus = function(self, type, levelId, status)
  -- function num : 0_10 , upvalues : _ENV
  LogInfoFormat("DM_Anniversary", "type = %s, levelId = %s, status = %s", type, levelId, status)
  local levelInfo = ((NekoData.BehaviorManager).BM_Anniversary):GetLevelInfo(type, levelId)
  if levelInfo then
    LogInfoFormat("DM_Anniversary", "curStatus = %s, status = %s", levelInfo.status, status)
    levelInfo.status = status
  end
end

DM_Anniversary.OnSOpenAnniversaryDraw = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).package = {}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).package).award = protocol.award
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).package).score = protocol.score
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._data).package).leftTime = protocol.leftTime
  if self._packageGameTimerID then
    (GameTimer.RemoveTask)(self._packageGameTimerID)
    self._packageGameTimerID = nil
  end
  if protocol.leftTime > 0 then
    self._packageGameTimerID = (GameTimer.AddTask)((math.ceil)(protocol.leftTime / 1000), 0, function()
    -- function num : 0_11_0 , upvalues : self
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (self._data).package = nil
  end
)
  else
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._data).package = nil
  end
end

return DM_Anniversary

