local Component = require("ecs.component")
local SkillComponent = dataclass("SkillComponent", Component)
SkillComponent.SkillIndexType = {BigSkill = 2}

function SkillComponent:Ctor(...)
  SkillComponent.super.Ctor(self, ...)
  self._skillId = 0
  self._buffCastSkillId = 0
  self._isClickUseSkill = false
  self._skillList = {}
  self._skillCostPowerList = {}
  self._skillCostPowerReduceList = {}
  self._skillCostPowerReduceList.chaos = fixedpoint_zero
  self._skillCostPowerReduceList.order = fixedpoint_zero
  self._passiveSkillList = {}
  self._attackEntitySkillList = {}
  self._isCostPower = true
  self._comboNumber = fixedpoint_zero
  self._bossComboNumber = fixedpoint_zero
  self._hittedEntityNumber = 0
  self._skillCoolDownReduce = fixedpoint_zero
  self._isHasPassiveSkillParamter = fixedpoint_zero
  self._useActSkillList = {}
  self._comborate1 = fixedpoint_zero
  self._comborate2 = fixedpoint_zero
  self._comborateRemainingNum = fixedpoint_zero
end

return SkillComponent
