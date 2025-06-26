-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/attackcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local AttackComponent = dataclass("AttackComponent", Component)
AttackComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AttackComponent, _ENV
  ((AttackComponent.super).Ctor)(self, ...)
  self._attack = fixedpoint_zero
  self._basicAttack = fixedpoint_zero
  self._attackCritRate = fixedpoint_zero
  self._basicAttackCritRate = fixedpoint_zero
  self._attackCritDegree = fixedpoint_zero
  self._basicAttackCritDegree = fixedpoint_zero
  self._attackCritLevel = fixedpoint_zero
  self._attackCritDegreeLevel = fixedpoint_zero
  self._attackDamageAddition = fixedpoint_zero
  self._magicDamageAddition = fixedpoint_zero
  self._attackSuckBlood = fixedpoint_zero
  self._magicSuckBlood = fixedpoint_zero
  self._attackSpeed = fixedpoint_zero
  self._attackDefBreak = fixedpoint_zero
  self._magicDefBreak = fixedpoint_zero
  self._attackAddition = fixedpoint_zero
  self._magicAddition = fixedpoint_zero
  self._treatmentAddition = fixedpoint_zero
  self._hitRate = fixedpoint_zero
  self._healingPower = fixedpoint_zero
  self._skillTreeteBonus = fixedpoint_zero
  self._skillDamageBonus = fixedpoint_zero
end

return AttackComponent

