-- chunkname: @modules/logic/fight/system/work/FightWorkCardInvalidContainer.lua

module("modules.logic.fight.system.work.FightWorkCardInvalidContainer", package.seeall)

local FightWorkCardInvalidContainer = class("FightWorkCardInvalidContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkCardInvalidContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkCardInvalidContainer:clearWork()
	return
end

return FightWorkCardInvalidContainer
