-- chunkname: @modules/logic/fight/system/work/FightWorkSkillDelay.lua

module("modules.logic.fight.system.work.FightWorkSkillDelay", package.seeall)

local FightWorkSkillDelay = class("FightWorkSkillDelay", BaseWork)

function FightWorkSkillDelay:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkSkillDelay:onStart()
	local config = lua_fight_skill_delay.configDict[self.fightStepData.actId]

	if config then
		if FightDataHelper.stateMgr.isReplay then
			self:onDone(true)
		else
			TaskDispatcher.runDelay(self._delayDone, self, config.delay / 1000 / FightModel.instance:getSpeed())
		end
	else
		self:onDone(true)
	end
end

function FightWorkSkillDelay:_delayDone()
	self:onDone(true)
end

function FightWorkSkillDelay:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkSkillDelay
