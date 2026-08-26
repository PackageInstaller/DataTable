-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaStoryStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaStoryStep", package.seeall)

local TianShiNaNaStoryStep = class("TianShiNaNaStoryStep", TianShiNaNaStepBase)

function TianShiNaNaStoryStep:onStart(context)
	local storyId = self._data.storyId
	local param = {}

	param.blur = true
	param.hideStartAndEndDark = true
	param.mark = true
	param.isReplay = false
	self._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
	self._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
	PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
	StoryController.instance:playStory(storyId, param, self.afterPlayStory, self)
end

function TianShiNaNaStoryStep:afterPlayStory()
	TaskDispatcher.runDelay(self.onDoneTrue, self, 0.3)
end

function TianShiNaNaStoryStep:onDoneTrue()
	self:onDone(true)
end

function TianShiNaNaStoryStep:clearWork()
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", self._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", self._initDistortStrength)
	TaskDispatcher.cancelTask(self.onDoneTrue, self)
end

return TianShiNaNaStoryStep
