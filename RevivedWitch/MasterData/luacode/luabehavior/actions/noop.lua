-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/noop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local Noop = class("Noop", Task)
Noop.Ctor = function(self, context)
  -- function num : 0_0 , upvalues : Noop
  ((Noop.super).Ctor)(self)
  self._context = context
end

Noop.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Behavior_Status
  return Behavior_Status.Success
end

return Noop

