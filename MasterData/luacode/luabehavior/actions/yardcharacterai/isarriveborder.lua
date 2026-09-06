local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsArriveBorder = class("IsArriveBorder", Task)

function IsArriveBorder:Ctor(context)
  IsArriveBorder.super.Ctor(self)
  self._character = context._character
end

function IsArriveBorder:OnStart()
end

function IsArriveBorder:OnUpdate(deltaTime)
  if self._character then
    local result = self._character:IsArriveBorder()
    if result then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    return TaskStatus.Failure
  end
end

function IsArriveBorder:OnEnd()
end

return IsArriveBorder
