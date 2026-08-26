-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/flow/Activity114RestFlow.lua

module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114RestFlow", package.seeall)

local Activity114RestFlow = class("Activity114RestFlow", Activity114BaseFlow)

function Activity114RestFlow:addEventWork()
	self:addWork(Activity114StoryWork.New(self.context.eventCo.config.successStoryId, Activity114Enum.StoryType.Result))
	self:addWork(Activity114StopStoryWork.New())
	self:addWork(Activity114OpenViewWork.New(ViewName.Activity114TransitionView))
	self:addWork(Activity114OpenAttrViewWork.New())
end

return Activity114RestFlow
