-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/composites/parallel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Policy = {FAIL_ON_ONE = 1, FAIL_ON_ALL = 2, SUCCEED_ON_ONE = 3, SUCCEED_ON_ALL = 4, CHILDFINISH_ONCE = 5, CHILDFINISH_LOOP = 6, EXIT_ABORT_RUNNINGSIBLINGS = 7, EXIT_NONE = 8}
local Parallel = class("Parallel", Task)
Parallel.Ctor = function(self, failurePolicy, successPolicy, childFinishPolicy, exitPolicy)
  -- function num : 0_0 , upvalues : Parallel, Policy
  ((Parallel.super).Ctor)(self)
  self._failurePolicy = Policy[failurePolicy]
  self._successPolicy = Policy[successPolicy]
  self._childFinishPolicy = Policy[childFinishPolicy]
  self._exitPolicy = Policy[exitPolicy]
  self._tasks = {}
  self._tasksStopFlag = {}
  self._tasksStatus = {}
end

Parallel.AddTask = function(self, task)
  -- function num : 0_1 , upvalues : _ENV
  (table.insert)(self._tasks, task)
end

Parallel.OnStart = function(self)
  -- function num : 0_2 , upvalues : Parallel
  ((Parallel.super).OnStart)(self)
  self._tasksStopFlag = {}
  self._tasksStatus = {}
end

Parallel.OnUpdate = function(self, deltaTime)
  -- function num : 0_3 , upvalues : TaskStatus, _ENV
  local selfStatus = TaskStatus.Running
  local checkTime = self:GetCheckPoints()
  local delta = (math.min)(checkTime, deltaTime)
  deltaTime = deltaTime - delta
  selfStatus = self:SelfUpdate(delta)
  while selfStatus == TaskStatus.Running and deltaTime > 0 do
    checkTime = self:GetCheckPoints()
    delta = (math.min)(checkTime, deltaTime)
    deltaTime = deltaTime - delta
    selfStatus = self:SelfUpdate(delta)
  end
  if selfStatus == TaskStatus.Running then
    return selfStatus
  end
end

Parallel.SelfUpdate = function(self, deltaTime)
  -- function num : 0_4 , upvalues : TaskStatus, _ENV, Policy
  local selfStatus = TaskStatus.Running
  local childStatus = TaskStatus.Invalid
  for i,task in ipairs(self._tasks) do
    if not (self._tasksStopFlag)[i] then
      childStatus = task:GetStatus()
      if childStatus == TaskStatus.Invalid then
        task:OnStart()
        task:SetStatus(TaskStatus.Running)
      end
      childStatus = task:SetStatus(task:OnUpdate(deltaTime))
      if childStatus == TaskStatus.Success then
        task:OnEnd()
        task:SetStatus(TaskStatus.Invalid)
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self._tasksStatus)[i] = (self._tasksStatus)[i] or childStatus
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

        if self._childFinishPolicy == Policy.CHILDFINISH_ONCE then
          (self._tasksStopFlag)[i] = true
        end
        if self._successPolicy == Policy.SUCCEED_ON_ONE then
          selfStatus = TaskStatus.Success
        end
      else
        if childStatus == TaskStatus.Failure then
          task:OnEnd()
          task:SetStatus(TaskStatus.Invalid)
          -- DECOMPILER ERROR at PC68: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self._tasksStatus)[i] = (self._tasksStatus)[i] or childStatus
          -- DECOMPILER ERROR at PC74: Confused about usage of register: R9 in 'UnsetPending'

          if self._childFinishPolicy == Policy.CHILDFINISH_ONCE then
            (self._tasksStopFlag)[i] = true
          end
          if self._failurePolicy == Policy.FAIL_ON_ONE then
            selfStatus = TaskStatus.Failure
          end
        end
      end
    end
  end
  if (table.nums)(self._tasksStatus) == #self._tasks and selfStatus == TaskStatus.Running then
    for i,status in ipairs(self._tasksStatus) do
      if status == TaskStatus.Failure and self._successPolicy == Policy.SUCCEED_ON_ALL then
        selfStatus = TaskStatus.Failure
        break
      else
        if status == TaskStatus.Success and self._failurePolicy == Policy.FAIL_ON_ALL then
          selfStatus = TaskStatus.Success
          break
        end
      end
    end
    do
      if selfStatus == TaskStatus.Running then
        selfStatus = TaskStatus.Success
      end
      return selfStatus
    end
  end
end

Parallel.OnEnd = function(self)
  -- function num : 0_5 , upvalues : Parallel, _ENV, TaskStatus
  ((Parallel.super).OnEnd)(self)
  for i,task in ipairs(self._tasks) do
    if task:GetStatus() ~= TaskStatus.Invalid then
      task:OnEnd()
      task:SetStatus(TaskStatus.Invalid)
    end
  end
end

Parallel.GetCheckPoints = function(self)
  -- function num : 0_6 , upvalues : TaskStatus, _ENV
  if self._status == TaskStatus.Invalid then
    return 0
  else
    if #self._tasks > 0 then
      local time = math.maxinteger
      for i = 1, #self._tasks do
        if not (self._tasksStatus)[i] then
          time = (math.min)(time, ((self._tasks)[i]):GetCheckPoints())
        end
      end
      return time
    else
      do
        do return 0 end
      end
    end
  end
end

return Parallel

