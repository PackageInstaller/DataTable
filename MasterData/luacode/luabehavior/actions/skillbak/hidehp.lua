local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local HideHP = class("HideHP", Task)

function HideHP:Ctor(context, identityInBattle)
  HideHP.super.Ctor(self)
  self._context = context
  self._identityInBattle = identityInBattle
end

function HideHP:OnUpdate(deltaTime)
  self._context._world:FireEvent(self._context._world._events.SkillHideHpBar, self._identityInBattle, self._context._skill)
  return Behavior_Status.Success
end

return HideHP
