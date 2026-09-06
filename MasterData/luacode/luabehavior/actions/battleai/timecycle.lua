local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local TimeCycle = class("TimeCycle", Task)

function TimeCycle:Ctor(context, loopTime)
  TimeCycle.super.Ctor(self)
  self._context = context
  self._loopTime = loopTime
  self._countIndex = 0
end

function TimeCycle:OnStart()
end

function TimeCycle:OnUpdate(deltaTime)
  self._countIndex = self._countIndex + 1
  if self._countIndex >= self._loopTime then
    self._countIndex = 0
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

function TimeCycle:OnEnd()
end

return TimeCycle
