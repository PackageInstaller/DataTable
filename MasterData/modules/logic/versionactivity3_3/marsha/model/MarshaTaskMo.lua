-- chunkname: @modules/logic/versionactivity3_3/marsha/model/MarshaTaskMo.lua

module("modules.logic.versionactivity3_3.marsha.model.MarshaTaskMo", package.seeall)

local MarshaTaskMo = pureTable("MarshaTaskMo")

function MarshaTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function MarshaTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function MarshaTaskMo:isLock()
	return self.taskMO == nil
end

function MarshaTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function MarshaTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function MarshaTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function MarshaTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return MarshaTaskMo
