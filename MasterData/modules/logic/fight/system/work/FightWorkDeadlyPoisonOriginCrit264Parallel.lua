-- chunkname: @modules/logic/fight/system/work/FightWorkDeadlyPoisonOriginCrit264Parallel.lua

module("modules.logic.fight.system.work.FightWorkDeadlyPoisonOriginCrit264Parallel", package.seeall)

local FightWorkDeadlyPoisonOriginCrit264Parallel = class("FightWorkDeadlyPoisonOriginCrit264Parallel", FightWorkDeadlyPoisonOriginDamage263Parallel)

function FightWorkDeadlyPoisonOriginCrit264Parallel:getEffectType()
	return FightEnum.EffectType.DEADLYPOISONORIGINCRIT
end

function FightWorkDeadlyPoisonOriginCrit264Parallel:getFloatType()
	return FightEnum.FloatType.crit_damage_origin
end

return FightWorkDeadlyPoisonOriginCrit264Parallel
