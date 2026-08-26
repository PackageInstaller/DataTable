-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionEntityDeadContinue.lua

module("modules.logic.guide.controller.action.impl.GuideActionEntityDeadContinue", package.seeall)

local GuideActionEntityDeadContinue = class("GuideActionEntityDeadContinue", BaseGuideAction)

function GuideActionEntityDeadContinue:onStart(context)
	GuideActionEntityDeadContinue.super.onStart(self, context)
	FightController.instance:dispatchEvent(FightEvent.OnGuideEntityDeadContinue)
	self:onDone(true)
end

return GuideActionEntityDeadContinue
