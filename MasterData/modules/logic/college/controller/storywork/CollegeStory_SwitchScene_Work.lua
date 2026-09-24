-- chunkname: @modules/logic/college/controller/storywork/CollegeStory_SwitchScene_Work.lua

module("modules.logic.college.controller.storywork.CollegeStory_SwitchScene_Work", package.seeall)

local CollegeStory_SwitchScene_Work = class("CollegeStory_SwitchScene_Work", BaseWork)

function CollegeStory_SwitchScene_Work:ctor(toSceneType)
	self._toSceneType = toSceneType
end

function CollegeStory_SwitchScene_Work:onStart()
	CollegeController.instance:registerCallback(CollegeEvent.ChangeSceneTypeEnd, self.onChangeSceneType, self)
	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeSceneType, self._toSceneType)
end

function CollegeStory_SwitchScene_Work:onChangeSceneType()
	self:onDone(true)
end

function CollegeStory_SwitchScene_Work:clearWork()
	CollegeController.instance:unregisterCallback(CollegeEvent.ChangeSceneTypeEnd, self.onChangeSceneType, self)
end

return CollegeStory_SwitchScene_Work
