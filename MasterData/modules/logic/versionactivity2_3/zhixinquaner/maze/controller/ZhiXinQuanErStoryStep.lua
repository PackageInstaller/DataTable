-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/controller/ZhiXinQuanErStoryStep.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.ZhiXinQuanErStoryStep", package.seeall)

local ZhiXinQuanErStoryStep = class("ZhiXinQuanErStoryStep", BaseWork)

function ZhiXinQuanErStoryStep:initData(data)
	self._data = data
end

function ZhiXinQuanErStoryStep:onStart(context)
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

function ZhiXinQuanErStoryStep:afterPlayStory()
	TaskDispatcher.runDelay(self.onDoneTrue, self, 0.3)
end

function ZhiXinQuanErStoryStep:onDoneTrue()
	self:onDone(true)
end

function ZhiXinQuanErStoryStep:clearWork()
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", self._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", self._initDistortStrength)
	TaskDispatcher.cancelTask(self.onDoneTrue, self)
end

return ZhiXinQuanErStoryStep
