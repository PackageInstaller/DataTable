-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitRougeStoryDoneWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitRougeStoryDoneWork", package.seeall)

local Rouge2_WaitRougeStoryDoneWork = class("Rouge2_WaitRougeStoryDoneWork", BaseWork)

function Rouge2_WaitRougeStoryDoneWork:ctor(storyId)
	self.storyId = storyId
end

function Rouge2_WaitRougeStoryDoneWork:onStart()
	if not self.storyId or self.storyId == 0 then
		return self:onDone(true)
	end

	StoryController.instance:playStory(self.storyId, nil, self.onStoryDone, self)
end

function Rouge2_WaitRougeStoryDoneWork:onStoryDone()
	self:onDone(true)
end

function Rouge2_WaitRougeStoryDoneWork:clearWork()
	return
end

return Rouge2_WaitRougeStoryDoneWork
