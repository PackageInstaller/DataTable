-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/decorators/loopuntil.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local LoopUntil = class("LoopUntil", Task)
LoopUntil.Ctor = function(self, context, totalCount, util)
  -- function num : 0_0 , upvalues : LoopUntil, TaskStatus
  ((LoopUntil.super).Ctor)(self)
  self._context = context
  self._totalCount = totalCount
  if util then
    self._util = TaskStatus.Success
  else
    self._util = TaskStatus.Failure
  end
  self._count = 0
end

LoopUntil.SetTask = function(self, task)
  -- function num : 0_1
  self._task = task
end

LoopUntil.OnStart = function(self)
  -- function num : 0_2 , upvalues : LoopUntil
  ((LoopUntil.super).OnStart)(self)
end

LoopUntil.OnUpdate = function(self, deltaTime)
  -- function num : 0_3 , upvalues : TaskStatus
  if self._totalCount == 0 then
    return TaskStatus.Success
  end
  if self._totalCount < 0 then
    local status = self:SelfUpdate(deltaTime)
    if status == self._util then
      return TaskStatus.Success
    end
  else
    do
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
end

LoopUntil.OnEnd = function(self)
  -- function num : 0_4 , upvalues : LoopUntil, TaskStatus
  ((LoopUntil.super).OnEnd)(self)
  if (self._task):GetStatus() ~= TaskStatus.Invalid then
    (self._task):OnEnd()
    ;
    (self._task):SetStatus(TaskStatus.Invalid)
  end
end

LoopUntil.GetCheckPoints = function(self)
  -- function num : 0_5
  if self._totalCount == 0 then
    return 0
  end
  return (self._task):GetCheckPoints()
end

LoopUntil.SelfUpdate = function(self, deltaTime)
  -- function num : 0_6 , upvalues : TaskStatus
  local status = (self._task):GetStatus()
  if status == TaskStatus.Invalid then
    (self._task):OnStart()
    status = (self._task):SetStatus(TaskStatus.Running)
  end
  status = (self._task):SetStatus((self._task):OnUpdate(deltaTime))
  if status == TaskStatus.Success or status == TaskStatus.Failure then
    (self._task):OnEnd()
    ;
    (self._task):SetStatus(TaskStatus.Invalid)
  end
  return status
end

return LoopUntil

