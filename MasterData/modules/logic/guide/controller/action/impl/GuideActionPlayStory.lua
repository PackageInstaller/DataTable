-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionPlayStory.lua

module("modules.logic.guide.controller.action.impl.GuideActionPlayStory", package.seeall)

local GuideActionPlayStory = class("GuideActionPlayStory", BaseGuideAction)

function GuideActionPlayStory:ctor(guideId, stepId, actionParam)
	GuideActionPlayStory.super.ctor(self, guideId, stepId, actionParam)

	self._storyId = tonumber(actionParam) or nil

	if self._storyId == nil then
		self._storyIds = string.splitToNumber(actionParam, "#")
	end
end

function GuideActionPlayStory:onStart(context)
	GuideActionPlayStory.super.onStart(self, context)

	if self._storyId then
		if StoryModel.instance:isPrologueSkip(self._storyId) then
			StoryController.instance:setStoryFinished(self._storyId)
			StoryRpc.instance:sendUpdateStoryRequest(self._storyId, -1, 0)
			StoryController.instance:dispatchEvent(StoryEvent.Finish, self._storyId)
		else
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self._storyId, param)
		end

		self:onDone(true)
	elseif self._storyIds and #self._storyIds > 0 then
		local param = {}

		param.mark = true

		StoryController.instance:playStories(self._storyIds, param)
		self:onDone(true)
	else
		logError("Guide story id nil, guide_" .. self.guideId .. "_" .. self.stepId)
		self:onDone(false)
	end
end

return GuideActionPlayStory
