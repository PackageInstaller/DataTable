local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local LoopUntil = class("LoopUntil", Task)

function LoopUntil:Ctor(context, totalCount, util)
  LoopUntil.super.Ctor(self)
  self._context = context
  self._totalCount = totalCount
  if util then
    self._util = TaskStatus.Success
  else
    self._util = TaskStatus.Failure
  end
  self._count = 0
end

function LoopUntil:SetTask(task)
  self._task = task
end

function LoopUntil:OnStart()
  LoopUntil.super.OnStart(self)
end

function LoopUntil:OnUpdate(deltaTime)
  if self._totalCount == 0 then
    return TaskStatus.Success
  end
  if self._totalCount < 0 then
    local status = self:SelfUpdate(deltaTime)
    if status == self._util then
      return TaskStatus.Success
    end
  else
    if self._count == self._totalCount then
      return TaskStatus.Failure
    end
    local status = self:SelfUpdate(deltaTime)
    if status == TaskStatus.Success or status == TaskStatus.Failure then
      if self._count == self._totalCount then
        return TaskStatus.Failure
      else
        self._count = self._count + 1
        if status == self._util then
          return TaskStatus.Success
        else
          return TaskStatus.Running
        end
      end
    end
  end
end

function LoopUntil:OnEnd()
  LoopUntil.super.OnEnd(self)
  if self._task:GetStatus() ~= TaskStatus.Invalid then
    self._task:OnEnd()
    self._task:SetStatus(TaskStatus.Invalid)
  end
end

function LoopUntil:GetCheckPoints()
  if self._totalCount == 0 then
    return 0
  end
  return self._task:GetCheckPoints()
end

function LoopUntil:SelfUpdate(deltaTime)
  local status = self._task:GetStatus()
  if status == TaskStatus.Invalid then
    self._task:OnStart()
    status = self._task:SetStatus(TaskStatus.Running)
  end
  status = self._task:SetStatus(self._task:OnUpdate(deltaTime))
  if status == TaskStatus.Success or status == TaskStatus.Failure then
    self._task:OnEnd()
    self._task:SetStatus(TaskStatus.Invalid)
  end
  return status
end

return LoopUntil
