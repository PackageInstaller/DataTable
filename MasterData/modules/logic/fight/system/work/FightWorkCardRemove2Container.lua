-- chunkname: @modules/logic/fight/system/work/FightWorkCardRemove2Container.lua

module("modules.logic.fight.system.work.FightWorkCardRemove2Container", package.seeall)

local FightWorkCardRemove2Container = class("FightWorkCardRemove2Container", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkCardRemove2Container:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkCardRemove2Container:clearWork()
	return
end

return FightWorkCardRemove2Container
