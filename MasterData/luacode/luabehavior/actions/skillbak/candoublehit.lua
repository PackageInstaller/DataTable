local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local CanDoubleHit = class("CanDoubleHit", Task)

function CanDoubleHit:Ctor(context, CanDoubleHitType)
  CanDoubleHit.super.Ctor(self)
  self._context = context
  self._CanDoubleHitType = CanDoubleHitType
end

function CanDoubleHit:OnUpdate(deltaTime)
  if self._context._skill:CanDoubleHit() then
    return Behavior_Status.Success
  end
  return Behavior_Status.Failure
end

return CanDoubleHit
