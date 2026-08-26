-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/flow/Activity114EduFlow.lua

module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114EduFlow", package.seeall)

local Activity114EduFlow = class("Activity114EduFlow", Activity114BaseFlow)

function Activity114EduFlow:addEventWork()
	self:addWork(Activity114EduWork.New())
	self:addWork(Activity114StoryWork.New(nil, Activity114Enum.StoryType.Result))
	self:addWork(Activity114StopStoryWork.New())
	self:addWork(Activity114OpenTransitionViewByEventCoWork.New())
	self:addWork(Activity114OpenAttrViewWork.New())
end

return Activity114EduFlow
