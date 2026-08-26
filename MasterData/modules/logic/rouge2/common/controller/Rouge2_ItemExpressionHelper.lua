-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ItemExpressionHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ItemExpressionHelper", package.seeall)

local Rouge2_ItemExpressionHelper = class("Rouge2_ItemExpressionHelper")
local attrMuchZeroInfoColor = "#CCFF99"
local DefaultMetaTable = {
	__index = function(tab, key)
		if tab.useParamsValue then
			tab.hasAttrMuchZero = false

			return (tab.params or nil) and (tab.params[key] or 0)
		end

		local attrValue = Rouge2_ItemExpressionHelper.getAttrValue(key, tab.params)

		if attrValue > 0 then
			tab.hasAttrMuchZero = true
		end

		return attrValue
	end
}
local DefaultEnv = {
	hasAttrMuchZero = false,
	useParamsValue = false,
	min = math.min,
	max = math.max,
	attrMap = {}
}

setmetatable(DefaultEnv, DefaultMetaTable)

function Rouge2_ItemExpressionHelper.getDescResult(mo, config, desc, useParamsValue)
	return Rouge2_ItemExpressionHelper._getDescExpressionResult(desc, mo, useParamsValue)
end

function Rouge2_ItemExpressionHelper._getDescExpressionResult(desc, params, useParamsValue)
	if string.nilorempty(desc) then
		return desc
	end

	return (string.gsub(desc, "%b{}", function(experison)
		return Rouge2_ItemExpressionHelper._loadAndExecuteExpressionFunc(experison, params, useParamsValue)
	end))
end

function Rouge2_ItemExpressionHelper._loadAndExecuteExpressionFunc(experison, params, useParamsValue)
	experison = string.gsub(experison, "{", "")
	experison = string.gsub(experison, "}", "")

	local expersionExcuteFunc = Rouge2_ItemExpressionHelper._loadExpressionFunc(experison)
	local env = Rouge2_ItemExpressionHelper._buildGsubExperisonEnv(params, useParamsValue)

	setfenv(expersionExcuteFunc, env)

	local result, hasAttrMuchZero = expersionExcuteFunc()

	if hasAttrMuchZero then
		result = string.format("<%s>%s</color>", attrMuchZeroInfoColor, result)
	end

	return result
end

function Rouge2_ItemExpressionHelper._loadExpressionFunc(experison)
	local str = string.format("return %s, hasAttrMuchZero", string.lower(experison))
	local expersionExcuteFunc = loadstring(str)

	if not expersionExcuteFunc then
		logError("肉鸽造物描述表达式解析失败: 文本内容:" .. tostring(experison))

		return experison
	end

	return expersionExcuteFunc
end

function Rouge2_ItemExpressionHelper._buildGsubExperisonEnv(params, useParamsValue)
	local env = DefaultEnv

	env.hasAttrMuchZero = false
	env.attrMap = {}
	env.params = params or {}
	env.useParamsValue = useParamsValue and useParamsValue or false

	return env
end

function Rouge2_ItemExpressionHelper.getAttrValue(flagName, params)
	local flagCo = Rouge2_CollectionConfig.instance:getAttrFlagConfigByName(flagName)

	if not flagCo then
		logError(string.format("尝试解析造物描述失败!!! 失败原因: 无法匹配属性关键字:%s", flagName))

		return 0
	end

	local type = flagCo.type
	local func = Rouge2_ItemExpressionHelper._getAttrValueFunc(type)

	return (func or nil) and func(flagCo, params) or 0
end

function Rouge2_ItemExpressionHelper._getAttrValueFunc(flagType)
	if not Rouge2_ItemExpressionHelper._getAttrValueFuncMap then
		Rouge2_ItemExpressionHelper._getAttrValueFuncMap = {}
		Rouge2_ItemExpressionHelper._getAttrValueFuncMap[Rouge2_Enum.ItemExpressionData.ItemAttr] = Rouge2_ItemExpressionHelper._getAttrValue_ItemAttr
		Rouge2_ItemExpressionHelper._getAttrValueFuncMap[Rouge2_Enum.ItemExpressionData.LeaderAttr] = Rouge2_ItemExpressionHelper._getAttrValue_LeaderAttr
		Rouge2_ItemExpressionHelper._getAttrValueFuncMap[Rouge2_Enum.ItemExpressionData.LeaderAttrSum] = Rouge2_ItemExpressionHelper._getAttrValue_LeaderAttrSum
	end

	local func = Rouge2_ItemExpressionHelper._getAttrValueFuncMap[flagType]

	if not func then
		logError(string.format("肉鸽属性解析表达式缺少对应方法, flagType = %s", flagType))
	end

	return func
end

function Rouge2_ItemExpressionHelper._getAttrValue_ItemAttr(flagCo, params)
	local attrId = flagCo.id
	local itemMo = params

	return (itemMo and itemMo.getAttrValue or nil) and itemMo:getAttrValue(attrId) or 0
end

function Rouge2_ItemExpressionHelper._getAttrValue_LeaderAttr(flagCo, params)
	local attrId = flagCo.id
	local leaderAttrValue = Rouge2_Model.instance:getAttrValue(attrId)

	return leaderAttrValue or 0
end

function Rouge2_ItemExpressionHelper._getAttrValue_LeaderAttrSum(flagCo, params)
	local careerId = Rouge2_Model.instance:getCareerId()
	local recommendAttrSum = 0

	if careerId and careerId ~= 0 then
		local recommendAttrList = Rouge2_CareerConfig.instance:getCareerRecommendAttrList(careerId)

		if recommendAttrList then
			for _, attrId in ipairs(recommendAttrList) do
				local attrValue = Rouge2_Model.instance:getAttrValue(attrId)

				recommendAttrSum = recommendAttrSum + attrValue
			end
		end
	end

	return recommendAttrSum
end

return Rouge2_ItemExpressionHelper
