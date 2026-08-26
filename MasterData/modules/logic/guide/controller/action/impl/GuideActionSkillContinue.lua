-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionSkillContinue.lua

module("modules.logic.guide.controller.action.impl.GuideActionSkillContinue", package.seeall)

local GuideActionSkillContinue = class("GuideActionSkillContinue", BaseGuideAction)

function GuideActionSkillContinue:onStart(context)
	GuideActionSkillContinue.super.onStart(self, context)
	FightController.instance:dispatchEvent(FightEvent.OnGuideBeforeSkillContinue)
	self:onDone(true)
end

return GuideActionSkillContinue
