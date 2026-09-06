local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsFreeFall = class("IsFreeFall", Task)

function IsFreeFall:Ctor(context, direction, isfreefall)
  IsFreeFall.super.Ctor(self)
  self._character = context._character
  self._direction = direction
  self._arriveborder = arriveborder
  self._isfreefall = isfreefall
end

function IsFreeFall:OnStart()
end

function IsFreeFall:OnUpdate(deltaTime)
  if self._character then
    local result = self._character:IsFreeFall(self._direction, self._isfreefall)
    if result then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
end

function IsFreeFall:OnEnd()
end

return IsFreeFall
