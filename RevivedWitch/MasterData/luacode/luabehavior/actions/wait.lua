-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/wait.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local Wait = class("Wait", Task)
Wait.Ctor = function(self, totalTime)
  -- function num : 0_0 , upvalues : Wait
  ((Wait.super).Ctor)(self)
  self._time = 0
  self._totalTime = totalTime
end

Wait.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Behavior_Status
  self._time = self._time + deltaTime
  if self._totalTime <= self._time then
    self._time = self._totalTime
    return Behavior_Status.Success
  end
  return Behavior_Status.Running
end

Wait.GetCheckPoints = function(self)
  -- function num : 0_2
  return self._totalTime - self._time
end

return Wait

