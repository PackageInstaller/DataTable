-- chunkname: @modules/logic/versionactivity3_4/lusijian/model/LuSiJianTaskMo.lua

module("modules.logic.versionactivity3_4.lusijian.model.LuSiJianTaskMo", package.seeall)

local LuSiJianTaskMo = pureTable("LuSiJianTaskMo")

function LuSiJianTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function LuSiJianTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function LuSiJianTaskMo:isLock()
	return self.taskMO == nil
end

function LuSiJianTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function LuSiJianTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function LuSiJianTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function LuSiJianTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return LuSiJianTaskMo
