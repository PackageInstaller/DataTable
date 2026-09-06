local Component = require("ecs.component")
local HpComponent = dataclass("HpComponent", Component)

function HpComponent:Ctor(...)
  HpComponent.super.Ctor(self, ...)
  self._maxHp = fixedpoint_zero
  self._basicMaxHp = fixedpoint_zero
  self._currentHp = fixedpoint_zero
  self._damageSheildNumberList = {}
  self._lastDamage = fixedpoint_zero
  self._lastDamageFrom = 0
  self._skillListOnceDamage = {}
  self._totalDamage = fixedpoint_zero
  self._elementDamageList = {}
  self._hpStage = "alive"
  self._buffDamgeSkillId = 0
  self._forceCritFlag = false
end

return HpComponent
