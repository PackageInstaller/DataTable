-- chunkname: @modules/logic/critter/config/CritterConfig.lua

module("modules.logic.critter.config.CritterConfig", package.seeall)

local CritterConfig = class("CritterConfig", BaseConfig)

function CritterConfig:reqConfigNames()
	return {
		"critter_const",
		"critter",
		"critter_skin",
		"critter_attribute",
		"critter_attribute_level",
		"critter_tag",
		"critter_train_event",
		"critter_hero_preference",
		"critter_summon",
		"critter_interaction_effect",
		"critter_interaction_audio",
		"critter_summon_pool",
		"critter_rare",
		"critter_catalogue",
		"critter_filter_type",
		"critter_patience_change"
	}
end

function CritterConfig:onInit()
	return
end

function CritterConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function CritterConfig:critter_interaction_effectConfigLoaded(configTable)
	self._commonInteractionEffDict = {}

	for skinId, effCfgDict in pairs(configTable.configDict) do
		for id, cfg in pairs(effCfgDict) do
			if string.nilorempty(cfg.animName) then
				if not string.nilorempty(cfg.effectKey) then
					self._commonInteractionEffDict[id] = cfg
				else
					logError(string.format("CritterConfig:critter_interaction_effectConfigLoaded error, cfg no animName and effectKey, skinId:%s id:%s", skinId, id))
				end
			end
		end
	end
end

function CritterConfig:critter_interaction_audioConfigLoaded(configTable)
	self._critterAudioDict = {}

	for critterId, audioCfgDict in pairs(configTable.configDict) do
		for animState, cfg in pairs(audioCfgDict) do
			local idArr = string.splitToNumber(cfg.audioId, "#")

			if idArr and #idArr > 0 then
				if not self._critterAudioDict[critterId] then
					self._critterAudioDict[critterId][animState] = self._critterAudioDict[critterId][animState] or {}

					tabletool.addValues(self._critterAudioDict[critterId][animState], idArr)

					self._critterAudioDict[critterId] = self._critterAudioDict[critterId]
				end
			end
		end
	end
end

function CritterConfig:getCritterConstStr(constId)
	local result
	local cfg = lua_critter_const.configDict[constId]

	if cfg then
		result = cfg.value

		if string.nilorempty(cfg.value) then
			result = cfg.value2
		end
	else
		logError(string.format("CritterConfig:getCritterConstStr error, cfg is nil, id:%s", constId))
	end

	return result
end

function CritterConfig:getCritterCfg(critterId, nilError)
	local cfg = lua_critter.configDict[critterId]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterCfg error, cfg is nil, critterId:%s", critterId))
	end

	return cfg
end

function CritterConfig:getCritterName(critterId)
	local cfg = self:getCritterCfg(critterId, true)

	return (cfg or nil) and cfg.name
end

function CritterConfig:getCritterRare(critterId)
	local result
	local cfg = self:getCritterCfg(critterId, true)

	return (cfg or nil) and cfg.rare
end

function CritterConfig:getCritterCatalogue(critterId)
	local result
	local cfg = self:getCritterCfg(critterId, true)

	return (cfg or nil) and cfg.catalogue
end

function CritterConfig:getCritterNormalSkin(critterId)
	local result
	local cfg = self:getCritterCfg(critterId, true)

	return (cfg or nil) and cfg.normalSkin
end

function CritterConfig:getCritterMutateSkin(critterId)
	local result
	local cfg = self:getCritterCfg(critterId, true)

	return (cfg or nil) and cfg.mutateSkin
end

function CritterConfig:getCritterSpecialRate(critterId)
	local cfg = self:getCritterCfg(critterId, true)

	return (cfg or nil) and cfg.specialRate
end

function CritterConfig:isFavoriteFood(critterId, foodItemId)
	local result = false

	self._critterFavoriteFoodDict = self._critterFavoriteFoodDict or {}

	if critterId then
		local critterFoodDict = self._critterFavoriteFoodDict[critterId]

		if not critterFoodDict then
			critterFoodDict = self:getFoodLikeDict(critterId)
			self._critterFavoriteFoodDict[critterId] = critterFoodDict
		end

		result = critterFoodDict[foodItemId] or false
	end

	return result
end

function CritterConfig:getFoodLikeDict(critterId)
	local result = {}
	local cfg = self:getCritterCfg(critterId, true)
	local foodItemList = GameUtil.splitString2(cfg and cfg.foodLike)

	if foodItemList then
		for _, itemId in ipairs(foodItemList) do
			local foodItemId = tonumber(itemId[1])

			result[foodItemId] = true
		end
	end

	return result
end

function CritterConfig:getCritterCount()
	return #lua_critter.configList
end

function CritterConfig:getCritterSkinCfg(skinId, nilError)
	local cfg = lua_critter_skin.configDict[skinId]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterSkinCfg error, cfg is nil, skinId:%s", skinId))
	end

	return cfg
end

function CritterConfig:getCritterHeadIcon(skinId)
	local result
	local cfg = self:getCritterSkinCfg(skinId, true)

	return (cfg or nil) and cfg.headIcon
end

function CritterConfig:getCritterLargeIcon(skinId)
	local result
	local cfg = self:getCritterSkinCfg(skinId, true)

	return (cfg or nil) and cfg.largeIcon
end

function CritterConfig:getCritterAttributeCfg(attributeId, nilError)
	local cfg = lua_critter_attribute.configDict[attributeId]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterAttributeCfg error, cfg is nil, attributeId:%s", attributeId))
	end

	return cfg
end

function CritterConfig:getCritterAttributeLevelCfg(level, nilError)
	local cfg = lua_critter_attribute_level.configDict[level]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterAttributeLevelCfg error, cfg is nil, level:%s", level))
	end

	return cfg
end

function CritterConfig:getCritterAttributeLevelCfgByValue(value)
	local cfgList = lua_critter_attribute_level.configList
	local tempCfg

	for i = 1, #cfgList do
		local cfg = cfgList[i]

		if value >= cfg.minValue and (tempCfg == nil or tempCfg.level < cfg.level) then
			tempCfg = cfg
		end
	end

	return tempCfg
end

function CritterConfig:getMaxCritterAttributeLevelCfg()
	if self._critterAttributeLevelMaxCfg == nil then
		local cfgList = lua_critter_attribute_level.configList
		local tempCfg

		for i = 1, #cfgList do
			local cfg = cfgList[i]

			if tempCfg == nil or tempCfg.level < cfg.level then
				tempCfg = cfg
			end
		end

		self._critterAttributeLevelMaxCfg = tempCfg
	end

	return self._critterAttributeLevelMaxCfg
end

function CritterConfig:getCritterAttributeMax()
	self:getMaxCritterAttributeLevelCfg()

	return self._critterAttributeLevelMaxCfg.minValue
end

function CritterConfig:getCritterTagCfg(tagId, nilError)
	local cfg = lua_critter_tag.configDict[tagId]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterTagCfg error, cfg is nil, tagId:%s", tagId))
	end

	return cfg
end

function CritterConfig:getCritterTrainEventCfg(eventId, nilError)
	local cfg = lua_critter_train_event.configDict[eventId]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterTrainEventCfg error, cfg is nil, eventId:%s", eventId))
	end

	return cfg
end

function CritterConfig:getCritterHeroPreferenceCfg(heroId, nilError)
	local cfg = lua_critter_hero_preference.configDict[heroId]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterHeroPreferenceCfg error, cfg is nil, heroId:%s", heroId))
	end

	return cfg
end

function CritterConfig:getCritterSummonCfg(summonId, nilError)
	local cfg = lua_critter_summon.configDict[summonId]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterSummonCfg error, cfg is nil, summonId:%s", summonId))
	end

	return cfg
end

function CritterConfig:getCritterSummonPoolCfg(poolId, nilError)
	local cfg = lua_critter_summon_pool.configDict[poolId]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterSummonPoolCfg error, cfg is nil, summonId:%s", poolId))
	end

	return cfg
end

function CritterConfig:getCritterFilterTypeCfg(filterType, nilError)
	local cfg = lua_critter_filter_type.configDict[filterType]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterFilterTypeCfg error, cfg is nil, id:%s", filterType))
	end

	return cfg
end

function CritterConfig:getCritterTabDataList(filterType)
	local result = {}
	local cfg = self:getCritterFilterTypeCfg(filterType, true)

	if cfg then
		local filterTabList = string.splitToNumber(cfg.filterTab, "#")
		local nameList = {}

		if filterType == CritterEnum.FilterType.Race then
			for i, filterTab in ipairs(filterTabList) do
				local categoryCfg = self:getCritterCatalogueCfg(filterTab)

				nameList[i] = categoryCfg.name
			end
		else
			nameList = string.split(cfg.tabName, "#")
		end

		local iconList = string.split(cfg.tabIcon, "#")

		for i, filterTab in ipairs(filterTabList) do
			result[i] = {
				filterTab = filterTab,
				name = nameList[i],
				icon = iconList[i]
			}
		end
	end

	return result
end

function CritterConfig:getCritterEffectList(skinId)
	if not self._critterSkinEffectDict then
		self._critterSkinEffectDict = {}
		self._critterSkinAnimEffectDict = {}

		local dict = self._critterSkinEffectDict

		for i, cfg in ipairs(lua_critter_interaction_effect.configList) do
			if not dict[cfg.skinId] then
				dict[cfg.skinId] = {}
				self._critterSkinAnimEffectDict[cfg.skinId] = {}
			end

			table.insert(dict[cfg.skinId], cfg)

			local nameDict = self._critterSkinAnimEffectDict[cfg.skinId]

			nameDict[cfg.animName] = nameDict[cfg.animName] or {}

			table.insert(nameDict[cfg.animName], cfg)
		end
	end

	return self._critterSkinEffectDict[skinId]
end

function CritterConfig:getCritterCommonInteractionEffCfg(interactEffectId)
	local result

	return (self._commonInteractionEffDict or nil) and self._commonInteractionEffDict[interactEffectId]
end

function CritterConfig:getAllCritterCommonInteractionEffKeyList()
	local result = {}

	if self._commonInteractionEffDict then
		for _, cfg in pairs(self._commonInteractionEffDict) do
			result[#result + 1] = cfg.effectKey
		end
	end

	return result
end

function CritterConfig:getCritterEffectListByAnimName(skinId, animName)
	if not self._critterSkinAnimEffectDict then
		self:getCritterEffectList(skinId)
	end

	return self._critterSkinAnimEffectDict[skinId] and self._critterSkinAnimEffectDict[skinId][animName]
end

function CritterConfig:getCritterRareCfg(rare, nilError)
	local cfg = lua_critter_rare.configDict[rare]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterRareCfg error, cfg is nil, summonId:%s", rare))
	end

	return cfg
end

function CritterConfig:getCritterInteractionAudioList(critterId, animState)
	return (self._critterAudioDict and self._critterAudioDict[critterId] or nil) and (self._critterAudioDict[critterId][animState] or {})
end

function CritterConfig:getCritterCatalogueCfg(id, nilError)
	local cfg = lua_critter_catalogue.configDict[id]

	if not cfg and nilError then
		logError(string.format("CritterConfig:getCritterCatalogueCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function CritterConfig:getBaseCard(id)
	local cfg = self:getCritterCatalogueCfg(id)

	return cfg and cfg.baseCard
end

function CritterConfig:isHasCatalogueChildId(parentId, childId)
	if not self._catalogueChildIdMapDict then
		self:_initCatalogueChildIdList_()
	end

	return self._catalogueChildIdMapDict[parentId] and self._catalogueChildIdMapDict[parentId][childId]
end

function CritterConfig:getCatalogueChildIdMap(id)
	if not self._catalogueChildIdMapDict then
		self:_initCatalogueChildIdList_()
	end

	return self._catalogueChildIdMapDict[id]
end

function CritterConfig:getCatalogueChildIdList(id)
	if not self._catalogueChildIdsDict then
		self:_initCatalogueChildIdList_()
	end

	return self._catalogueChildIdsDict[id]
end

function CritterConfig:_initCatalogueChildIdList_()
	if not self._catalogueChildIdsDict then
		self._catalogueChildIdsDict = {}
		self._catalogueChildIdMapDict = {}

		local cfgList = lua_critter_catalogue.configList

		for i = 1, #cfgList do
			local cfg = cfgList[i]
			local id = cfg.id
			local idList, idDict = self:_findCatalogueChildIdList_(id, cfgList)

			self._catalogueChildIdsDict[id] = idList
			self._catalogueChildIdMapDict[id] = idDict
		end
	end
end

function CritterConfig:_findCatalogueChildIdList_(parentId, cfgList)
	local childIds = {}
	local childIdMap = {}
	local nextIdx = 0

	while parentId do
		for i = 1, #cfgList do
			local childCfg = cfgList[i]

			if childCfg.parentId == parentId and not childIdMap[childCfg.id] then
				childIdMap[childCfg.id] = true

				table.insert(childIds, childCfg.id)
			end
		end

		nextIdx = nextIdx + 1
		parentId = childIds[nextIdx]
	end

	return childIds, childIdMap
end

function CritterConfig:getPatienceChangeCfg(buildingType)
	return lua_critter_patience_change.configDict[buildingType]
end

CritterConfig.instance = CritterConfig.New()

return CritterConfig
