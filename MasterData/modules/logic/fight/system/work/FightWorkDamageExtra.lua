-- chunkname: @modules/logic/fight/system/work/FightWorkDamageExtra.lua

module("modules.logic.fight.system.work.FightWorkDamageExtra", package.seeall)

local FightWorkDamageExtra = class("FightWorkDamageExtra", FightEffectBase)

function FightWorkDamageExtra:onStart()
	self._flow = FlowParallel.New()

	self._flow:addWork(FunctionWork.New(self._resignDone, self))
	self._flow:addWork(FightWork2Work.New(FightWorkEffectDamage, self.fightStepData, self.actEffectData))
	self._flow:addWork(FunctionWork.New(self._resignDone, self))
	self._flow:addWork(FightWork2Work.New(FightBuffTriggerEffect, self.fightStepData, self.actEffectData))
	self._flow:registerDoneListener(self._onFlowDone, self)
	self._flow:start()
end

function FightWorkDamageExtra:_resignDone()
	self.actEffectData:revertDone()
end

function FightWorkDamageExtra:_onFlowDone()
	self:onDone(true)
end

function FightWorkDamageExtra:clearWork()
	if self._flow then
		self._flow:unregisterDoneListener(self._onFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkDamageExtra
