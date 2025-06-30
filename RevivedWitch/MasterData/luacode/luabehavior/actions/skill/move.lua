-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skill/move.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EMoveType = require("luabehavior.agent.emovetype")
local Logic_BattlerMoveSystem = require("logic.battle.system.logic.battlermovesystem")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local Move = class("Move", Task)
Move.Ctor = function(self, context, distance)
  -- function num : 0_0 , upvalues : Move
  ((Move.super).Ctor)(self)
  self._context = context
  self._distance = distance / 1000
  self._time = 0
  self._totalTime = 250
  self._taskId = 0
  self._entityId = 0
end

Move.OnStart = function(self)
  -- function num : 0_1 , upvalues : Logic_BattlerMoveSystem
  self._time = 0
  self._taskId = 0
  self._entityId = 0
  self._entityId = ((self._context)._attacker)._entityId
  self._taskId = (((self._context)._world):GetSystem(Logic_BattlerMoveSystem)):MoveForward(self._entityId, self._distance, 0, 0, self._totalTime)
end

Move.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : Logic_BattlerMoveSystem, Behavior_Status
  self._time = self._time + deltaTime
  if self._totalTime < self._time then
    self._time = self._totalTime
  end
  ;
  (((self._context)._world):GetSystem(Logic_BattlerMoveSystem)):UpdateTask(self._entityId, self._taskId, self._time)
  if self._time == self._totalTime then
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

Move.OnEnd = function(self)
  -- function num : 0_3 , upvalues : Logic_BattlerMoveSystem
  if self._time ~= self._totalTime then
    (((self._context)._world):GetSystem(Logic_BattlerMoveSystem)):UpdateTask(self._entityId, self._taskId, self._totalTime)
  end
end

Move.GetCheckPoints = function(self)
  -- function num : 0_4
  return self._totalTime - self._time
end

return Move

