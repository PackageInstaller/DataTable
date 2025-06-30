-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_puzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Puzzle = class("DM_Puzzle")
local TasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
DM_Puzzle.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._puzzles = ((NekoData.Data).activities).puzzle
  self._allTaskList = ((NekoData.Data).activityTasks).allTaskList
  self._finishedTaskList = ((NekoData.Data).activityTasks).finishedTaskList
end

DM_Puzzle.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs(self._puzzles) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._puzzles)[k] = nil
  end
end

DM_Puzzle.OnSOpenPuzzle = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  self:RemoveTask(protocol.actId)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.leftTime > 0 then
    (self._puzzles)[protocol.actId] = {actId = protocol.actId, endTime = protocol.deadLine, leftTime = protocol.leftTime, puzzleNum = protocol.puzzleNum, puzzleInfo = protocol.puzzleInfo, progressReward = protocol.progressReward, gameTimerId = (ServerGameTimer.AddTask)((math.floor)(protocol.leftTime / 1000), -1, function()
    -- function num : 0_2_0 , upvalues : _ENV, protocol, self
    LogInfoFormat("DM_Puzzle", "EndPuzzle:%s", protocol.actId)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

    if (self._puzzles)[protocol.actId] then
      (self._puzzles)[protocol.actId] = nil
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self._allTaskList)[2] = {}
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self._finishedTaskList)[2] = {}
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshActivityRewards, nil, nil)
  end
)}
  end
end

DM_Puzzle.OnSUnlockPuzzle = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  if not (self._puzzles)[protocol.activityId] then
    LogErrorFormat("DM_Puzzle", " No exist activityID:%s", protocol.activityId)
    return 
  end
  for k,v in ipairs(((self._puzzles)[protocol.activityId]).puzzleInfo) do
    if k == protocol.puzzleId then
      if v == 1 then
        LogErrorFormat("DM_Puzzle", " Puzzle:%s.%s are unlocked repeatedly ", protocol.activityId, protocol.puzzleId)
      else
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (((self._puzzles)[protocol.activityId]).puzzleInfo)[protocol.puzzleId] = 1
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self._puzzles)[protocol.activityId]).puzzleNum = protocol.puzzleNum
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_OnGetNewPuzzle, nil, protocol)
      end
    end
  end
end

DM_Puzzle.OnSGetProgressReward = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  if not (self._puzzles)[protocol.activityId] then
    LogErrorFormat("DM_Puzzle", "No exist activityID:%s", protocol.activityId)
    return 
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._puzzles)[protocol.activityId]).progressReward = protocol.progressReward
end

DM_Puzzle.RemoveTask = function(self, actid)
  -- function num : 0_5 , upvalues : _ENV
  if (self._puzzles)[actid] and ((self._puzzles)[actid]).gameTimerId ~= nil then
    (ServerGameTimer.RemoveTask)(((self._puzzles)[actid]).gameTimerId)
  end
end

return DM_Puzzle

