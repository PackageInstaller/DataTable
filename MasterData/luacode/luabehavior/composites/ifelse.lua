local Behavior_Status = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local IfElse = class("IfElse", Task)

function IfElse:Ctor()
  IfElse.super.Ctor(self)
  self._index = 1
  self._tasks = {}
end

function IfElse:AddTask(condition, trueCase, falseCase)
  self._tasks[1] = condition
  self._tasks[2] = trueCase
  self._tasks[3] = falseCase
end

function IfElse:OnStart()
  self._index = 1
end

function IfElse:OnUpdate(deltaTime)
  local selfStatus = Behavior_Status.Running
  local checkTime = self:GetCheckPoints()
  local delta = math.min(checkTime, deltaTime)
  deltaTime = deltaTime - delta
  selfStatus = self:SelfUpdate(delta)
  if selfStatus == Behavior_Status.Running then
    while 0 < deltaTime do
      checkTime = self:GetCheckPoints()
      delta = math.min(checkTime, deltaTime)
      deltaTime = deltaTime - delta
      selfStatus = self:SelfUpdate(delta)
      if selfStatus ~= Behavior_Status.Running then
        break
      end
    end
  end
  return selfStatus
end

function IfElse:SelfUpdate(deltaTime)
  if self._index == 1 then
    return self:OnUpdateCondition(deltaTime)
  elseif self._index == 2 then
    return self:OnUpdateTrueCase(deltaTime)
  elseif self._index == 3 then
    return self:OnUpdateFalseCase(deltaTime)
  end
end

function IfElse:OnEnd()
  IfElse.super.OnEnd(self)
  if self._index == 1 then
    self._tasks[1]:OnEnd()
    self._tasks[1]:SetStatus(Behavior_Status.Invalid)
  elseif self._index == 2 and self._tasks[2]:GetStatus() ~= Behavior_Status.Invalid then
    self._tasks[2]:OnEnd()
    self._tasks[2]:SetStatus(Behavior_Status.Invalid)
  elseif self._index == 3 and self._tasks[3]:GetStatus() ~= Behavior_Status.Invalid then
    self._tasks[3]:OnEnd()
    self._tasks[3]:SetStatus(Behavior_Status.Invalid)
  end
end

function IfElse:OnUpdateCondition(deltaTime)
  local task = self._tasks[1]
  if task:GetStatus() == Behavior_Status.Invalid then
    task:OnStart()
    task:SetStatus(Behavior_Status.Running)
  end
  local status = task:SetStatus(task:OnUpdate(deltaTime))
  if status == Behavior_Status.Success then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
    self._index = 2
    return self:OnUpdateTrueCase(0)
  elseif status == Behavior_Status.Failure then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
    self._index = 3
    return self:OnUpdateFalseCase(0)
  end
  return Behavior_Status.Running
end

function IfElse:OnUpdateTrueCase(deltaTime)
  local task = self._tasks[2]
  if task:GetStatus() == Behavior_Status.Invalid then
    task:OnStart()
    task:SetStatus(Behavior_Status.Running)
  end
  local status = task:SetStatus(task:OnUpdate(deltaTime))
  if status == Behavior_Status.Success then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
    return Behavior_Status.Success
  elseif status == Behavior_Status.Failure then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
    return Behavior_Status.Failure
  end
  return Behavior_Status.Running
end

function IfElse:OnUpdateFalseCase(deltaTime)
  local task = self._tasks[3]
  if task:GetStatus() == Behavior_Status.Invalid then
    task:OnStart()
    task:SetStatus(Behavior_Status.Running)
  end
  local status = task:SetStatus(task:OnUpdate(deltaTime))
  if status == Behavior_Status.Success then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
    return Behavior_Status.Success
  elseif status == Behavior_Status.Failure then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
    return Behavior_Status.Failure
  end
  return Behavior_Status.Running
end

function IfElse:GetCheckPoints()
  if self._status == Behavior_Status.Invalid then
    return 0
  elseif 0 < #self._tasks then
    return self._tasks[self._index]:GetCheckPoints()
  else
    return 0
  end
end

return IfElse
