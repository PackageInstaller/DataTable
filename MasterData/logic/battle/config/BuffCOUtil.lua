-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/BuffCOUtil.lua

module("logic.battle.config.BuffCOUtil", package.seeall)

local BuffCOUtil = {}
local kBuffTipsBgName = {}

kBuffTipsBgName[1] = "tips_buff_di1"
kBuffTipsBgName[2] = "tips_buff_di2"

local kBuffTipsIconName = {}

kBuffTipsIconName[1] = "tips_buff_01"
kBuffTipsIconName[2] = "tips_buff_02"

local kBuffIconBgName = {}

kBuffIconBgName[1] = "buff_di_red"
kBuffIconBgName[2] = "buff_di_blue"

local kDizzyOrSleep = {
	"Sleep",
	"DizzyOrSleep"
}
local kLinkBuff = "DamageLink"

function BuffCOUtil.buffSort(aBuffCode, bBuffCode)
	local aBuffCO = BuffConfig.instance:getBuffCO(aBuffCode)
	local bBuffCO = BuffConfig.instance:getBuffCO(bBuffCode)

	if aBuffCO.isGood == bBuffCO.isGood then
		return aBuffCode < bBuffCode
	end

	return aBuffCO.isGood > bBuffCO.isGood
end

function BuffCOUtil.isGood(buffCO)
	return buffCO.isGood == 1
end

function BuffCOUtil.isDizzyOrSleep(buffCO)
	local buffEffectCO = BuffConfig.instance:getBuffEffectCO(buffCO.buffType)

	for _, key in ipairs(kDizzyOrSleep) do
		if buffEffectCO.programming == key then
			return true
		end
	end

	return false
end

function BuffCOUtil.isLink(buffCO)
	local buffEffectCO = BuffConfig.instance:getBuffEffectCO(buffCO.buffType)

	return buffEffectCO.programming == kLinkBuff
end

function BuffCOUtil.getBuffIconBgOfTips(buffCO)
	return BuffCOUtil.isGood(buffCO) and kBuffIconBgName[2] or kBuffIconBgName[1]
end

function BuffCOUtil.getBuffBgOfTips(buffCO)
	return BuffCOUtil.isGood(buffCO) and kBuffTipsBgName[2] or kBuffTipsBgName[1]
end

function BuffCOUtil.getBuffIconOfTips(buffCO)
	return BuffCOUtil.isGood(buffCO) and kBuffTipsIconName[2] or kBuffTipsIconName[1]
end

function BuffCOUtil.getBuffLayerRangeProgramming(buffCO)
	local layerRangeStr = string.split(buffCO.buffAttribute, ",")
	local layerRangeArr = string.split(layerRangeStr[1], "|")
	local minAttributeCO = AttributeDefineConfig.instance:getAttributeCO(checkint(layerRangeArr[1]))
	local maxAttributeCO = AttributeDefineConfig.instance:getAttributeCO(checkint(layerRangeArr[2]))

	return minAttributeCO.programming, maxAttributeCO.programming
end

function BuffCOUtil.sortBuffCodes(buffCodes)
	table.sort(buffCodes, BuffCOUtil.buffSort)
end

function BuffCOUtil.isLayerBuff(buffEffectCO)
	return buffEffectCO.composition == 3
end

return BuffCOUtil
