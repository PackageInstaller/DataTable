-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114FightResultWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114FightResultWork", package.seeall)

local Activity114FightResultWork = class("Activity114FightResultWork", Activity114BaseWork)

function Activity114FightResultWork:onStart()
	Activity114Controller.instance:registerCallback(Activity114Event.OnFightResult, self.onFightResult, self)
end

function Activity114FightResultWork:onFightResult(result)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnFightResult, self.onFightResult, self)

	self.context.result = result

	if self.context.type == Activity114Enum.EventType.KeyDay then
		if result == Activity114Enum.Result.Success then
			self.context.storyId = self.context.eventCo.config.successStoryId or self.context.eventCo.config.failureStoryId
		end
	end

	self:onDone(true)
end

function Activity114FightResultWork:clearWork()
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnFightResult, self.onFightResult, self)
	Activity114FightResultWork.super.clearWork(self)
end

return Activity114FightResultWork
