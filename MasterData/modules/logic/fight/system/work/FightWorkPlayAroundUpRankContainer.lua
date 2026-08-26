-- chunkname: @modules/logic/fight/system/work/FightWorkPlayAroundUpRankContainer.lua

module("modules.logic.fight.system.work.FightWorkPlayAroundUpRankContainer", package.seeall)

local FightWorkPlayAroundUpRankContainer = class("FightWorkPlayAroundUpRankContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = true,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = true,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = true
}

function FightWorkPlayAroundUpRankContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkPlayAroundUpRankContainer:clearWork()
	return
end

return FightWorkPlayAroundUpRankContainer
