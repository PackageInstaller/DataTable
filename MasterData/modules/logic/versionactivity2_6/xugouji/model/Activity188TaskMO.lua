-- chunkname: @modules/logic/versionactivity2_6/xugouji/model/Activity188TaskMO.lua

module("modules.logic.versionactivity2_6.xugouji.model.Activity188TaskMO", package.seeall)

local Activity188TaskMO = pureTable("Activity188TaskMO")

function Activity188TaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function Activity188TaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity188TaskMO:isLock()
	return self.taskMO == nil
end

function Activity188TaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function Activity188TaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity188TaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity188TaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return Activity188TaskMO
