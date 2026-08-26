-- chunkname: @modules/logic/fight/system/work/FightWorkSpCardAddContainer.lua

module("modules.logic.fight.system.work.FightWorkSpCardAddContainer", package.seeall)

local FightWorkSpCardAddContainer = class("FightWorkSpCardAddContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.SPCARDADD] = true,
	[FightEnum.EffectType.CHANGETOTEMPCARD] = true
}

function FightWorkSpCardAddContainer:onStart()
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

function FightWorkSpCardAddContainer:clearWork()
	return
end

return FightWorkSpCardAddContainer
