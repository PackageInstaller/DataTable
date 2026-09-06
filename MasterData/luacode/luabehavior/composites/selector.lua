local Behavior_Status = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Selector = class("Selector", Task)

function Selector:Ctor()
  Selector.super.Ctor(self)
  self._index = 1
  self._tasks = {}
end

function Selector:AddTask(task)
  table.insert(self._tasks, task)
end

function Selector:OnStart()
  Selector.super.OnStart(self)
  self._index = 1
end

function Selector:OnUpdate(deltaTime)
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

function Selector:SelfUpdate(deltaTime)
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
      return Behavior_Status.Success
    elseif status == Behavior_Status.Failure then
      task:OnEnd()
      task:SetStatus(Behavior_Status.Invalid)
      if self._index == #self._tasks then
        self._index = 1
        return Behavior_Status.Failure
      else
        self._index = self._index + 1
        return self:OnUpdate(0)
      end
    end
    return Behavior_Status.Running
  else
    return Behavior_Status.Success
  end
end

function Selector:GetCheckPoints()
  if self._status == Behavior_Status.Invalid then
    return 0
  elseif 0 < #self._tasks then
    return self._tasks[self._index]:GetCheckPoints()
  else
    return 0
  end
end

return Selector
