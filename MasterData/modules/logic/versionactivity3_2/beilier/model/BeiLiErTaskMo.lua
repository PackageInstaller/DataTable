-- chunkname: @modules/logic/versionactivity3_2/beilier/model/BeiLiErTaskMo.lua

module("modules.logic.versionactivity3_2.beilier.model.BeiLiErTaskMo", package.seeall)

local BeiLiErTaskMo = pureTable("BeiLiErTaskMo")

function BeiLiErTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function BeiLiErTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function BeiLiErTaskMo:isLock()
	return self.taskMO == nil
end

function BeiLiErTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function BeiLiErTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function BeiLiErTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function BeiLiErTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return BeiLiErTaskMo
