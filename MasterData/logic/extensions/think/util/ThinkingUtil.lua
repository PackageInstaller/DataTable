-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/think/util/ThinkingUtil.lua

module("logic.extensions.think.util.ThinkingUtil", package.seeall)

local ThinkingUtil = {}

ThinkingUtil.AttributeSortOrder = {
	5003,
	5103,
	5303,
	5203,
	5403,
	5
}

function ThinkingUtil.findCostItems(costList, isCurrency)
	local ret = {}

	for _, item in ipairs(costList) do
		local itemCfg = BackpackConfig.instance:getItemInfoByItemId(item.id)

		if isCurrency then
			if itemCfg.type == GameEnum.ItemTypeEnum.CurrencyItemType then
				table.insert(ret, item)
			end
		elseif itemCfg.type ~= GameEnum.ItemTypeEnum.CurrencyItemType then
			table.insert(ret, item)
		end
	end

	return ret
end

function ThinkingUtil.sortAttributeFunc(attA, attB)
	local indexA = table.indexof(ThinkingUtil.AttributeSortOrder, attA.key) or 0
	local indexB = table.indexof(ThinkingUtil.AttributeSortOrder, attB.key) or 0

	if indexA ~= indexB then
		return indexA < indexB
	end

	if attA.key ~= attB.key then
		return attA.key < attB.key
	end

	return false
end

return ThinkingUtil
