-- chunkname: @modules/logic/rouge/map/work/WaitRougeStoryDoneWork.lua

module("modules.logic.rouge.map.work.WaitRougeStoryDoneWork", package.seeall)

local WaitRougeStoryDoneWork = class("WaitRougeStoryDoneWork", BaseWork)

function WaitRougeStoryDoneWork:ctor(storyId)
	self.storyId = storyId
end

function WaitRougeStoryDoneWork:onStart()
	if not self.storyId or self.storyId == 0 then
		return self:onDone(true)
	end

	StoryController.instance:playStory(self.storyId, nil, self.onStoryDone, self)
end

function WaitRougeStoryDoneWork:onStoryDone()
	self:onDone(true)
end

function WaitRougeStoryDoneWork:clearWork()
	return
end

return WaitRougeStoryDoneWork
