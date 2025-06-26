-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/component/animationeventcomponent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Component = require("ecs.component")
local AnimationEventComponent = dataclass("AnimationEventComponent", Component)
AnimationEventComponent.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AnimationEventComponent
  ((AnimationEventComponent.super).Ctor)(self, ...)
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

