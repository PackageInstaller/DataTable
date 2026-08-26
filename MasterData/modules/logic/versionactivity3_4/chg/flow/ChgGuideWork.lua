-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgGuideWork.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgGuideWork", package.seeall)

local ChgGuideWork = class("ChgGuideWork", GaoSiNiaoWorkBase)

function ChgGuideWork.s_create(guideId)
	local work = ChgGuideWork.New()

	work._guideId = tonumber(guideId) or 0

	return work
end

function ChgGuideWork:onStart()
	self:clearWork()

	if not self._guideId or self._guideId == 0 then
		self:onSucc()

		return
	end

	if GuideController.instance:isForbidGuides() then
		self:onSucc()

		return
	end

	if GuideModel.instance:isGuideFinish(self._guideId) then
		self:onSucc()

		return
	end

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideFail, self._onGuideFinish, self)
	self:_startGuide()
end

function ChgGuideWork:_startGuide()
	local guideId = self._guideId

	if GuideModel.instance:isGuideRunning(guideId) then
		ChgController.instance:startGuide(guideId)
	else
		GuideController.instance:registerCallback(GuideEvent.onReceiveFinishGuideReply, self._onReceiveFinishGuideReply, self)
		GuideController.instance:startGudie(guideId)
	end
end

function ChgGuideWork:_onReceiveFinishGuideReply()
	local guideId = self._guideId

	if GuideModel.instance:isGuideRunning(guideId) then
		ChgController.instance:startGuide(guideId)
		GuideController.instance:unregisterCallback(GuideEvent.onReceiveFinishGuideReply, self._onReceiveFinishGuideReply, self)
	end
end

function ChgGuideWork:_onGuideFinish(guideId)
	if self._guideId ~= guideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideFail, self._onGuideFinish, self)
	self:onSucc()
end

function ChgGuideWork:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideFail, self._onGuideFinish, self)
	GuideController.instance:unregisterCallback(GuideEvent.onReceiveFinishGuideReply, self._onReceiveFinishGuideReply, self)
end

return ChgGuideWork
