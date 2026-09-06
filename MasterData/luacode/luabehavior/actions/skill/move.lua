local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EMoveType = require("luabehavior.agent.emovetype")
local Logic_BattlerMoveSystem = require("logic.battle.system.logic.battlermovesystem")
local BattlerPositionComponent = require("logic.battle.component.battlerpositioncomponent")
local Move = class("Move", Task)

function Move:Ctor(context, distance)
  Move.super.Ctor(self)
  self._context = context
  self._distance = distance / 1000
  self._time = 0
  self._totalTime = 250
  self._taskId = 0
  self._entityId = 0
end

function Move:OnStart()
  self._time = 0
  self._taskId = 0
  self._entityId = 0
  self._entityId = self._context._attacker._entityId
  self._taskId = self._context._world:GetSystem(Logic_BattlerMoveSystem):MoveForward(self._entityId, self._distance, 0, 0, self._totalTime)
end

function Move:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time > self._totalTime then
    self._time = self._totalTime
  end
  self._context._world:GetSystem(Logic_BattlerMoveSystem):UpdateTask(self._entityId, self._taskId, self._time)
  if self._time == self._totalTime then
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

function Move:OnEnd()
  if self._time ~= self._totalTime then
    self._context._world:GetSystem(Logic_BattlerMoveSystem):UpdateTask(self._entityId, self._taskId, self._totalTime)
  end
end

function Move:GetCheckPoints()
  return self._totalTime - self._time
end

return Move
