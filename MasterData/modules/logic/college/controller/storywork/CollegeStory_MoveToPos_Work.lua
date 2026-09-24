-- chunkname: @modules/logic/college/controller/storywork/CollegeStory_MoveToPos_Work.lua

module("modules.logic.college.controller.storywork.CollegeStory_MoveToPos_Work", package.seeall)

local CollegeStory_MoveToPos_Work = class("CollegeStory_MoveToPos_Work", BaseWork)

function CollegeStory_MoveToPos_Work:onStart()
	UIBlockHelper.instance:startBlock("CollegeStory_MoveToPos_Work", 0.5)
	CollegeController.instance:dispatchEvent(CollegeEvent.TweenCameraPos, self.context.toPos, 0.5, self._onDone, self)
end

function CollegeStory_MoveToPos_Work:_onDone()
	self:onDone(true)
end

return CollegeStory_MoveToPos_Work
