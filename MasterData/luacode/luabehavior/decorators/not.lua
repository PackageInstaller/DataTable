local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Not = class("Not", Task)

function Not:Ctor()
  Not.super.Ctor(self)
  self._task = nil
end

function Not:SetTask(task)
  self._task = task
end

function Not:OnUpdate(deltaTime)
  if self._task then
    if self._task:GetStatus() == TaskStatus.Invalid then
      self._task:OnStart()
      self._task:SetStatus(TaskStatus.Running)
    end
    local status = self._task:SetStatus(self._task:OnUpdate(deltaTime))
    if status == TaskStatus.Success then
      self._task:OnEnd()
      self._task:SetStatus(TaskStatus.Invalid)
      return TaskStatus.Failure
    elseif status == TaskStatus.Failure then
      self._task:OnEnd()
      self._task:SetStatus(TaskStatus.Invalid)
      return TaskStatus.Success
    end
    return status
  end
  return TaskStatus.Success
end

function Not:OnEnd()
  Not.super.OnEnd(self)
  if self._task and self._task:GetStatus() ~= TaskStatus.Invalid then
    self._task:OnEnd()
    self._task:SetStatus(TaskStatus.Invalid)
  end
end

function Not:GetCheckPoints()
  if self._status == TaskStatus.Invalid then
    return 0
  elseif not self._task then
    return self._task:GetCheckPoints()
  else
    return 0
  end
end

return Not
