-- chunkname: @modules/logic/fight/system/work/FightWorkInjuryBankHealContainer.lua

module("modules.logic.fight.system.work.FightWorkInjuryBankHealContainer", package.seeall)

local FightWorkInjuryBankHealContainer = class("FightWorkInjuryBankHealContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.FIGHTSTEP] = true
}

function FightWorkInjuryBankHealContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkInjuryBankHealContainer:clearWork()
	return
end

return FightWorkInjuryBankHealContainer
