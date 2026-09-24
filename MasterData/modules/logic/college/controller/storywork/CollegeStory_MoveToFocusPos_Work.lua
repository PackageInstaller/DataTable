-- chunkname: @modules/logic/college/controller/storywork/CollegeStory_MoveToFocusPos_Work.lua

module("modules.logic.college.controller.storywork.CollegeStory_MoveToFocusPos_Work", package.seeall)

local CollegeStory_MoveToFocusPos_Work = class("CollegeStory_MoveToFocusPos_Work", BaseWork)

function CollegeStory_MoveToFocusPos_Work:ctor(pos)
	self._toPos = pos
end

function CollegeStory_MoveToFocusPos_Work:onStart()
	CollegeHelper.instance:focusToPos(self._toPos, self._onDone, self)
end

function CollegeStory_MoveToFocusPos_Work:_onDone()
	self:onDone(true)
end

return CollegeStory_MoveToFocusPos_Work
