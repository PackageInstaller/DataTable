-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114CheckResultWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckResultWork", package.seeall)

local Activity114CheckResultWork = class("Activity114CheckResultWork", Activity114BaseWork)

function Activity114CheckResultWork:onStart(context)
	local eventCo = self.context.eventCo

	if eventCo.config.isCheckEvent == 1 then
		self:getFlow():addWork(Activity114StopStoryWork.New())
	end

	if self.context.result == Activity114Enum.Result.None then
		self.context.storyId = nil
	elseif self.context.result == Activity114Enum.Result.Success then
		self:getFlow():addWork(Activity114StoryWork.New(eventCo.config.successStoryId, Activity114Enum.StoryType.Result))
		self:getFlow():addWork(Activity114StopStoryWork.New())
		self:getFlow():addWork(Activity114OpenAttrViewWork.New())
	elseif self.context.result == Activity114Enum.Result.Fail then
		self:getFlow():addWork(Activity114StoryWork.New(eventCo.config.failureStoryId, Activity114Enum.StoryType.Result))

		if eventCo.config.battleId > 0 then
			self:getFlow():addWork(Activity114StopStoryWork.New())
			self:getFlow():addWork(Activity114FightWork.New())
			self:getFlow():addWork(Activity114FightResultWork.New())
			self:getFlow():addWork(Activity114OpenAttrViewWork.New())
		else
			self:getFlow():addWork(Activity114StopStoryWork.New())
			self:getFlow():addWork(Activity114OpenAttrViewWork.New())
		end
	end

	self:startFlow()
end

return Activity114CheckResultWork
