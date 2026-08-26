-- chunkname: @modules/logic/versionactivity1_3/chess/model/Activity122TaskMO.lua

module("modules.logic.versionactivity1_3.chess.model.Activity122TaskMO", package.seeall)

local Activity122TaskMO = pureTable("Activity122TaskMO")

function Activity122TaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.config = taskCfg
	self.taskMO = taskMO
end

function Activity122TaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity122TaskMO:isLock()
	return self.taskMO == nil
end

function Activity122TaskMO:isFinished()
	if self.taskMO then
		return self.taskMO.hasFinished
	end

	return false
end

function Activity122TaskMO:getProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity122TaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity122TaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.finishCount or 0)
end

function Activity122TaskMO:alreadyGotReward()
	return self:getFinishProgress() > 0
end

function Activity122TaskMO:haveRewardToGet()
	return self:getFinishProgress() == 0 and self:isFinished()
end

return Activity122TaskMO
