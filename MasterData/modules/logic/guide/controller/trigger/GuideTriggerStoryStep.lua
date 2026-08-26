-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerStoryStep.lua

module("modules.logic.guide.controller.trigger.GuideTriggerStoryStep", package.seeall)

local GuideTriggerStoryStep = class("GuideTriggerStoryStep", BaseGuideTrigger)

function GuideTriggerStoryStep:ctor(triggerKey)
	GuideTriggerStoryStep.super.ctor(self, triggerKey)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, self._onStep, self)
end

function GuideTriggerStoryStep:assertGuideSatisfy(param, configParam)
	local _param = string.splitToNumber(configParam, "_")

	if not param then
		return false
	end

	if #_param == 1 then
		return _param[1] == param.storyId
	elseif #_param > 1 then
		return _param[1] == param.storyId and _param[2] == param.stepId
	end
end

function GuideTriggerStoryStep:_onStep(param)
	local storyId = param.storyId
	local stepId = param.stepId

	if storyId and stepId then
		self:checkStartGuide(param)
	end
end

return GuideTriggerStoryStep
