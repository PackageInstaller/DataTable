local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local PositionUtility = require("logic.battle.utility.positionutility")
local AnimaitonUtility = require("logic.battle.utility.animaitonutility")
local Logic_BattlerMoveSystem = require("logic.battle.system.logic.battlermovesystem")
local Exec = class("Exec", Task)

function Exec:Ctor(context)
  Exec.super.Ctor(self)
  self._context = context
  self._time = 0
  self._totalTime = 0
  self._taskId = 0
  self._entityId = 0
end

function Exec:OnStart()
  self._time = 0
  self._taskId = 0
  self._entityId = 0
  if not PositionUtility.AtOriPosition(self._context._world, self._context._entityId) then
    self._totalTime = 150
    self._taskId = self._context._world:GetSystem(Logic_BattlerMoveSystem):MoveBack(self._context._entityId, self._totalTime)
  end
end

function Exec:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time > self._totalTime then
    self._time = self._totalTime
  end
  if self._taskId > 0 then
    self._context._world:GetSystem(Logic_BattlerMoveSystem):UpdateTask(self._context._entityId, self._taskId, self._time)
  end
  if self._time == self._totalTime then
    if not AnimaitonUtility.IsBattleIdle(self._context._world, self._context._entityId) then
      AnimaitonUtility.PlayBattleIdle(self._context._world, self._context._entityId)
    end
    return Behavior_Status.Success
  else
    return Behavior_Status.Running
  end
end

function Exec:OnEnd()
  if self._time ~= self._totalTime then
    if self._taskId > 0 then
      self._context._world:GetSystem(Logic_BattlerMoveSystem):UpdateTask(self._context._entityId, self._taskId, self._totalTime)
    end
    if not AnimaitonUtility.IsBattleIdle(self._context._world, self._context._entityId) then
      AnimaitonUtility.PlayBattleIdle(self._context._world, self._context._entityId)
    end
  end
end

function Exec:GetCheckPoints()
  return self._totalTime - self._time
end

return Exec
