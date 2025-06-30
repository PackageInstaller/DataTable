-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/yardcharacterai/stand.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local Stand = class("Stand", Task)
Stand.Ctor = function(self, context, same, minTime, maxTime)
  -- function num : 0_0 , upvalues : Stand
  ((Stand.super).Ctor)(self)
  self._character = context._character
  self._same = same
  self._minTime = minTime
  self._maxTime = maxTime
end

Stand.OnStart = function(self)
  -- function num : 0_1
end

Stand.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._character then
    (self._character):Stand(self._same, self._minTime, self._maxTime)
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Success
end

Stand.OnEnd = function(self)
  -- function num : 0_3
end

return Stand

