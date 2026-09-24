-- chunkname: @modules/logic/college/controller/storywork/CollegeStory_PlayDialogue_Work.lua

module("modules.logic.college.controller.storywork.CollegeStory_PlayDialogue_Work", package.seeall)

local CollegeStory_PlayDialogue_Work = class("CollegeStory_PlayDialogue_Work", BaseWork)

function CollegeStory_PlayDialogue_Work:ctor(storyData)
	self._storyData = storyData
end

function CollegeStory_PlayDialogue_Work:onStart()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	ViewMgr.instance:openView(ViewName.CollegeStoryView, {
		steps = self._storyData.steps,
		type = self._storyData.type
	})
end

function CollegeStory_PlayDialogue_Work:_onViewClose(viewName)
	if viewName == ViewName.CollegeStoryView then
		self:onDone(true)
	end
end

function CollegeStory_PlayDialogue_Work:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

return CollegeStory_PlayDialogue_Work
