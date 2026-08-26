-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionStoryStart.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionStoryStart", package.seeall)

local WaitGuideActionStoryStart = class("WaitGuideActionStoryStart", BaseGuideAction)

function WaitGuideActionStoryStart:onStart(context)
	WaitGuideActionStoryStart.super.onStart(self, context)
	StoryController.instance:registerCallback(StoryEvent.Start, self._onStoryStart, self)

	self._storyId = tostring(self.actionParam)
end

function WaitGuideActionStoryStart:_onStoryStart(storyId)
	if not self._storyId or self._storyId == storyId then
		StoryController.instance:unregisterCallback(StoryEvent.Start, self._onStoryStart, self)
		self:onDone(true)
	end
end

function WaitGuideActionStoryStart:clearWork()
	StoryController.instance:unregisterCallback(StoryEvent.Start, self._onStoryStart, self)
end

return WaitGuideActionStoryStart
