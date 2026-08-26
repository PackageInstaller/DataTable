-- chunkname: @modules/logic/fight/system/work/FightWorkEffectDeadPerformance.lua

module("modules.logic.fight.system.work.FightWorkEffectDeadPerformance", package.seeall)

local FightWorkEffectDeadPerformance = class("FightWorkEffectDeadPerformance", FightEffectBase)

function FightWorkEffectDeadPerformance:onLogicEnter(fightStepData, fightActEffectData, waitForLastHit)
	self.fightStepData = fightStepData
	self.actEffectData = fightActEffectData
	self._waitForLastHit = waitForLastHit
end

function FightWorkEffectDeadPerformance:onStart()
	self:com_registFightEvent(FightEvent.BeforeDestroyEntity, self.onBeforeDestroyEntity)

	local flow = self:com_registWorkDoneFlowSequence()

	flow:registWork(FightWorkEffectDeadNew, self.fightStepData, self.actEffectData, self._waitForLastHit)

	local version = FightModel.instance:getVersion()

	if version < 1 and self.actEffectData and self.actEffectData.targetId then
		flow:addWork(Work2FightWork.New(FightWorkDissolveCardForDeadVersion0, self.actEffectData))
	end

	flow:start()
end

function FightWorkEffectDeadPerformance:onBeforeDestroyEntity(entity)
	if entity.id == self.fightStepData.fromId then
		-- block empty
	end
end

function FightWorkEffectDeadPerformance:clearWork()
	return
end

return FightWorkEffectDeadPerformance
