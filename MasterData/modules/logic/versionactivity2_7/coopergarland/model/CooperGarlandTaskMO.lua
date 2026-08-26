-- chunkname: @modules/logic/versionactivity2_7/coopergarland/model/CooperGarlandTaskMO.lua

module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandTaskMO", package.seeall)

local CooperGarlandTaskMO = pureTable("CooperGarlandTaskMO")

function CooperGarlandTaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function CooperGarlandTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function CooperGarlandTaskMO:isLock()
	return self.taskMO == nil
end

function CooperGarlandTaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function CooperGarlandTaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function CooperGarlandTaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function CooperGarlandTaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return CooperGarlandTaskMO
