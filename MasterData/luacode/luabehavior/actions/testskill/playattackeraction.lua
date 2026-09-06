local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local PlayAttackerAction = class("PlayAttackerAction", Task)

function PlayAttackerAction:Ctor(context, actionName)
  PlayAttackerAction.super.Ctor(self)
  self._context = context
  self._actionName = actionName
  self._time = 0
  self._totalTime = 200
  self._handle = 0
end

function PlayAttackerAction:OnStart()
  self._time = 0
  self._handle = BattleECS.Utilitys.FighterUtility.PlayAction(self._context.world, self._context.attacker._entityId, self._actionName)
end

function PlayAttackerAction:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time >= self._totalTime then
    self._time = self._totalTime
    return TaskStatus.Success
  end
  return TaskStatus.Running
end

function PlayAttackerAction:OnEnd()
  if self._handle then
    BattleECS.Utilitys.FighterUtility.StopAction(self._context.world, self._context.attacker._entityId, self._handle)
  end
end

function PlayAttackerAction:GetCheckPoints()
  return self._totalTime - self._time
end

return PlayAttackerAction
