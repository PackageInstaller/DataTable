-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/timecycle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local TimeCycle = class("TimeCycle", Task)
TimeCycle.Ctor = function(self, context, loopTime)
  -- function num : 0_0 , upvalues : TimeCycle
  ((TimeCycle.super).Ctor)(self)
  self._context = context
  self._loopTime = loopTime
  self._countIndex = 0
end

TimeCycle.OnStart = function(self)
  -- function num : 0_1
end

TimeCycle.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  self._countIndex = self._countIndex + 1
  if self._loopTime <= self._countIndex then
    self._countIndex = 0
    return TaskStatus.Success
  end
  return TaskStatus.Failure
end

TimeCycle.OnEnd = function(self)
  -- function num : 0_3
end

return TimeCycle

