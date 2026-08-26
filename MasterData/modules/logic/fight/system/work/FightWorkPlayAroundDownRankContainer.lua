-- chunkname: @modules/logic/fight/system/work/FightWorkPlayAroundDownRankContainer.lua

module("modules.logic.fight.system.work.FightWorkPlayAroundDownRankContainer", package.seeall)

local FightWorkPlayAroundDownRankContainer = class("FightWorkPlayAroundDownRankContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = true,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = true,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = true
}

function FightWorkPlayAroundDownRankContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkPlayAroundDownRankContainer:clearWork()
	return
end

return FightWorkPlayAroundDownRankContainer
