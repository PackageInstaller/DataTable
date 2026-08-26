-- chunkname: @modules/logic/fight/system/work/FightWorkEffectCardLevelChangeContainer.lua

module("modules.logic.fight.system.work.FightWorkEffectCardLevelChangeContainer", package.seeall)

local FightWorkEffectCardLevelChangeContainer = class("FightWorkEffectCardLevelChangeContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkEffectCardLevelChangeContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkEffectCardLevelChangeContainer:clearWork()
	return
end

return FightWorkEffectCardLevelChangeContainer
