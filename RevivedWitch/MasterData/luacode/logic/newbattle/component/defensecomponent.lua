-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/defensecomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local DefenseComponent = dataclass("DefenseComponent", Component)
DefenseComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DefenseComponent, _ENV
  ((DefenseComponent.super).Ctor)(self, ...)
  self._attackDefense = fixedpoint_zero
  self._magicDefense = fixedpoint_zero
  self._basicAttackDefense = fixedpoint_zero
  self._basicMagicDefense = fixedpoint_zero
  self._attackDefenseAddition = fixedpoint_zero
  self._magicDefenseAddition = fixedpoint_zero
  self._attackInjuryReduceNumber = fixedpoint_zero
  self._magicInjuryReduceNumber = fixedpoint_zero
  self._attackMiss = fixedpoint_zero
  self._physicalEvasion = fixedpoint_zero
  self._magicEvasion = fixedpoint_zero
  self._attackCritDefense = fixedpoint_zero
  self._attackCritDegreeDefense = fixedpoint_zero
  self._damageReduce = fixedpoint_zero
end

return DefenseComponent

