local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Policy = {
  FAIL_ON_ONE = 1,
  FAIL_ON_ALL = 2,
  SUCCEED_ON_ONE = 3,
  SUCCEED_ON_ALL = 4,
  CHILDFINISH_ONCE = 5,
  CHILDFINISH_LOOP = 6,
  EXIT_ABORT_RUNNINGSIBLINGS = 7,
  EXIT_NONE = 8
}
local Parallel = class("Parallel", Task)

function Parallel:Ctor(failurePolicy, successPolicy, childFinishPolicy, exitPolicy)
  Parallel.super.Ctor(self)
  self._failurePolicy = Policy[failurePolicy]
  self._successPolicy = Policy[successPolicy]
  self._childFinishPolicy = Policy[childFinishPolicy]
  self._exitPolicy = Policy[exitPolicy]
  self._tasks = {}
  self._tasksStopFlag = {}
  self._tasksStatus = {}
end

function Parallel:AddTask(task)
  table.insert(self._tasks, task)
end

function Parallel:OnStart()
  Parallel.super.OnStart(self)
  self._tasksStopFlag = {}
  self._tasksStatus = {}
end

function Parallel:OnUpdate(deltaTime)
  local selfStatus = TaskStatus.Running
  local checkTime = self:GetCheckPoints()
  local delta = math.min(checkTime, deltaTime)
  deltaTime = deltaTime - delta
  selfStatus = self:SelfUpdate(delta)
  if selfStatus == TaskStatus.Running then
    while 0 < deltaTime do
      checkTime = self:GetCheckPoints()
      delta = math.min(checkTime, deltaTime)
      deltaTime = deltaTime - delta
      selfStatus = self:SelfUpdate(delta)
      if selfStatus ~= TaskStatus.Running then
        break
      end
    end
  end
  return selfStatus
end

function Parallel:SelfUpdate(deltaTime)
  local selfStatus = TaskStatus.Running
  local childStatus = TaskStatus.Invalid
  for i, task in ipairs(self._tasks) do
    if not self._tasksStopFlag[i] then
      childStatus = task:GetStatus()
      if childStatus == TaskStatus.Invalid then
        task:OnStart()
        task:SetStatus(TaskStatus.Running)
      end
      childStatus = task:SetStatus(task:OnUpdate(deltaTime))
      if childStatus == TaskStatus.Success then
        task:OnEnd()
        task:SetStatus(TaskStatus.Invalid)
        self._tasksStatus[i] = self._tasksStatus[i] or childStatus
        if self._childFinishPolicy == Policy.CHILDFINISH_ONCE then
          self._tasksStopFlag[i] = true
        end
        if self._successPolicy == Policy.SUCCEED_ON_ONE then
          selfStatus = TaskStatus.Success
        end
      elseif childStatus == TaskStatus.Failure then
        task:OnEnd()
        task:SetStatus(TaskStatus.Invalid)
        self._tasksStatus[i] = self._tasksStatus[i] or childStatus
        if self._childFinishPolicy == Policy.CHILDFINISH_ONCE then
          self._tasksStopFlag[i] = true
        end
        if self._failurePolicy == Policy.FAIL_ON_ONE then
          selfStatus = TaskStatus.Failure
        end
      end
    end
  end
  if table.nums(self._tasksStatus) == #self._tasks and selfStatus == TaskStatus.Running then
    for i, status in ipairs(self._tasksStatus) do
      if status == TaskStatus.Failure and self._successPolicy == Policy.SUCCEED_ON_ALL then
        selfStatus = TaskStatus.Failure
        break
      elseif status == TaskStatus.Success and self._failurePolicy == Policy.FAIL_ON_ALL then
        selfStatus = TaskStatus.Success
        break
      end
    end
    if selfStatus == TaskStatus.Running then
      selfStatus = TaskStatus.Success
    end
  end
  return selfStatus
end

function Parallel:OnEnd()
  Parallel.super.OnEnd(self)
  for i, task in ipairs(self._tasks) do
    if task:GetStatus() ~= TaskStatus.Invalid then
      task:OnEnd()
      task:SetStatus(TaskStatus.Invalid)
    end
  end
end

function Parallel:GetCheckPoints()
  if self._status == TaskStatus.Invalid then
    return 0
  elseif 0 < #self._tasks then
    local time = math.maxinteger
    for i = 1, #self._tasks do
      if not self._tasksStatus[i] then
        time = math.min(time, self._tasks[i]:GetCheckPoints())
      end
    end
    return time
  else
    return 0
  end
end

return Parallel
