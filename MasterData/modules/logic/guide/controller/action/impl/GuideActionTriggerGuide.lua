-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionTriggerGuide.lua

module("modules.logic.guide.controller.action.impl.GuideActionTriggerGuide", package.seeall)

local GuideActionTriggerGuide = class("GuideActionTriggerGuide", BaseGuideAction)

function GuideActionTriggerGuide:ctor(guideId, stepId, actionParam)
	GuideActionTriggerGuide.super.ctor(self, guideId, stepId, actionParam)

	self._triggerGuideId = not string.nilorempty(actionParam) and tonumber(actionParam)
end

function GuideActionTriggerGuide:onStart(context)
	GuideActionTriggerGuide.super.onStart(self, context)
	self:onDone(true)
end

function GuideActionTriggerGuide:onDestroy()
	GuideActionTriggerGuide.super.onDestroy(self)

	if self._triggerGuideId then
		local guideMO = GuideModel.instance:getById(self._triggerGuideId)

		if guideMO and not guideMO.isFinish then
			GuideController.instance:execNextStep(self._triggerGuideId)
		else
			GuideController.instance:dispatchEvent(GuideEvent.TriggerGuide, self._triggerGuideId)
		end
	else
		local doingGuideId = GuideModel.instance:getDoingGuideId()

		if doingGuideId then
			GuideController.instance:execNextStep(doingGuideId)
		else
			GuideController.instance:dispatchEvent(GuideEvent.TriggerGuide)
		end
	end
end

return GuideActionTriggerGuide
