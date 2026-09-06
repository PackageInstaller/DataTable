local Component = require("ecs.component")
local PositionComponent = dataclass("PositionComponent", Component)

function PositionComponent:Ctor(...)
  PositionComponent.super.Ctor(self, ...)
  self._position = {}
  self._position.x = fixedpoint_zero
  self._position.y = fixedpoint_zero
  self._position.z = fixedpoint_zero
  self._targetPos = {}
  self._velocity = {}
  self._velocity.x = fixedpoint_zero
  self._velocity.y = fixedpoint_zero
  self._velocity.z = fixedpoint_zero
  self._toUseSkillEntityPositonDeltaPosition = {}
  self._toUseSkillEntityPositonDeltaPosition.x = fixedpoint_zero
  self._toUseSkillEntityPositonDeltaPosition.y = fixedpoint_zero
end

return PositionComponent
