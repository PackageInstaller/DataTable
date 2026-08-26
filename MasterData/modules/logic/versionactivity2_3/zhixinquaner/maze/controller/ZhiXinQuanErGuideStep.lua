-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/controller/ZhiXinQuanErGuideStep.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.ZhiXinQuanErGuideStep", package.seeall)

local ZhiXinQuanErGuideStep = class("ZhiXinQuanErGuideStep", BaseWork)

function ZhiXinQuanErGuideStep:initData(effectData)
	self.effectData = effectData
	self._guideId = tonumber(self.effectData.param)
end

function ZhiXinQuanErGuideStep:onStart()
	if GuideController.instance:isForbidGuides() then
		self:onDone(true)

		return
	end

	if GuideModel.instance:isGuideFinish(self._guideId) then
		self:onDone(true)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.GuideStart, tostring(self._guideId))
end

function ZhiXinQuanErGuideStep:_onGuideFinish(guideId)
	if self._guideId ~= guideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	self:onDone(true)
end

function ZhiXinQuanErGuideStep:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
end

return ZhiXinQuanErGuideStep
