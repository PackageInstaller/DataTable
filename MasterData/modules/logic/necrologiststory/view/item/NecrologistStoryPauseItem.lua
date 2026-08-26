-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryPauseItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryPauseItem", package.seeall)

local NecrologistStoryPauseItem = class("NecrologistStoryPauseItem", NecrologistStoryBaseItem)

function NecrologistStoryPauseItem:onInit()
	return
end

function NecrologistStoryPauseItem:onPlayStory(isSkip)
	self.isFinished = false

	local storyConfig = self:getStoryConfig()
	local pauseTime = tonumber(storyConfig.param)

	if pauseTime and pauseTime > 0 then
		TaskDispatcher.runDelay(self.onFinished, self, pauseTime)
	else
		self:onFinished()
	end
end

function NecrologistStoryPauseItem:onFinished()
	if self.isFinished then
		return
	end

	self.isFinished = true

	self:onPlayFinish(true)
end

function NecrologistStoryPauseItem:isDone()
	return self.isFinished
end

function NecrologistStoryPauseItem:justDone()
	return
end

function NecrologistStoryPauseItem:caleHeight()
	return 0
end

function NecrologistStoryPauseItem.getResPath()
	return
end

function NecrologistStoryPauseItem:getItemType()
	return
end

function NecrologistStoryPauseItem:onDestroy()
	TaskDispatcher.cancelTask(self.onFinished, self)
end

return NecrologistStoryPauseItem
