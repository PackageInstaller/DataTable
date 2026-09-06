local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Weight = class("Weight", Task)

function Weight:Ctor(weight)
  Weight.super.Ctor(self)
  self._task = nil
  self._weight = weight
end

function Weight:SetTask(task)
  self._task = task
end

function Weight:GetWeight()
  return self._weight
end

function Weight:OnUpdate(deltaTime)
  if self._task then
    if self._task:GetStatus() == TaskStatus.Invalid then
      self._task:OnStart()
      self._task:SetStatus(TaskStatus.Running)
    end
    local status = self._task:SetStatus(self._task:OnUpdate(deltaTime))
    if status == TaskStatus.Success or status == TaskStatus.Failure then
      self._task:OnEnd()
      self._task:SetStatus(TaskStatus.Invalid)
    end
    return status
  end
  return TaskStatus.Success
end

function Weight:OnEnd()
  Weight.super.OnEnd(self)
  if self._task and self._task:GetStatus() ~= TaskStatus.Invalid then
    self._task:OnEnd()
    self._task:SetStatus(TaskStatus.Invalid)
  end
end

function Weight:GetCheckPoints()
  if self._status == TaskStatus.Invalid then
    return 0
  elseif not self._task then
    return self._task:GetCheckPoints()
  else
    return 0
  end
end

return Weight
