-- chunkname: @modules/logic/survival/util/SurvivalDescExpressionHelper.lua

module("modules.logic.survival.util.SurvivalDescExpressionHelper", package.seeall)

local SurvivalDescExpressionHelper = class("SurvivalDescExpressionHelper")
local haveCheckVal

local function checkFunc(val)
	haveCheckVal = val

	return ""
end

local function conditionFunc(cond, val1, val2)
	if cond then
		return val1 or ""
	else
		return val2 or ""
	end
end

local funcEnvTb = {
	hasAttrVal = false,
	min = math.min,
	max = math.max,
	floor = math.floor,
	ceil = math.ceil,
	abs = math.abs,
	check = checkFunc,
	condition = conditionFunc
}

setmetatable(funcEnvTb, {
	__index = function(t, k)
		local matchIndex = 0

		k, matchIndex = string.gsub(k, "out_", "")

		local id = SurvivalConfig.instance.attrNameToId[k]

		if not id then
			logError("属性Key不存在" .. tostring(k))

			return 0
		end

		if matchIndex > 0 then
			if not t.attrMapTotal then
				local map = t.attrMap

				if not map[id] then
					local val = 0

					if val then
						funcEnvTb.hasAttrVal = true
					end

					return val
				end
			end
		end
	end
})

function SurvivalDescExpressionHelper:parstDesc(desc, attrMap, attrMapTotal)
	if string.nilorempty(desc) then
		return desc
	end

	haveCheckVal = true
	funcEnvTb.attrMap = attrMap or {}
	funcEnvTb.attrMapTotal = attrMapTotal or {}
	funcEnvTb.hasAttrVal = false
	funcEnvTb.roleattr1 = 0

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo and weekInfo.survivalShelterRoleMo then
		funcEnvTb.roleattr1 = weekInfo.survivalShelterRoleMo:getRoleAttrValue(1)
	end

	local result = string.gsub(desc, "%b{}", SurvivalDescExpressionHelper._passExpressionStr)

	funcEnvTb.attrMap = nil
	funcEnvTb.attrMapTotal = nil

	return result, haveCheckVal
end

function SurvivalDescExpressionHelper._passExpressionStr(experison)
	experison = string.sub(experison, 2, #experison - 1)

	local func = loadstring(string.format("return %s, hasAttrVal", string.lower(experison)))

	if not func then
		logError("解析表达式失败" .. experison)

		return experison
	end

	setfenv(func, funcEnvTb)

	local result, resultString, hasAttrVal = pcall(func)

	if result then
		return resultString
	else
		logError("执行表达式错误" .. experison)

		return experison
	end
end

SurvivalDescExpressionHelper.instance = SurvivalDescExpressionHelper.New()

return SurvivalDescExpressionHelper
