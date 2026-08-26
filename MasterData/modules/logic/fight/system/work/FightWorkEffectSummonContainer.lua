-- chunkname: @modules/logic/fight/system/work/FightWorkEffectSummonContainer.lua

module("modules.logic.fight.system.work.FightWorkEffectSummonContainer", package.seeall)

local FightWorkEffectSummonContainer = class("FightWorkEffectSummonContainer", FightStepEffectFlow)

function FightWorkEffectSummonContainer:onStart()
	self:playAdjacentParallelEffect(nil, true)
end

function FightWorkEffectSummonContainer:clearWork()
	return
end

return FightWorkEffectSummonContainer
