-- chunkname: @modules/logic/guide/controller/exception/GuideExceptionHandler.lua

module("modules.logic.guide.controller.exception.GuideExceptionHandler", package.seeall)

local GuideExceptionHandler = _M

function GuideExceptionHandler.finishStep(guideId, stepId)
	GuideController.instance:finishStep(guideId, stepId, true)
end

function GuideExceptionHandler.finishGuide(guideId, stepId, param)
	GuideController.instance:oneKeyFinishGuide(guideId, true)
end

function GuideExceptionHandler.finishNextGuide(guideId, stepId, param)
	local nextGuideId = tonumber(param)

	if nextGuideId == nil then
		return
	end

	GuideController.instance:oneKeyFinishGuide(nextGuideId, true)
end

function GuideExceptionHandler.gotoStep(guideId, stepId, param)
	local guideMO = GuideModel.instance:getById(guideId)
	local targetStepId = tonumber(param)
	local hasFindStep, toSendStepId
	local stepCOList = GuideConfig.instance:getStepList(guideId)

	for i = #stepCOList, 1, -1 do
		local stepCO = stepCOList[i]
		local tempStepId = stepCO.stepId

		if tempStepId == guideMO.currStepId then
			if stepCO.keyStep == 1 then
				toSendStepId = tempStepId
			end

			break
		elseif hasFindStep then
			if stepCO.keyStep == 1 then
				toSendStepId = tempStepId

				break
			end
		elseif tempStepId == targetStepId then
			hasFindStep = true
		end
	end

	if toSendStepId then
		guideMO:toGotoStep(targetStepId)
		GuideRpc.instance:sendFinishGuideRequest(guideId, toSendStepId)
	else
		guideMO:gotoStep(targetStepId)
		GuideStepController.instance:clearFlow(guideId)
		GuideController.instance:execNextStep(guideId)
	end
end

function GuideExceptionHandler.openView(guideId, stepId, param)
	ViewMgr.instance:openView(param)
end

function GuideExceptionHandler.closeView(guideId, stepId, param)
	ViewMgr.instance:closeView(param, true)
end

return GuideExceptionHandler
