-- chunkname: @modules/logic/rouge/controller/RougeSettlementTriggerHelper.lua

module("modules.logic.rouge.controller.RougeSettlementTriggerHelper", package.seeall)

local RougeSettlementTriggerHelper = class("RougeSettlementTriggerHelper")

function RougeSettlementTriggerHelper.isResultTrigger(triggerType, ...)
	local func = RougeSettlementTriggerHelper["triggerType" .. triggerType]

	if not func then
		logError("未处理当前触发类型, 触发类型 = " .. tostring(triggerType))

		return
	end

	return func(...)
end

function RougeSettlementTriggerHelper.triggerType1(collectionCount)
	local resultInfo = RougeModel.instance:getRougeResult()
	local reviewInfo = resultInfo and resultInfo.reviewInfo

	if reviewInfo then
		if not reviewInfo.collectionNum then
			local allCollectionCount = 0

			collectionCount = collectionCount or 0

			if collectionCount <= allCollectionCount then
				local rareMap = RougeCollectionModel.instance:getCollectionRareMap()
				local rareCfgList = lua_rouge_quality.configList
				local result = {}

				if rareCfgList then
					for _, rareCfg in ipairs(rareCfgList) do
						local rareName = rareCfg.name
						local rareId = rareCfg.id
						local rareCount = rareMap[rareId] and tabletool.len(rareMap[rareId]) or 0

						table.insert(result, rareCount)
						table.insert(result, rareName)
					end
				end

				return unpack(result)
			end
		end
	end
end

function RougeSettlementTriggerHelper.triggerType2(tagCount)
	local allCollections = RougeCollectionModel.instance:getAllCollections()
	local tagMap = {}

	if allCollections then
		for _, collection in ipairs(allCollections) do
			RougeSettlementTriggerHelper.computeTagCount(collection, tagMap)
		end
	end

	local maxTagId, maxTypeTagCount = 0, -10000

	for tagId, tagCount in pairs(tagMap) do
		if maxTypeTagCount < tagCount then
			maxTagId = tagId
			tagCount = maxTypeTagCount
		end
	end

	local tagCfg = lua_rouge_tag.configDict[maxTagId]
	local tagName = tagCfg and tagCfg.name

	if tagCount <= maxTypeTagCount then
		return maxTypeTagCount, tagName
	end
end

function RougeSettlementTriggerHelper.computeTagCount(collection, tagMap)
	if not collection then
		return 0
	end

	RougeSettlementTriggerHelper.computeTypeTagCount(collection.cfgId, tagMap)

	local enchantCfgs = collection:getAllEnchantCfgId()

	if enchantCfgs then
		for _, cfgId in pairs(enchantCfgs) do
			if cfgId and cfgId > 0 then
				RougeSettlementTriggerHelper.computeTypeTagCount(cfgId, tagMap)
			end
		end
	end
end

function RougeSettlementTriggerHelper.computeTypeTagCount(collectionCfgId, tagMap)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)
	local tags = collectionCfg and collectionCfg.tags

	if tags then
		for _, tagId in pairs(tags) do
			if not tagMap[tagId] then
				local tagCount = 0

				tagCount = tagMap[tagId] + 1
				tagMap[tagId] = tagMap[tagId]
			end
		end
	end
end

function RougeSettlementTriggerHelper.triggerType3(compositeCount)
	local resultInfo = RougeModel.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.compositeCount then
			local hasCompositeCount = 0
			local compositeInfos = resultInfo:getCompositeCollectionIdAndCount()
			local composteIds = {}

			if compositeInfos then
				for _, compositeInfo in ipairs(compositeInfos) do
					local compositeId = compositeInfo[1]
					local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(compositeId)
					local composteName = collectionCfg and collectionCfg.name

					table.insert(composteIds, composteName)
				end
			end

			if compositeCount <= hasCompositeCount then
				return (table.concat(composteIds, luaLang("room_levelup_init_and1")))
			end
		end
	end
end

function RougeSettlementTriggerHelper.triggerType4(count)
	local slotCollections = RougeCollectionModel.instance:getSlotAreaCollection()
	local hasEnchantCount = 0

	if slotCollections then
		for _, collection in pairs(slotCollections) do
			local enchantCount = collection:getEnchantCount()

			if enchantCount and enchantCount > 0 then
				hasEnchantCount = hasEnchantCount + 1
			end
		end
	end

	if count <= hasEnchantCount then
		return hasEnchantCount
	end
end

function RougeSettlementTriggerHelper.triggerType5(count)
	local resultInfo = RougeModel.instance:getRougeResult()
	local totalFightCount = 0

	if resultInfo then
		totalFightCount = resultInfo:getTotalFightCount()
	end

	if count <= totalFightCount then
		return totalFightCount
	end
end

function RougeSettlementTriggerHelper.triggerType6(count)
	local resultInfo = RougeModel.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.costPower then
			local costPower = 0

			if count <= costPower then
				return costPower
			end
		end
	end
end

function RougeSettlementTriggerHelper.triggerType7(value)
	local resultInfo = RougeModel.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.maxDamage then
			local maxDamage = 0

			if value <= maxDamage then
				return maxDamage
			end
		end
	end
end

function RougeSettlementTriggerHelper.triggerType8(eventId)
	local resultInfo = RougeModel.instance:getRougeResult()

	if (resultInfo or nil) and resultInfo:isEventFinish(eventId) then
		local eventCfg = RougeMapConfig.instance:getRougeEvent(eventId)

		return eventCfg and eventCfg.name
	end
end

function RougeSettlementTriggerHelper.triggerType9(entrustId)
	local resultInfo = RougeModel.instance:getRougeResult()

	if (resultInfo or nil) and resultInfo:isEntrustFinish(entrustId) then
		return entrustId
	end
end

function RougeSettlementTriggerHelper.triggerType10(count)
	local resultInfo = RougeModel.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.consumeCoin then
			local consumeCoin = 0

			if count <= consumeCoin then
				return consumeCoin
			end
		end
	end
end

function RougeSettlementTriggerHelper.triggerType11(count)
	local resultInfo = RougeModel.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.displaceNum then
			local displaceNum = 0

			if count <= displaceNum then
				return displaceNum
			end
		end
	end
end

function RougeSettlementTriggerHelper.triggerType12(count)
	local resultInfo = RougeModel.instance:getRougeResult()

	if resultInfo then
		if not resultInfo.repairShopNum then
			local repairShopNum = 0

			if count <= repairShopNum then
				return repairShopNum
			end
		end
	end
end

function RougeSettlementTriggerHelper.triggerType13(endId)
	local resultInfo = RougeModel.instance:getRougeResult()
	local reviewInfo = resultInfo and resultInfo.reviewInfo
	local finishEndId = reviewInfo and reviewInfo.endId

	if finishEndId == endId then
		return finishEndId
	end
end

function RougeSettlementTriggerHelper.triggerType14(endId)
	local failEndId = RougeMapModel.instance:getEndId()
	local resultInfo = RougeModel.instance:getRougeResult()
	local isSucc = resultInfo:isSucceed()

	if not isSucc and failEndId == endId then
		return failEndId
	end
end

function RougeSettlementTriggerHelper.triggerType15()
	local isAbort = RougeModel.instance:isAbortRouge()

	if isAbort then
		return
	end

	local resultInfo = RougeModel.instance:getRougeResult()
	local failEndId = RougeMapModel.instance:getEndId()
	local isSucc = resultInfo:isSucceed()
	local isNormalFight = not isSucc and (not failEndId or failEndId <= 0)
	local eventCo = RougeMapModel.instance:getCurEvent()

	if not eventCo then
		return
	end

	local eventName = eventCo.name

	if isNormalFight then
		return eventName
	end
end

function RougeSettlementTriggerHelper.triggerType16()
	local isAbort = RougeModel.instance:isAbortRouge()

	if isAbort then
		return "abort"
	end
end

function RougeSettlementTriggerHelper.triggerType17()
	local rougeInfo = RougeModel.instance:getRougeInfo()
	local resultInfo = RougeModel.instance:getRougeResult()
	local season = resultInfo and resultInfo.season
	local difficultyCfg = lua_rouge_difficulty.configDict[season][rougeInfo.difficulty]
	local difficultyTitle = difficultyCfg and difficultyCfg.title
	local styleCfg = RougeController.instance:getStyleConfig()
	local styleName = styleCfg and styleCfg.name
	local initHeroNames = RougeSettlementTriggerHelper.getAllInitHeroNames(resultInfo.initHeroId)

	return difficultyTitle, styleName, initHeroNames
end

function RougeSettlementTriggerHelper.getAllInitHeroNames(initHeroId)
	local heroNameList = {}

	if initHeroId then
		for _, heroId in ipairs(initHeroId) do
			local heroCfg = HeroConfig.instance:getHeroCO(heroId)
			local heroName = heroCfg and heroCfg.name

			if heroName then
				table.insert(heroNameList, heroName)
			end
		end
	end

	return (table.concat(heroNameList, luaLang("room_levelup_init_and1")))
end

function RougeSettlementTriggerHelper.triggerType18()
	local resultInfo = RougeModel.instance:getRougeResult()
	local reviewInfo = resultInfo and resultInfo.reviewInfo
	local teamInfo = reviewInfo and reviewInfo:getTeamInfo()
	local heroCount = teamInfo and teamInfo:getAllHeroCount() or 0
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if rougeInfo then
		if not rougeInfo.teamSize then
			local teamSize = 0

			return heroCount, teamSize
		end
	end
end

function RougeSettlementTriggerHelper.triggerType19()
	local rougeResult = RougeModel.instance:getRougeResult()
	local reviewInfo = rougeResult and rougeResult.reviewInfo

	if reviewInfo then
		if not reviewInfo.gainCoin then
			local gainCoin = 0
			local stepNum = rougeResult and rougeResult.stepNum

			return stepNum, gainCoin
		end
	end
end

function RougeSettlementTriggerHelper.triggerType20()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if rougeInfo then
		if not rougeInfo.teamExp then
			local teamExp = 0

			if rougeInfo then
				if not rougeInfo.teamLevel then
					local teamLevel = 0
					local season = rougeInfo.season
					local totalTeamExp = RougeSettlementTriggerHelper._getTotalTeamExp(season, teamLevel, teamExp)

					return totalTeamExp, teamLevel
				end
			end
		end
	end
end

function RougeSettlementTriggerHelper._getTotalTeamExp(season, curTeamLv, curTeamExp)
	if not season then
		return 0
	end

	curTeamLv = curTeamLv or 0
	curTeamExp = curTeamExp or 0

	local seasonTeamCfgs = lua_rouge_level.configDict[season]
	local totalTeamExp = 0

	for i = 1, curTeamLv do
		local lvCfg = seasonTeamCfgs and seasonTeamCfgs[i]

		if lvCfg then
			if not lvCfg.exp then
				local teamExp = 0

				totalTeamExp = totalTeamExp + teamExp
			end
		end
	end

	totalTeamExp = totalTeamExp + curTeamExp

	return totalTeamExp
end

return RougeSettlementTriggerHelper
