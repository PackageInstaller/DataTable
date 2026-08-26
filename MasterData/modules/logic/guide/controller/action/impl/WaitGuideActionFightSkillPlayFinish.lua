-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightSkillPlayFinish.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightSkillPlayFinish", package.seeall)

local WaitGuideActionFightSkillPlayFinish = class("WaitGuideActionFightSkillPlayFinish", BaseGuideAction)

function WaitGuideActionFightSkillPlayFinish:onStart(context)
	WaitGuideActionFightSkillPlayFinish.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	local temp = string.splitToNumber(self.actionParam, "#")

	self._attackId = temp[1]
	self._skillId = temp[2]
end

function WaitGuideActionFightSkillPlayFinish:_onSkillPlayFinish(attacker, skillId)
	local attackId = attacker:getMO().modelId
	local checkAttackId = not self._attackId or self._attackId == attackId
	local checkSkillId = not self._skillId or self._skillId == skillId

	if checkAttackId and checkSkillId then
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
		self:onDone(true)
	end
end

function WaitGuideActionFightSkillPlayFinish:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
end

return WaitGuideActionFightSkillPlayFinish
