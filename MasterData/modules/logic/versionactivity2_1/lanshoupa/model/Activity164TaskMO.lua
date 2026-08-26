-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/model/Activity164TaskMO.lua

module("modules.logic.versionactivity2_1.lanshoupa.model.Activity164TaskMO", package.seeall)

local Activity164TaskMO = pureTable("Activity164TaskMO")

function Activity164TaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function Activity164TaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity164TaskMO:isLock()
	return self.taskMO == nil
end

function Activity164TaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function Activity164TaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity164TaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity164TaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return Activity164TaskMO
