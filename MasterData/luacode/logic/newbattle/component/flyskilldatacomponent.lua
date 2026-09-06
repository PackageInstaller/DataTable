local Component = require("ecs.component")
local FlySkillDataComponent = dataclass("FlySkillDataComponent", Component)
FlySkillDataComponent.SkillEffectType = {
  FlyProp = 1,
  DefendFlyProp = 2,
  ConfirmProp = 3,
  ConfirmFlyProp = 4,
  ParaFlyProp = 5
}

function FlySkillDataComponent:Ctor(...)
  FlySkillDataComponent.super.Ctor(self, ...)
  self._skillEffectType = 0
  self._skillMaxContactNumber = 0
  self._skillCurrentContactNumber = 0
  self._colliderLifeTime = 0
  self._colliderLifeCurrentTime = 0
  self._turnBackFraps = 0
  self._currentFlyFraps = fixedpoint_zero
  self._onceFlyTime = fixedpoint_zero
  self._randomNum = 0
  self._flyDestination = {
    x = fixedpoint(-1),
    y = fixedpoint(-1)
  }
  self._shouldBeButByShiKongZhiMen = false
end

return FlySkillDataComponent
