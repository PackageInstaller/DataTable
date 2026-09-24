-- chunkname: @modules/logic/college/controller/storywork/CollegeStory_MoveToFocus_Work.lua

module("modules.logic.college.controller.storywork.CollegeStory_MoveToFocus_Work", package.seeall)

local CollegeStory_MoveToFocus_Work = class("CollegeStory_MoveToFocus_Work", BaseWork)

function CollegeStory_MoveToFocus_Work:ctor(mo)
	self._toMo = mo
end

function CollegeStory_MoveToFocus_Work:onStart()
	CollegeHelper.instance:focusTo(self._toMo, self._onDone, self)
end

function CollegeStory_MoveToFocus_Work:_onDone()
	self:onDone(true)
end

return CollegeStory_MoveToFocus_Work
