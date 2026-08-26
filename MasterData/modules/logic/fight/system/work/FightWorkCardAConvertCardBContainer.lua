-- chunkname: @modules/logic/fight/system/work/FightWorkCardAConvertCardBContainer.lua

module("modules.logic.fight.system.work.FightWorkCardAConvertCardBContainer", package.seeall)

local FightWorkCardAConvertCardBContainer = class("FightWorkCardAConvertCardBContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true,
	[FightEnum.EffectType.CHANGEHERO] = true
}

function FightWorkCardAConvertCardBContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkCardAConvertCardBContainer:clearWork()
	return
end

return FightWorkCardAConvertCardBContainer
