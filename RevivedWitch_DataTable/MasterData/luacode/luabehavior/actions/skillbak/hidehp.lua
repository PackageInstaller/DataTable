-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/hidehp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local HideHP = class("HideHP", Task)
HideHP.Ctor = function(self, context, identityInBattle)
  -- function num : 0_0 , upvalues : HideHP
  ((HideHP.super).Ctor)(self)
  self._context = context
  self._identityInBattle = identityInBattle
end

HideHP.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Behavior_Status
  ((self._context)._world):FireEvent((((self._context)._world)._events).SkillHideHpBar, self._identityInBattle, (self._context)._skill)
  return Behavior_Status.Success
end

return HideHP

