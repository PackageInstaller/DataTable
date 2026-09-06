local Behavior_Status = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Sequence = class("Sequence", Task)

function Sequence:Ctor()
  Sequence.super.Ctor(self)
  self._index = 1
  self._tasks = {}
end

function Sequence:AddTask(task)
  table.insert(self._tasks, task)
end

function Sequence:OnStart()
  Sequence.super.OnStart(self)
  self._index = 1
end

function Sequence:OnUpdate(deltaTime)
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

function Sequence:SelfUpdate(deltaTime)
  if #self._tasks > 0 then
    local task = self._tasks[self._index]
    if task:GetStatus() == Behavior_Status.Invalid then
      task:OnStart()
      task:SetStatus(Behavior_Status.Running)
    end
    local status = task:SetStatus(task:OnUpdate(deltaTime))
    if status == Behavior_Status.Success then
      task:OnEnd()
      task:SetStatus(Behavior_Status.Invalid)
      if self._index == #self._tasks then
        self._index = 1
        return Behavior_Status.Success
      else
        self._index = self._index + 1
        return self:SelfUpdate(0)
      end
    elseif status == Behavior_Status.Failure then
      self._index = 1
      task:OnEnd()
      task:SetStatus(Behavior_Status.Invalid)
      return Behavior_Status.Failure
    end
    return Behavior_Status.Running
  else
    return Behavior_Status.Success
  end
end

function Sequence:OnEnd()
  Sequence.super.OnEnd(self)
  local task = self._tasks[self._index]
  if task and task:GetStatus() ~= Behavior_Status.Invalid then
    task:OnEnd()
    task:SetStatus(Behavior_Status.Invalid)
  end
end

function Sequence:GetCheckPoints()
  if self._status == Behavior_Status.Invalid then
    return 0
  elseif 0 < #self._tasks then
    return self._tasks[self._index]:GetCheckPoints()
  else
    return 0
  end
end

return Sequence
