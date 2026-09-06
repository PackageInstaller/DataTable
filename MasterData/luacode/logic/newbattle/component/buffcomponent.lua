local Component = require("ecs.component")
local BuffComponent = dataclass("BuffComponent", Component)

function BuffComponent:Ctor(...)
  BuffComponent.super.Ctor(self, ...)
  self._buffList = {}
  self._dispelbuffnum = 0
  self._buffnum = {}
  self._orderPowerCost = fixedpoint_zero
  self._chaosPowerCost = fixedpoint_zero
  self._phyDmgLimit = -fixedpoint.maxinteger
  self._magicDmgLimit = -fixedpoint.maxinteger
  self._dmgLimitRate = fixedpoint_zero
  self._bringOutPhyDmgLimit = -fixedpoint.maxinteger
  self._bringOutMagicDmgLimit = -fixedpoint.maxinteger
  self._delayBuffList = {}
  self._isPowerCost = {Order = false, Chaos = false}
  self._attackTime = fixedpoint_zero
  self._removeBuffClassNameList = {}
  self._isHasChangeBuff = {}
  self._skillsectionendbuffSnapShoot = {}
  self._skillsectionendbuffSkillId = 0
  self._skillsectionendbuffSkillEffect = {}
end

return BuffComponent
