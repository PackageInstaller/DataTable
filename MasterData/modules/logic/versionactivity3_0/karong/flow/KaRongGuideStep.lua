-- chunkname: @modules/logic/versionactivity3_0/karong/flow/KaRongGuideStep.lua

module("modules.logic.versionactivity3_0.karong.flow.KaRongGuideStep", package.seeall)

local KaRongGuideStep = class("KaRongGuideStep", BaseWork)

function KaRongGuideStep:ctor(data)
	self._data = data
	self._guideId = tonumber(self._data.param)
end

function KaRongGuideStep:onStart()
	if GuideController.instance:isForbidGuides() then
		self:onDone(true)

		return
	end

	if GuideModel.instance:isGuideFinish(self._guideId) then
		self:onDone(true)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	KaRongDrawController.instance:dispatchEvent(KaRongDrawEvent.GuideStart, tostring(self._guideId))
end

function KaRongGuideStep:_onGuideFinish(guideId)
	if self._guideId ~= guideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	self:onDone(true)
end

function KaRongGuideStep:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
end

return KaRongGuideStep
