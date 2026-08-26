-- chunkname: @modules/logic/fight/system/work/FightWorkRemoveUnivesalCardsContainer.lua

module("modules.logic.fight.system.work.FightWorkRemoveUnivesalCardsContainer", package.seeall)

local FightWorkRemoveUnivesalCardsContainer = class("FightWorkRemoveUnivesalCardsContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkRemoveUnivesalCardsContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkRemoveUnivesalCardsContainer:clearWork()
	return
end

return FightWorkRemoveUnivesalCardsContainer
