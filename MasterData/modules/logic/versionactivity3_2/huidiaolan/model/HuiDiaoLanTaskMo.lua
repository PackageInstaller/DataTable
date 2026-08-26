-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/model/HuiDiaoLanTaskMo.lua

module("modules.logic.versionactivity3_2.huidiaolan.model.HuiDiaoLanTaskMo", package.seeall)

local HuiDiaoLanTaskMo = pureTable("HuiDiaoLanTaskMo")

function HuiDiaoLanTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function HuiDiaoLanTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function HuiDiaoLanTaskMo:isLock()
	return self.taskMO == nil
end

function HuiDiaoLanTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function HuiDiaoLanTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function HuiDiaoLanTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function HuiDiaoLanTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return HuiDiaoLanTaskMo
