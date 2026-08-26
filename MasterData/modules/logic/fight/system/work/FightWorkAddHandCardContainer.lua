-- chunkname: @modules/logic/fight/system/work/FightWorkAddHandCardContainer.lua

module("modules.logic.fight.system.work.FightWorkAddHandCardContainer", package.seeall)

local FightWorkAddHandCardContainer = class("FightWorkAddHandCardContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkAddHandCardContainer:onStart()
	local list = self:getAdjacentSameEffectList(parallelEffectType, true)
	local flow = self:com_registWorkDoneFlowParallel()
	local count = 0

	for i, data in ipairs(list) do
		local effectType = data.actEffectData.effectType
		local class = FightStepBuilder.ActEffectWorkCls[effectType]

		count = count + 1

		local sequence = flow:registWork(FightWorkFlowSequence)

		sequence:registWork(FightWorkDelayTimer, 0.05 * count)
		sequence:registWork(class, data.fightStepData, data.actEffectData)
	end

	flow:start()
end

function FightWorkAddHandCardContainer:clearWork()
	return
end

return FightWorkAddHandCardContainer
