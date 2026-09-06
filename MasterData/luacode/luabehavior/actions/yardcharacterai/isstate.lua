local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsState = class("IsState", Task)

function IsState:Ctor(context, type)
  IsState.super.Ctor(self)
  self._character = context._character
  self._type = type
end

function IsState:OnStart()
end

function IsState:OnUpdate(deltaTime)
  if self._character then
    local result = self._character:IsState(self._type)
    if result then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
end

function IsState:OnEnd()
end

return IsState
