local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local EMoveType = require("luabehavior.agent.emovetype")
local Utility = require("logic.battle.utility")
local Move = class("Move", Task)

function Move:Ctor(context, moveType, distance, totalTime)
  Move.super.Ctor(self)
  self._context = context
  self._moveType = moveType
  self._distance = distance / 1000
  self._time = 0
  self._totalTime = totalTime
  self._taskId = 0
end

function Move:OnStart()
  self._time = 0
  self._taskId = 0
  local skill = self._context._skill
  if self._moveType == EMoveType.MoveForward then
    self._taskId = Utility.CreateMoveForwardTask(skill:GetAttacker(), -self._distance)
  elseif self._moveType == EMoveType.MoveBack then
    self._taskId = Utility.CreateMoveBackTask(skill:GetAttacker())
  elseif self._moveType == EMoveType.MoveToTarget and skill:GetTarget(1) then
    self._taskId = Utility.CreateMoveToTargetTask(skill:GetAttacker(), skill:GetTarget(1))
  end
end

function Move:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time > self._totalTime then
    self._time = self._totalTime
  end
  local skill = self._context._skill
  Utility.UpdateMoveTask(skill:GetAttacker(), self._taskId, self._time, self._totalTime)
  if self._time == self._totalTime then
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

function Move:OnEnd()
  if self._time ~= self._totalTime then
    Utility.UpdateMoveTask(self._context._skill:GetAttacker(), self._taskId, self._totalTime, self._totalTime)
  end
end

function Move:GetCheckPoints()
  return self._totalTime - self._time
end

return Move
