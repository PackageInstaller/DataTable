-- chunkname: @modules/logic/sp01/assassin2/config/AssassinConfig.lua

module("modules.logic.sp01.assassin2.config.AssassinConfig", package.seeall)

local AssassinConfig = class("AssassinConfig", BaseConfig)

function AssassinConfig:reqConfigNames()
	return {
		"assassin_const",
		"assassin_library",
		"assassin_building",
		"assassin_map",
		"assassin_quest_type",
		"assassin_quest",
		"assassin_item",
		"assassin_career",
		"assassin_hero_trial",
		"assassin_career_skill_mapping",
		"assassin_stealth_const",
		"assassin_stealth_map",
		"assassin_stealth_map_grid",
		"assassin_stealth_map_grid_type",
		"assassin_stealth_map_wall",
		"assassin_stealth_map_point_comp_type",
		"assassin_stealth_mission",
		"assassin_act",
		"assassin_interactive",
		"assassin_stealth_refresh",
		"assassin_monster_group",
		"assassin_monster",
		"assassin_random",
		"assassin_buff",
		"assassin_trap",
		"assassin_task",
		"assassin_effect",
		"stealth_technique"
	}
end

function AssassinConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function AssassinConfig:assassin_constConfigLoaded(configTable)
	self._pointPosList = {}
	self._gridMaxPointCount = nil

	local cfg = configTable.configDict[AssassinEnum.ConstId.StealthGameGridPoint]

	if cfg then
		local allPointList = GameUtil.splitString2(cfg.value, true)

		for i, pos in ipairs(allPointList) do
			self._pointPosList[i] = {
				x = pos[1],
				y = pos[2]
			}
		end
	end

	self._gridMaxPointCount = #self._pointPosList
end

function AssassinConfig:assassin_buildingConfigLoaded(configTable)
	self._typeBuildingDict = {}
	self._buidlingEffectDict = {}
	self._buildingLvCostDict = {}

	for _, buildingCo in ipairs(configTable.configList) do
		local type = buildingCo.type
		local lv = buildingCo.level

		self._typeBuildingDict[type] = self._typeBuildingDict[type] or {}
		self._typeBuildingDict[type][lv] = buildingCo
	end
end

local function checkDictTable(refDict, key)
	local table = refDict[key]

	if not table then
		table = {}
		refDict[key] = table
	end

	return table
end

function AssassinConfig:assassin_questConfigLoaded(configTable)
	self._mapId2QuestCfgDict = {}
	self._episode2QuestDict = {}

	for _, questCo in ipairs(configTable.configList) do
		local mapId = questCo.mapId
		local questList = checkDictTable(self._mapId2QuestCfgDict, mapId)

		table.insert(questList, questCo)

		if questCo.type == AssassinEnum.QuestType.Fight then
			self._episode2QuestDict[tonumber(questCo.param)] = questCo.id
		end
	end
end

function AssassinConfig:assassin_libraryConfigLoaded(configTable)
	self._actLibraryDict = {}
	self._libraryTypeDict = {}
	self._libraryActIdList = {}

	for _, libraryCo in ipairs(configTable.configList) do
		local actId = libraryCo.activityId
		local libType = libraryCo.type
		local actLibraryDict = self._actLibraryDict[actId]

		if not actLibraryDict then
			actLibraryDict = {}
			self._actLibraryDict[actId] = actLibraryDict
			self._libraryTypeDict[actId] = {}

			table.insert(self._libraryActIdList, actId)
		end

		local libTypeCoList = actLibraryDict[libType]

		if not libTypeCoList then
			libTypeCoList = {}
			actLibraryDict[libType] = libTypeCoList

			table.insert(self._libraryTypeDict[actId], libType)
		end

		table.insert(libTypeCoList, libraryCo)
	end

	for _, typeList in pairs(self._libraryTypeDict) do
		table.sort(typeList, function(aType, bType)
			return aType < bType
		end)
	end
end

function AssassinConfig:assassin_itemConfigLoaded(configTable)
	self._itemTypeDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local itemType = cfg.itemType
		local levelItemDict = checkDictTable(self._itemTypeDict, itemType)

		levelItemDict[cfg.level] = cfg.itemId
	end
end

function AssassinConfig:assassin_hero_trialConfigLoaded(configTable)
	self._quest2HeroIdDict = {}
	self._careerUnlockDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local career = cfg.career
		local heroList = checkDictTable(self._careerUnlockDict, career)

		heroList[#heroList + 1] = cfg.assassinHeroId

		if not string.nilorempty(cfg.unlock) then
			local params = string.split(cfg.unlock, "#")
			local questId = tonumber(params[2])

			self._quest2HeroIdDict[questId] = cfg.assassinHeroId
		end
	end
end

function AssassinConfig:assassin_career_skill_mappingConfigLoaded(configTable)
	self.heroCareerSkillDict = {}
	self.heroCareerPassiveSkillDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local assassinHeroId = cfg.assassinHeroId
		local careerId = cfg.careerId
		local heroSkillDict

		;(cfg.type == "Passive" and checkDictTable(self.heroCareerPassiveSkillDict, assassinHeroId) or checkDictTable(self.heroCareerSkillDict, assassinHeroId))[careerId] = cfg.id
	end
end

function AssassinConfig:assassin_stealth_map_gridConfigLoaded(configTable)
	self.mapGridPointDict = {}
	self.mapGridPointTypeShow = {}
	self.mapGridEntranceDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local mapId = cfg.mapId
		local gridId = cfg.gridId
		local point = cfg.point
		local pointShow = cfg.pointShow

		if not string.nilorempty(point) then
			local gridDict = checkDictTable(self.mapGridPointDict, mapId)
			local pointDict = {}

			gridDict[gridId] = pointDict

			local pointArr = string.split(point, "|")

			for _, pointStr in ipairs(pointArr) do
				local pointData = string.split(pointStr, "#")

				pointDict[tonumber(pointData[1])] = {
					pointType = tonumber(pointData[2]),
					pointParam = pointData[3]
				}
			end
		end

		if not string.nilorempty(pointShow) then
			local gridDict = checkDictTable(self.mapGridPointTypeShow, mapId)
			local pointShowDict = {}

			gridDict[gridId] = pointShowDict

			local pointShowArr = string.split(pointShow, "|")

			for _, pointShowStr in ipairs(pointShowArr) do
				local pointData = string.split(pointShowStr, "#")

				pointShowDict[tonumber(pointData[1])] = {
					showImg = pointData[2],
					rotation = tonumber(pointData[3])
				}
			end
		end

		local gridParam = cfg.gridParam

		if cfg.gridType == AssassinEnum.StealthGameGridType.Roof and not string.nilorempty(gridParam) then
			local stairList = checkDictTable(self.mapGridEntranceDict, mapId)
			local stairDirList = string.splitToNumber(gridParam, "#")

			for _, dir in ipairs(stairDirList) do
				stairList[#stairList + 1] = {
					gridId = gridId,
					dir = dir
				}
			end
		end
	end
end

function AssassinConfig:assassin_monster_groupConfigLoaded(configTable)
	self._enemyRefreshGroupDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local groupId = cfg.group
		local idList = self._enemyRefreshGroupDict[groupId]

		if not idList then
			idList = {}
			self._enemyRefreshGroupDict[groupId] = idList
		end

		idList[#idList + 1] = cfg
	end
end

function AssassinConfig:stealth_techniqueConfigLoaded(configTable)
	self._mapShowTechniqueDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local mapId = cfg.showInMap
		local idList = self._mapShowTechniqueDict[mapId]

		if not idList then
			idList = {}
			self._mapShowTechniqueDict[mapId] = idList
		end

		idList[#idList + 1] = cfg.id
	end
end

function AssassinConfig:getSkillPropTargetType(skillPropId, isSkill)
	local result

	return isSkill and self:getAssassinSkillTarget(skillPropId) or self:getAssassinItemTarget(skillPropId)
end

function AssassinConfig:getAssassinConstCfg(constId, nilError)
	local cfg = lua_assassin_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function AssassinConfig:getAssassinConst(constId, isToNumber)
	local result
	local cfg = self:getAssassinConstCfg(constId, true)

	if cfg then
		result = cfg.value

		if isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function AssassinConfig:getGridPointPosList()
	return self._pointPosList
end

function AssassinConfig:getGridMaxPointCount()
	return self._gridMaxPointCount
end

function AssassinConfig:getAssassinStealthConstCfg(constId, nilError)
	local cfg = lua_assassin_stealth_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinStealthConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function AssassinConfig:getAssassinStealthConst(constId, isToNumber)
	local result
	local cfg = self:getAssassinStealthConstCfg(constId, true)

	if cfg then
		result = cfg.value

		if isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function AssassinConfig:getMapCfg(mapId)
	local mapCo = lua_assassin_map.configDict[mapId]

	if not mapCo then
		logError(string.format("AssassinConfig:getMapCfg error, cfg is nil, mapId = %s", mapId))
	end

	return mapCo
end

function AssassinConfig:getMapIdList()
	local result = {}

	for _, cfg in ipairs(lua_assassin_map.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

function AssassinConfig:getMapTitle(mapId)
	local cfg = self:getMapCfg(mapId)

	return (cfg or nil) and (cfg.title or "")
end

function AssassinConfig:getMapBg(mapId)
	local cfg = self:getMapCfg(mapId)

	return cfg and cfg.bg
end

function AssassinConfig:getMapCenterPos(mapId)
	local x, y = 0, 0
	local cfg = self:getMapCfg(mapId)

	if cfg and not string.nilorempty(cfg.bgCenter) then
		local arr = string.splitToNumber(cfg.bgCenter, "#")

		x = arr[1] or x
		y = arr[2] or y
	end

	return x, y
end

function AssassinConfig:getQuestTypeCfg(questType)
	local questTypeCfg = lua_assassin_quest_type.configDict[questType]

	if not questTypeCfg then
		logError(string.format("AssassinConfig.getQuestTypeCfg error cfg is nil, type:%s", questType))
	end

	return questTypeCfg
end

function AssassinConfig:getQuestTypeList()
	local result = {}

	for _, cfg in ipairs(lua_assassin_quest_type.configList) do
		result[#result + 1] = cfg.type
	end

	return result
end

function AssassinConfig:getQuestTypeName(questType)
	local cfg = self:getQuestTypeCfg(questType)

	return (cfg or nil) and (cfg.name or "")
end

function AssassinConfig:getQuestTypeIcon(questType)
	local cfg = self:getQuestTypeCfg(questType)

	return cfg and cfg.icon
end

function AssassinConfig:getQuestCfg(questId)
	local questCo = lua_assassin_quest.configDict[questId]

	if not questCo then
		logError(string.format("AssassinConfig:getQuestCfg error, cfg is nil, questId = %s", questId))
	end

	return questCo
end

function AssassinConfig:getQuestListInMap(mapId, questType)
	local result = {}
	local questCfgList = self._mapId2QuestCfgDict[mapId]

	if questCfgList then
		for _, questCfg in ipairs(questCfgList) do
			if not questType then
				result[#result + 1] = questCfg
			elseif questType == questCfg.type then
				result[#result + 1] = questCfg
			end
		end
	else
		logError(string.format("AssassinConfig:getQuestListInMap, map not has quest, mapId = %s", mapId))
	end

	return result
end

function AssassinConfig:getQuestName(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.title
end

function AssassinConfig:getQuestDesc(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.desc
end

function AssassinConfig:getQuestPicture(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.picture
end

function AssassinConfig:getQuestMapId(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.mapId
end

function AssassinConfig:getQuestPos(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.position
end

function AssassinConfig:getQuestType(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.type
end

function AssassinConfig:getQuestParam(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.param
end

function AssassinConfig:getQuestDisplay(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.display
end

function AssassinConfig:getQuestRewardCount(questId)
	local cfg = self:getQuestCfg(questId)

	return cfg and cfg.rewardCount
end

function AssassinConfig:getQuestRecommendHeroList(questId)
	local cfg = self:getQuestCfg(questId)

	if cfg and not string.nilorempty(cfg.recommend) then
		return string.splitToNumber(cfg.recommend, "#")
	end
end

function AssassinConfig:getFightQuestId(episodeId)
	return self._episode2QuestDict[episodeId]
end

function AssassinConfig:getHeroCfgByAssassinHeroId(assassinHeroId)
	local config = self:getAssassinHeroCfg(assassinHeroId, true)
	local templateId = 0
	local trialCo = lua_hero_trial.configDict[config.model][templateId]

	if trialCo then
		return HeroConfig.instance:getHeroCO(trialCo.heroId)
	end
end

function AssassinConfig:getAssassinItemCfg(itemId, nilError)
	local cfg = lua_assassin_item.configDict[itemId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinItemCfg error, cfg is nil, itemId:%s", itemId))
	end

	return cfg
end

function AssassinConfig:getAssassinItemId(itemType, level)
	local result
	local levelItemDict = self._itemTypeDict[itemType]

	return (levelItemDict or nil) and levelItemDict[level]
end

function AssassinConfig:getAssassinItemType(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return cfg and cfg.itemType
end

function AssassinConfig:getAssassinItemLevel(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return cfg and cfg.level
end

function AssassinConfig:getAssassinItemName(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return cfg and cfg.name
end

function AssassinConfig:getAssassinItemIcon(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return cfg and cfg.icon
end

function AssassinConfig:getAssassinItemFightEffDesc(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return cfg and cfg.fightEffDesc
end

function AssassinConfig:getAssassinItemStealthEffDesc(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return cfg and cfg.stealthEffDesc
end

function AssassinConfig:getAssassinItemRoundLimit(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return (cfg or nil) and (cfg.roundLimit or 0)
end

function AssassinConfig:getAssassinItemCostPoint(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return (cfg or nil) and (cfg.costPoint or 0)
end

function AssassinConfig:getAssassinItemRange(itemId)
	local rangeType, range
	local cfg = self:getAssassinItemCfg(itemId, true)
	local strRange = cfg and cfg.range

	if not string.nilorempty(strRange) then
		local arr = string.split(strRange, "#")

		rangeType = arr[1]
		range = arr[2]
	end

	return rangeType, range
end

function AssassinConfig:getAssassinItemTargetCheck(itemId)
	local checkType, checkParam
	local cfg = self:getAssassinItemCfg(itemId, true)
	local strTargetCheck = cfg and cfg.targetCheck

	if not string.nilorempty(strTargetCheck) then
		local arr = string.splitToNumber(strTargetCheck, "#")

		checkType = arr[1]
		checkParam = arr[2]
	end

	return checkType, checkParam
end

function AssassinConfig:getAssassinItemTarget(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return cfg and cfg.target
end

function AssassinConfig:getAssassinItemTargetEff(itemId)
	local cfg = self:getAssassinItemCfg(itemId, true)

	return cfg and cfg.targetEff
end

function AssassinConfig:getAssassinCareerCfg(careerId, nilError)
	local cfg = lua_assassin_career.configDict[careerId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinCareerCfg error, cfg is nil, careerId:%s", careerId))
	end

	return cfg
end

function AssassinConfig:getAssassinCareerTitle(careerId)
	local cfg = self:getAssassinCareerCfg(careerId, true)

	return cfg and cfg.title
end

function AssassinConfig:getAssassinCareerEquipName(careerId)
	local cfg = self:getAssassinCareerCfg(careerId, true)

	return cfg and cfg.equipName
end

function AssassinConfig:getAssassinCareerCapacity(careerId)
	local cfg = self:getAssassinCareerCfg(careerId, true)

	return (cfg or nil) and (cfg.capacity or 0)
end

function AssassinConfig:getAssassinCareerAttrList(careerId)
	local result = {}
	local cfg = self:getAssassinCareerCfg(careerId, true)

	result = cfg and GameUtil.splitString2(cfg.attrs, true) or result

	return result
end

function AssassinConfig:getAssassinCareerEquipPic(careerId)
	local cfg = self:getAssassinCareerCfg(careerId, true)

	return cfg and cfg.pic
end

function AssassinConfig:getAssassinCareerUnlockNeedHeroList(careerId)
	if not self._careerUnlockDict[careerId] then
		return self._careerUnlockDict[careerId]
	end
end

function AssassinConfig:getAssassinHeroCfg(assassinHeroId, nilError)
	local cfg = lua_assassin_hero_trial.configDict[assassinHeroId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinHeroCfg error, cfg is nil, assassinHeroId:%s", assassinHeroId))
	end

	return cfg
end

function AssassinConfig:getAssassinHeroIdList()
	local result = {}

	for _, assassinHeroCfg in ipairs(lua_assassin_hero_trial.configList) do
		result[#result + 1] = assassinHeroCfg.assassinHeroId
	end

	return result
end

function AssassinConfig:getAssassinHeroCareerList(assassinHeroId)
	local result = {}
	local cfg = self:getAssassinHeroCfg(assassinHeroId, true)

	if cfg then
		result[#result + 1] = cfg.career

		if cfg.secondCareer and cfg.secondCareer ~= 0 then
			result[#result + 1] = cfg.secondCareer
		end
	end

	return result
end

function AssassinConfig:isAssassinHeroCanChangeToCareer(assassinHeroId, careerId)
	local cfg = self:getAssassinHeroCfg(assassinHeroId, true)

	return (cfg or nil) and (careerId == cfg.career or careerId == cfg.secondCareer)
end

function AssassinConfig:isAssassinHeroHasSecondCareer(assassinHeroId)
	local cfg = self:getAssassinHeroCfg(assassinHeroId, true)
	local secondCareer = cfg and cfg.secondCareer

	return not not (secondCareer and secondCareer ~= 0)
end

function AssassinConfig:getAssassinHeroImg(assassinHeroId)
	local cfg = self:getAssassinHeroCfg(assassinHeroId, true)

	return cfg and cfg.heroImg
end

function AssassinConfig:getAssassinHeroIcon(assassinHeroId)
	local cfg = self:getAssassinHeroCfg(assassinHeroId, true)

	return cfg and cfg.heroIcon
end

function AssassinConfig:getAssassinHeroEntityIcon(assassinHeroId)
	local cfg = self:getAssassinHeroCfg(assassinHeroId, true)

	return cfg and cfg.entityIcon
end

function AssassinConfig:getAssassinHeroTrialId(assassinHeroId)
	local cfg = self:getAssassinHeroCfg(assassinHeroId, true)

	return cfg and cfg.model
end

function AssassinConfig:getAssassinHeroTrialCfg(assassinHeroId, templateId)
	local trialId = self:getAssassinHeroTrialId(assassinHeroId)
	local cfg = lua_hero_trial.configDict[trialId][templateId or 0]

	if not cfg then
		logError(string.format("AssassinConfig:getAssassinHeroTrialCfg error, cfg is nil, assassinHeroId:%s trialId:%s", assassinHeroId, trialId))
	end

	return cfg
end

function AssassinConfig:getUnlockHeroId(questId)
	return self._quest2HeroIdDict[questId]
end

function AssassinConfig:getAssassinCareerSkillCfg(skillId, nilError)
	local cfg = lua_assassin_career_skill_mapping.configDict[skillId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinCareerSkillCfg error, cfg is nil, skillId:%s", skillId))
	end

	return cfg
end

function AssassinConfig:getAssassinSkillIdByHeroCareer(assassinHeroId, careerId)
	local result = self:getAssassinActiveSkillIdByHeroCareer(assassinHeroId, careerId)

	result = result or self:getAssassinPassiveSkillIdByHeroCareer(assassinHeroId, careerId)

	return result
end

function AssassinConfig:getAssassinActiveSkillIdByHeroCareer(assassinHeroId, careerId)
	local result

	if self.heroCareerSkillDict then
		return (self.heroCareerSkillDict or nil) and self.heroCareerSkillDict[careerId]
	end
end

function AssassinConfig:getAssassinPassiveSkillIdByHeroCareer(assassinHeroId, careerId)
	local result

	if self.heroCareerPassiveSkillDict then
		return (self.heroCareerPassiveSkillDict or nil) and self.heroCareerPassiveSkillDict[careerId]
	end
end

function AssassinConfig:getAssassinSkillName(skillId)
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)

	return cfg and cfg.name
end

function AssassinConfig:getAssassinSkillIcon(skillId)
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)

	return cfg and cfg.icon
end

function AssassinConfig:getAssassinCareerSkillDesc(skillId)
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)

	return cfg and cfg.desc
end

function AssassinConfig:getIsStealthGameSkill(skillId)
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)
	local strCost = cfg and cfg.cost

	return not string.nilorempty(strCost)
end

function AssassinConfig:getAssassinSkillCost(skillId)
	local costType, cost
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)
	local strCost = cfg and cfg.cost

	if not string.nilorempty(strCost) then
		local costArr = string.split(strCost, "#")

		costType = costArr[1]
		cost = tonumber(costArr[2])
	end

	return costType, cost
end

function AssassinConfig:getAssassinSkillRange(skillId)
	local rangeType, range
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)
	local strRange = cfg and cfg.range

	if not string.nilorempty(strRange) then
		local arr = string.split(strRange, "#")

		rangeType = arr[1]
		range = arr[2]
	end

	return rangeType, range
end

function AssassinConfig:getAssassinSkillTargetCheck(skillId)
	local checkType, checkParam
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)
	local strTargetCheck = cfg and cfg.targetCheck

	if not string.nilorempty(strTargetCheck) then
		local arr = string.splitToNumber(strTargetCheck, "#")

		checkType = arr[1]
		checkParam = arr[2]
	end

	return checkType, checkParam
end

function AssassinConfig:getAssassinSkillTarget(skillId)
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)

	return cfg and cfg.target
end

function AssassinConfig:getAssassinSkillRoundLimit(skillId)
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)

	return cfg and cfg.roundLimit
end

function AssassinConfig:getAssassinSkillTimesLimit(skillId)
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)

	return cfg and cfg.timesLimit
end

function AssassinConfig:getAssassinSkillTargetEff(skillId)
	local cfg = self:getAssassinCareerSkillCfg(skillId, true)

	return cfg and cfg.targetEff
end

function AssassinConfig:getStealthMapCfg(mapId, nilError)
	local cfg = lua_assassin_stealth_map.configDict[mapId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getStealthMapCfg error, cfg is nil, mapId:%s", mapId))
	end

	return cfg
end

function AssassinConfig:getStealthMapTitle(mapId)
	local cfg = self:getStealthMapCfg(mapId, true)

	return cfg and cfg.title
end

function AssassinConfig:getStealthMapNeedHeroCount(mapId)
	local cfg = self:getStealthMapCfg(mapId, true)

	return (cfg or nil) and (cfg.player or 0)
end

function AssassinConfig:getStealthMapMission(mapId)
	local cfg = self:getStealthMapCfg(mapId, true)

	return cfg and cfg.mission
end

function AssassinConfig:getStealthMapForbidScaleGuide(mapId)
	local guideId, step
	local cfg = self:getStealthMapCfg(mapId, true)

	if cfg then
		local temp = string.splitToNumber(cfg.forbidScaleGuide, "#")

		guideId = temp[1]
		step = temp[2]
	end

	return guideId, step
end

function AssassinConfig:getStealthGameMapGridCfg(mapId, gridId, nilError)
	if lua_assassin_stealth_map_grid.configDict[mapId] then
		if not lua_assassin_stealth_map_grid.configDict[mapId] and nilError then
			logError(string.format("AssassinConfig:getStealthGameMapGridCfg error, cfg is nil, mapId:%s, gridId:%s", mapId, gridId))
		end

		return lua_assassin_stealth_map_grid.configDict[mapId]
	end
end

function AssassinConfig:getStealthGameMapGridList(mapId)
	local result = {}

	if lua_assassin_stealth_map_grid then
		if lua_assassin_stealth_map_grid then
			for gridId, _ in pairs(lua_assassin_stealth_map_grid) do
				result[#result + 1] = gridId
			end
		end

		return result
	end
end

function AssassinConfig:getStealthGameMapTowerGridList(mapId)
	local result = {}

	if lua_assassin_stealth_map_grid then
		if lua_assassin_stealth_map_grid then
			for gridId, _ in pairs(lua_assassin_stealth_map_grid) do
				local pointType = self:getGridPointType(mapId, gridId, AssassinEnum.TowerPointIndex.RightTop)

				if pointType == AssassinEnum.StealthGamePointType.Tower then
					result[#result + 1] = gridId
				end
			end
		end

		return result
	end
end

function AssassinConfig:isShowGrid(mapId, gridId)
	local cfg = self:getStealthGameMapGridCfg(mapId, gridId)

	return not not cfg
end

function AssassinConfig:getGridType(mapId, gridId)
	local cfg = self:getStealthGameMapGridCfg(mapId, gridId, true)

	return cfg and cfg.gridType
end

function AssassinConfig:getGridParam(mapId, gridId)
	local cfg = self:getStealthGameMapGridCfg(mapId, gridId, true)

	return cfg and cfg.gridParam
end

function AssassinConfig:getGridIsEasyExpose(mapId, gridId)
	local cfg = self:getStealthGameMapGridCfg(mapId, gridId, true)

	return cfg and cfg.easyExplore
end

function AssassinConfig:getGridPointType(mapId, gridId, pointIndex)
	local result
	local isShowGrid = self:isShowGrid(mapId, gridId)

	if isShowGrid then
		result = AssassinEnum.StealthGamePointType.Empty

		local mapDict = self.mapGridPointDict[mapId]
		local gridDict = mapDict and mapDict[gridId]
		local pointData = gridDict and gridDict[pointIndex]

		if pointData then
			result = pointData.pointType
		end
	else
		logError(string.format("AssassinConfig:getGridPointType error, map not has grid, map:%s gridId:%s", mapId, gridId))
	end

	return result
end

function AssassinConfig:getGridPointTypeParam(mapId, gridId, pointIndex)
	local result
	local mapDict = self.mapGridPointDict[mapId]
	local gridDict = mapDict and mapDict[gridId]
	local pointData = gridDict and gridDict[pointIndex]

	return (pointData or nil) and pointData.pointParam
end

function AssassinConfig:isGridHasPointType(mapId, gridId, pointType)
	local result = false
	local mapDict = self.mapGridPointDict[mapId]
	local gridDict = mapDict and mapDict[gridId]

	if gridDict then
		for _, pointData in pairs(gridDict) do
			if pointData.pointType == pointType then
				result = true

				break
			end
		end
	end

	return result
end

function AssassinConfig:getGridPos(mapId, gridId)
	local cfg = self:getStealthGameMapGridCfg(mapId, gridId, true)

	if cfg then
		return cfg.x, cfg.y
	end
end

function AssassinConfig:getTowerGridDict(mapId, gridId, pointIndex)
	local result = {}
	local pointType = self:getGridPointType(mapId, gridId, pointIndex)

	if pointType == AssassinEnum.StealthGamePointType.Tower then
		local param = self:getGridPointTypeParam(mapId, gridId, pointIndex)

		if not string.nilorempty(param) then
			local gridArr = string.split(param, ",")

			for _, strGridId in ipairs(gridArr) do
				result[tonumber(strGridId)] = true
			end
		end
	end

	return result
end

function AssassinConfig:getStealthGridImg(mapId, gridId)
	local cfg = self:getStealthGameMapGridCfg(mapId, gridId, true)

	return cfg and cfg.gridImg
end

function AssassinConfig:getStealthGridRotation(mapId, gridId)
	local cfg = self:getStealthGameMapGridCfg(mapId, gridId, true)

	return cfg and cfg.rotation
end

function AssassinConfig:getPointTypeShowData(mapId, gridId, pointIndex)
	local pointTypeIcon
	local rotation = 0
	local mapDict = self.mapGridPointTypeShow[mapId]
	local gridDict = mapDict and mapDict[gridId]
	local pointShowData = gridDict and gridDict[pointIndex]

	if pointShowData then
		pointTypeIcon = pointShowData.showImg
		rotation = pointShowData.rotation or 0
	end

	if string.nilorempty(pointTypeIcon) then
		local pointType = self:getGridPointType(mapId, gridId, pointIndex)

		pointTypeIcon = self:getPointTypeIcon(pointType)
	end

	return pointTypeIcon, rotation
end

function AssassinConfig:getMapStairList(mapId)
	return (self.mapGridEntranceDict or nil) and (self.mapGridEntranceDict[mapId] or {})
end

function AssassinConfig:getStealthGameMapWallCfg(mapId, wallId, nilError)
	if lua_assassin_stealth_map_wall.configDict[mapId] then
		if not lua_assassin_stealth_map_wall.configDict[mapId] and nilError then
			logError(string.format("AssassinConfig:getStealthGameMapWallCfg error, cfg is nil, mapId:%s, wallId:%s", mapId, wallId))
		end

		return lua_assassin_stealth_map_wall.configDict[mapId]
	end
end

function AssassinConfig:getStealthGameMapWallList(mapId, isHor)
	local result = {}

	if lua_assassin_stealth_map_wall then
		local mapDict = lua_assassin_stealth_map_wall.configDict[mapId]

		if mapDict then
			isHor = not not isHor

			for wallId, cfg in pairs(mapDict) do
				if cfg.isHor == isHor then
					result[#result + 1] = wallId
				end
			end
		end

		return result
	end
end

function AssassinConfig:isShowWall(mapId, wallId)
	local cfg = self:getStealthGameMapWallCfg(mapId, wallId)

	return not not cfg
end

function AssassinConfig:getWallPos(mapId, wallId)
	local cfg = self:getStealthGameMapWallCfg(mapId, wallId, true)

	if cfg then
		return cfg.x, cfg.y
	end
end

function AssassinConfig:getStealthGameMapGridTypeCfg(gridType, nilError)
	local cfg = lua_assassin_stealth_map_grid_type.configDict[gridType]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getStealthGameMapGridTypeCfg error, cfg is nil, gridType:%s", gridType))
	end

	return cfg
end

function AssassinConfig:getStealthGameMapGridTypeName(gridType)
	local cfg = self:getStealthGameMapGridTypeCfg(gridType, true)

	return cfg and cfg.name
end

function AssassinConfig:getStealthGameMapGridTypeIcon(gridType)
	local cfg = self:getStealthGameMapGridTypeCfg(gridType, true)

	return cfg and cfg.icon
end

function AssassinConfig:getStealthGameMapPointTypeCfg(pointType, nilError)
	local cfg = lua_assassin_stealth_map_point_comp_type.configDict[pointType]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getStealthGameMapPointTypeCfg error, cfg is nil, pointType:%s", pointType))
	end

	return cfg
end

function AssassinConfig:getPointTypeName(pointType)
	local cfg = self:getStealthGameMapPointTypeCfg(pointType, true)

	return cfg and cfg.name
end

function AssassinConfig:getPointTypeIcon(pointType)
	local cfg = self:getStealthGameMapPointTypeCfg(pointType, true)

	return cfg and cfg.icon
end

function AssassinConfig:getPointTypeSmallIcon(pointType)
	local cfg = self:getStealthGameMapPointTypeCfg(pointType, true)

	return cfg and cfg.smallIcon
end

function AssassinConfig:getStealthMissionCfg(missionId, nilError)
	local cfg = lua_assassin_stealth_mission.configDict[missionId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getStealthMissionCfg error, cfg is nil, missionId:%s", missionId))
	end

	return cfg
end

function AssassinConfig:getStealthMissionDesc(missionId)
	local cfg = self:getStealthMissionCfg(missionId, true)

	return cfg and cfg.desc
end

function AssassinConfig:getStealthMissionRefresh(missionId)
	local cfg = self:getStealthMissionCfg(missionId, true)

	if cfg then
		return cfg.refresh1, cfg.refresh2
	end
end

function AssassinConfig:getStealthMissionType(missionId)
	local cfg = self:getStealthMissionCfg(missionId, true)

	return cfg and cfg.type
end

function AssassinConfig:getStealthMissionParam(missionId, toNumber)
	local result
	local cfg = self:getStealthMissionCfg(missionId, true)

	result = cfg and cfg.param

	if toNumber then
		result = string.splitToNumber(result, "#")
	end

	return result
end

function AssassinConfig:getTargetEnemies(missionId)
	local result

	if missionId and missionId ~= 0 then
		local missionType = self:getStealthMissionType(missionId)

		if missionType == AssassinEnum.MissionType.TargetEnemy then
			result = self:getStealthMissionParam(missionId, true)
		end
	end

	return result
end

function AssassinConfig:getEnemyRefreshCfg(refreshId, nilError)
	local cfg = lua_assassin_stealth_refresh.configDict[refreshId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getEnemyRefreshCfg error, cfg is nil, refreshId:%s", refreshId))
	end

	return cfg
end

function AssassinConfig:getEnemyRefreshPositionList(refreshId)
	local cfg = self:getEnemyRefreshCfg(refreshId)
	local strPosition = cfg and cfg.position1

	return (not string.nilorempty(strPosition) or nil) and GameUtil.splitString2(strPosition, true)
end

function AssassinConfig:getEnemyRefreshData(argsRefreshId, argsGridId)
	if not self._enemyRefreshIndexDict then
		self._enemyRefreshIndexDict = {}

		for _, cfg in ipairs(lua_assassin_stealth_refresh.configList) do
			local refreshId = cfg.id
			local strPosition = cfg.position1

			if not string.nilorempty(strPosition) then
				local dict = checkDictTable(self._enemyRefreshIndexDict, refreshId)
				local pointArr = GameUtil.splitString2(strPosition, true)

				for i, point in ipairs(pointArr) do
					dict[point[1]] = {
						index = i,
						enemy = point[2]
					}
				end
			end
		end
	end

	local refreshDict = self._enemyRefreshIndexDict[argsRefreshId]

	return refreshDict and refreshDict[argsGridId]
end

function AssassinConfig:getEnemyGroupCfg(id, nilError)
	local cfg = lua_assassin_monster_group.configDict[id]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getEnemyGroupCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function AssassinConfig:getEnemyListInGroup(groupId)
	local result = {}

	if self._enemyRefreshGroupDict then
		if self._enemyRefreshGroupDict then
			for _, cfg in ipairs(self._enemyRefreshGroupDict) do
				local strEnemy = cfg and cfg.monster

				if not string.nilorempty(strEnemy) then
					local enemyList = string.splitToNumber(strEnemy, "#")

					tabletool.addValues(result, enemyList)
				end
			end
		end

		return result
	end
end

function AssassinConfig:getAssassinActCfg(actId, nilError)
	local cfg = lua_assassin_act.configDict[actId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinActCfg error, cfg is nil, actId:%s", actId))
	end

	return cfg
end

function AssassinConfig:getAssassinActName(actId)
	local cfg = self:getAssassinActCfg(actId, true)

	return cfg and cfg.name
end

function AssassinConfig:getAssassinActIcon(actId)
	local cfg = self:getAssassinActCfg(actId)

	return cfg and cfg.icon
end

function AssassinConfig:getAssassinActShowImg(actId)
	local cfg = self:getAssassinActCfg(actId, true)

	return cfg and cfg.showImg
end

function AssassinConfig:getAssassinActPower(actId)
	local cfg = self:getAssassinActCfg(actId, true)

	return cfg and cfg.power
end

function AssassinConfig:getAssassinActEffect(actId)
	local cfg = self:getAssassinActCfg(actId, true)

	if cfg then
		return cfg.effectId, cfg.targetEffectId
	end
end

function AssassinConfig:getAssassinActAudioId(actId)
	local cfg = self:getAssassinActCfg(actId, true)

	return cfg and cfg.audioId
end

function AssassinConfig:getAssassinInteractCfg(interactId, nilError)
	local cfg = lua_assassin_interactive.configDict[interactId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinInteractCfg error, cfg is nil, interactId:%s", interactId))
	end

	return cfg
end

function AssassinConfig:getInteractGridId(interactId)
	local cfg = self:getAssassinInteractCfg(interactId, true)

	return cfg and cfg.gridId
end

function AssassinConfig:getInteractApCost(interactId)
	local cfg = self:getAssassinInteractCfg(interactId, true)

	return cfg and cfg.costPoint
end

function AssassinConfig:getAssassinRandomEventCfg(eventId, nilError)
	local cfg = lua_assassin_random.configDict[eventId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinRandomEventCfg error, cfg is nil, eventId:%s", eventId))
	end

	return cfg
end

function AssassinConfig:getEventType(eventId)
	local cfg = self:getAssassinRandomEventCfg(eventId, true)

	return cfg and cfg.type
end

function AssassinConfig:getEventParam(eventId)
	local cfg = self:getAssassinRandomEventCfg(eventId, true)

	return cfg and cfg.param
end

function AssassinConfig:getEventName(eventId)
	local cfg = self:getAssassinRandomEventCfg(eventId, true)

	return cfg and cfg.name
end

function AssassinConfig:getEventImg(eventId)
	local cfg = self:getAssassinRandomEventCfg(eventId, true)

	return cfg and cfg.img
end

function AssassinConfig:getEventDesc(eventId)
	local cfg = self:getAssassinRandomEventCfg(eventId, true)

	return cfg and cfg.desc
end

function AssassinConfig:getAssassinBuffCfg(buffId, nilError)
	local cfg = lua_assassin_buff.configDict[buffId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinBuffCfg error, cfg is nil, buffId:%s", buffId))
	end

	return cfg
end

function AssassinConfig:getBuffIdList()
	if not self._buffIdList then
		self._buffIdList = {}

		for _, cfg in ipairs(lua_assassin_buff.configList) do
			self._buffIdList[#self._buffIdList + 1] = cfg.buffId
		end
	end

	return self._buffIdList
end

function AssassinConfig:getAssassinBuffType(buffId)
	local cfg = self:getAssassinBuffCfg(buffId, true)

	return cfg and cfg.type
end

function AssassinConfig:getAssassinBuffEffectId(buffId)
	local cfg = self:getAssassinBuffCfg(buffId, true)

	return cfg and cfg.effectId
end

function AssassinConfig:getAssassinTrapCfg(trapId, nilError)
	local cfg = lua_assassin_trap.configDict[trapId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinTrapCfg error, cfg is nil, trapId:%s", trapId))
	end

	return cfg
end

function AssassinConfig:getTrapIdList()
	if not self._trapIdList then
		self._trapIdList = {}

		for _, cfg in ipairs(lua_assassin_trap.configList) do
			self._trapIdList[#self._trapIdList + 1] = cfg.trapId
		end
	end

	return self._trapIdList
end

function AssassinConfig:getTrapTypeList()
	if not self._trapTypeDict then
		self._trapTypeDict = {}

		for _, cfg in ipairs(lua_assassin_trap.configList) do
			self._trapTypeDict[cfg.type] = self._trapTypeDict[cfg.type] or {}

			table.insert(self._trapTypeDict[cfg.type], cfg.trapId)
		end
	end

	return self._trapTypeDict
end

function AssassinConfig:getAssassinTrapType(trapId)
	local cfg = self:getAssassinTrapCfg(trapId, true)

	return cfg and cfg.type
end

function AssassinConfig:getAssassinTrapEffectId(trapId)
	local cfg = self:getAssassinTrapCfg(trapId, true)

	return cfg and cfg.effectId
end

function AssassinConfig:getAssassinEffectCfg(effectId, nilError)
	local cfg = lua_assassin_effect.configDict[effectId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinEffectCfg error, cfg is nil, effectId:%s", effectId))
	end

	return cfg
end

function AssassinConfig:getAssassinEffectResName(effectId)
	local cfg = self:getAssassinEffectCfg(effectId, true)

	return cfg and cfg.resName
end

function AssassinConfig:getAssassinEffectDuration(effectId)
	local cfg = self:getAssassinEffectCfg(effectId, true)

	return cfg and cfg.duration
end

function AssassinConfig:getAssassinEffectAudioId(effectId)
	local cfg = self:getAssassinEffectCfg(effectId, true)

	return cfg and cfg.audioId
end

function AssassinConfig:getStealthTechniqueCfg(techniqueId, nilError)
	local cfg = lua_stealth_technique.configDict[techniqueId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getStealthTechniqueCfg error, cfg is nil, techniqueId:%s", techniqueId))
	end

	return cfg
end

function AssassinConfig:getStealthTechniqueMainTitleId(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId, true)

	return cfg and cfg.mainTitleId
end

function AssassinConfig:getStealthTechniqueSubTitleId(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId, true)

	return cfg and cfg.subTitleId
end

function AssassinConfig:getStealthTechniqueMainTitle(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId, true)

	return cfg and cfg.mainTitle
end

function AssassinConfig:getStealthTechniqueSubTitle(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId, true)

	return cfg and cfg.subTitle
end

function AssassinConfig:getStealthTechniquePicture(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId, true)

	return cfg and cfg.picture
end

function AssassinConfig:getStealthTechniqueContent(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId, true)

	return cfg and cfg.content
end

function AssassinConfig:getTechniqueIdList()
	local result = {}

	for _, cfg in ipairs(lua_stealth_technique.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

function AssassinConfig:getMapShowTechniqueList(mapId)
	return self._mapShowTechniqueDict and self._mapShowTechniqueDict[mapId]
end

function AssassinConfig:getAssassinEnemyCfg(monsterId, nilError)
	local cfg = lua_assassin_monster.configDict[monsterId]

	if not cfg and nilError then
		logError(string.format("AssassinConfig:getAssassinEnemyCfg error, cfg is nil, monsterId:%s", monsterId))
	end

	return cfg
end

function AssassinConfig:getEnemyType(monsterId)
	local cfg = self:getAssassinEnemyCfg(monsterId, true)

	return cfg and cfg.type
end

function AssassinConfig:getEnemyScanRate(monsterId)
	local cfg = self:getAssassinEnemyCfg(monsterId, true)

	return cfg and cfg.scanRate
end

function AssassinConfig:getEnemyIsBoss(monsterId)
	local cfg = self:getAssassinEnemyCfg(monsterId, true)
	local boss = cfg and cfg.boss

	return boss ~= 0
end

function AssassinConfig:getEnemyIsNotMove(monsterId)
	local cfg = self:getAssassinEnemyCfg(monsterId, true)
	local notMove = cfg and cfg.notMove

	return notMove == AssassinEnum.EnemyMoveType.NotMove
end

function AssassinConfig:getEnemyHeadIcon(monsterId)
	local cfg = self:getAssassinEnemyCfg(monsterId, true)

	return cfg and cfg.icon
end

function AssassinConfig:getBuildingCo(buildingId)
	local buildingCo = lua_assassin_building.configDict[buildingId]

	if not buildingCo then
		logError(string.format("建筑配置不存在 buildingId = %s", buildingId))
	end

	return buildingCo
end

function AssassinConfig:getBuildingLvCo(buildingType, lv)
	local typeBuildingDict = self:getBuildingTypeDict(buildingType)
	local buildingCo = typeBuildingDict and typeBuildingDict[lv]

	if not buildingCo then
		logError(string.format("建筑配置不存在 buildingType = %s, lv = %s", buildingType, lv))
	end

	return buildingCo
end

function AssassinConfig:getBuildingMaxLv(buildingType)
	local typeBuildingDict = self:getBuildingTypeDict(buildingType)

	return typeBuildingDict and tabletool.len(typeBuildingDict) or 0
end

function AssassinConfig:getBuildingTypeDict(buildingType)
	local buildingTypeDict = self._typeBuildingDict[buildingType]

	if not buildingTypeDict then
		logError(string.format("建筑配置不存在 buildingType = %s", buildingType))
	end

	return buildingTypeDict
end

function AssassinConfig:getBuildingLvCostList(buildingType, lv)
	local buildingCo = self:getBuildingLvCo(buildingType, lv)

	if not buildingCo then
		return
	end

	local buildingId = buildingCo and buildingCo.id
	local costList = self._buildingLvCostDict[buildingId]

	if not costList then
		costList = GameUtil.splitString2(buildingCo.unlock, true)
		self._buidlingEffectDict[buildingId] = costList
	end

	return costList
end

function AssassinConfig:getLibrarConfig(libraryId)
	local libraryCo = lua_assassin_library.configDict[libraryId]

	if not libraryCo then
		logError(string.format("资料库配置不存在 libraryId = %s", libraryId))
	end

	return libraryCo
end

function AssassinConfig:getActLibraryConfigDict(actId)
	if self._actLibraryDict then
		if not self._actLibraryDict then
			logError(string.format("资料库配置不存在 actId = %s", actId))
		end

		return self._actLibraryDict
	end
end

function AssassinConfig:getLibraryConfigs(actId, libType)
	local actLibraryDict = self:getActLibraryConfigDict(actId)
	local libraryList = actLibraryDict and actLibraryDict[libType]

	if not libraryList then
		logError(string.format("资料库配置不存在 actId = %s, libType = %s", actId, libType))
	end

	return libraryList
end

function AssassinConfig:getLibraryActIdList()
	return self._libraryActIdList
end

function AssassinConfig:getActLibraryTypeList(actId)
	local libTypeList = self._libraryTypeDict[actId]

	if not libTypeList then
		logError(string.format("资料库大类中没有子类 actId = %s", actId))
	end

	return libTypeList
end

function AssassinConfig:getTaskCo(taskId)
	local taskCo = lua_assassin_task.configDict[taskId]

	if not taskCo then
		logError(string.format("任务配置不存在 taskId = %s", taskId))
	end

	return taskCo
end

AssassinConfig.instance = AssassinConfig.New()

return AssassinConfig
