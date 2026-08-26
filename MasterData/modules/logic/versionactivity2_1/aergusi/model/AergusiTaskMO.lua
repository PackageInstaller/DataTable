-- chunkname: @modules/logic/versionactivity2_1/aergusi/model/AergusiTaskMO.lua

module("modules.logic.versionactivity2_1.aergusi.model.AergusiTaskMO", package.seeall)

local AergusiTaskMO = pureTable("AergusiTaskMO")

function AergusiTaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function AergusiTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function AergusiTaskMO:isLock()
	return self.taskMO == nil
end

function AergusiTaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function AergusiTaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function AergusiTaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function AergusiTaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return AergusiTaskMO
