-- chunkname: @modules/logic/versionactivity1_3/jialabona/model/Activity120TaskMO.lua

module("modules.logic.versionactivity1_3.jialabona.model.Activity120TaskMO", package.seeall)

local Activity120TaskMO = pureTable("Activity120TaskMO")

function Activity120TaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function Activity120TaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity120TaskMO:isLock()
	return self.taskMO == nil
end

function Activity120TaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function Activity120TaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity120TaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity120TaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return Activity120TaskMO
