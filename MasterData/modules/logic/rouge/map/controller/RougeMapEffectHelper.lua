-- chunkname: @modules/logic/rouge/map/controller/RougeMapEffectHelper.lua

module("modules.logic.rouge.map.controller.RougeMapEffectHelper", package.seeall)

local RougeMapEffectHelper = class("RougeMapEffectHelper")

function RougeMapEffectHelper.checkHadEffect(type, param)
	local effectDict = RougeModel.instance:getEffectDict()

	if not effectDict then
		return false
	end

	RougeMapEffectHelper._initEffectHandle()

	local handle = RougeMapEffectHelper.effectHandleDict[type]

	if not handle then
		return false
	end

	for _, effectCo in pairs(effectDict) do
		if effectCo.type == type and handle(effectCo, param) then
			return true
		end
	end

	return false
end

function RougeMapEffectHelper._initEffectHandle()
	RougeMapEffectHelper.effectHandleDict = RougeMapEffectHelper.effectHandleDict or {
		[RougeMapEnum.EffectType.UnlockRestRefresh] = RougeMapEffectHelper.defaultCheck,
		[RougeMapEnum.EffectType.UnlockFightDropRefresh] = RougeMapEffectHelper._checkUnlockFightDropRefresh,
		[RougeMapEnum.EffectType.UnlockShowPassFightMask] = RougeMapEffectHelper._checkUnlockShowPassFightMask
	}
end

function RougeMapEffectHelper.defaultCheck(effectCo)
	return true
end

function RougeMapEffectHelper._checkUnlockFightDropRefresh(effectCo, fightType)
	local paramList = string.splitToNumber(effectCo.typeParam, "#")

	return paramList[1] == fightType
end

function RougeMapEffectHelper._checkUnlockShowPassFightMask(effectCo, fightType)
	return tonumber(effectCo.typeParam) == fightType
end

return RougeMapEffectHelper
