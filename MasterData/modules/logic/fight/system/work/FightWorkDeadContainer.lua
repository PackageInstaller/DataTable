-- chunkname: @modules/logic/fight/system/work/FightWorkDeadContainer.lua

module("modules.logic.fight.system.work.FightWorkDeadContainer", package.seeall)

local FightWorkDeadContainer = class("FightWorkDeadContainer", FightStepEffectFlow)
local parallelEffectType = {
	[FightEnum.EffectType.DEAD] = true,
	[FightEnum.EffectType.KILL] = true,
	[FightEnum.EffectType.REMOVEENTITYCARDS] = true
}

function FightWorkDeadContainer:onStart()
	self:playAdjacentParallelEffect(parallelEffectType, true)
end

function FightWorkDeadContainer:clearWork()
	return
end

return FightWorkDeadContainer
