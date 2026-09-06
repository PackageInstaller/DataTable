local Component = require("ecs.component")
local AnimationEventComponent = dataclass("AnimationEventComponent", Component)

function AnimationEventComponent:Ctor(...)
  AnimationEventComponent.super.Ctor(self, ...)
  self._roleIsInSkill = false
  self._roleIsInSkillTimer = 0
  self._roleIsInSkillMaxTime = 0
  self._roleIsInPositionChangeAnimationState = false
  self._roleIsInPositionChangeAnimationName = ""
  self._roleIsInPositionChangeAnimationData = {}
  self._roleIsInPositionChangeAnimationTimeStamp = 0
  self._chargeBackTime = 0
  self._roleIsInSkillWithEndTime = false
  self._roleIsInSkillTimerWithEndTime = 0
  self._roleIsInSkillMaxTimeWithEndTime = 0
end

return AnimationEventComponent
