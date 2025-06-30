-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/composites/referencedbehavior.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStatus = require("luabehavior.base.taskstatus")
local Task = require("luabehavior.base.task")
local ReferencedBehavior = class("ReferencedBehavior", Task)
ReferencedBehavior.Ctor = function(self, context, behaviorName)
  -- function num : 0_0 , upvalues : ReferencedBehavior, _ENV
  ((ReferencedBehavior.super).Ctor)(self)
  self._context = context
  if behaviorName and behaviorName ~= "" then
    self._behaviorTree = (require("data.behavior." .. (string.gsub)((string.lower)(behaviorName), "/", ".")))(context)
  end
end

ReferencedBehavior.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : TaskStatus
  do
    if self._behaviorTree then
      local status = (self._behaviorTree):GetStatus()
      if status == TaskStatus.Invalid then
        (self._behaviorTree):OnStart()
        status = (self._behaviorTree):SetStatus(TaskStatus.Running)
      end
      status = (self._behaviorTree):SetStatus((self._behaviorTree):OnUpdate(deltaTime))
      if status == TaskStatus.Success or status == TaskStatus.Failure then
        (self._behaviorTree):OnEnd()
        ;
        (self._behaviorTree):SetStatus(TaskStatus.Invalid)
      end
      return status
    end
    return TaskStatus.Success
  end
end

ReferencedBehavior.OnEnd = function(self)
  -- function num : 0_2 , upvalues : ReferencedBehavior, TaskStatus
  ((ReferencedBehavior.super).OnEnd)(self)
  if self._behaviorTree and (self._behaviorTree):GetStatus() ~= TaskStatus.Invalid then
    (self._behaviorTree):OnEnd()
    ;
    (self._behaviorTree):SetStatus(TaskStatus.Invalid)
  end
end

ReferencedBehavior.GetCheckPoints = function(self)
  -- function num : 0_3
  if self._behaviorTree then
    return (self._behaviorTree):GetCheckPoints()
  end
  return 0
end

return ReferencedBehavior

