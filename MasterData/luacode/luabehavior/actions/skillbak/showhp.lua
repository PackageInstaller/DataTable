local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local ShowHP = class("ShowHP", Task)

function ShowHP:Ctor(context, identityInBattle)
  ShowHP.super.Ctor(self)
  self._context = context
  self._identityInBattle = identityInBattle
end

function ShowHP:OnUpdate(deltaTime)
  self._context._world:FireEvent(self._context._world._events.SkillShowHpBar, self._identityInBattle, self._context._skill)
  return Behavior_Status.Success
end

return ShowHP
