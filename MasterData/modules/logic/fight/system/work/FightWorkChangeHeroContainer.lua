-- chunkname: @modules/logic/fight/system/work/FightWorkChangeHeroContainer.lua

module("modules.logic.fight.system.work.FightWorkChangeHeroContainer", package.seeall)

local FightWorkChangeHeroContainer = class("FightWorkChangeHeroContainer", FightStepEffectFlow)

function FightWorkChangeHeroContainer:onStart()
	local parallelEffectType = {
		[FightEnum.EffectType.CALLMONSTERTOSUB] = true
	}
	local list = self:getAdjacentSameEffectList(parallelEffectType, true)
	local sequence = self:com_registWorkDoneFlowSequence()
	local flow = sequence:registWork(FightWorkFlowParallel)

	for i, data in ipairs(list) do
		local effectType = data.actEffectData.effectType
		local class = FightStepBuilder.ActEffectWorkCls[effectType]

		flow:registWork(class, data.fightStepData, data.actEffectData)
	end

	sequence:registWork(FightWorkFocusMonsterAfterChangeHero)
	sequence:start()
end

function FightWorkChangeHeroContainer:_showSubEntity()
	FightGameMgr.entityMgr:showSubEntity()
end

function FightWorkChangeHeroContainer:clearWork()
	return
end

return FightWorkChangeHeroContainer
