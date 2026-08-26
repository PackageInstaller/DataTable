-- chunkname: @modules/logic/fight/system/work/FightWorkAddSpHandCard320Container.lua

module("modules.logic.fight.system.work.FightWorkAddSpHandCard320Container", package.seeall)

local FightWorkAddSpHandCard320Container = class("FightWorkAddSpHandCard320Container", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.SPCARDADD] = true,
	[FightEnum.EffectType.CHANGETOTEMPCARD] = true
}

function FightWorkAddSpHandCard320Container:onStart()
	local list = self:getAdjacentSameEffectList(parallelEffectType, true)
	local flow = self:com_registWorkDoneFlowParallel()
	local sequence = flow:registWork(FightWorkFlowSequence)
	local count = 0

	for i, data in ipairs(list) do
		local effectType = data.actEffectData.effectType
		local class = FightStepBuilder.ActEffectWorkCls[effectType]

		if effectType == FightEnum.EffectType.SPCARDADD then
			count = count + 1
			sequence = flow:registWork(FightWorkFlowSequence)

			sequence:registWork(FightWorkDelayTimer, 0.1 * count)
		end

		sequence:registWork(class, data.fightStepData, data.actEffectData)
	end

	flow:start()
end

function FightWorkAddSpHandCard320Container:clearWork()
	return
end

return FightWorkAddSpHandCard320Container
