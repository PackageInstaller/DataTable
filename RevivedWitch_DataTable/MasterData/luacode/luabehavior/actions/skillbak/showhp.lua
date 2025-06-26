-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/skillbak/showhp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local Behavior_Status = require("luabehavior.base.taskstatus")
local ShowHP = class("ShowHP", Task)
ShowHP.Ctor = function(self, context, identityInBattle)
  -- function num : 0_0 , upvalues : ShowHP
  ((ShowHP.super).Ctor)(self)
  self._context = context
  self._identityInBattle = identityInBattle
end

ShowHP.OnUpdate = function(self, deltaTime)
  -- function num : 0_1 , upvalues : Behavior_Status
  ((self._context)._world):FireEvent((((self._context)._world)._events).SkillShowHpBar, self._identityInBattle, (self._context)._skill)
  return Behavior_Status.Success
end

return ShowHP

