-- chunkname: @modules/logic/versionactivity1_6/getian/model/ActGeTianTaskMO.lua

module("modules.logic.versionactivity1_6.getian.model.ActGeTianTaskMO", package.seeall)

local ActGeTianTaskMO = pureTable("ActGeTianTaskMO")

function ActGeTianTaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function ActGeTianTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function ActGeTianTaskMO:isLock()
	return self.taskMO == nil
end

function ActGeTianTaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function ActGeTianTaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function ActGeTianTaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function ActGeTianTaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return ActGeTianTaskMO
