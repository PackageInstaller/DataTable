-- chunkname: @modules/logic/versionactivity1_7/isolde/model/ActIsoldeTaskMO.lua

module("modules.logic.versionactivity1_7.isolde.model.ActIsoldeTaskMO", package.seeall)

local ActIsoldeTaskMO = pureTable("ActIsoldeTaskMO")

function ActIsoldeTaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function ActIsoldeTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function ActIsoldeTaskMO:isLock()
	return self.taskMO == nil
end

function ActIsoldeTaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function ActIsoldeTaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function ActIsoldeTaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function ActIsoldeTaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return ActIsoldeTaskMO
