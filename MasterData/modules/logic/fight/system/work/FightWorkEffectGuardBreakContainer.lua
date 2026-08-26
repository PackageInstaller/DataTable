-- chunkname: @modules/logic/fight/system/work/FightWorkEffectGuardBreakContainer.lua

module("modules.logic.fight.system.work.FightWorkEffectGuardBreakContainer", package.seeall)

local FightWorkEffectGuardBreakContainer = class("FightWorkEffectGuardBreakContainer", FightStepEffectFlow)

function FightWorkEffectGuardBreakContainer:onStart()
	local parallelEffectType = {
		[FightEnum.EffectType.GUARDBREAK] = true
	}

	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkEffectGuardBreakContainer:clearWork()
	return
end

return FightWorkEffectGuardBreakContainer
