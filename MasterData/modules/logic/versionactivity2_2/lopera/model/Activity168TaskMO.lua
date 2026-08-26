-- chunkname: @modules/logic/versionactivity2_2/lopera/model/Activity168TaskMO.lua

module("modules.logic.versionactivity2_2.lopera.model.Activity168TaskMO", package.seeall)

local Activity168TaskMO = pureTable("Activity168TaskMO")

function Activity168TaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function Activity168TaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity168TaskMO:isLock()
	return self.taskMO == nil
end

function Activity168TaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function Activity168TaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity168TaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity168TaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return Activity168TaskMO
