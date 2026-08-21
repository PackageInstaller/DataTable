-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/immunebuff/ImmuneBuffHandlerUtil.lua

module("logic.battle.unit.comp.property.immunebuff.ImmuneBuffHandlerUtil", package.seeall)

local ImmuneBuffHandlerUtil = {}
local kHandlerTable = {
	[BattleEnum.State.STEPPABLE_AGAIN] = BattleStateHandler_SteppableAgain,
	[BattleEnum.State.SNIPING] = BattleStateHandler_Sniping
}

function ImmuneBuffHandlerUtil.handleSpecialImmuneUpdate(unit, buffCode, isAdd)
	local buffCO = BuffConfig.instance:getBuffCO(buffCode)

	if BuffCOUtil.isDizzyOrSleep(buffCO) then
		ImmuneBuffHandlerUtil._onDizzyOrSleepUpdate(unit, buffCode, isAdd)
	end
end

function ImmuneBuffHandlerUtil._onDizzyOrSleepUpdate(unit, buffCode, isAdd)
	printError("_onDizzyOrSleepUpdate")

	if isAdd and unit.property:isStateActive(BattleEnum.State.DIZZY_OR_SLEEP) then
		local hasEffect = ImmuneBuffHandlerUtil._containDizzyOrSleep(unit)

		if not hasEffect then
			unit.property:inactiveState(BattleEnum.State.DIZZY_OR_SLEEP)
			unit.stateEffect:refreshStateEffect()
		end
	end

	if not isAdd and not unit.property:isStateActive(BattleEnum.State.DIZZY_OR_SLEEP) then
		local hasEffect = ImmuneBuffHandlerUtil._containDizzyOrSleep(unit)

		if hasEffect then
			unit.property:activeState(BattleEnum.State.DIZZY_OR_SLEEP)
			unit.stateEffect:refreshStateEffect()
		end
	end
end

function ImmuneBuffHandlerUtil._containDizzyOrSleep(unit)
	local allBuff = unit.buff:getAllBuff()

	for _, buffMO in pairs(allBuff) do
		if not unit.property:isImmuneBuff(buffMO:getBuffCode()) and BuffCOUtil.isDizzyOrSleep(buffMO:getBuffCO()) then
			return true
		end
	end
end

return ImmuneBuffHandlerUtil
