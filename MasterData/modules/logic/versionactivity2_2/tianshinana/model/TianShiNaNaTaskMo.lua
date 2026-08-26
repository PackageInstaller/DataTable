-- chunkname: @modules/logic/versionactivity2_2/tianshinana/model/TianShiNaNaTaskMo.lua

module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaTaskMo", package.seeall)

local TianShiNaNaTaskMo = pureTable("TianShiNaNaTaskMo")

function TianShiNaNaTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function TianShiNaNaTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function TianShiNaNaTaskMo:isLock()
	return self.taskMO == nil
end

function TianShiNaNaTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function TianShiNaNaTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function TianShiNaNaTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function TianShiNaNaTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return TianShiNaNaTaskMo
