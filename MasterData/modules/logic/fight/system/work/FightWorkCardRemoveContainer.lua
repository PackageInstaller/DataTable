-- chunkname: @modules/logic/fight/system/work/FightWorkCardRemoveContainer.lua

module("modules.logic.fight.system.work.FightWorkCardRemoveContainer", package.seeall)

local FightWorkCardRemoveContainer = class("FightWorkCardRemoveContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkCardRemoveContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkCardRemoveContainer:clearWork()
	return
end

return FightWorkCardRemoveContainer
