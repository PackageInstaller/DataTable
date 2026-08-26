-- chunkname: @modules/logic/summon/config/SummonConfig.lua

module("modules.logic.summon.config.SummonConfig", package.seeall)

local SummonConfig = class("SummonConfig", BaseConfig)

function SummonConfig:reqConfigNames()
	return {
		"summon_pool",
		"summon",
		"summon_character",
		"summon_pool_detail",
		"summon_equip_detail",
		"lucky_bag_heroes",
		"summon_pool_package",
		"summon_pool_limit_replicate",
		"summon_pool_infallible",
		"summon_progress_choose"
	}
end

function SummonConfig:onInit()
	self._itemId2CountDict = nil
end

function SummonConfig:onConfigLoaded(configName, configTable)
	if configName == "summon_equip_detail" then
		self:_initEquipDetails()
	end
end

function SummonConfig:_initEquipDetails()
	self._equipPoolDict = {}
	self._summonPoolPackageListDic = {}

	local list = lua_summon_equip_detail.configList

	for i, v in ipairs(list) do
		self._equipPoolDict[v.poolId] = self._equipPoolDict[v.poolId] or {}
		self._equipPoolDict[v.poolId][v.location] = v
	end
end

function SummonConfig:getSummonPoolList()
	return lua_summon_pool.configList
end

function SummonConfig:getSummon(poolId)
	return lua_summon.configDict[poolId]
end

function SummonConfig:getCharacterDetailConfig(characterDetailId)
	return lua_summon_character.configDict[characterDetailId]
end

function SummonConfig:getPoolDetailConfig(poolDetailId)
	return lua_summon_pool_detail.configDict[poolDetailId]
end

function SummonConfig:getPoolDetailConfigList()
	return lua_summon_pool_detail.configList
end

function SummonConfig:getEquipDetailByPoolId(poolId)
	return self._equipPoolDict[poolId]
end

function SummonConfig:getSummonPool(id)
	return lua_summon_pool.configDict[id]
end

function SummonConfig:getSummonLuckyBag(poolId)
	self._pool2luckyBagMap = self._pool2luckyBagMap or {}

	local result = self._pool2luckyBagMap[poolId]

	if not result then
		result = result or {}

		local poolRareDict = SummonConfig.instance:getSummon(poolId)

		if poolRareDict then
			for rare, summonCfg in pairs(poolRareDict) do
				if not string.nilorempty(summonCfg.luckyBagId) then
					tabletool.addValues(result, string.splitToNumber(summonCfg.luckyBagId, "#"))
				end
			end
		end

		self._pool2luckyBagMap[poolId] = result
	end

	return result
end

function SummonConfig:getLuckyBag(poolId, luckyBagId)
	if lua_lucky_bag_heroes.configDict[poolId] then
		return lua_lucky_bag_heroes.configDict[poolId][luckyBagId]
	end
end

function SummonConfig:getLuckyBagHeroIds(poolId, luckyBagId)
	if VersionValidator.instance:isInReviewing() then
		if #lua_app_include.configList > 0 then
			return lua_app_include.configList[1].character
		else
			return {}
		end
	end

	self._luckyBagHerosMap = self._luckyBagHerosMap or {}
	self._luckyBagHerosMap[poolId] = self._luckyBagHerosMap[poolId] or {}

	local result = self._luckyBagHerosMap[poolId][luckyBagId]

	if not result then
		local co = self:getLuckyBag(poolId, luckyBagId)

		if co then
			result = string.splitToNumber(co.heroChoices, "#")
		else
			logError("summon luckyBag config not found, id = " .. tostring(luckyBagId))

			result = {}
		end

		self._luckyBagHerosMap[poolId][luckyBagId] = result
	end

	return result
end

function SummonConfig:getValidPoolList()
	local list = self:getSummonPoolList()
	local result = {}

	for i, v in ipairs(list) do
		if not string.nilorempty(v.customClz) and not string.nilorempty(v.prefabPath) then
			table.insert(result, v)
		end
	end

	table.sort(result, function(a, b)
		if a.priority == b.priority then
			return a.id < b.id
		end

		return a.priority > b.priority
	end)

	return result
end

function SummonConfig.getSummonSSRTimes(co)
	if co then
		SummonConfig.instance.ssrTimesMap = SummonConfig.instance.ssrTimesMap or {}

		local times = SummonConfig.instance.ssrTimesMap[co.id]

		if not times then
			local strArr = string.split(co.awardTime, "|")

			if #strArr >= 2 then
				times = tonumber(strArr[2])
				SummonConfig.instance.ssrTimesMap[co.id] = times
			end
		end

		return times
	end

	return nil
end

local tempReward = {}

function SummonConfig:getRewardItems(heroId, duplicateCount, showNewHero)
	local rewardItems = {}

	tabletool.clear(tempReward)

	local heroConfig = HeroConfig.instance:getHeroCO(heroId)

	if duplicateCount <= 0 then
		table.insert(tempReward, heroConfig.firstItem)

		if showNewHero then
			local heroReward = {}

			heroReward.type = MaterialEnum.MaterialType.Hero
			heroReward.id = heroId
			heroReward.quantity = 1

			table.insert(rewardItems, heroReward)
		end
	elseif duplicateCount < CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount) - 1 then
		table.insert(tempReward, heroConfig.duplicateItem)
		table.insert(tempReward, heroConfig.duplicateItemSpecial)
	else
		table.insert(tempReward, heroConfig.duplicateItem2)
	end

	for i = 1, #tempReward do
		local reward = tempReward[i]

		if not string.nilorempty(reward) then
			local items = string.split(reward, "|")

			for _, item in ipairs(items) do
				local rewardItem = {}
				local itemParams = string.split(item, "#")

				rewardItem.type = tonumber(itemParams[1])
				rewardItem.id = tonumber(itemParams[2])
				rewardItem.quantity = tonumber(itemParams[3])

				table.insert(rewardItems, rewardItem)
			end
		end
	end

	return rewardItems
end

function SummonConfig:canShowSingleFree(summonPoolId)
	local co = self:getSummonPool(summonPoolId)

	return co ~= nil and co.totalFreeCount ~= nil and co.totalFreeCount > 0
end

function SummonConfig:isLuckyBagPoolExist()
	local list = self:getSummonPoolList()

	for poolId, poolCo in pairs(list) do
		if poolCo.type == SummonEnum.Type.LuckyBag then
			return true
		end
	end

	return false
end

function SummonConfig.poolIsLuckyBag(poolId)
	local co = SummonConfig.instance:getSummonPool(poolId)

	if co then
		return SummonConfig.poolTypeIsLuckyBag(co.type)
	end

	return false
end

function SummonConfig.poolIsInfallible(poolId)
	local co = SummonConfig.instance:getSummonPool(poolId)

	if co then
		return co.infallibleItemId ~= nil and co.infallibleItemId ~= 0 and co.infallibleItemMaxUseCount > 0
	end

	return false
end

function SummonConfig.poolTypeIsLuckyBag(poolType)
	return poolType == SummonEnum.Type.LuckyBag
end

function SummonConfig:getSummonDetailIdByHeroId(heroId)
	for _, config in ipairs(lua_summon_character.configList) do
		if config.heroId == heroId then
			return config.id
		end
	end
end

function SummonConfig:isStrongCustomChoice(poolId)
	local co = SummonConfig.instance:getSummonPool(poolId)

	if co then
		return co.type == SummonEnum.Type.StrongCustomOnePick
	end

	return false
end

function SummonConfig:getStrongCustomChoiceIds(poolId)
	local co = SummonConfig.instance:getSummonPool(poolId)

	if co and co.type == SummonEnum.Type.StrongCustomOnePick then
		return string.splitToNumber(co.param, "#")
	end

	return nil
end

function SummonConfig:getProgressRewardsByPoolId(poolId)
	if not self._poolProgressRewardsDic then
		self._poolProgressRewardsDic = {}

		local cfgList = self:getSummonPoolList()

		for _, cfg in ipairs(cfgList) do
			if cfg and not string.nilorempty(cfg.progressRewards) then
				local totalParamList = GameUtil.splitString2(cfg.progressRewards, false, "|", ",")

				for index, singleTarget in ipairs(totalParamList) do
					local result = {}

					result[1] = tonumber(singleTarget[1])

					local rewardItemList = {}

					for i = 2, #singleTarget do
						local param = singleTarget[i]
						local singleRewardParam = string.splitToNumber(param, "#")

						table.insert(rewardItemList, singleRewardParam)
					end

					result[2] = rewardItemList
					totalParamList[index] = result
				end

				self._poolProgressRewardsDic[cfg.id] = totalParamList
			end
		end
	end

	return self._poolProgressRewardsDic[poolId]
end

function SummonConfig:getOptionalProgressRewardByPoolId(poolId)
	if not self._poolOptionalProgressRewardsDic then
		self._poolOptionalProgressRewardsDic = {}

		local cfgList = self:getSummonPoolList()

		for _, cfg in ipairs(cfgList) do
			if cfg and not string.nilorempty(cfg.progressChooseGroupId) then
				local groupId = tonumber(cfg.progressChooseGroupId)
				local rewardGroupConfigList = self:getProgressChooseConfigList(groupId)
				local tempList = {}

				for progress, rewardGroupConfig in pairs(rewardGroupConfigList) do
					table.insert(tempList, progress)
				end

				table.sort(tempList, SummonConfig.sortOptionalProgress)

				local totalParamList = {}

				for index, progressId in ipairs(tempList) do
					local rewardGroupConfig = self:getProgressChooseConfig(groupId, progressId)
					local result = {}

					result[1] = tonumber(rewardGroupConfig.progress)
					result[2] = GameUtil.splitString2(rewardGroupConfig.chooseRewards, true)
					totalParamList[index] = result
				end

				self._poolOptionalProgressRewardsDic[cfg.id] = totalParamList
			end
		end
	end

	return self._poolOptionalProgressRewardsDic[poolId]
end

function SummonConfig.sortOptionalProgress(a, b)
	return a < b
end

function SummonConfig:getProgressChooseConfigList(groupId)
	return lua_summon_progress_choose.configDict[groupId]
end

function SummonConfig:getProgressChooseConfig(groupId, progressId)
	return lua_summon_progress_choose.configDict[groupId] and lua_summon_progress_choose.configDict[groupId][progressId]
end

function SummonConfig:getSummonPoolPackageConfig(poolId, order)
	if poolId == nil or order == nil then
		return nil
	end

	local singleConfigDic = lua_summon_pool_package.configDict[poolId]

	if singleConfigDic == nil then
		return nil
	end

	return singleConfigDic[order]
end

function SummonConfig:getSummonPoolPackageConfigList(poolId)
	if poolId == nil then
		return nil
	end

	local singleConfigDic = lua_summon_pool_package.configDict[poolId]

	if singleConfigDic == nil then
		return nil
	end

	if not self._summonPoolPackageListDic[poolId] then
		local list = {}

		for _, config in pairs(singleConfigDic) do
			list[config.order] = config
		end

		self._summonPoolPackageListDic[poolId] = list
	end

	return self._summonPoolPackageListDic[poolId]
end

function SummonConfig:getSummonLimitReplicateConfig(heroId)
	if heroId == nil then
		return nil
	end

	return lua_summon_pool_limit_replicate.configDict[heroId]
end

function SummonConfig:getSummonInfallibleConfig(infallibleItemId)
	if infallibleItemId == nil then
		return nil
	end

	return lua_summon_pool_infallible.configDict[infallibleItemId]
end

function SummonConfig:getSummonCountByItemId(itemId)
	if not self._itemId2CountDict then
		self._itemId2CountDict = {}

		local cfgList = self:getSummonPoolList()

		for _, cfg in ipairs(cfgList) do
			local cost10Nums = GameUtil.splitString2(cfg.cost10, true, "|", "#")

			if cost10Nums then
				for _i, nums in ipairs(cost10Nums) do
					if nums and #nums >= 3 and nums[3] == 1 then
						local t_id = nums[2]

						self._itemId2CountDict[t_id] = 10
					end
				end
			end
		end
	end

	return self._itemId2CountDict[itemId] or 1
end

SummonConfig.instance = SummonConfig.New()

return SummonConfig
