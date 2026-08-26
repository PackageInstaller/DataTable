-- chunkname: @modules/logic/versionactivity2_5/liangyue/model/LiangYueTaskMo.lua

module("modules.logic.versionactivity2_5.liangyue.model.LiangYueTaskMo", package.seeall)

local LiangYueTaskMo = pureTable("LiangYueTaskMo")

function LiangYueTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function LiangYueTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function LiangYueTaskMo:isLock()
	return self.taskMO == nil
end

function LiangYueTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function LiangYueTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function LiangYueTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function LiangYueTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return LiangYueTaskMo
