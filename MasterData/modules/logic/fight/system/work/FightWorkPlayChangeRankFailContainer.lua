-- chunkname: @modules/logic/fight/system/work/FightWorkPlayChangeRankFailContainer.lua

module("modules.logic.fight.system.work.FightWorkPlayChangeRankFailContainer", package.seeall)

local FightWorkPlayChangeRankFailContainer = class("FightWorkPlayChangeRankFailContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = true,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = true,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = true
}

function FightWorkPlayChangeRankFailContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkPlayChangeRankFailContainer:clearWork()
	return
end

return FightWorkPlayChangeRankFailContainer
