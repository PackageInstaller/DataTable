local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local Stand = class("Stand", Task)

function Stand:Ctor(context, same, minTime, maxTime)
  Stand.super.Ctor(self)
  self._character = context._character
  self._same = same
  self._minTime = minTime
  self._maxTime = maxTime
end

function Stand:OnStart()
end

function Stand:OnUpdate(deltaTime)
  if self._character then
    self._character:Stand(self._same, self._minTime, self._maxTime)
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Success
end

function Stand:OnEnd()
end

return Stand
