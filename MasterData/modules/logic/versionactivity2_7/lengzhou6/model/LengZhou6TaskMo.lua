-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/LengZhou6TaskMo.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6TaskMo", package.seeall)

local LengZhou6TaskMo = pureTable("LengZhou6TaskMo")

function LengZhou6TaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function LengZhou6TaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function LengZhou6TaskMo:isLock()
	return self.taskMO == nil
end

function LengZhou6TaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function LengZhou6TaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function LengZhou6TaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function LengZhou6TaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return LengZhou6TaskMo
