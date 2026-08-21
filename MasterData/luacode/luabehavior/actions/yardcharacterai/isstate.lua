-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/yardcharacterai/isstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local IsState = class("IsState", Task)
IsState.Ctor = function(self, context, type)
  -- function num : 0_0 , upvalues : IsState
  ((IsState.super).Ctor)(self)
  self._character = context._character
  self._type = type
end

IsState.OnStart = function(self)
  -- function num : 0_1
end

IsState.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  if self._character then
    local result = (self._character):IsState(self._type)
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

IsState.OnEnd = function(self)
  -- function num : 0_3
end

return IsState

