-- chunkname: @modules/logic/fight/system/work/FightWorkSpecialDelay.lua

module("modules.logic.fight.system.work.FightWorkSpecialDelay", package.seeall)

local FightWorkSpecialDelay = class("FightWorkSpecialDelay", BaseWork)

function FightWorkSpecialDelay:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkSpecialDelay:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 0.5)

	local entity = FightHelper.getEntity(self.fightStepData.fromId)
	local entityMO = entity and entity:getMO()

	if entityMO then
		local tarClass = _G["FightWorkSpecialDelayModelId" .. entityMO.modelId]

		if tarClass then
			TaskDispatcher.cancelTask(self._delayDone, self)

			self._delayClass = tarClass.New(self, self.fightStepData)

			return
		end
	end

	self:_delayDone()
end

function FightWorkSpecialDelay:_delayDone()
	self:onDone(true)
end

function FightWorkSpecialDelay:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)

	if self._delayClass then
		self._delayClass:releaseSelf()

		self._delayClass = nil
	end
end

return FightWorkSpecialDelay
