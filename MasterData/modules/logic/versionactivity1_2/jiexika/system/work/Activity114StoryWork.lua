-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114StoryWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114StoryWork", package.seeall)

local Activity114StoryWork = class("Activity114StoryWork", Activity114BaseWork)

function Activity114StoryWork:ctor(storyId, storyType)
	self._storyId = storyId
	self._storyType = storyType

	Activity114StoryWork.super.ctor(self)
end

function Activity114StoryWork:onStart(context)
	if not self._storyId then
		self._storyId = context.storyId
		context.storyId = nil
	end

	if type(self._storyId) == "string" then
		self._storyId = tonumber(self._storyId)
	end

	if not self._storyId or self._storyId <= 0 then
		self:onDone(true)

		return
	end

	if Activity114Model.instance.waitStoryFinish then
		Activity114Controller.instance:registerCallback(Activity114Event.StoryFinish, self.playStory, self)
	else
		self:playStory()
	end
end

function Activity114StoryWork:playStory()
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, self.playStory, self)
	StoryController.instance:registerCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
	StoryController.instance:playStory(self._storyId)

	self.context.storyType = self._storyType
end

function Activity114StoryWork:forceEndStory()
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
	self:onDone(true)
end

function Activity114StoryWork:_onStoryFinish()
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)

	if Activity114Model.instance:isEnd() then
		self:onDone(false)
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	self:onDone(true)
end

function Activity114StoryWork:clearWork()
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, self.playStory, self)
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
	Activity114StoryWork.super.clearWork(self)
end

return Activity114StoryWork
