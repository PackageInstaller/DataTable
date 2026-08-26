-- chunkname: @modules/logic/activity/model/warmup/ActivityWarmUpTaskMO.lua

module("modules.logic.activity.model.warmup.ActivityWarmUpTaskMO", package.seeall)

local ActivityWarmUpTaskMO = pureTable("ActivityWarmUpTaskMO")

function ActivityWarmUpTaskMO:init(taskMO, taskCO)
	self.id = taskCO.id
	self.config = taskCO
	self.taskMO = taskMO
end

function ActivityWarmUpTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function ActivityWarmUpTaskMO:isLock()
	return self.taskMO == nil
end

function ActivityWarmUpTaskMO:isFinished()
	if self.taskMO then
		return self.taskMO.hasFinished
	end

	return false
end

function ActivityWarmUpTaskMO:getProgress()
	if self.taskMO then
		return self.taskMO.progress
	end

	return 0
end

function ActivityWarmUpTaskMO:alreadyGotReward()
	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

return ActivityWarmUpTaskMO
