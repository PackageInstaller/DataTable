-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/base/task.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Behavior_Status = require("luabehavior.base.taskstatus")
local Task = class("Task")
Task.Ctor = function(self)
  -- function num : 0_0 , upvalues : Behavior_Status
  self._status = Behavior_Status.Invalid
end

Task.OnStart = function(self)
  -- function num : 0_1
end

Task.OnUpdate = function(self, deltaTime)
  -- function num : 0_2
end

Task.OnEnd = function(self)
  -- function num : 0_3
end

Task.GetStatus = function(self)
  -- function num : 0_4
  return self._status
end

Task.SetStatus = function(self, status)
  -- function num : 0_5
  self._status = status
  return status
end

Task.GetCheckPoints = function(self)
  -- function num : 0_6
  return 0
end

return Task

