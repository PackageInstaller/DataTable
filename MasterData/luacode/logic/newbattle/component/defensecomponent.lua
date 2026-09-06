local Component = require("ecs.component")
local DefenseComponent = dataclass("DefenseComponent", Component)

function DefenseComponent:Ctor(...)
  DefenseComponent.super.Ctor(self, ...)
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
