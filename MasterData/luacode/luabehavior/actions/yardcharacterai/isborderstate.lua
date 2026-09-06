local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsBorderState = class("IsBorderState", Task)

function IsBorderState:Ctor(context, direction, arriveborder, action)
  IsBorderState.super.Ctor(self)
  self._character = context._character
  self._direction = direction
  self._arriveborder = arriveborder
  self._action = action
end

function IsBorderState:OnStart()
end

function IsBorderState:OnUpdate(deltaTime)
  if self._character then
    local result = self._character:IsBorderState(self._direction, self._arriveborder, self._action)
    if result then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
end

function IsBorderState:OnEnd()
end

return IsBorderState
