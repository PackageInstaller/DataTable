-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionStoryFinish.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionStoryFinish", package.seeall)

local WaitGuideActionStoryFinish = class("WaitGuideActionStoryFinish", BaseGuideAction)

function WaitGuideActionStoryFinish:onStart(context)
	WaitGuideActionStoryFinish.super.onStart(self, context)

	local param = string.splitToNumber(self.actionParam, "#")

	self._storyId = param[1]
	self._noCheckFinish = param[2] == 1

	if self._storyId and not self._noCheckFinish and StoryModel.instance:isStoryFinished(self._storyId) then
		self:onDone(true)
	else
		StoryController.instance:registerCallback(StoryEvent.Finish, self._onStoryFinish, self)
	end
end

function WaitGuideActionStoryFinish:_onStoryFinish(storyId)
	if not self._storyId or self._storyId == storyId then
		StoryController.instance:unregisterCallback(StoryEvent.Finish, self._onStoryFinish, self)
		self:onDone(true)
	end
end

function WaitGuideActionStoryFinish:clearWork()
	StoryController.instance:unregisterCallback(StoryEvent.Finish, self._onStoryFinish, self)
end

return WaitGuideActionStoryFinish
