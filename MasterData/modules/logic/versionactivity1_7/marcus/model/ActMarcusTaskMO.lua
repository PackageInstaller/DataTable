-- chunkname: @modules/logic/versionactivity1_7/marcus/model/ActMarcusTaskMO.lua

module("modules.logic.versionactivity1_7.marcus.model.ActMarcusTaskMO", package.seeall)

local ActMarcusTaskMO = pureTable("ActMarcusTaskMO")

function ActMarcusTaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function ActMarcusTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function ActMarcusTaskMO:isLock()
	return self.taskMO == nil
end

function ActMarcusTaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function ActMarcusTaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function ActMarcusTaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function ActMarcusTaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return ActMarcusTaskMO
