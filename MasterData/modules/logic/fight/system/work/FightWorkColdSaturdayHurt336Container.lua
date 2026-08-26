-- chunkname: @modules/logic/fight/system/work/FightWorkColdSaturdayHurt336Container.lua

module("modules.logic.fight.system.work.FightWorkColdSaturdayHurt336Container", package.seeall)

local FightWorkColdSaturdayHurt336Container = class("FightWorkColdSaturdayHurt336Container", FightStepEffectFlow)

function FightWorkColdSaturdayHurt336Container:onStart()
	local parallelType = {
		[FightEnum.EffectType.BUFFADD] = true,
		[FightEnum.EffectType.BUFFDEL] = true,
		[FightEnum.EffectType.BUFFUPDATE] = true,
		[FightEnum.EffectType.NONE] = true,
		[FightEnum.EffectType.DAMAGE] = true,
		[FightEnum.EffectType.CRIT] = true
	}

	self:playAdjacentParallelEffect(parallelType, true)
end

function FightWorkColdSaturdayHurt336Container:clearWork()
	return
end

return FightWorkColdSaturdayHurt336Container
