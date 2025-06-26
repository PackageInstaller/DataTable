-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/yardcharacterai/walkorstand.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local WalkOrStand = class("WalkOrStand", Task)
WalkOrStand.Ctor = function(self, context, type, direction, minTime, maxTime)
  -- function num : 0_0 , upvalues : WalkOrStand
  ((WalkOrStand.super).Ctor)(self)
  self._character = context._character
  self._type = type
  self._direction = direction
  self._minTime = minTime
  self._maxTime = maxTime
end

WalkOrStand.OnStart = function(self)
  -- function num : 0_1
end

WalkOrStand.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._character then
    (self._character):WalkOrStand(self._type, self._direction, self._minTime, self._maxTime)
  else
    return TaskStatus.Failure
  end
  return TaskStatus.Success
end

WalkOrStand.OnEnd = function(self)
  -- function num : 0_3
end

return WalkOrStand

