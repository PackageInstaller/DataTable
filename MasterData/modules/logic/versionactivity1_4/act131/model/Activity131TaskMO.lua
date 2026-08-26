-- chunkname: @modules/logic/versionactivity1_4/act131/model/Activity131TaskMO.lua

module("modules.logic.versionactivity1_4.act131.model.Activity131TaskMO", package.seeall)

local Activity131TaskMO = pureTable("Activity131TaskMO")

function Activity131TaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function Activity131TaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity131TaskMO:isLock()
	return self.taskMO == nil
end

function Activity131TaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function Activity131TaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity131TaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity131TaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return Activity131TaskMO
