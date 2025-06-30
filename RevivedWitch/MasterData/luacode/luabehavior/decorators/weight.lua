-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/decorators/weight.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Weight = class("Weight", Task)
Weight.Ctor = function(self, weight)
  -- function num : 0_0 , upvalues : Weight
  ((Weight.super).Ctor)(self)
  self._task = nil
  self._weight = weight
end

Weight.SetTask = function(self, task)
  -- function num : 0_1
  self._task = task
end

Weight.GetWeight = function(self)
  -- function num : 0_2
  return self._weight
end

Weight.OnUpdate = function(self, deltaTime)
  -- function num : 0_3 , upvalues : TaskStatus
  if self._task then
    if (self._task):GetStatus() == TaskStatus.Invalid then
      (self._task):OnStart()
      ;
      (self._task):SetStatus(TaskStatus.Running)
    end
    local status = (self._task):SetStatus((self._task):OnUpdate(deltaTime))
    if status == TaskStatus.Success or status == TaskStatus.Failure then
      (self._task):OnEnd()
      ;
      (self._task):SetStatus(TaskStatus.Invalid)
    end
    return status
  end
  do
    return TaskStatus.Success
  end
end

Weight.OnEnd = function(self)
  -- function num : 0_4 , upvalues : Weight, TaskStatus
  ((Weight.super).OnEnd)(self)
  if self._task and (self._task):GetStatus() ~= TaskStatus.Invalid then
    (self._task):OnEnd()
    ;
    (self._task):SetStatus(TaskStatus.Invalid)
  end
end

Weight.GetCheckPoints = function(self)
  -- function num : 0_5 , upvalues : TaskStatus
  if self._status == TaskStatus.Invalid then
    return 0
  else
    if not self._task then
      return (self._task):GetCheckPoints()
    else
      return 0
    end
  end
end

return Weight

