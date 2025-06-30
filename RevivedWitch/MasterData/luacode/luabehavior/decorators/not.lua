-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/decorators/not.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local Not = class("Not", Task)
Not.Ctor = function(self)
  -- function num : 0_0 , upvalues : Not
  ((Not.super).Ctor)(self)
  self._task = nil
end

Not.SetTask = function(self, task)
  -- function num : 0_1
  self._task = task
end

Not.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._task then
    if (self._task):GetStatus() == TaskStatus.Invalid then
      (self._task):OnStart()
      ;
      (self._task):SetStatus(TaskStatus.Running)
    end
    local status = (self._task):SetStatus((self._task):OnUpdate(deltaTime))
    if status == TaskStatus.Success then
      (self._task):OnEnd()
      ;
      (self._task):SetStatus(TaskStatus.Invalid)
      return TaskStatus.Failure
    else
      if status == TaskStatus.Failure then
        (self._task):OnEnd()
        ;
        (self._task):SetStatus(TaskStatus.Invalid)
        return TaskStatus.Success
      end
    end
    return status
  end
  do
    return TaskStatus.Success
  end
end

Not.OnEnd = function(self)
  -- function num : 0_3 , upvalues : Not, TaskStatus
  ((Not.super).OnEnd)(self)
  if self._task and (self._task):GetStatus() ~= TaskStatus.Invalid then
    (self._task):OnEnd()
    ;
    (self._task):SetStatus(TaskStatus.Invalid)
  end
end

Not.GetCheckPoints = function(self)
  -- function num : 0_4 , upvalues : TaskStatus
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

return Not

