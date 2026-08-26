-- chunkname: @modules/logic/fight/system/work/FightWorkDeadlyPoisonCritContainer.lua

module("modules.logic.fight.system.work.FightWorkDeadlyPoisonCritContainer", package.seeall)

local FightWorkDeadlyPoisonCritContainer = class("FightWorkDeadlyPoisonCritContainer", FightWorkDeadlyPoisonContainer)

function FightWorkDeadlyPoisonCritContainer:getEffectType()
	return FightEnum.EffectType.DEADLYPOISONORIGINCRIT
end

function FightWorkDeadlyPoisonCritContainer:getFloatType()
	return FightEnum.FloatType.crit_damage_origin
end

return FightWorkDeadlyPoisonCritContainer
