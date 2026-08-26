-- chunkname: @modules/logic/room/config/RoomConfig.lua

module("modules.logic.room.config.RoomConfig", package.seeall)

local RoomConfig = class("RoomConfig", BaseConfig)

function RoomConfig:ctor()
	self._taskConfig = nil
	self._resourceConfig = nil
	self._roomBuildingConfig = nil
	self._roomBuildingTypeConfig = nil
	self._formulaConfig = nil
	self._levelGroupConfig = nil
	self._formulaShowTypeConfig = nil
	self._blockRandomEventConfig = nil
	self._roomLevelConfig = nil
	self._roomCharacterConfig = nil
	self._blockPackageConfig = nil
	self._initBuildingOccupyDict = nil
	self._taskFinishRewardDict = nil
	self._blockPackageDataConfig = nil
	self._productionPartConfig = nil
	self._productionLineToPart = nil
	self._sceneTaskConfig = nil
	self._blockId2PackageIdDict = nil
	self._specialBlockConfig = nil
	self._heroId2SpecialBlockIdDict = nil
	self._roomCharacterInteractionConfig = nil
	self._roomCharacterInteractionConfigHeroDict = nil
	self._roomCharacterDialogConfig = nil
	self._roomThemeConfig = nil
	self._roomCharacterDialogSelectConfig = nil
	self._roomVehicleConfig = nil
	self._roomSourcesTypeConfig = nil
	self._roomCharacterAnimConfig = nil
	self._roomAudioExtendConfig = nil
	self._roomCameraParamsConfig = nil
	self._roomCharacterBuildingInteractCameraConfig = nil
	self.roomCharacterShadowConfig = nil
	self._roomLayoutPlanCoverConfig = nil
	self._building2AtmosphereIds = nil
	self._roomSceneAmbientConfig = nil
	self._roomType2SkinsDict = nil
	self._unlockItem2RoomSkinList = nil
	self._blockId2WaterReformTypeDict = nil
	self._blockId2BlockColorDict = nil
end

function RoomConfig:reqConfigNames()
	return {
		"block_task",
		"block_resource",
		"room_building",
		"room_building_area",
		"formula",
		"room_building_level",
		"room_building_skin",
		"room_interact_building",
		"formula_showtype",
		"block_random_event",
		"room_level",
		"room_character",
		"task_room",
		"block_package",
		"block_package_data",
		"block",
		"block_init",
		"production_part",
		"production_line",
		"production_line_level",
		"building_bonus",
		"special_block",
		"room_character_interaction",
		"room_character_dialog",
		"room_character_dialog_select",
		"room_theme",
		"room_vehicle",
		"room_sources_type",
		"room_character_anim",
		"block_place_position",
		"room_audio_extend",
		"room_camera_params",
		"room_character_building_interact_camera",
		"room_character_shadow",
		"room_character_interaction_effect",
		"room_layout_plan_cover",
		"room_atmosphere",
		"room_effect",
		"room_scene_ambient",
		"room_water_reform",
		"room_skin",
		"room_building_occupy",
		"room_building_type",
		"room_block_color",
		"room_block_color_param"
	}
end

function RoomConfig:onConfigLoaded(configName, configTable)
	if configName == "block_task" then
		self._taskConfig = configTable
	elseif configName == "block_resource" then
		self._resourceConfig = configTable

		self:_initBlockResource(configTable)
	elseif configName == "room_building" then
		self._roomBuildingConfig = configTable
	elseif configName == "room_building_area" then
		self._roomBuildingAreaConfig = configTable
	elseif configName == "formula" then
		self:initFormulaConfig(configTable)
	elseif configName == "room_building_level" then
		self._levelGroupConfig = configTable
	elseif configName == "room_building_skin" then
		self:_initBuildingSkinConfig(configTable)
	elseif configName == "room_interact_building" then
		self._roomInteractBuildingConfig = configTable
	elseif configName == "formula_showtype" then
		self._formulaShowTypeConfig = configTable
	elseif configName == "block_random_event" then
		self._blockRandomEventConfig = configTable
	elseif configName == "room_level" then
		self._roomLevelConfig = configTable
	elseif configName == "room_character" then
		self._roomCharacterConfig = configTable
	elseif configName == "task_room" then
		self._sceneTaskConfig = configTable
	elseif configName == "block_package" then
		self._blockPackageConfig = configTable
	elseif configName == "block_package_data" then
		self._blockPackageDataConfig = configTable
	elseif configName == "block" then
		self._blockDefineConfig = configTable
	elseif configName == "block_init" then
		self._blockInitConfig = configTable
	elseif configName == "production_part" then
		self:initProductionPart(configTable)
	elseif configName == "production_line" then
		self._productionLineConfig = configTable
	elseif configName == "production_line_level" then
		self._productionLineLevelConfig = configTable
	elseif configName == "building_bonus" then
		self._buildingBonusConfig = configTable
	elseif configName == "special_block" then
		self:_initSpecialBlock(configTable)
	elseif configName == "room_character_interaction" then
		self._roomCharacterInteractionConfig = configTable
	elseif configName == "room_character_dialog" then
		self._roomCharacterDialogConfig = configTable
	elseif configName == "room_character_dialog_select" then
		self._roomCharacterDialogSelectConfig = configTable
	elseif configName == "room_theme" then
		self:_initTheme(configTable)
	elseif configName == "room_vehicle" then
		self._roomVehicleConfig = configTable
	elseif configName == "room_sources_type" then
		self._roomSourcesTypeConfig = configTable.configDict
	elseif configName == "room_character_anim" then
		self._roomCharacterAnimConfig = configTable
	elseif configName == "block_place_position" then
		self._blockPlacePositionConfig = configTable
	elseif configName == "room_audio_extend" then
		self._roomAudioExtendConfig = configTable
	elseif configName == "room_camera_params" then
		self:_initCameraParam(configTable)
	elseif configName == "room_character_building_interact_camera" then
		self._roomCharacterBuildingInteractCameraConfig = configTable
	elseif configName == "room_character_shadow" then
		self.roomCharacterShadowConfig = configTable
	elseif configName == "room_character_interaction_effect" then
		self._roomCharacterEffectConfig = configTable
	elseif configName == "room_layout_plan_cover" then
		self._roomLayoutPlanCoverConfig = configTable
	elseif configName == "room_atmosphere" then
		self:_initAtmosphereCfg(configTable)
	elseif configName == "room_scene_ambient" then
		self._roomSceneAmbientConfig = configTable
	elseif configName == "room_skin" then
		self:_initRoomSkinCfg(configTable)
	end
end

function RoomConfig:_toListDictByKeyName(cfgList, keyName)
	local dict = {}

	for _, cfg in ipairs(cfgList) do
		local keyValue = cfg[keyName]

		dict[keyValue] = dict[keyValue] or {}

		table.insert(dict[keyValue], cfg)
	end

	return dict
end

function RoomConfig:initProductionPart(configTable)
	self._productionPartConfig = configTable
	self._productionLineToPart = {}

	for partId, cfg in pairs(configTable.configDict) do
		for _, lineId in pairs(cfg.productionLines) do
			self._productionLineToPart[lineId] = partId
		end
	end
end

function RoomConfig:_initSpecialBlock(configTable)
	self._heroId2SpecialBlockIdDict = {}
	self._specialBlockConfig = configTable

	for _, cfg in ipairs(configTable.configList) do
		self._heroId2SpecialBlockIdDict[cfg.heroId] = cfg.id
	end
end

function RoomConfig:initFormulaConfig(configTable)
	self._formulaConfig = configTable
	self.item2FormulaIdDic = {}

	for formulaId, cfg in pairs(configTable.configDict) do
		if cfg.type == 2 then
			local produceItem = RoomProductionHelper.getFormulaProduceItem(formulaId, cfg)

			if produceItem then
				self.item2FormulaIdDic[produceItem.type] = self.item2FormulaIdDic[produceItem.type] or {}
				self.item2FormulaIdDic[produceItem.type][produceItem.id] = formulaId
			end
		end
	end
end

function RoomConfig:getItemFormulaId(type, id)
	return (self.item2FormulaIdDic[type] or nil) and (self.item2FormulaIdDic[type][id] or 0)
end

function RoomConfig:_initTheme(configTable)
	self._roomThemeConfig = configTable
	self._itemIdToRoomThemeId = {}
	self._roomThemeToItemList = {}
	self._roomThemeCollectionBonusDic = {}

	local materkvs = {
		building = MaterialEnum.MaterialType.Building,
		package = MaterialEnum.MaterialType.BlockPackage,
		extraShowBuilding = MaterialEnum.MaterialType.Building
	}

	for itemK, itemType in pairs(materkvs) do
		self._itemIdToRoomThemeId[itemType] = {}
	end

	local themeDic = {}

	self._itemIdToRoomThemeId[MaterialEnum.MaterialType.RoomTheme] = themeDic

	for themeId, cfg in pairs(configTable.configDict) do
		local t = {}

		t.building = GameUtil.splitString2(cfg.building, true) or {}
		t.package = GameUtil.splitString2(cfg.packages, true) or {}
		t.extraShowBuilding = GameUtil.splitString2(cfg.extraShowBuilding, true) or {}
		self._roomThemeToItemList[themeId] = t
		themeDic[themeId] = themeId

		for itemK, itemType in pairs(materkvs) do
			local typeCfglist = self._itemIdToRoomThemeId[itemType]

			for _, items in ipairs(t[itemK]) do
				typeCfglist[items[1]] = themeId
			end
		end

		if not string.nilorempty(cfg.collectionBonus) then
			self._roomThemeCollectionBonusDic[cfg.id] = GameUtil.splitString2(cfg.collectionBonus, true)
		end
	end
end

function RoomConfig:_initBlockResource(configTable)
	self._resourceParamCofig = {}
	self._resourceLightDict = {}

	local cfgList = configTable.configList

	for _, cfg in ipairs(cfgList) do
		if cfg.placeBuilding then
			self._resourceParamCofig[cfg.id] = {
				placeBuilding = string.splitToNumber(cfg.placeBuilding, "#")
			}
		end

		self._resourceLightDict[cfg.id] = cfg.blockLight == 1
	end
end

function RoomConfig:_initCameraParam(configTable)
	self._roomCameraParamsConfig = configTable
	self._cameraParamsConfigDefauleDict = {}

	local cfgList = configTable.configList

	for _, cfg in ipairs(cfgList) do
		if not self._cameraParamsConfigDefauleDict[cfg.state] or cfg.gameMode == 0 then
			self._cameraParamsConfigDefauleDict[cfg.state] = cfg
		end
	end
end

function RoomConfig:_initAtmosphereCfg(configTable)
	self._building2AtmosphereIds = {}

	local cfgList = configTable.configList

	for _, cfg in ipairs(cfgList) do
		local buildingId = cfg.buildingId
		local idList = self._building2AtmosphereIds[buildingId]

		if not idList then
			idList = {}
			self._building2AtmosphereIds[buildingId] = idList
		end

		idList[#idList + 1] = cfg.id
	end
end

function RoomConfig:_initRoomSkinCfg(configTable)
	self._roomType2SkinsDict = {}
	self._unlockItem2RoomSkinList = {}

	local cfgList = configTable.configList

	for _, cfg in ipairs(cfgList) do
		local buildingType = cfg.type
		local skinList = self._roomType2SkinsDict[buildingType]

		if not skinList then
			skinList = {}
			self._roomType2SkinsDict[buildingType] = skinList
		end

		skinList[#skinList + 1] = cfg.id

		local unlockItem = cfg.itemId
		local roomSkinList = self._unlockItem2RoomSkinList[unlockItem]

		if not roomSkinList then
			roomSkinList = {}
			self._unlockItem2RoomSkinList[unlockItem] = roomSkinList
		end

		roomSkinList[#roomSkinList + 1] = cfg.id
	end
end

function RoomConfig:getCameraParamByStateId(stateId, gameMode)
	if gameMode and gameMode ~= 0 then
		local cfgList = self._roomCameraParamsConfig.configList

		for i = 1, #cfgList do
			local cfg = cfgList[i]

			if cfg.state == stateId and cfg.gameMode == gameMode then
				return cfg
			end
		end
	end

	return self._cameraParamsConfigDefauleDict[stateId]
end

function RoomConfig:getCharacterBuildingInteractCameraConfig(id)
	return self._roomCharacterBuildingInteractCameraConfig.configDict[id]
end

function RoomConfig:getCharacterEffectList(skinId)
	if not self._roomCharacterSkinEffectDict then
		self._roomCharacterSkinEffectDict = {}
		self._roomCharacterSkinAnimEffectDict = {}

		local dict = self._roomCharacterSkinEffectDict

		for i, cfg in ipairs(self._roomCharacterEffectConfig.configList) do
			if not dict[cfg.skinId] then
				dict[cfg.skinId] = {}
				self._roomCharacterSkinAnimEffectDict[cfg.skinId] = {}
			end

			table.insert(dict[cfg.skinId], cfg)

			local nameDict = self._roomCharacterSkinAnimEffectDict[cfg.skinId]

			nameDict[cfg.animName] = nameDict[cfg.animName] or {}

			table.insert(nameDict[cfg.animName], cfg)
		end
	end

	return self._roomCharacterSkinEffectDict[skinId]
end

function RoomConfig:getCharacterEffectListByAnimName(skinId, animName)
	if not self._roomCharacterSkinAnimEffectDict then
		self:getCharacterEffectList(skinId)
	end

	return self._roomCharacterSkinAnimEffectDict[skinId] and self._roomCharacterSkinAnimEffectDict[skinId][animName]
end

function RoomConfig:getTaskConfig(taskId)
	return self._taskConfig.configDict[taskId]
end

function RoomConfig:getResourceConfig(resourceId)
	return self._resourceConfig.configDict[resourceId]
end

function RoomConfig:getResourceParam(resourceId)
	return self._resourceParamCofig[resourceId]
end

function RoomConfig:isLightByResourceId(resourceId)
	return self._resourceLightDict[resourceId]
end

function RoomConfig:getBuildingConfig(buildingId)
	return self._roomBuildingConfig.configDict[buildingId]
end

function RoomConfig:getBuildingType(buildingId)
	local result
	local cfg = self:getBuildingConfig(buildingId)

	return (cfg or nil) and cfg.buildingType
end

function RoomConfig:getBuildingAreaConfig(buildingAreaId)
	return self._roomBuildingAreaConfig.configDict[buildingAreaId]
end

local function GetOccupyCfg(occupyId, nilError)
	local cfg

	if not lua_room_building_occupy.configDict[occupyId] and nilError then
		logError(string.format("RoomConfig.GetOccupyCfg Error,cfg is nil, id%s", occupyId))
	end

	return lua_room_building_occupy.configDict[occupyId]
end

function RoomConfig:getBuildingOccupyList()
	local result = {}

	for _, cfg in ipairs(lua_room_building_occupy.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

function RoomConfig:getMaxBuildingOccupyNum()
	if not self._maxBuildingOccupyNum then
		if lua_room_building_occupy then
			self._maxBuildingOccupyNum = #lua_room_building_occupy.configList or 0
		end
	end

	return self._maxBuildingOccupyNum
end

function RoomConfig:getBuildingOccupyIcon(occupyId)
	local result
	local cfg = GetOccupyCfg(occupyId, true)

	return (cfg or nil) and cfg.icon
end

function RoomConfig:getBuildingOccupyNum(occupyId)
	local result
	local cfg = GetOccupyCfg(occupyId, true)

	return (cfg or nil) and cfg.occupyNum
end

function RoomConfig:getFormulaConfig(formulaId)
	return self._formulaConfig.configDict[formulaId]
end

function RoomConfig:getBlockPackageConfig(packageId)
	return self._blockPackageConfig.configDict[packageId]
end

function RoomConfig:getBlockPackageFullDegree(packageId)
	local packageConfig = self:getBlockPackageConfig(packageId)
	local blockList = self:getBlockListByPackageId(packageId)

	return packageConfig.blockBuildDegree * #blockList
end

function RoomConfig:getLevelGroupConfig(levelGroup, level)
	return self._levelGroupConfig.configDict[levelGroup] and self._levelGroupConfig.configDict[levelGroup][level]
end

function RoomConfig:getLevelGroupInfo(levelGroup, level)
	local info = {}

	if self._levelGroupConfig.configDict[levelGroup] then
		local config = self._levelGroupConfig.configDict[levelGroup][level]

		if self._levelGroupConfig.configDict[levelGroup] then
			info.desc = self._levelGroupConfig.configDict[levelGroup].desc
		end

		config = self._levelGroupConfig.configDict[levelGroup] or self._levelGroupConfig.configDict[levelGroup] and self._levelGroupConfig.configDict[levelGroup][1]

		if self._levelGroupConfig.configDict[levelGroup] then
			info.name = self._levelGroupConfig.configDict[levelGroup].name
			info.nameEn = self._levelGroupConfig.configDict[levelGroup].nameEn
			info.icon = self._levelGroupConfig.configDict[levelGroup].icon
		end

		return info
	end
end

function RoomConfig:getLevelGroupLevelDict(levelGroup)
	return self._levelGroupConfig.configDict[levelGroup] and self._levelGroupConfig.configDict[levelGroup]
end

function RoomConfig:getLevelGroupMaxLevel(levelGroup)
	local groupConfig = self._levelGroupConfig.configDict[levelGroup]
	local maxLevel = 0

	if groupConfig then
		for level, _ in pairs(groupConfig) do
			if maxLevel < level then
				maxLevel = level
			end
		end
	end

	return maxLevel
end

function RoomConfig:_initBuildingSkinConfig(configTable)
	self._buildingSkinCongfig = configTable
	self._buildingSkinListDict = {}

	local skinCfgList = configTable.configList

	for i, skinCfg in ipairs(skinCfgList) do
		self._buildingSkinListDict[skinCfg.buildingId] = self._buildingSkinListDict[skinCfg.buildingId] or {}

		table.insert(self._buildingSkinListDict[skinCfg.buildingId], skinCfg)
	end
end

function RoomConfig:getBuildingSkinConfig(skinId)
	return self._buildingSkinCongfig and self._buildingSkinCongfig.configDict[skinId]
end

function RoomConfig:getAllBuildingSkinList()
	return self._buildingSkinCongfig and self._buildingSkinCongfig.configList
end

function RoomConfig:getBuildingSkinList(buildingId)
	return self._buildingSkinListDict and self._buildingSkinListDict[buildingId]
end

function RoomConfig:getInteractBuildingConfig(buildingId)
	return self._roomInteractBuildingConfig and self._roomInteractBuildingConfig.configDict[buildingId]
end

function RoomConfig:getBuildingSkinCoByItemId(id)
	for _, co in ipairs(self._buildingSkinCongfig.configList) do
		if co.itemId == id then
			return co
		end
	end
end

function RoomConfig:getFormulaShowTypeConfig(formulaShowTypeId)
	return self._formulaShowTypeConfig.configDict[formulaShowTypeId]
end

function RoomConfig:getRoomCharacterConfig(skinId)
	return self._roomCharacterConfig.configDict[skinId]
end

function RoomConfig:getAccelerateConfig()
	local param = CommonConfig.instance:getConstStr(ConstEnum.RoomAccelerateParam)

	param = GameUtil.splitString2(param, true)

	return {
		item = {
			type = param[1][1],
			id = param[1][2],
			quantity = param[1][3]
		},
		second = param[2][1]
	}
end

function RoomConfig:getInitBuildingOccupyDict()
	if not self._initBuildingOccupyDict then
		self._initBuildingOccupyDict = {}

		local occupyParam = CommonConfig.instance:getConstStr(ConstEnum.RoomInitBuildingOccupy)

		if not string.nilorempty(occupyParam) then
			local pointParamList = GameUtil.splitString2(occupyParam, true)

			for i, pointParam in ipairs(pointParamList) do
				local hexPoint = HexPoint(pointParam[1], pointParam[2])

				self._initBuildingOccupyDict[hexPoint.x] = self._initBuildingOccupyDict[hexPoint.x] or {}
				self._initBuildingOccupyDict[hexPoint.x][hexPoint.y] = true
			end
		end
	end

	return self._initBuildingOccupyDict
end

function RoomConfig:getTaskReward(taskCount)
	if not self._taskFinishRewardDict then
		self._taskFinishRewardDict = {}

		for i, config in ipairs(self._blockRandomEventConfig.configList) do
			local event = config.event
			local _, _, count = string.find(event, "TaskFinishCount=(%d+)")

			count = count and tonumber(count)

			if count then
				self._taskFinishRewardDict[count] = config.blockCount
			end
		end
	end

	return self._taskFinishRewardDict[taskCount] or 0
end

function RoomConfig:getRoomLevelConfig(roomLevel)
	return self._roomLevelConfig.configDict[roomLevel]
end

function RoomConfig:getMaxRoomLevel()
	local maxRoomLevel = 1

	for i, config in ipairs(self._roomLevelConfig.configList) do
		if maxRoomLevel < config.level then
			maxRoomLevel = config.level
		end
	end

	return maxRoomLevel
end

function RoomConfig:getBlockDefineConfig(defineId)
	return self._blockDefineConfig.configDict[defineId]
end

function RoomConfig:getBlockDefineConfigDict()
	return self._blockDefineConfig.configDict
end

function RoomConfig:getBlock(blockId)
	return (self._blockPackageDataConfig or nil) and (self._blockPackageDataConfig.configDict[blockId] or self._blockInitConfig and self._blockInitConfig.configDict[blockId])
end

function RoomConfig:getSpecialBlockConfig(blockId)
	return self._specialBlockConfig and self._specialBlockConfig.configDict[blockId]
end

function RoomConfig:getHeroSpecialBlockId(heroId)
	if not heroId then
		return
	end

	return self._heroId2SpecialBlockIdDict[heroId]
end

function RoomConfig:getBlockListByPackageId(packageId)
	return self._blockPackageDataConfig and self._blockPackageDataConfig.packageDict[packageId]
end

function RoomConfig:getPackageConfigByBlockId(blockId)
	if not blockId or blockId <= 0 then
		return nil
	end

	if not self._blockId2PackageIdDict then
		self._blockId2PackageIdDict = {}

		for packageId, blockList in pairs(self._blockPackageDataConfig.packageDict) do
			for _, config in ipairs(blockList) do
				self._blockId2PackageIdDict[config.blockId] = packageId
			end
		end
	end

	if not self._blockId2PackageIdDict then
		return nil
	end

	local packageId = self._blockId2PackageIdDict[blockId]

	return packageId and self:getBlockPackageConfig(packageId)
end

function RoomConfig:getInitBlockList()
	return self._blockInitConfig and self._blockInitConfig.configList
end

function RoomConfig:getInitBlock(blockId)
	return self._blockInitConfig and self._blockInitConfig.configDict[blockId]
end

function RoomConfig:getInitBlockByXY(x, y)
	if self._blockInitConfig then
		local var_59_0

		if self._blockInitConfig then
			::label_59_0::

			var_59_0 = self._blockInitConfig[x] and self._blockInitConfig[x][y]
		end

		return var_59_0
	end
end

function RoomConfig:getSceneTaskList()
	local result = {}

	for _, v in ipairs(self._sceneTaskConfig.configList) do
		if v.isOnline then
			table.insert(result, v)
		end
	end

	return self._sceneTaskConfig.configList
end

function RoomConfig:getBuildingConfigList()
	return self._roomBuildingConfig.configList
end

function RoomConfig:getProductionPartConfig(id)
	return self._productionPartConfig.configDict[id]
end

function RoomConfig:getProductionPartConfigList()
	return self._productionPartConfig.configList
end

function RoomConfig:getProductionPartByLineId(lineId)
	return self._productionLineToPart[lineId]
end

function RoomConfig:getProductionLineConfig(lineId)
	return self._productionLineConfig.configDict[lineId]
end

function RoomConfig:getProductionLineLevelGroupIdConfig(groupId)
	return self._productionLineLevelConfig.configDict[groupId]
end

function RoomConfig:getProductionLineLevelGroupMaxLevel(groupId)
	local co = self._productionLineLevelConfig.configDict[groupId]

	return (co or nil) and tabletool.len(co)
end

function RoomConfig:getProductionLineLevelConfig(groupId, level)
	return (self._productionLineLevelConfig.configDict[groupId] or {})[level]
end

function RoomConfig:getProductionLineLevelConfigList(groupId)
	local configDict = self._productionLineLevelConfig.configDict[groupId]
	local configList = {}

	for _, config in pairs(configDict) do
		table.insert(configList, config)
	end

	table.sort(configList, function(x, y)
		return x.id < y.id
	end)

	return configList
end

function RoomConfig:getCharacterLimitAddByBuildDegree(buildDegree)
	local characterLimitAdd = 0

	for i, v in ipairs(self._buildingBonusConfig.configList) do
		if buildDegree < v.buildDegree then
			break
		end

		characterLimitAdd = v.characterLimitAdd
	end

	return characterLimitAdd
end

function RoomConfig:getBuildBonusByBuildDegree(buildDegree)
	local bonus = 0
	local nextLevelNeed = 0
	local curLevel = 1

	for i, v in ipairs(self._buildingBonusConfig.configList) do
		if buildDegree < v.buildDegree then
			nextLevelNeed = v.buildDegree - buildDegree

			break
		end

		curLevel = i + 1
		bonus = v.bonus
	end

	return bonus, nextLevelNeed, curLevel
end

function RoomConfig:getCharacterInteractionConfig(interactionId)
	return self._roomCharacterInteractionConfig.configDict[interactionId]
end

function RoomConfig:getCharacterInteractionConfigList()
	return self._roomCharacterInteractionConfig.configList
end

function RoomConfig:getCharacterInteractionConfigListByHeroId(heroId)
	self._roomCharacterInteractionConfigHeroDict = self._roomCharacterInteractionConfigHeroDict or self:_toListDictByKeyName(self._roomCharacterInteractionConfig.configList, "heroId")

	return self._roomCharacterInteractionConfigHeroDict[heroId]
end

function RoomConfig:getCharacterDialogConfig(dialogId, stepId)
	return self._roomCharacterDialogConfig.configDict[dialogId] and self._roomCharacterDialogConfig.configDict[dialogId][stepId]
end

function RoomConfig:getCharacterDialogSelectConfig(selectId)
	return self._roomCharacterDialogSelectConfig.configDict[selectId]
end

function RoomConfig:getThemeConfig(themeId)
	return self._roomThemeConfig and self._roomThemeConfig.configDict[themeId]
end

function RoomConfig:getThemeConfigList()
	return self._roomThemeConfig and self._roomThemeConfig.configList
end

function RoomConfig:getThemeIdByItem(itemId, materialType)
	if materialType == nil or itemId == nil then
		return nil
	end

	if materialType == MaterialEnum.MaterialType.SpecialBlock then
		local blockCfg = self:getBlock(itemId)

		if blockCfg then
			itemId = blockCfg.packageId
			materialType = MaterialEnum.MaterialType.BlockPackage
		end
	end

	return self._itemIdToRoomThemeId and self._itemIdToRoomThemeId[materialType] and self._itemIdToRoomThemeId[materialType][itemId]
end

function RoomConfig:getThemeCollectionRewards(themeId)
	return self._roomThemeCollectionBonusDic and self._roomThemeCollectionBonusDic[themeId]
end

function RoomConfig:getVehicleConfig(vehicleId)
	return self._roomVehicleConfig and self._roomVehicleConfig.configDict[vehicleId]
end

function RoomConfig:getVehicleConfigList()
	return self._roomVehicleConfig and self._roomVehicleConfig.configList
end

function RoomConfig:getSourcesTypeConfig(sourcesTypeId)
	return self._roomSourcesTypeConfig and self._roomSourcesTypeConfig[sourcesTypeId]
end

function RoomConfig:getCharacterAnimConfig(skinId, animName)
	return self._roomCharacterAnimConfig.configDict[skinId] and self._roomCharacterAnimConfig.configDict[skinId][animName]
end

function RoomConfig:getCharacterShadowConfig(skinId, animName)
	return self.roomCharacterShadowConfig and self.roomCharacterShadowConfig.configDict[skinId] and self.roomCharacterShadowConfig.configDict[skinId][animName]
end

function RoomConfig:getBlockPlacePositionCfgList()
	return self._blockPlacePositionConfig and self._blockPlacePositionConfig.configList
end

function RoomConfig:getAudioExtendConfig(audioExtendId)
	return self._roomAudioExtendConfig and self._roomAudioExtendConfig.configDict[audioExtendId]
end

function RoomConfig:getPlanCoverConfig(coverId)
	return self._roomLayoutPlanCoverConfig and self._roomLayoutPlanCoverConfig.configDict[coverId]
end

function RoomConfig:getPlanCoverConfigList()
	return self._roomLayoutPlanCoverConfig and self._roomLayoutPlanCoverConfig.configList
end

function RoomConfig:getSceneAmbientConfigList()
	return self._roomSceneAmbientConfig and self._roomSceneAmbientConfig.configList
end

function RoomConfig:getSceneAmbientConfig(ambientId)
	return self._roomSceneAmbientConfig and self._roomSceneAmbientConfig.configDict[ambientId]
end

function RoomConfig:getBuildingTypeCfg(buildingType, nilError)
	local cfg = lua_room_building_type.configDict[buildingType]

	if not cfg and nilError then
		logError(string.format("RoomConfig.getBuildingTypeCfg error, cfg is nil, buildingType:%s", buildingType))
	end

	return cfg
end

function RoomConfig:getBuildingTypeIcon(buildingType)
	local result
	local cfg = self:getBuildingTypeCfg(buildingType, true)

	return (cfg or nil) and cfg.icon
end

local function getRoomAtmosphereCfg(atmosphereId, nilError)
	local cfg = lua_room_atmosphere.configDict[atmosphereId]

	if not cfg and nilError then
		logError(string.format("RoomConfig.getRoomAtmosphereCfg error, cfg is nil, id:%s", atmosphereId))
	end

	return cfg
end

function RoomConfig:getAtmosphereCfg(atmosphereId)
	return getRoomAtmosphereCfg(atmosphereId, true)
end

function RoomConfig:getAtmosphereRelatedBuilding(atmosphereId)
	local cfg = getRoomAtmosphereCfg(atmosphereId, true)

	return (cfg or nil) and cfg.buildingId
end

function RoomConfig:getAtmosphereEffectIdList(atmosphereId)
	local cfg = getRoomAtmosphereCfg(atmosphereId, true)

	return (cfg or nil) and string.splitToNumber(cfg.effectSequence, "#")
end

function RoomConfig:getAtmosphereAllEffectPathList(atmosphereId)
	local result = {}
	local idList = self:getAtmosphereEffectIdList(atmosphereId)
	local residentEffect = self:getAtmosphereResidentEffect(atmosphereId)

	if residentEffect and residentEffect ~= 0 then
		idList[#idList + 1] = residentEffect
	end

	for _, effectId in ipairs(idList) do
		local path = self:getRoomEffectPath(effectId)

		if not GameResMgr.IsFromEditorDir then
			path = FightHelper.getEffectAbPath(path)
		end

		if not string.nilorempty(path) then
			result[#result + 1] = path
		end
	end

	return result
end

function RoomConfig:getAtmosphereResidentEffect(atmosphereId)
	local cfg = getRoomAtmosphereCfg(atmosphereId, true)

	return (cfg or nil) and cfg.residentEffect
end

function RoomConfig:getAtmosphereCyclesTimes(atmosphereId)
	local cfg = getRoomAtmosphereCfg(atmosphereId, true)

	return (cfg or nil) and cfg.cyclesTimes
end

function RoomConfig:getAtmosphereOpenTime(atmosphereId)
	local result = 0
	local cfg = getRoomAtmosphereCfg(atmosphereId, true)

	if cfg then
		local strDateTime = cfg.openTime

		result = TimeUtil.stringToTimestamp(strDateTime)
	end

	return result
end

function RoomConfig:getAtmosphereDurationDay(atmosphereId)
	local cfg = getRoomAtmosphereCfg(atmosphereId, true)

	return (cfg or nil) and cfg.durationDay
end

function RoomConfig:getAtmosphereTriggerType(atmosphereId)
	local cfg = getRoomAtmosphereCfg(atmosphereId, true)

	return (cfg or nil) and cfg.triggerType
end

function RoomConfig:getBuildingAtmospheres(buildingId)
	local result = {}

	result = self._building2AtmosphereIds and self._building2AtmosphereIds[buildingId] or result

	return result
end

local function getRoomEffectCfg(effectId, nilError)
	local cfg = lua_room_effect.configDict[effectId]

	if not cfg and nilError then
		logError(string.format("RoomConfig.getRoomEffectCfg error, cfg is nil, id:%s", effectId))
	end

	return cfg
end

function RoomConfig:getRoomEffectPath(effectId)
	local result
	local cfg = getRoomEffectCfg(effectId, true)

	return (cfg or nil) and cfg.resPath
end

function RoomConfig:getRoomEffectDuration(effectId)
	local cfg = getRoomEffectCfg(effectId, true)

	return (cfg or nil) and cfg.duration
end

function RoomConfig:getRoomEffectAudioId(effectId)
	local result
	local cfg = getRoomEffectCfg(effectId, true)

	return (cfg or nil) and cfg.audioId
end

local function getRoomWaterReformCfg(waterType, nilError)
	local cfg = lua_room_water_reform.configDict[waterType]

	if not cfg and nilError then
		logError(string.format("RoomConfig.getRoomWaterReformCfg error, cfg is nil, id:%s", waterType))
	end

	return cfg
end

function RoomConfig:getWaterReformTypeList()
	local result = {}

	if lua_room_water_reform and lua_room_water_reform.configList then
		for _, cfg in ipairs(lua_room_water_reform.configList) do
			result[#result + 1] = cfg.blockType
		end
	end

	return result
end

function RoomConfig:getWaterReformTypeBlockId(waterType)
	local result
	local cfg = getRoomWaterReformCfg(waterType, true)

	return (cfg or nil) and cfg.blockId
end

function RoomConfig:getWaterReformTypeBlockCfg(waterType)
	local result
	local blockId = self:getWaterReformTypeBlockId(waterType)

	if blockId then
		result = self:getBlock(blockId)
		result = result or {
			mainRes = 0,
			blockId = blockId,
			defineWaterType = waterType,
			defineId = RoomBlockEnum.WaterReformCommonDefineId
		}
	end

	return result
end

function RoomConfig:getWaterReformItemId(waterType)
	local cfg = getRoomWaterReformCfg(waterType, true)

	if cfg then
		if not cfg.itemId then
			return 0
		end
	end
end

function RoomConfig:getWaterTypeByBlockId(blockId)
	if not self._blockId2WaterReformTypeDict then
		self:_initBlockId2WaterReformTypeDict()
	end

	return self._blockId2WaterReformTypeDict[blockId]
end

function RoomConfig:_initBlockId2WaterReformTypeDict()
	self._blockId2WaterReformTypeDict = {}

	for _, cfg in ipairs(lua_room_water_reform.configList) do
		self._blockId2WaterReformTypeDict[cfg.blockId] = cfg.blockType
	end
end

local function getBlockColorReformCfg(blockColor, nilError)
	local cfg = lua_room_block_color.configDict[blockColor]

	if not cfg and nilError then
		logError(string.format("RoomConfig.getBlockColorReformCfg error, cfg is nil, id:%s", blockColor))
	end

	return cfg
end

local function _sortBlockColor(aBlockColor, bBlockColor)
	return aBlockColor < bBlockColor
end

function RoomConfig:getBlockColorReformList()
	if not self._blockColorReformList then
		self._blockColorReformList = {}

		if lua_room_block_color and lua_room_block_color.configList then
			for _, cfg in ipairs(lua_room_block_color.configList) do
				self._blockColorReformList[#self._blockColorReformList + 1] = cfg.blockColor
			end

			table.sort(self._blockColorReformList, _sortBlockColor)
		end
	end

	return self._blockColorReformList
end

function RoomConfig:getBlockColorReformBlockId(blockColor)
	local result
	local cfg = getBlockColorReformCfg(blockColor, true)

	return (cfg or nil) and cfg.blockId
end

function RoomConfig:getBlockColorReformBlockCfg(blockColor)
	local result
	local blockId = self:getBlockColorReformBlockId(blockColor)

	if blockId then
		result = self:getBlock(blockId)
		result = result or {
			mainRes = 0,
			blockId = blockId,
			blockColor = blockColor,
			defineId = RoomBlockEnum.BlockColorReformCommonDefineId
		}
	end

	return result
end

function RoomConfig:getBlockColorReformVoucherId(blockColor)
	local cfg = getBlockColorReformCfg(blockColor, true)

	if cfg then
		if not cfg.voucherId then
			return 0
		end
	end
end

function RoomConfig:getBlockColorByBlockId(blockId)
	if not self._blockId2BlockColorDict then
		self:_initBlockId2BlockColorDict()
	end

	return self._blockId2BlockColorDict[blockId]
end

function RoomConfig:_initBlockId2BlockColorDict()
	self._blockId2BlockColorDict = {}

	for _, cfg in ipairs(lua_room_block_color.configList) do
		self._blockId2BlockColorDict[cfg.blockId] = cfg.blockColor
	end
end

local function getRoomSkinCfg(skinId, nilError)
	local cfg = lua_room_skin.configDict[skinId]

	if not cfg and nilError then
		logError(string.format("RoomConfig.getRoomSkinCfg error, cfg is nil, id:%s", skinId))
	end

	return cfg
end

function RoomConfig:getAllSkinIdList()
	local result = {}

	if lua_room_skin and lua_room_skin.configList then
		for _, cfg in ipairs(lua_room_skin.configList) do
			result[#result + 1] = cfg.id
		end
	end

	return result
end

function RoomConfig:getSkinIdList(partId)
	if partId then
		::label_127_0::

		local var_127_0 = self._roomType2SkinsDict

		if self._roomType2SkinsDict then
			local skinList = self._roomType2SkinsDict[partId]

			return (skinList or nil) and tabletool.copy(skinList)
		end
	end
end

function RoomConfig:getBelongPart(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.type
end

function RoomConfig:getRoomSkinUnlockItemId(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.itemId
end

function RoomConfig:getRoomSkinName(skinId)
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.name
end

function RoomConfig:getRoomSkinActId(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.activity
end

function RoomConfig:getRoomSkinIcon(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.icon
end

function RoomConfig:getRoomSkinDesc(skinId)
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.desc
end

function RoomConfig:getRoomSkinBannerIcon(skinId)
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.bannerIcon
end

function RoomConfig:getRoomSkinRare(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.rare
end

function RoomConfig:getRoomSkinPriority(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.priority
end

function RoomConfig:getRoomSkinModelPath(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.model
end

function RoomConfig:getRoomSkinEquipEffPos(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.equipEffPos
end

function RoomConfig:getRoomSkinEquipEffSize(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.equipEffSize
end

function RoomConfig:getRoomSkinSources(skinId)
	local result
	local cfg = getRoomSkinCfg(skinId, true)

	return (cfg or nil) and cfg.sources
end

RoomConfig.instance = RoomConfig.New()

return RoomConfig
