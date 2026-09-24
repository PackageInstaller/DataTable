-- chunkname: @modules/logic/college/controller/storywork/CollegeStory_PlayAVG_Work.lua

module("modules.logic.college.controller.storywork.CollegeStory_PlayAVG_Work", package.seeall)

local CollegeStory_PlayAVG_Work = class("CollegeStory_PlayAVG_Work", BaseWork)

function CollegeStory_PlayAVG_Work:ctor(storyId)
	self._storyId = storyId
end

function CollegeStory_PlayAVG_Work:onStart()
	StoryController.instance:playStory(self._storyId, {
		blur = true,
		hideStartAndEndDark = true
	}, self._onPlayNormalStoryEnd, self)
end

function CollegeStory_PlayAVG_Work:_onPlayNormalStoryEnd()
	self:onDone(true)
end

return CollegeStory_PlayAVG_Work
