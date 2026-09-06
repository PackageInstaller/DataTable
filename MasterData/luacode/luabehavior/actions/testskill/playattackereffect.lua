local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local PlayAttackerEffect = class("PlayAttackerEffect", Task)

function PlayAttackerEffect:Ctor(context, actionName)
  PlayAttackerEffect.super.Ctor(self)
  self._context = context
  self._actionName = actionName
  self._time = 0
  self._totalTime = 200
  self._handle = 0
end

function PlayAttackerEffect:OnStart()
  self._time = 0
  self._handle = BattleECS.Utilitys.FighterUtility.PlayAction(self._context.world, self._context.attacker._entityId, self._actionName)
end

function PlayAttackerEffect:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time >= self._totalTime then
    self._time = self._totalTime
    return TaskStatus.Success
  end
  return TaskStatus.Running
end

function PlayAttackerEffect:OnEnd()
  if self._handle then
    BattleECS.Utilitys.FighterUtility.StopAction(self._context.world, self._context.attacker._entityId, self._handle)
  end
end

function PlayAttackerEffect:GetCheckPoints()
  return self._totalTime - self._time
end

return PlayAttackerEffect
