-- chunkname: @modules/logic/guide/controller/GuideAudioPreloadController.lua

module("modules.logic.guide.controller.GuideAudioPreloadController", package.seeall)

local GuideAudioPreloadController = class("GuideAudioPreloadController", BaseController)
local NeedPreloadGuideDict = {
	[106] = true,
	[206] = true,
	[104] = true,
	[205] = true,
	[101] = true
}

function GuideAudioPreloadController:addConstEvents()
	GuideController.instance:registerCallback(GuideEvent.GuideEvent.StartGuideStep, self._onStartGuideStep, self)
	GuideController.instance:registerCallback(GuideEvent.GuideEvent.FinishGuideLastStep, self._onFinishGuide, self)
end

function GuideAudioPreloadController:onInit()
	self._preloadGuideIdDict = {}
end

function GuideAudioPreloadController:reInit()
	for guideId, _ in pairs(self._preloadGuideIdDict) do
		self:unload(guideId)
	end

	self._preloadGuideIdDict = {}
end

function GuideAudioPreloadController:_onStartGuideStep(guideId, stepId)
	self:preload(guideId)
end

function GuideAudioPreloadController:_onFinishGuide(guideId, stepId)
	self:unload(guideId)
end

function GuideAudioPreloadController:preload(guideId)
	if not NeedPreloadGuideDict[guideId] then
		return
	end

	if self._preloadGuideIdDict[guideId] then
		return
	end

	local bankNameDict = {}

	self._preloadGuideIdDict[guideId] = bankNameDict

	local guideStepCOList = GuideConfig.instance:getStepList(guideId)

	for _, stepCO in ipairs(guideStepCOList) do
		local audioCO = AudioConfig.instance:getAudioCOById(stepCO.audio)

		if stepCO.audio > 0 and audioCO then
			bankNameDict[audioCO.bankName] = true
		end
	end

	for bankName, _ in pairs(bankNameDict) do
		ZProj.AudioManager.Instance:LoadBank(bankName)
	end
end

function GuideAudioPreloadController:unload(guideId)
	local bankNameDict = self._preloadGuideIdDict[guideId]

	if bankNameDict then
		self._preloadGuideIdDict[guideId] = nil

		for bankName, _ in pairs(bankNameDict) do
			ZProj.AudioManager.Instance:UnloadBank(bankName)
		end
	end
end

GuideAudioPreloadController.instance = GuideAudioPreloadController.New()

return GuideAudioPreloadController
