-- chunkname: @modules/logic/partycloth/config/PartyClothConfig.lua

module("modules.logic.partycloth.config.PartyClothConfig", package.seeall)

local PartyClothConfig = class("PartyClothConfig", BaseConfig)

function PartyClothConfig:reqConfigNames()
	return {
		"party_cloth_suit",
		"partygame_cloth_part",
		"party_cloth_summon",
		"party_cloth_summon_pool",
		"party_cloth_summon_prize",
		"party_const"
	}
end

function PartyClothConfig:onInit()
	return
end

function PartyClothConfig:onConfigLoaded(configName, configTable)
	if configName == "partygame_cloth_part" then
		self._defaultSuitSkinIds = {}

		for i, v in ipairs(lua_partygame_cloth_part.configList) do
			if v.suitId == PartyClothEnum.DefaultSuitId then
				table.insert(self._defaultSuitSkinIds, v.clothId)
			end
		end
	end
end

function PartyClothConfig:getDefaultSuitSkinIds()
	return self._defaultSuitSkinIds
end

function PartyClothConfig:getSuitConfig(suitId)
	local config = lua_party_cloth_suit.configDict[suitId]

	if config then
		return config
	else
		logError(string.format("联机玩法外围_套装表不存在套装suitId为：%s 的配置", suitId))
	end
end

function PartyClothConfig:getClothConfig(clothId)
	local config = lua_partygame_cloth_part.configDict[clothId]

	if config then
		return config
	else
		logError(string.format("联机玩法外围_服装小件表不存在套装clothId为：%s 的配置", clothId))
	end
end

function PartyClothConfig:getRewardData(groupId, index)
	local prizeConfig = lua_party_cloth_summon_prize.configDict[groupId]

	if prizeConfig then
		local rewards = string.split(prizeConfig.prizeParams, "|")
		local rewardStr = rewards[index + 1]

		if rewardStr then
			local params = string.split(rewardStr, ",")

			return string.splitToNumber(params[1], "#")
		else
			logError(string.format("联机玩法外围_服装抽奖池奖品不存在groupId为：%s 索引为： %s 的配置", groupId, index + 1))
		end
	else
		logError(string.format("联机玩法外围_服装抽奖池奖品不存在groupId为：%s 的配置", groupId))
	end
end

function PartyClothConfig:getClothCfgsBySuit(suitId)
	local clothCfgs = {}

	for _, config in ipairs(lua_partygame_cloth_part.configList) do
		if config.suitId == suitId then
			clothCfgs[#clothCfgs + 1] = config
		end
	end

	return clothCfgs
end

function PartyClothConfig:getInitClothIdMap()
	local clothIdMap = {}
	local suitId = tonumber(lua_party_const.configDict[1].value)
	local clothCfgs = self:getClothCfgsBySuit(suitId)

	for _, config in ipairs(clothCfgs) do
		clothIdMap[config.partId] = config.clothId
	end

	return clothIdMap
end

function PartyClothConfig:_setSkinResMap(skinResMap, clothId)
	local config = self:getClothConfig(clothId)

	if not config then
		return
	end

	local clothType = config.partId

	if clothType == PartyClothEnum.ClothType.Head then
		local params = string.split(config.partRes, "#")

		if #params == 2 then
			skinResMap[clothType] = params[1]
			skinResMap[PartyClothEnum.ClothType.Body] = params[2]
		else
			logError(string.format("联机玩法外围_服装小件表clothId：%s 的partRes配置错误", clothId))
		end
	else
		skinResMap[clothType] = config.partRes
	end
end

function PartyClothConfig:getSkinRes(clothIdMap)
	local skinResMap = {}

	for _, clothId in pairs(clothIdMap) do
		self:_setSkinResMap(skinResMap, clothId)
	end

	if not skinResMap[PartyClothEnum.ClothType.Head] then
		self:_setSkinResMap(skinResMap, PartyClothEnum.DefaultSkinPartId)
	end

	return skinResMap
end

function PartyClothConfig:getSummonCost(poolId)
	local summonCfg = lua_party_cloth_summon.configDict[poolId]

	if summonCfg then
		return (string.splitToNumber(summonCfg.cost, "#"))
	else
		logError(string.format("联机玩法外围_服装抽奖表不存在奖池ID为：%s 的配置", poolId))
	end
end

PartyClothConfig.instance = PartyClothConfig.New()

return PartyClothConfig
