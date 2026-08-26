-- chunkname: @modules/common/work/PlayStoryWork.lua

module("modules.common.work.PlayStoryWork", package.seeall)

local PlayStoryWork = class("PlayStoryWork", BaseWork)

function PlayStoryWork:ctor(storyId)
	self.storyId = storyId
end

function PlayStoryWork:onStart()
	StoryController.instance:playStory(self.storyId, nil, self.onPlayStoryDone, self)
end

function PlayStoryWork:onPlayStoryDone()
	self:onDone(true)
end

function PlayStoryWork:clearWork()
	return
end

return PlayStoryWork
