-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillend/exec.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local PositionUtility = require("logic.battle.utility.positionutility")
local AnimaitonUtility = require("logic.battle.utility.animaitonutility")
local Logic_BattlerMoveSystem = require("logic.battle.system.logic.battlermovesystem")
local Exec = class("Exec", Task)
Exec.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : Exec
  ((Exec.super).Ctor)(self)
  self._context = context
  self._time = 0
  self._totalTime = 0
  self._taskId = 0
  self._entityId = 0
end

Exec.OnStart = function(self)
  -- function num : 0_1 , upvalues : PositionUtility, Logic_BattlerMoveSystem
  self._time = 0
  self._taskId = 0
  self._entityId = 0
  if not (PositionUtility.AtOriPosition)((self._context)._world, (self._context)._entityId) then
    self._totalTime = 150
    self._taskId = (((self._context)._world):GetSystem(Logic_BattlerMoveSystem)):MoveBack((self._context)._entityId, self._totalTime)
  end
end

Exec.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : Logic_BattlerMoveSystem, AnimaitonUtility, Behavior_Status
  self._time = self._time + deltaTime
  if self._totalTime < self._time then
    self._time = self._totalTime
  end
  if self._taskId > 0 then
    (((self._context)._world):GetSystem(Logic_BattlerMoveSystem)):UpdateTask((self._context)._entityId, self._taskId, self._time)
  end
  if self._time == self._totalTime then
    if not (AnimaitonUtility.IsBattleIdle)((self._context)._world, (self._context)._entityId) then
      (AnimaitonUtility.PlayBattleIdle)((self._context)._world, (self._context)._entityId)
    end
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

Exec.OnEnd = function(self)
  -- function num : 0_3 , upvalues : Logic_BattlerMoveSystem, AnimaitonUtility
  if self._time ~= self._totalTime then
    if self._taskId > 0 then
      (((self._context)._world):GetSystem(Logic_BattlerMoveSystem)):UpdateTask((self._context)._entityId, self._taskId, self._totalTime)
    end
    if not (AnimaitonUtility.IsBattleIdle)((self._context)._world, (self._context)._entityId) then
      (AnimaitonUtility.PlayBattleIdle)((self._context)._world, (self._context)._entityId)
    end
  end
end

Exec.GetCheckPoints = function(self)
  -- function num : 0_4
  return self._totalTime - self._time
end

return Exec

