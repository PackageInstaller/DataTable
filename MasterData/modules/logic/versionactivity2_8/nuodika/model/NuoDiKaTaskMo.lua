-- chunkname: @modules/logic/versionactivity2_8/nuodika/model/NuoDiKaTaskMo.lua

module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaTaskMo", package.seeall)

local NuoDiKaTaskMo = pureTable("NuoDiKaTaskMo")

function NuoDiKaTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function NuoDiKaTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function NuoDiKaTaskMo:isLock()
	return self.taskMO == nil
end

function NuoDiKaTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function NuoDiKaTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function NuoDiKaTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function NuoDiKaTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return NuoDiKaTaskMo
