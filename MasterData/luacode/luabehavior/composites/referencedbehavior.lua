local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local ReferencedBehavior = class("ReferencedBehavior", Task)

function ReferencedBehavior:Ctor(context, behaviorName)
  ReferencedBehavior.super.Ctor(self)
  self._context = context
  if behaviorName and behaviorName ~= "" then
    self._behaviorTree = require("data.behavior." .. string.gsub(string.lower(behaviorName), "/", "."))(context)
  end
end

function ReferencedBehavior:OnUpdate(deltaTime)
  if self._behaviorTree then
    local status = self._behaviorTree:GetStatus()
    if status == TaskStatus.Invalid then
      self._behaviorTree:OnStart()
      status = self._behaviorTree:SetStatus(TaskStatus.Running)
    end
    status = self._behaviorTree:SetStatus(self._behaviorTree:OnUpdate(deltaTime))
    if status == TaskStatus.Success or status == TaskStatus.Failure then
      self._behaviorTree:OnEnd()
      self._behaviorTree:SetStatus(TaskStatus.Invalid)
    end
    return status
  end
  return TaskStatus.Success
end

function ReferencedBehavior:OnEnd()
  ReferencedBehavior.super.OnEnd(self)
  if self._behaviorTree and self._behaviorTree:GetStatus() ~= TaskStatus.Invalid then
    self._behaviorTree:OnEnd()
    self._behaviorTree:SetStatus(TaskStatus.Invalid)
  end
end

function ReferencedBehavior:GetCheckPoints()
  if self._behaviorTree then
    return self._behaviorTree:GetCheckPoints()
  end
  return 0
end

return ReferencedBehavior
