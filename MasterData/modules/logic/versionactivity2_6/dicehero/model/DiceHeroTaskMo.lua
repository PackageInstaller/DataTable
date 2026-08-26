-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/DiceHeroTaskMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroTaskMo", package.seeall)

local DiceHeroTaskMo = pureTable("DiceHeroTaskMo")

function DiceHeroTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function DiceHeroTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function DiceHeroTaskMo:isLock()
	return self.taskMO == nil
end

function DiceHeroTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function DiceHeroTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function DiceHeroTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function DiceHeroTaskMo:alreadyGotReward()
	if self.id == -99999 then
		return true
	end

	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return DiceHeroTaskMo
