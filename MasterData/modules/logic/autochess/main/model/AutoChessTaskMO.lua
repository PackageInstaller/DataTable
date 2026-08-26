-- chunkname: @modules/logic/autochess/main/model/AutoChessTaskMO.lua

module("modules.logic.autochess.main.model.AutoChessTaskMO", package.seeall)

local AutoChessTaskMO = pureTable("AutoChessTaskMO")

function AutoChessTaskMO:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function AutoChessTaskMO:initAllMo(actId)
	self.id = -99999
	self.activityId = actId
end

function AutoChessTaskMO:isAllMo()
	return self.id == -99999
end

function AutoChessTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function AutoChessTaskMO:isLock()
	if self.config then
		local openLimit = self.config.openLimit

		if not string.nilorempty(openLimit) then
			local actMo = Activity182Model.instance:getActMo()
			local openLvl = tonumber(string.split(openLimit, "=")[2])

			if openLvl > actMo.warnLevel then
				return true, openLvl
			end
		end

		return false
	end
end

function AutoChessTaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function AutoChessTaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function AutoChessTaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function AutoChessTaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return AutoChessTaskMO
