-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/candoublehit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local CanDoubleHit = class("CanDoubleHit", Task)
CanDoubleHit.Ctor = function(self, context, CanDoubleHitType)
  -- function num : 0_0 , upvalues : CanDoubleHit
  ((CanDoubleHit.super).Ctor)(self)
  self._context = context
  self._CanDoubleHitType = CanDoubleHitType
end

CanDoubleHit.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Behavior_Status
  if ((self._context)._skill):CanDoubleHit() then
    return Behavior_Status.Success
  end
  return Behavior_Status.Failure
end

return CanDoubleHit

