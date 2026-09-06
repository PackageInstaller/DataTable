local Behavior_Status = require("luabehavior.base.taskstatus")
local Task = class("Task")

function Task:Ctor()
  self._status = Behavior_Status.Invalid
end

function Task:OnStart()
end

function Task:OnUpdate(deltaTime)
end

function Task:OnEnd()
end

function Task:GetStatus()
  return self._status
end

function Task:SetStatus(status)
  self._status = status
  return status
end

function Task:GetCheckPoints()
  return 0
end

return Task
