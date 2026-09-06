local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local Noop = class("Noop", Task)

function Noop:Ctor(context)
  Noop.super.Ctor(self)
  self._context = context
end

function Noop:OnUpdate(deltaTime)
  return Behavior_Status.Success
end

return Noop
