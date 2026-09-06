local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local Walk = class("Walk", Task)

function Walk:Ctor(context, same, minTime, maxTime)
  Walk.super.Ctor(self)
  self._character = context._character
  self._same = same
  self._minTime = minTime
  self._maxTime = maxTime
end

function Walk:OnStart()
end

function Walk:OnUpdate(deltaTime)
  if self._character then
    self._character:Walk(self._same, self._minTime, self._maxTime)
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Success
end

function Walk:OnEnd()
end

return Walk
