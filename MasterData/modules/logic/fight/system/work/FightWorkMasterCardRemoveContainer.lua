-- chunkname: @modules/logic/fight/system/work/FightWorkMasterCardRemoveContainer.lua

module("modules.logic.fight.system.work.FightWorkMasterCardRemoveContainer", package.seeall)

local FightWorkMasterCardRemoveContainer = class("FightWorkMasterCardRemoveContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkMasterCardRemoveContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkMasterCardRemoveContainer:clearWork()
	return
end

return FightWorkMasterCardRemoveContainer
