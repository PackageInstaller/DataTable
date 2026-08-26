-- chunkname: @modules/logic/versionactivity220/model/Activity220TaskMo.lua

module("modules.logic.versionactivity220.model.Activity220TaskMo", package.seeall)

local Activity220TaskMo = pureTable("Activity220TaskMo")

function Activity220TaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function Activity220TaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function Activity220TaskMo:isLock()
	return self.taskMO == nil
end

function Activity220TaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function Activity220TaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function Activity220TaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function Activity220TaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return Activity220TaskMo
