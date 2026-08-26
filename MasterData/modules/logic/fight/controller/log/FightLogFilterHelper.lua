-- chunkname: @modules/logic/fight/controller/log/FightLogFilterHelper.lua

module("modules.logic.fight.controller.log.FightLogFilterHelper", package.seeall)

local FightLogFilterHelper = _M
local effectFilterList = {
	FightEnum.EffectType.FIGHTSTEP
}
local filtering = false

function FightLogFilterHelper.setFilterEffectList(effectStr)
	if string.nilorempty(effectStr) then
		filtering = false

		return
	end

	FightLogFilterHelper.resetEffectFilter()
	tabletool.addValues(effectFilterList, string.splitToNumber(effectStr, ";"))

	filtering = true
end

function FightLogFilterHelper.resetEffectFilter()
	tabletool.clear(effectFilterList)
	table.insert(effectFilterList, FightEnum.EffectType.FIGHTSTEP)
end

function FightLogFilterHelper.checkActEffectDataIsFilter(actEffectData)
	if not filtering then
		return false
	end

	if tabletool.indexOf(effectFilterList, actEffectData.effectType) then
		return false
	end

	return true
end

return FightLogFilterHelper
