local Component = require("ecs.component")
local SkillEffectComponent = dataclass("SkillEffectComponent", Component)

function SkillEffectComponent:Ctor(...)
  SkillEffectComponent.super.Ctor(self, ...)
  self._flightPropEffectAtk = {}
  self._typeMineEffectAtkList = {}
  self._invalidEffectAtkList = {}
  self._noColliderEffectList = {}
  self._warningEffectList = {}
  self._animationAtkList = {}
  self._startAnimationDelayTime = 0
  self._useSkillEntityID = 0
  self._attackEntityList = {}
  self._attackTime = 0
  self._skillID = 0
  self._flyEntityList = {}
  self._flyNeedDestroyMaxFrap = 0
  self._randomDeltXOffect = fixedpoint_zero
  self._typeMineEffectAtkEffectTime = 0
end

return SkillEffectComponent
