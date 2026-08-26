-- chunkname: @modules/logic/guide/controller/action/GuideActionFlow.lua

module("modules.logic.guide.controller.action.GuideActionFlow", package.seeall)

local GuideActionFlow = class("GuideActionFlow", FlowSequence)

function GuideActionFlow:ctor(guideId, stepId, againGuideId)
	self.guideId = guideId
	self.stepId = stepId
	self.againGuideId = againGuideId

	GuideActionFlow.super.ctor(self)
end

function GuideActionFlow:onStart(context)
	GuideActionFlow.super.onStart(context)
	GuideController.instance:startStep(self.guideId, self.stepId, self.againGuideId)
end

function GuideActionFlow:onDone(result)
	GuideActionFlow.super.onDone(self, result)
	GuideController.instance:finishStep(self.guideId, self.stepId, false, false, self.againGuideId)
end

return GuideActionFlow
