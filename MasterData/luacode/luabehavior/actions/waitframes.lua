local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local WaitFrames = class("WaitFrames", Task)

function WaitFrames:Ctor(totalFrames)
  WaitFrames.super.Ctor(self)
  self._countFrame = 0
  self._totalFrames = totalFrames
end

function WaitFrames:OnUpdate(deltaTime)
  self._countFrame = self._countFrame + 1
  if self._countFrame >= self._totalFrames then
    self._countFrame = self._totalFrames
    return Behavior_Status.Success
  end
  return Behavior_Status.Running
end

function WaitFrames:GetCheckPoints()
  return self._totalFrames - self._countFrame
end

return WaitFrames
