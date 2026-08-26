-- chunkname: @modules/logic/fight/system/work/FightWorkRemoveEntityCardsContainer.lua

module("modules.logic.fight.system.work.FightWorkRemoveEntityCardsContainer", package.seeall)

local FightWorkRemoveEntityCardsContainer = class("FightWorkRemoveEntityCardsContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.DEAD] = true,
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkRemoveEntityCardsContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkRemoveEntityCardsContainer:clearWork()
	return
end

return FightWorkRemoveEntityCardsContainer
