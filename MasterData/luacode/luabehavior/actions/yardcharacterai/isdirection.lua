local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsDirection = class("IsDirection", Task)

function IsDirection:Ctor(context, direction)
  IsDirection.super.Ctor(self)
  self._character = context._character
  self._direction = direction
end

function IsDirection:OnStart()
end

function IsDirection:OnUpdate(deltaTime)
  if self._character then
    local result = self._character:IsDirection(self._direction)
    if result then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
end

function IsDirection:OnEnd()
end

return IsDirection
