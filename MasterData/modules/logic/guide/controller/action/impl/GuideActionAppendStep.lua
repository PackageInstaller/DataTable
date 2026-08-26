-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionAppendStep.lua

module("modules.logic.guide.controller.action.impl.GuideActionAppendStep", package.seeall)

local GuideActionAppendStep = class("GuideActionAppendStep", BaseGuideAction)

function GuideActionAppendStep:onStart(context)
	GuideActionAppendStep.super.onStart(self, context)

	local guideId = self.guideId
	local params = string.split(self.actionParam, "#")
	local appendGuideId = tonumber(params[1])
	local appendStepIds = string.split(params[2], "_")
	local flow = GuideStepController.instance:getActionFlow(self.sourceGuideId or guideId)
	local actionBuilder = GuideStepController.instance:getActionBuilder()

	for _, stepIdStr in ipairs(appendStepIds) do
		local appendStepId = tonumber(stepIdStr)

		actionBuilder:addActionToFlow(flow, appendGuideId, appendStepId, true)
	end

	if flow then
		local workList = flow:getWorkList()

		if workList then
			for k, v in pairs(workList) do
				v.sourceGuideId = guideId
			end
		end
	end

	self:onDone(true)
end

return GuideActionAppendStep
