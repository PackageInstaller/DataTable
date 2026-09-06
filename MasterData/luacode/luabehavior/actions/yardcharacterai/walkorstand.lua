local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local WalkOrStand = class("WalkOrStand", Task)

function WalkOrStand:Ctor(context, type, direction, minTime, maxTime)
  WalkOrStand.super.Ctor(self)
  self._character = context._character
  self._type = type
  self._direction = direction
  self._minTime = minTime
  self._maxTime = maxTime
end

function WalkOrStand:OnStart()
end

function WalkOrStand:OnUpdate(deltaTime)
  if self._character then
    self._character:WalkOrStand(self._type, self._direction, self._minTime, self._maxTime)
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Success
end

function WalkOrStand:OnEnd()
end

return WalkOrStand
