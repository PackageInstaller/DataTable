-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionSkillPause.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionSkillPause", package.seeall)

local WaitGuideActionSkillPause = class("WaitGuideActionSkillPause", BaseGuideAction)

function WaitGuideActionSkillPause:onStart(context)
	WaitGuideActionSkillPause.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnGuideBeforeSkillPause, self._onGuideBeforeSkillPause, self)

	local temp = string.splitToNumber(self.actionParam, "#")

	self._attackId = temp[1]
	self._skillId = temp[2]
end

function WaitGuideActionSkillPause:_onGuideBeforeSkillPause(guideParam, attackId, skillId)
	guideParam.OnGuideBeforeSkillPause = attackId == self._attackId and skillId == self._skillId

	if guideParam.OnGuideBeforeSkillPause then
		FightController.instance:unregisterCallback(FightEvent.OnGuideBeforeSkillPause, self._onGuideBeforeSkillPause, self)
		self:onDone(true)
	end
end

function WaitGuideActionSkillPause:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnGuideBeforeSkillPause, self._onGuideBeforeSkillPause, self)
end

return WaitGuideActionSkillPause
