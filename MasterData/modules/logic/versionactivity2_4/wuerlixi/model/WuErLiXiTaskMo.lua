-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiTaskMo.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiTaskMo", package.seeall)

local WuErLiXiTaskMo = pureTable("WuErLiXiTaskMo")

function WuErLiXiTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function WuErLiXiTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function WuErLiXiTaskMo:isLock()
	return self.taskMO == nil
end

function WuErLiXiTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function WuErLiXiTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function WuErLiXiTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function WuErLiXiTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return WuErLiXiTaskMo
