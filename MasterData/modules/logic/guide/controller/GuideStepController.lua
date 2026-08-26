-- chunkname: @modules/logic/guide/controller/GuideStepController.lua

module("modules.logic.guide.controller.GuideStepController", package.seeall)

local GuideStepController = class("GuideStepController", BaseController)

function GuideStepController:onInit()
	self._guideId = nil
	self._stepId = nil
	self._againGuideId = nil
	self._actionFlow = nil
	self._actionFlowsParallel = {}
	self._actionBuilder = GuideActionBuilder.New()
	self._startTime = 0
end

function GuideStepController:reInit()
	self:clearStep()
end

function GuideStepController:execStep(guideId, stepId, againGuideId)
	GuideAudioPreloadController.instance:preload(guideId)

	self._guideId = guideId
	self._stepId = stepId
	self._againGuideId = againGuideId

	local guideCO = GuideConfig.instance:getGuideCO(guideId)

	if guideCO.parallel == 1 or self._actionFlow == nil then
		self:_reallyStartGuide({})

		if not GuideModel.instance:isStepFinish(guideId, stepId) then
			if self._againGuideId > 0 then
				if not self._againGuideId then
					local stepGuideId = self._guideId

					GuideExceptionController.instance:checkStep(stepGuideId, stepId)
				end
			end
		end
	end
end

function GuideStepController:clearFlow(guideId)
	GuideExceptionController.instance:stopCheck()

	if self._actionFlowsParallel[guideId] then
		self._actionFlowsParallel[guideId]:destroy()

		self._actionFlowsParallel[guideId] = nil
	elseif self._actionFlow and self._actionFlow.guideId == guideId then
		local flow = self._actionFlow

		self._actionFlow = nil

		flow:destroy()
	end
end

function GuideStepController:clearStep()
	GuideExceptionController.instance:stopCheck()

	if self._actionFlow then
		local flow = self._actionFlow

		self._actionFlow = nil

		flow:destroy()
	end

	for _, flow in pairs(self._actionFlowsParallel) do
		flow:destroy()
	end

	self._actionFlowsParallel = {}
end

function GuideStepController:_reallyStartGuide(param)
	local guideCO = GuideConfig.instance:getGuideCO(self._guideId)

	if guideCO.parallel and self._actionFlowsParallel[self._guideId] or not guideCO.parallel and self._actionFlow then
		return
	end

	local actionFlow = self._actionBuilder:buildActionFlow(self._guideId, self._stepId, self._againGuideId)

	if actionFlow then
		if guideCO.parallel == 1 then
			self._actionFlowsParallel[self._guideId] = actionFlow
		else
			self._actionFlow = actionFlow
		end

		if self._againGuideId > 0 then
			if not self._againGuideId then
				local stepGuideId = self._guideId

				GuideController.instance:dispatchEvent(GuideEvent.StartGuideStep, stepGuideId, self._stepId)
				actionFlow:start(param)
			end
		end
	else
		logNormal(string.format("<color=#FFA500>guide_%d_%d</color> has no action", self._guideId, self._stepId))
	end
end

function GuideStepController:getActionBuilder()
	return self._actionBuilder
end

function GuideStepController:getActionFlow(guideId)
	local guideCO = GuideConfig.instance:getGuideCO(guideId)

	if guideCO and guideCO.parallel == 1 then
		return self._actionFlowsParallel[guideId]
	else
		return self._actionFlow
	end
end

GuideStepController.instance = GuideStepController.New()

return GuideStepController
