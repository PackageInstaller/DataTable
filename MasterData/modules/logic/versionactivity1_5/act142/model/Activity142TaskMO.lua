-- chunkname: @modules/logic/versionactivity1_5/act142/model/Activity142TaskMO.lua

module("modules.logic.versionactivity1_5.act142.model.Activity142TaskMO", package.seeall)

local Activity142TaskMO = pureTable("Activity142TaskMO")

function Activity142TaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.config = taskCfg
	self.taskMO = taskMO
end

function Activity142TaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity142TaskMO:isLock()
	return self.taskMO == nil
end

function Activity142TaskMO:isFinished()
	if self.taskMO then
		return self.taskMO.hasFinished
	end

	return false
end

function Activity142TaskMO:getProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity142TaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity142TaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.finishCount or 0)
end

function Activity142TaskMO:alreadyGotReward()
	return self:getFinishProgress() > 0
end

function Activity142TaskMO:haveRewardToGet()
	return self:getFinishProgress() == 0 and self:isFinished()
end

return Activity142TaskMO
