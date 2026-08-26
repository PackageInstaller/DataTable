-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/Activity201MaLiAnNaTaskMo.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.Activity201MaLiAnNaTaskMo", package.seeall)

local Activity201MaLiAnNaTaskMo = pureTable("Activity201MaLiAnNaTaskMo")

function Activity201MaLiAnNaTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function Activity201MaLiAnNaTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity201MaLiAnNaTaskMo:isLock()
	return self.taskMO == nil
end

function Activity201MaLiAnNaTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function Activity201MaLiAnNaTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity201MaLiAnNaTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity201MaLiAnNaTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return Activity201MaLiAnNaTaskMo
