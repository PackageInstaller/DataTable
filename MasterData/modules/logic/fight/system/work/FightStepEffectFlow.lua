-- chunkname: @modules/logic/fight/system/work/FightStepEffectFlow.lua

module("modules.logic.fight.system.work.FightStepEffectFlow", package.seeall)

local FightStepEffectFlow = class("FightStepEffectFlow", FightEffectBase)

function FightStepEffectFlow:playEffectData()
	return
end

function FightStepEffectFlow:playAdjacentSequenceEffect(parallelEffectType, detectNextStep)
	local list = self:getAdjacentSameEffectList(parallelEffectType, detectNextStep)
	local flow = self:com_registWorkDoneFlowSequence()

	for i, data in ipairs(list) do
		local actEffectData = data.actEffectData
		local effectType = actEffectData.effectType
		local class = FightStepBuilder.ActEffectWorkCls[effectType]

		flow:registWork(class, data.fightStepData, actEffectData)
	end

	return flow:start()
end

function FightStepEffectFlow:playAdjacentParallelEffect(parallelEffectType, detectNextStep)
	local list = self:getAdjacentSameEffectList(parallelEffectType, detectNextStep)
	local flow = self:com_registWorkDoneFlowParallel()

	for i, data in ipairs(list) do
		local effectType = data.actEffectData.effectType
		local class = FightStepBuilder.ActEffectWorkCls[effectType]

		flow:registWork(class, data.fightStepData, data.actEffectData)
	end

	return flow:start()
end

return FightStepEffectFlow
