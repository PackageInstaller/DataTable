local Component = require("ecs.component")
local PhysicsComponent = dataclass("PhysicsComponent", Component)

function PhysicsComponent:Ctor(...)
  PhysicsComponent.super.Ctor(self, ...)
  self._box2DBodyID = 0
  self._isNeedReleaseBox = false
  self._hittedContactList = {}
  self._toTargetMaxSpeed = {
    x = fixedpoint_zero,
    y = fixedpoint_zero
  }
  self._toTargetCurrentSpeed = {
    x = fixedpoint_zero,
    y = fixedpoint_zero
  }
  self._toTargetAcceleration = {
    x = fixedpoint_zero,
    y = fixedpoint_zero
  }
  self._isStartMove = false
  self._isStopMove = true
  self._moveMaxFraps = 0
  self._moveCurrentFraps = 0
  self._hittedAwake = true
  self._isChangePositionToUseSkillEntity = false
  self._useSkillEntityEntityID = 0
  self._hittedAwakeCount = 0
end

return PhysicsComponent
