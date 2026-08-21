-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleUnitDieUtil.lua

module("logic.battle.util.BattleUnitDieUtil", package.seeall)

local BattleUnitDieUtil = {}

function BattleUnitDieUtil.handleDie(unit, deadType, isSanityDeadth)
	if unit.property:isStateActive(BattleEnum.State.SANITY_BROKEN) then
		isSanityDeadth = true
	end

	if unit.specialHandler then
		unit.specialHandler:handleDie(deadType, isSanityDeadth)
	else
		unit.dieHandler:handleDie(deadType, isSanityDeadth)
	end
end

function BattleUnitDieUtil.playDeathAnimation(unit, playAudio)
	if playAudio then
		BattleUnitUtil.play3dAudio(unit, unit.property:getDeathAudio())
	end

	unit.meshModelMover:playMappedAnimation(UnitAnimState.Death, false, true)
end

return BattleUnitDieUtil
