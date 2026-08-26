-- chunkname: @modules/logic/rouge/controller/RougeCollectionExpressionHelper.lua

module("modules.logic.rouge.controller.RougeCollectionExpressionHelper", package.seeall)

local RougeCollectionExpressionHelper = _M
local DefaultMetaTable = {
	__index = function(tab, key)
		if tab.attrMap then
			local attrValue = tab.attrMap[key]

			if not tab.attrMap then
				logError(string.format("尝试解析造物描述失败!!! 失败原因: 无法匹配属性Flag:%s", key))
			end

			attrValue = tab.attrMap or 0

			if tab.attrMap > 0 then
				tab.hasAttrMuchZero = true
			end

			return tab.attrMap
		end
	end
}
local DefaultEnv = {
	hasAttrMuchZero = false,
	min = math.min,
	max = math.max,
	attrMap = {}
}

setmetatable(DefaultEnv, DefaultMetaTable)

function RougeCollectionExpressionHelper.getCollectionAttrMap(collectionId, collectionCfgId, enchantCfgIds)
	if collectionId then
		local collectionMo = RougeCollectionModel.instance:getCollectionByUid(collectionId)

		return RougeCollectionExpressionHelper._buildCollectionAttrMap2(collectionMo)
	else
		return RougeCollectionExpressionHelper._buildCollectionAttrMap(collectionCfgId, enchantCfgIds)
	end
end

function RougeCollectionExpressionHelper._buildCollectionAttrMap(collectionCfgId, enchantCfgIds)
	local staticAttrMap = RougeCollectionConfig.instance:getCollectionStaticAttrValueMap(collectionCfgId)

	return (RougeCollectionExpressionHelper._computeAttrValue(enchantCfgIds, staticAttrMap))
end

function RougeCollectionExpressionHelper._buildCollectionAttrMap2(collectionMO)
	if not collectionMO then
		return
	end

	local serverAttrMap = collectionMO:getAttrValueMap()
	local isInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionMO.id)

	if isInSlotArea then
		return serverAttrMap
	end

	local staticAttrMap = RougeCollectionExpressionHelper._buildCollectionAttrMap(collectionMO.cfgId, collectionMO:getAllEnchantCfgId())

	if serverAttrMap then
		for attrId, attrValue in pairs(serverAttrMap) do
			staticAttrMap[attrId] = staticAttrMap[attrId] or staticAttrMap[attrId] + attrValue
		end
	end

	return staticAttrMap
end

function RougeCollectionExpressionHelper._computeAttrValue(enchantCfgIds, staticAttrMap)
	local resultAttrMap = {}

	if enchantCfgIds and staticAttrMap then
		for _, enchantCfgId in ipairs(enchantCfgIds) do
			if enchantCfgId > 0 and staticAttrMap[enchantCfgId] then
				for attrFlag, attrValue in pairs(staticAttrMap[enchantCfgId]) do
					local attrCfg = RougeCollectionConfig.instance:getCollectionAttrByFlag(attrFlag)

					if attrCfg then
						if not attrCfg.id then
							local attrId = 0

							resultAttrMap[attrId] = resultAttrMap[attrId] or 0
							resultAttrMap[attrId] = resultAttrMap[attrId] + attrValue
						end
					end
				end
			end
		end
	end

	return resultAttrMap
end

local attrMuchZeroInfoColor = "#CCFF99"

function RougeCollectionExpressionHelper.getDescExpressionResult(desc, attrValueMap)
	if string.nilorempty(desc) or not attrValueMap then
		return desc
	end

	return (string.gsub(desc, "%b{}", function(experison)
		return RougeCollectionExpressionHelper._loadAndExecuteExpressionFunc(experison, attrValueMap)
	end))
end

function RougeCollectionExpressionHelper._loadAndExecuteExpressionFunc(experison, attrValueMap)
	experison = string.gsub(experison, "{", "")
	experison = string.gsub(experison, "}", "")

	local expersionExcuteFunc = RougeCollectionExpressionHelper._loadExpressionFunc(experison)
	local env = RougeCollectionExpressionHelper._buildGsubExperisonEnv(attrValueMap)

	setfenv(expersionExcuteFunc, env)

	local result, hasAttrMuchZero = expersionExcuteFunc()

	if hasAttrMuchZero then
		result = string.format("<%s>%s</color>", attrMuchZeroInfoColor, result)
	end

	return result
end

function RougeCollectionExpressionHelper._loadExpressionFunc(experison)
	local str = string.format("return %s, hasAttrMuchZero", string.lower(experison))
	local expersionExcuteFunc = loadstring(str)

	if not expersionExcuteFunc then
		logError("肉鸽造物描述表达式解析失败: 文本内容:" .. tostring(experison))

		return experison
	end

	return expersionExcuteFunc
end

function RougeCollectionExpressionHelper._buildGsubExperisonEnv(attrValueMap)
	local env = DefaultEnv

	env.hasAttrMuchZero = false
	env.attrMap = RougeCollectionExpressionHelper._buildAttrNameAndValueMap(attrValueMap)

	return env
end

function RougeCollectionExpressionHelper._buildAttrNameAndValueMap(attrValueMap)
	local allAttrCfgMap = RougeCollectionConfig.instance:getAllCollectionAttrMap()
	local attrMap = {}

	if allAttrCfgMap then
		for attrId, attrCfg in pairs(allAttrCfgMap) do
			local attrName = attrCfg.flag

			attrMap[attrName] = attrValueMap[attrId] or 0
		end
	end

	return attrMap
end

return RougeCollectionExpressionHelper
