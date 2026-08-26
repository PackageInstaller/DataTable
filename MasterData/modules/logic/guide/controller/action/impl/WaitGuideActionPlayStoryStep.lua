-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionPlayStoryStep.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionPlayStoryStep", package.seeall)

local WaitGuideActionPlayStoryStep = class("WaitGuideActionPlayStoryStep", BaseGuideAction)

function WaitGuideActionPlayStoryStep:onStart(context)
	WaitGuideActionPlayStoryStep.super.onStart(self, context)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, self._onStep, self)

	local _param = string.splitToNumber(self.actionParam, "#")

	if #_param == 2 then
		self.storyId = _param[1]
		self.stepId = _param[2]
	end
end

function WaitGuideActionPlayStoryStep:_onStep(param)
	if self.storyId and self.stepId and self.storyId == param.storyId and self.stepId == param.stepId then
		StoryController.instance:unregisterCallback(StoryEvent.RefreshStep, self._onStep, self)

		local auto = StoryModel.instance:isStoryAuto()

		if auto then
			StoryModel.instance:setStoryAuto(false)
			StoryController.instance:dispatchEvent(StoryEvent.Auto)
		end

		self:onDone(true)
	end
end

function WaitGuideActionPlayStoryStep:clearWork()
	StoryController.instance:unregisterCallback(StoryEvent.RefreshStep, self._onStep, self)
end

return WaitGuideActionPlayStoryStep
