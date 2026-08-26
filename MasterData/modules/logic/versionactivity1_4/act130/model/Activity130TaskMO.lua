-- chunkname: @modules/logic/versionactivity1_4/act130/model/Activity130TaskMO.lua

module("modules.logic.versionactivity1_4.act130.model.Activity130TaskMO", package.seeall)

local Activity130TaskMO = pureTable("Activity130TaskMO")

function Activity130TaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function Activity130TaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity130TaskMO:isLock()
	return self.taskMO == nil
end

function Activity130TaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function Activity130TaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity130TaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity130TaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return Activity130TaskMO
