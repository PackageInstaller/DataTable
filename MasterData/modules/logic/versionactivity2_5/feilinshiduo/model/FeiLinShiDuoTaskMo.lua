-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/model/FeiLinShiDuoTaskMo.lua

module("modules.logic.versionactivity2_5.feilinshiduo.model.FeiLinShiDuoTaskMo", package.seeall)

local FeiLinShiDuoTaskMo = pureTable("FeiLinShiDuoTaskMo")

function FeiLinShiDuoTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function FeiLinShiDuoTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function FeiLinShiDuoTaskMo:isLock()
	return self.taskMO == nil
end

function FeiLinShiDuoTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function FeiLinShiDuoTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function FeiLinShiDuoTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function FeiLinShiDuoTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return FeiLinShiDuoTaskMo
