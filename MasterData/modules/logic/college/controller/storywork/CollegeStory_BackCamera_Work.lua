-- chunkname: @modules/logic/college/controller/storywork/CollegeStory_BackCamera_Work.lua

module("modules.logic.college.controller.storywork.CollegeStory_BackCamera_Work", package.seeall)

local CollegeStory_BackCamera_Work = class("CollegeStory_BackCamera_Work", BaseWork)

function CollegeStory_BackCamera_Work:onStart()
	CollegeHelper.instance:cancelFocus(self._onDone, self)
end

function CollegeStory_BackCamera_Work:_onDone()
	self:onDone(true)
end

return CollegeStory_BackCamera_Work
