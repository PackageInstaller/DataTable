-- chunkname: @modules/logic/summon/helper/SummonPoolPackageHelper.lua

module("modules.logic.summon.helper.SummonPoolPackageHelper", package.seeall)

local SummonPoolPackageHelper = class("SummonPoolPackageHelper")

function SummonPoolPackageHelper.checkSummonPoolCanProp(poolId, order, heroDict)
	if poolId == nil then
		return false
	end

	local config = SummonConfig.instance:getSummonPoolPackageConfig(poolId, order)

	if config == nil then
		return false
	end

	if string.nilorempty(config.showLimit) then
		return false
	end

	local singleConditionList = string.split(config.showLimit, "|")

	if not singleConditionList or next(singleConditionList) == nil then
		logError("弹出条件参数错误, 卡池id: " .. tostring(poolId) .. " order: " .. tostring(order) .. " 参数: " .. tostring(config.showLimit))

		return false
	end

	for _, singleCondition in ipairs(singleConditionList) do
		local subConditionList = string.split(singleCondition, "&")

		if not subConditionList or next(subConditionList) == nil then
			logError("弹出条件参数错误, 卡池id: " .. tostring(poolId) .. " order: " .. tostring(order) .. " 参数: " .. tostring(config.showLimit))

			return false
		end

		local result = true

		for _, subCondition in ipairs(subConditionList) do
			local conditionParamList = string.split(subCondition, ":")
			local type = tostring(conditionParamList[1])
			local conditionParam = string.splitToNumber(conditionParamList[2], "#")

			if not SummonPoolPackageHelper.isConditionTrigger(type, poolId, order, conditionParam, heroDict) then
				result = false

				break
			end
		end

		if result == true then
			return true
		end
	end

	return false
end

function SummonPoolPackageHelper.isConditionTrigger(conditionType, ...)
	local func = SummonPoolPackageHelper["handlerType_" .. conditionType]

	if not func then
		logError("未处理当前条件类型, 类型 = " .. tostring(conditionType))

		return false
	end

	return func(...)
end

function SummonPoolPackageHelper.handlerType_1(poolId, order, paramList, heroDict)
	for _, heroId in ipairs(paramList) do
		if heroDict[heroId] then
			logNormal("抽取某个指定角色 id: " .. tostring(heroId))

			return true
		end
	end

	return false
end

function SummonPoolPackageHelper.handlerType_2(poolId, order, paramList, heroDict)
	for heroId, _ in pairs(heroDict) do
		local config = HeroConfig.instance:getHeroCO(heroId)

		if config and config.rare >= CharacterEnum.MaxRare then
			logNormal("抽取任意6星角色 id: " .. tostring(heroId))

			return true
		end
	end

	return false
end

function SummonPoolPackageHelper.handlerType_3(poolId, order, paramList, heroDict)
	local result = SummonModel.instance:getSummonPoolUpList(poolId)

	if result == nil then
		logError("没有配置对应的UP角色,请检查配置 卡池id: " .. tostring(poolId))

		return false
	end

	local maxStarHeroList = result[CharacterEnum.MaxRare]

	if maxStarHeroList == nil then
		logError("没有配置对应的UP角色,请检查配置 卡池id: " .. tostring(poolId))

		return false
	end

	for _, heroId in ipairs(maxStarHeroList) do
		if heroDict[heroId] then
			logNormal("抽取卡池对应UP id: " .. tostring(heroId))

			return true
		end
	end

	return false
end

return SummonPoolPackageHelper
