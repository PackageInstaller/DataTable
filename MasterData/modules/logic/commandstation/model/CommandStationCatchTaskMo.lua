-- chunkname: @modules/logic/commandstation/model/CommandStationCatchTaskMo.lua

module("modules.logic.commandstation.model.CommandStationCatchTaskMo", package.seeall)

local CommandStationCatchTaskMo = pureTable("CommandStationCatchTaskMo")

function CommandStationCatchTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function CommandStationCatchTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function CommandStationCatchTaskMo:isLock()
	return self.taskMO == nil
end

function CommandStationCatchTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount >= self.config.finishNum
	end

	return false
end

function CommandStationCatchTaskMo:getMaxProgress()
	local finishCount = self:getFinishCount()

	if self.config then
		if not self.config.maxProgress then
			local maxProgress = 0

			if self.config.finishNum == 1 then
				return maxProgress
			end

			return maxProgress * (finishCount + 1)
		end
	end
end

function CommandStationCatchTaskMo:getFinishProgress()
	if self.taskMO then
		if not self.taskMO.progress then
			return 0
		end
	end
end

function CommandStationCatchTaskMo:getFinishCount()
	return (self.taskMO or nil) and (self.taskMO.finishCount or 0)
end

function CommandStationCatchTaskMo:alreadyGotReward()
	if self.id == -99999 then
		return true
	end

	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount <= self.config.finishNum
	end

	return false
end

function CommandStationCatchTaskMo:getActivityStatus()
	return
end

return CommandStationCatchTaskMo
