-- chunkname: @modules/logic/versionactivity3_0/karong/flow/KaRongStoryStep.lua

module("modules.logic.versionactivity3_0.karong.flow.KaRongStoryStep", package.seeall)

local KaRongStoryStep = class("KaRongStoryStep", BaseWork)

function KaRongStoryStep:ctor(data)
	self._data = data
end

function KaRongStoryStep:onStart(context)
	local storyId = tonumber(self._data.param)
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

function KaRongStoryStep:afterPlayStory()
	TaskDispatcher.runDelay(self.onDoneTrue, self, 0.3)
end

function KaRongStoryStep:onDoneTrue()
	self:onDone(true)
end

function KaRongStoryStep:clearWork()
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", self._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", self._initDistortStrength)
	TaskDispatcher.cancelTask(self.onDoneTrue, self)
end

return KaRongStoryStep
