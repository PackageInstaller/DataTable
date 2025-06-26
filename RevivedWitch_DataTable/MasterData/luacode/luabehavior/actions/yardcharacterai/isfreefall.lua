-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/yardcharacterai/isfreefall.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsFreeFall = class("IsFreeFall", Task)
IsFreeFall.Ctor = function(self, context, direction, isfreefall)
  -- function num : 0_0 , upvalues : IsFreeFall, _ENV
  ((IsFreeFall.super).Ctor)(self)
  self._character = context._character
  self._direction = direction
  self._arriveborder = arriveborder
  self._isfreefall = isfreefall
end

IsFreeFall.OnStart = function(self)
  -- function num : 0_1
end

IsFreeFall.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._character then
    local result = (self._character):IsFreeFall(self._direction, self._isfreefall)
    if result then
      return TaskStatus.Success
    else
      return TaskStatus.Failure
    end
  else
    do
      do return TaskStatus.Failure end
    end
  end
end

IsFreeFall.OnEnd = function(self)
  -- function num : 0_3
end

return IsFreeFall

