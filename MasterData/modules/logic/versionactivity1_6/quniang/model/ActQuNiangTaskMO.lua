-- chunkname: @modules/logic/versionactivity1_6/quniang/model/ActQuNiangTaskMO.lua

module("modules.logic.versionactivity1_6.quniang.model.ActQuNiangTaskMO", package.seeall)

local ActQuNiangTaskMO = pureTable("ActQuNiangTaskMO")

function ActQuNiangTaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function ActQuNiangTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function ActQuNiangTaskMO:isLock()
	return self.taskMO == nil
end

function ActQuNiangTaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function ActQuNiangTaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function ActQuNiangTaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function ActQuNiangTaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return ActQuNiangTaskMO
