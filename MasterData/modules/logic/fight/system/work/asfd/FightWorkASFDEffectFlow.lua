-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkASFDEffectFlow.lua

module("modules.logic.fight.system.work.asfd.FightWorkASFDEffectFlow", package.seeall)

local FightWorkASFDEffectFlow = class("FightWorkASFDEffectFlow", BaseWork)

function FightWorkASFDEffectFlow:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkASFDEffectFlow:onStart()
	local effectWorkList = FightStepBuilder._buildEffectWorks(self.fightStepData)

	self.stepWork = effectWorkList and effectWorkList[1]

	if not self.stepWork then
		return self:onDone(true)
	end

	self.stepWork:registerDoneListener(self.onEffectWorkDone, self)
	self.stepWork:onStartInternal()
end

function FightWorkASFDEffectFlow:onEffectWorkDone()
	return self:onDone(true)
end

return FightWorkASFDEffectFlow
