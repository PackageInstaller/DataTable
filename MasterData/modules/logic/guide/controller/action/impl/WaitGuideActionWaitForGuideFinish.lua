-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionWaitForGuideFinish.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionWaitForGuideFinish", package.seeall)

local WaitGuideActionWaitForGuideFinish = class("WaitGuideActionWaitForGuideFinish", BaseGuideAction)

function WaitGuideActionWaitForGuideFinish:onStart(context)
	WaitGuideActionWaitForGuideFinish.super.onStart(self, context)

	self._waitForGuides = string.splitToNumber(self.actionParam, "#")

	if not self:_hasDoingGuide() then
		self:onDone(true)
	else
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
	end
end

function WaitGuideActionWaitForGuideFinish:_hasDoingGuide()
	for _, guideId in ipairs(self._waitForGuides) do
		if GuideModel.instance:isGuideRunning(guideId) then
			return true
		end
	end

	return false
end

function WaitGuideActionWaitForGuideFinish:_onFinishGuide()
	if not self:_hasDoingGuide() then
		self:onDone(true)
	end
end

function WaitGuideActionWaitForGuideFinish:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
end

return WaitGuideActionWaitForGuideFinish
