-- chunkname: @modules/logic/versionactivity2_4/pinball/model/PinballTaskMo.lua

module("modules.logic.versionactivity2_4.pinball.model.PinballTaskMo", package.seeall)

local PinballTaskMo = pureTable("PinballTaskMo")

function PinballTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function PinballTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function PinballTaskMo:isLock()
	return self.taskMO == nil
end

function PinballTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function PinballTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function PinballTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function PinballTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return PinballTaskMo
