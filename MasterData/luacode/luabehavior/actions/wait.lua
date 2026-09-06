local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local Wait = class("Wait", Task)

function Wait:Ctor(totalTime)
  Wait.super.Ctor(self)
  self._time = 0
  self._totalTime = totalTime
end

function Wait:OnUpdate(deltaTime)
  self._time = self._time + deltaTime
  if self._time >= self._totalTime then
    self._time = self._totalTime
    return Behavior_Status.Success
  end
  return Behavior_Status.Running
end

function Wait:GetCheckPoints()
  return self._totalTime - self._time
end

return Wait
