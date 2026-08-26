-- chunkname: @modules/logic/fight/system/work/FightWorkMasterAddHandCardContainer.lua

module("modules.logic.fight.system.work.FightWorkMasterAddHandCardContainer", package.seeall)

local FightWorkMasterAddHandCardContainer = class("FightWorkMasterAddHandCardContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function FightWorkMasterAddHandCardContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkMasterAddHandCardContainer:clearWork()
	return
end

return FightWorkMasterAddHandCardContainer
