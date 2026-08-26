-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzGuideWork.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzGuideWork", package.seeall)

local WmzGuideWork = class("WmzGuideWork", GaoSiNiaoWorkBase)

function WmzGuideWork.s_create(guideId)
	local work = WmzGuideWork.New()

	work._guideId = tonumber(guideId) or 0

	return work
end

function WmzGuideWork:onStart()
	self:clearWork()

	if not self._guideId or self._guideId == 0 then
		self:onSucc()

		return
	end

	if GuideController.instance:isForbidGuides() then
		self:onSucc()

		return
	end

	if self:_isGuideFinish(self._guideId) then
		self:onSucc()

		return
	end

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideFail, self._onGuideFinish, self)
	self:_startGuide()
end

function WmzGuideWork:_startGuide()
	local guideId = self._guideId

	if self:_isGuideRunning(guideId) then
		self:_myStartGuide()
	else
		GuideController.instance:registerCallback(GuideEvent.onReceiveFinishGuideReply, self._onReceiveFinishGuideReply, self)
		GuideController.instance:startGudie(guideId)
	end
end

function WmzGuideWork:_onReceiveFinishGuideReply()
	local guideId = self._guideId

	if self:_isGuideRunning(guideId) then
		self:_myStartGuide()
		GuideController.instance:unregisterCallback(GuideEvent.onReceiveFinishGuideReply, self._onReceiveFinishGuideReply, self)
	end
end

function WmzGuideWork:_onGuideFinish(guideId)
	if self._guideId ~= guideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideFail, self._onGuideFinish, self)
	self:onSucc()
end

function WmzGuideWork:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideFail, self._onGuideFinish, self)
	GuideController.instance:unregisterCallback(GuideEvent.onReceiveFinishGuideReply, self._onReceiveFinishGuideReply, self)
end

function WmzGuideWork:_isGuideRunning(guideId)
	return GuideModel.instance:isGuideRunning(guideId)
end

function WmzGuideWork:_isGuideFinish(guideId)
	return GuideModel.instance:isGuideFinish(guideId)
end

function WmzGuideWork:_myStartGuide()
	WmzController.instance:dispatchEvent(WmzEvent.GuideStart1)
end

return WmzGuideWork
