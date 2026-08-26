-- chunkname: @modules/logic/dungeon/config/DungeonConfig.lua

module("modules.logic.dungeon.config.DungeonConfig", package.seeall)

local DungeonConfig = class("DungeonConfig", BaseConfig)

function DungeonConfig:ctor()
	self._chapterConfig = nil
	self._episodeConfig = nil
	self._bonusConfig = nil
	self._chapterEpisodeDict = nil
	self._chpaterNonSpEpisodeDict = nil
	self._episodeIndex = {}
	self._chapterListByType = {}
	self._lvConfig = nil
	self._interactConfig = nil
	self._colorConfig = nil
	self._dispatchConfig = nil
	self._rewardConfigDict = nil
end

function DungeonConfig:reqConfigNames()
	return {
		"chapter_map_element",
		"chapter_map",
		"story_element",
		"chapter",
		"episode",
		"bonus",
		"battle",
		"condition",
		"rule",
		"chapter_divide",
		"chapter_point_reward",
		"chapter_map_fragment",
		"chapter_map_element_dispatch",
		"chapter_map_element_dialog",
		"equip_chapter",
		"chapter_puzzle_question",
		"chapter_puzzle_square",
		"chapter_map_hole",
		"reward",
		"reward_group",
		"chapter_puzzle_changecolor",
		"chapter_puzzle_changecolor_interact",
		"chapter_puzzle_changecolor_color",
		"paper_trail"
	}
end

function DungeonConfig:onConfigLoaded(configName, configTable)
	if configName == "chapter" then
		self._chapterConfig = configTable

		self:_initChapterList()
	elseif configName == "episode" then
		self._episodeConfig = configTable

		self:_rebuildEpisodeConfigs()
		self:_initEpisodeList()
	elseif configName == "bonus" then
		self._bonusConfig = configTable
	elseif configName == "reward_group" then
		self._rewardConfigDict = {}

		for i, co in ipairs(configTable.configList) do
			self._rewardConfigDict[co.group] = self._rewardConfigDict[co.group] or {}

			table.insert(self._rewardConfigDict[co.group], co)
		end
	elseif configName == "chapter_divide" then
		self:_initChapterDivide()
	elseif configName == "chapter_point_reward" then
		self:_initChapterPointReward()
	elseif configName == "chapter_map_element" then
		self:_initElement()
	elseif configName == "chapter_map_element_dialog" then
		self:_initDialog()
	elseif configName == "chapter_map" then
		self:_initChapterMap()
	elseif configName == "chapter_puzzle_square" then
		self:_initPuzzleSquare(configTable)
	elseif configName == "chapter_puzzle_changecolor" then
		self._lvConfig = configTable
	elseif configName == "chapter_puzzle_changecolor_interact" then
		self._interactConfig = configTable
	elseif configName == "chapter_puzzle_changecolor_color" then
		self._colorConfig = configTable
	end
end

function DungeonConfig:_initElement()
	if self._elementFightList then
		return
	end

	self._elementFightList = {}
	self._mapGuidepostDict = {}
	self._mapIdToElements = {}
	self._v3a7TowerTypeElements = {}

	for i, v in ipairs(lua_chapter_map_element.configList) do
		if v.type == DungeonEnum.ElementType.Fight then
			local episodeId = tonumber(v.param)

			if self._elementFightList[episodeId] then
				logError(string.format("chapter_map_element.json element fight id:%s 参数：%s 重复配置了", v.id, episodeId))
			end

			if episodeId then
				self._elementFightList[episodeId] = v
			else
				logError(string.format("战斗元件id：%s,没有配参数：%s", v.id, v.param))
			end
		elseif v.type == DungeonEnum.ElementType.Guidepost then
			self._mapGuidepostDict[v.mapId] = v.id
		elseif v.type == DungeonEnum.ElementType.V3a7Tower then
			table.insert(self._v3a7TowerTypeElements, v)
		end

		local mapElementList = self._mapIdToElements[v.mapId]

		if not mapElementList then
			mapElementList = {}
			self._mapIdToElements[v.mapId] = mapElementList
		end

		if not DungeonEnum.ImplicitElementType[v.type] then
			table.insert(mapElementList, v)
		end
	end
end

function DungeonConfig:getMapElements(mapId)
	return self._mapIdToElements and self._mapIdToElements[mapId]
end

function DungeonConfig:getV3a7TowerTypeElements()
	return self._v3a7TowerTypeElements
end

function DungeonConfig:getMapElementByFragmentId(fragmentId)
	if not fragmentId then
		return
	end

	for _, mapElementCo in ipairs(lua_chapter_map_element.configList) do
		if mapElementCo.fragment == fragmentId then
			return mapElementCo
		end
	end
end

function DungeonConfig:getMapGuidepost(mapId)
	return self._mapGuidepostDict[mapId]
end

function DungeonConfig:getElementEpisode(episodeId)
	local config = self._elementFightList[episodeId]

	if not config then
		return nil
	end

	local mapId = config.mapId

	return self._chapterMapEpisodeDic[mapId]
end

function DungeonConfig:getEpisodeIdByMapId(mapId)
	return self._chapterMapEpisodeDic[mapId]
end

function DungeonConfig:getDispatchCfg(dispatchId)
	local cfg

	if dispatchId then
		cfg = lua_chapter_map_element_dispatch.configDict[dispatchId]
	end

	if not cfg then
		logError(string.format("DungeonConfig:getDispatchCfg error, cfg is nil, dispatchId: %s", dispatchId))
	end

	return cfg
end

function DungeonConfig:_initDialog()
	if self._dialogList then
		return
	end

	self._dialogList = {}

	local sectionId
	local defaultId = 0

	for i, v in ipairs(lua_chapter_map_element_dialog.configList) do
		local group = self._dialogList[v.id]

		if not group then
			group = {}
			sectionId = defaultId
			self._dialogList[v.id] = group
		end

		if v.type == "selector" then
			sectionId = v.param
		elseif v.type == "selectorend" then
			sectionId = defaultId
		else
			group[sectionId] = group[sectionId] or {}

			table.insert(group[sectionId], v)
		end
	end

	if SLFramework.FrameworkSettings.IsEditor then
		for i, v in ipairs(lua_chapter_map_element_dialog.configList) do
			if v.type == "options" then
				local optionList = string.split(rawget(v, 7), "#")
				local sectionIdList = string.split(v.param, "#")

				if #optionList ~= #sectionIdList then
					logError("_initDialog dialog config error, optionList and sectionIdList length not equal", v.id, v.stepId)
				end

				for j, sectionId in ipairs(sectionIdList) do
					local section = self:getDialog(v.id, sectionId)

					if not section then
						logError("_initDialog dialog config error, section not exist", v.id, v.stepId, sectionId)
					end
				end
			end
		end
	end
end

function DungeonConfig:getDialog(groupId, sectionId)
	local group = self._dialogList[groupId]

	return group and group[sectionId]
end

function DungeonConfig:_initChapterDivide()
	self._chapterDivide = {}

	for i, v in ipairs(lua_chapter_divide.configList) do
		for _, chapterId in ipairs(v.chapterId) do
			self._chapterDivide[chapterId] = v.sectionId
		end
	end
end

function DungeonConfig:getChapterDivideSectionId(chapterId)
	return self._chapterDivide[chapterId]
end

function DungeonConfig:_initChapterPointReward()
	if self._chapterPointReward then
		return
	end

	self._chapterPointReward = {}

	for i, v in ipairs(lua_chapter_point_reward.configList) do
		self._chapterPointReward[v.chapterId] = self._chapterPointReward[v.chapterId] or {}

		table.insert(self._chapterPointReward[v.chapterId], v)
	end
end

function DungeonConfig:getChapterPointReward(chapterId)
	return self._chapterPointReward[chapterId]
end

function DungeonConfig:_initChapterMap()
	if self._chapterMapList then
		return
	end

	self._chapterMapList = {}
	self._chapterMapEpisodeDic = {}

	for i, v in ipairs(lua_chapter_map.configList) do
		self._chapterMapList[v.chapterId] = self._chapterMapList[v.chapterId] or {}

		if string.nilorempty(v.unlockCondition) then
			self._chapterMapList[v.chapterId][0] = v
		else
			local episodeId = string.gsub(v.unlockCondition, "EpisodeFinish=", "")

			episodeId = tonumber(episodeId)
			self._chapterMapList[v.chapterId][episodeId] = v
		end
	end
end

function DungeonConfig:_mapConnectEpisode(episodeConfig)
	local chapterMapList = self._chapterMapList[episodeConfig.chapterId]

	if not chapterMapList then
		return
	end

	local isNewChapter = episodeConfig.preEpisode <= 0

	if not isNewChapter then
		local preEpisodeCfg = self:getEpisodeCO(episodeConfig.preEpisode)

		isNewChapter = preEpisodeCfg.chapterId ~= episodeConfig.chapterId
	end

	local episodeId = isNewChapter and 0 or episodeConfig.preEpisode2
	local mapConfig = chapterMapList[episodeId]

	if not mapConfig then
		return
	end

	self._chapterMapEpisodeDic[mapConfig.id] = episodeConfig.id
end

function DungeonConfig:getChapterMapCfg(chapterId, episodeId)
	local list = self._chapterMapList[chapterId]
	local value = list and list[episodeId]

	if value then
		return value
	end

	episodeId = self._backwardChainDict[episodeId]

	return list and list[episodeId]
end

function DungeonConfig:getEpisodeIdByMapCo(mapCo)
	if not self._chapterMapList then
		return
	end

	local chapterId = mapCo.chapterId
	local episodeId2MapDict = self._chapterMapList[chapterId]

	if not episodeId2MapDict then
		return
	end

	for episodeId, _ in pairs(episodeId2MapDict) do
		local getMapCo = self:getChapterMapCfg(chapterId, episodeId)

		if getMapCo and getMapCo.id == mapCo.id then
			local episodeList = self:getChapterEpisodeCOList(chapterId)

			for _, config in ipairs(episodeList) do
				if config.preEpisode == episodeId then
					return config.id
				end
			end
		end
	end
end

function DungeonConfig:getChapterMapElement(id)
	return lua_chapter_map_element.configDict[id]
end

function DungeonConfig:isDispatchElement(elementId)
	local elementCfg = elementId and self:getChapterMapElement(elementId)

	return (elementCfg or nil) and elementCfg.type == DungeonEnum.ElementType.Dispatch
end

function DungeonConfig:getElementDispatchId(elementId)
	local result
	local isDispatchElement = self:isDispatchElement(elementId)

	if isDispatchElement then
		local elementCfg = self:getChapterMapElement(elementId)

		result = elementCfg and elementCfg.param or nil
	end

	return tonumber(result)
end

function DungeonConfig:getHardEpisode(normalEpisodeId)
	if not self._normalHardMap then
		self._normalHardMap = {}

		for i, v in ipairs(lua_episode.configList) do
			local chapterCo = self:getChapterCO(v.chapterId)

			if chapterCo and chapterCo.type == DungeonEnum.ChapterType.Hard then
				self._normalHardMap[v.preEpisode] = v
			end
		end
	end

	return self._normalHardMap[normalEpisodeId]
end

function DungeonConfig:getNormalEpisodeId(episodeId)
	local episodeCo = self:getEpisodeCO(episodeId)
	local chapterCo = self:getChapterCO(episodeCo.chapterId)

	if chapterCo.type == DungeonEnum.ChapterType.Simple then
		return episodeCo.normalEpisodeId
	else
		self:getHardEpisode(episodeId)

		for normalId, hardCO in pairs(self._normalHardMap) do
			if hardCO.id == episodeId then
				return normalId
			end
		end
	end

	return episodeId
end

function DungeonConfig:getChapterCOList()
	return self._chapterConfig.configList
end

function DungeonConfig:getFirstChapterCO()
	return self:getChapterCOList()[1]
end

function DungeonConfig:getChapterCOListByType(type)
	if self._chapterListByType[type] then
		return self._chapterListByType[type]
	end

	local list = {}

	for i, v in ipairs(self:getChapterCOList()) do
		if v.type == type then
			table.insert(list, v)
		end
	end

	self._chapterListByType[type] = list

	return list
end

function DungeonConfig:getChapterIndex(type, chapterId)
	local list = self:getChapterCOListByType(type)

	if list then
		for i, v in ipairs(list) do
			if v.id == chapterId then
				if type == DungeonEnum.ChapterType.Simple then
					return i + 3, #list
				end

				return i, #list
			end
		end
	end

	return nil, nil
end

function DungeonConfig.episodeSortFunction(xEpisodeId, yEpisodeId)
	if not xEpisodeId and yEpisodeId then
		return true
	end

	if not yEpisodeId then
		return false
	end

	local xEpisodeConfig = DungeonConfig.instance:getEpisodeCO(xEpisodeId)
	local yEpisodeConfig = DungeonConfig.instance:getEpisodeCO(yEpisodeId)

	if not xEpisodeConfig or not yEpisodeConfig then
		return false
	end

	local xChapterId = xEpisodeConfig.chapterId
	local yChapterId = yEpisodeConfig.chapterId
	local xChapterConfig = DungeonConfig.instance:getChapterCO(xChapterId)
	local yChapterConfig = DungeonConfig.instance:getChapterCO(yChapterId)
	local xChapterType = xChapterConfig.type
	local yChapterType = yChapterConfig.type

	if (xChapterType == DungeonEnum.ChapterType.Normal or xChapterType == DungeonEnum.ChapterType.Hard) and (xChapterType == DungeonEnum.ChapterType.Normal or xChapterType == DungeonEnum.ChapterType.Hard) then
		local xChapterIndex = DungeonConfig.instance:getChapterIndex(xChapterType, xChapterId)
		local yChapterIndex = DungeonConfig.instance:getChapterIndex(yChapterType, yChapterId)

		if xChapterIndex ~= yChapterIndex then
			return xChapterIndex < yChapterIndex
		elseif xChapterType ~= yChapterType then
			return xChapterType == DungeonEnum.ChapterType.Normal
		else
			local xEpisodeIndex, xEpisodeType = DungeonConfig.instance:getChapterEpisodeIndexWithSP(xChapterId, xEpisodeId)
			local yEpisodeIndex, yEpisodeType = DungeonConfig.instance:getChapterEpisodeIndexWithSP(yChapterId, yEpisodeId)

			if xEpisodeType ~= DungeonEnum.EpisodeType.Sp and yEpisodeType == DungeonEnum.EpisodeType.Sp then
				return true
			else
				return xEpisodeIndex < yEpisodeIndex
			end
		end
	elseif xChapterType ~= yChapterType then
		return xChapterType < yChapterType
	else
		local xEpisodeIndex, xEpisodeType = DungeonConfig.instance:getChapterEpisodeIndexWithSP(xChapterId, xEpisodeId)
		local yEpisodeIndex, yEpisodeType = DungeonConfig.instance:getChapterEpisodeIndexWithSP(yChapterId, yEpisodeId)

		if xEpisodeType ~= DungeonEnum.EpisodeType.Sp and yEpisodeType == DungeonEnum.EpisodeType.Sp then
			return true
		else
			return xEpisodeIndex < yEpisodeIndex
		end
	end
end

function DungeonConfig:getChapterFrontSpNum(chapterId)
	local chapterCfg = self:getChapterCO(chapterId)
	local num = 0

	if chapterCfg and chapterCfg.preChapter > 0 then
		num = num + self:getChapterFrontSpNum(chapterCfg.preChapter)
		num = num + self:getChapterSpNum(chapterCfg.preChapter)
	end

	return num
end

function DungeonConfig:getChapterEpisodeIndexWithSP(chapterId, episodeId)
	local list = self:getChapterEpisodeCOList(chapterId)
	local spIndex = 0
	local nonSpIndex = 0
	local curIndex, type

	for i, config in ipairs(list) do
		local spType = config.type == DungeonEnum.EpisodeType.Sp

		type = config.type

		if spType then
			spIndex = spIndex + 1
			curIndex = spIndex
		else
			nonSpIndex = nonSpIndex + 1
			curIndex = nonSpIndex
		end

		if config.id == episodeId then
			break
		end
	end

	if type == DungeonEnum.EpisodeType.Sp then
		curIndex = curIndex + self:getChapterFrontSpNum(chapterId)
	end

	return curIndex, type
end

function DungeonConfig:getChapterEpisodeIndexWithSPType(chapterId, episodeId, episodeType)
	episodeType = episodeType or DungeonEnum.EpisodeType.Sp

	local list = self:getChapterEpisodeCOList(chapterId)
	local spIndex = 0
	local nonSpIndex = 0
	local curIndex, type

	for i, config in ipairs(list) do
		local spType = config.type == episodeType

		type = config.type

		if spType then
			spIndex = spIndex + 1
			curIndex = spIndex
		else
			nonSpIndex = nonSpIndex + 1
			curIndex = nonSpIndex
		end

		if config.id == episodeId then
			break
		end
	end

	if type == episodeType then
		curIndex = curIndex + self:getChapterFrontSpNum(chapterId)
	end

	return curIndex, type
end

function DungeonConfig:getEpisodeIndex(episodeId)
	local episodeCo = self:getEpisodeCO(episodeId)
	local episodeList = self:getChapterEpisodeCOList(episodeCo.chapterId)
	local index = 0

	for i, config in ipairs(episodeList) do
		index = index + 1

		if config.id == episodeId then
			break
		end
	end

	return index
end

function DungeonConfig:getEpisodeDisplay(episodeId)
	if not episodeId or episodeId == 0 then
		return nil
	end

	local episodeConfig = self:getEpisodeCO(episodeId)
	local chapterConfig = episodeConfig and self:getChapterCO(episodeConfig.chapterId)

	if not episodeConfig or not chapterConfig then
		return nil
	end

	local episodeIndex, type = self:getChapterEpisodeIndexWithSP(chapterConfig.id, episodeConfig.id)

	return string.format("%s-%s", (type == DungeonEnum.EpisodeType.Sp or nil) and "SP", episodeIndex)
end

function DungeonConfig:getChapterCO(chapterId)
	return self._chapterConfig.configDict[chapterId]
end

function DungeonConfig:getEpisodeCO(episodeId)
	local config = self._episodeConfig.configDict[episodeId]

	if not config then
		logNormal("dungeon no episode:" .. tostring(episodeId))
	end

	return config
end

function DungeonConfig:getEpisodeAdditionRule(episodeId)
	local battleId = self:getEpisodeBattleId(episodeId)
	local battleCo = battleId and lua_battle.configDict[battleId]

	return battleCo and battleCo.additionRule
end

function DungeonConfig:getBattleAdditionRule(battleId)
	local battleCo = battleId and lua_battle.configDict[battleId]

	return battleCo and battleCo.additionRule
end

function DungeonConfig:getEpisodeAdvancedCondition(episodeId, battleId)
	local battleId = battleId or self:getEpisodeBattleId(episodeId)
	local battleCo = battleId and lua_battle.configDict[battleId]

	return battleCo and battleCo.advancedCondition
end

function DungeonConfig:getEpisodeAdvancedCondition2(episodeId, index, battleId)
	local battleId = battleId or self:getEpisodeBattleId(episodeId)
	local battleCo = battleId and lua_battle.configDict[battleId]
	local advancedCondition = battleCo and battleCo.advancedCondition

	if not advancedCondition then
		return advancedCondition
	end

	local conditionList = string.splitToNumber(advancedCondition, "|")

	return conditionList[index]
end

function DungeonConfig:getEpisodeCondition(episodeId, battleId)
	local battleId = battleId or self:getEpisodeBattleId(episodeId)
	local battleCO = lua_battle.configDict[battleId]

	if not battleCO then
		return ""
	else
		return battleCO.winCondition
	end
end

function DungeonConfig:getBattleCo(episodeId, battleId)
	local battleId = battleId or self:getEpisodeBattleId(episodeId)

	return lua_battle.configDict[battleId]
end

function DungeonConfig:getEpisodeBattleId(episodeId)
	local co = self:getEpisodeCO(episodeId)

	if not co then
		return nil
	end

	local firstBattleId = co.firstBattleId

	if firstBattleId and firstBattleId > 0 then
		local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

		if episodeInfo and episodeInfo.star <= DungeonEnum.StarType.None then
			return firstBattleId
		end

		if HeroGroupBalanceHelper.isClickBalance() then
			local fightParam = FightModel.instance:getFightParam()

			if fightParam and fightParam.battleId == firstBattleId then
				return firstBattleId
			end
		end
	end

	if FightModel.instance:getFightParam() and co.type ~= DungeonEnum.EpisodeType.Story and co.battleId == 0 then
		return FightModel.instance:getFightParam().battleId
	end

	return co.battleId
end

function DungeonConfig:getBonusCO(bonusId)
	return self._bonusConfig.configDict[bonusId]
end

function DungeonConfig:isNewReward(episodeId, keyName)
	local episodeCo = lua_episode.configDict[episodeId]

	if not episodeCo then
		return
	end

	local rewardCo = lua_reward.configDict[episodeCo[keyName]]

	if not rewardCo then
		return
	end

	return true
end

function DungeonConfig:getRewardItems(rewardId)
	local rewardCo = lua_reward.configDict[rewardId]

	if not rewardCo then
		return {}
	end

	self._cacheRewardResults = self._cacheRewardResults or {}

	if self._cacheRewardResults[rewardId] then
		return self._cacheRewardResults[rewardId]
	end

	local result = {}
	local cacheItemId = {}

	for i = 1, math.huge do
		local value = rewardCo["rewardGroup" .. i]

		if not value then
			break
		end

		local groupId = string.match(value, "^(.+):")

		if groupId then
			local groupCoList = self._rewardConfigDict[groupId]

			if groupCoList then
				for _, groupCo in ipairs(groupCoList) do
					if groupCo.label ~= "none" then
						cacheItemId[groupCo.materialType] = cacheItemId[groupCo.materialType] or {}

						if not cacheItemId[groupCo.materialType][groupCo.materialId] then
							cacheItemId[groupCo.materialType][groupCo.materialId] = true

							local var_48_0 = result
							local var_48_1 = {
								groupCo.materialType,
								groupCo.materialId
							}

							var_48_1[3] = groupCo.shownum == 1 and tonumber(groupCo.count) or 0
							var_48_1.tagType = DungeonEnum.RewardProbability[groupCo.label]

							table.insert(var_48_0, var_48_1)
						end
					end
				end
			end
		end
	end

	table.sort(result, DungeonConfig._rewardSort)

	self._cacheRewardResults[rewardId] = result

	return result
end

function DungeonConfig._rewardSort(a, b)
	local aconfig = ItemModel.instance:getItemConfig(a[1], a[2])
	local bconfig = ItemModel.instance:getItemConfig(b[1], b[2])

	if aconfig.rare ~= bconfig.rare then
		return aconfig.rare > bconfig.rare
	else
		return aconfig.id > bconfig.id
	end
end

function DungeonConfig:getMaterialSource(type, materialId)
	if not self._materialSourceDict then
		self._materialSourceDict = {}

		for k, co in ipairs(lua_episode.configList) do
			local chapterCo = lua_chapter.configDict[co.chapterId]

			if chapterCo and (chapterCo.type == DungeonEnum.ChapterType.Normal or chapterCo.type == DungeonEnum.ChapterType.Hard or chapterCo.type == DungeonEnum.ChapterType.Simple) then
				local rewardId = co.reward
				local rewardCo = lua_reward.configDict[rewardId]

				if rewardCo then
					for i = 1, math.huge do
						local value = rewardCo["rewardGroup" .. i]

						if not value then
							break
						end

						local groupId = string.match(value, "^(.+):")

						if groupId then
							local groupCoList = self._rewardConfigDict[groupId]

							if groupCoList then
								for _, groupCo in ipairs(groupCoList) do
									if groupCo.label ~= "none" then
										self._materialSourceDict[groupCo.materialType] = self._materialSourceDict[groupCo.materialType] or {}
										self._materialSourceDict[groupCo.materialType][groupCo.materialId] = self._materialSourceDict[groupCo.materialType][groupCo.materialId] or {}

										if not tabletool.indexOf(self._materialSourceDict[groupCo.materialType][groupCo.materialId], co.id) then
											table.insert(self._materialSourceDict[groupCo.materialType][groupCo.materialId], {
												episodeId = co.id,
												probability = DungeonEnum.RewardProbabilityToMaterialProbability[groupCo.label]
											})
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if not self._materialSourceDict[type] then
		return
	end

	return self._materialSourceDict[type][materialId]
end

function DungeonConfig:_initChapterList()
	self._normalChapterList = {}
	self._hardChapterList = {}
	self._simpleChapterList = {}
	self._exploreChapterList = {}
	self._chapterUnlockMap = {}
	self._previewChapterList = {}

	local list = self._chapterConfig.configList

	self._lastEarlyAccessChapterId = 0

	for _, chapterCfg in ipairs(list) do
		if chapterCfg.type == DungeonEnum.ChapterType.Normal then
			table.insert(self._normalChapterList, chapterCfg)

			self._chapterUnlockMap[chapterCfg.preChapter] = chapterCfg
		elseif chapterCfg.type == DungeonEnum.ChapterType.Explore then
			table.insert(self._exploreChapterList, chapterCfg)
		elseif chapterCfg.type == DungeonEnum.ChapterType.Hard then
			table.insert(self._hardChapterList, chapterCfg)
		elseif chapterCfg.type == DungeonEnum.ChapterType.Simple then
			table.insert(self._simpleChapterList, chapterCfg)
		end

		if chapterCfg.dramaModeToMainChapterld > 0 then
			local t = {
				chapterCfg,
				lua_chapter.configDict[chapterCfg.dramaModeToMainChapterld]
			}

			self._previewChapterList[chapterCfg.dramaModeToMainChapterld] = t
			self._previewChapterList[chapterCfg.id] = t

			if chapterCfg.dramaModeToMainChapterld > self._lastEarlyAccessChapterId then
				self._lastEarlyAccessChapterId = chapterCfg.dramaModeToMainChapterld
			end
		end
	end

	local sortFun = SortUtil.keyLower("id")

	table.sort(self._normalChapterList, sortFun)
	table.sort(self._hardChapterList, sortFun)
	table.sort(self._simpleChapterList, sortFun)

	if self._lastEarlyAccessChapterId == 0 then
		logError("DungeonConfig _initChapterList _lastEarlyAccessChapterId == 0")
	end
end

function DungeonConfig:getLastEarlyAccessChapterId()
	return self._lastEarlyAccessChapterId
end

function DungeonConfig:getPreviewChapterList(chapterId)
	local list = self._previewChapterList[chapterId]

	if not list or #list ~= 2 then
		logError(string.format("DungeonConfig getPreviewChapterList chapterId = %d, chapter list size = %s error", chapterId, list and #list))
	end

	return list
end

function DungeonConfig:getUnlockChapterConfig(chapterId)
	return self._chapterUnlockMap[chapterId]
end

function DungeonConfig:getNormalChapterList()
	return self._normalChapterList
end

function DungeonConfig:getSimpleChapterList()
	return self._simpleChapterList
end

function DungeonConfig:getHardChapterList()
	return self._hardChapterList
end

function DungeonConfig:getExploreChapterList()
	return self._exploreChapterList
end

function DungeonConfig:_rebuildEpisodeConfigs()
	local realKeyMap = {
		preEpisode2 = "preEpisode",
		normalEpisodeId = "id"
	}
	local storyKeys = {
		"beforeStory",
		"story",
		"afterStory"
	}
	local chainEpisodeDict = {}
	local backwardChainDict = {}
	local episodeMetatable = getmetatable(lua_episode.configList[1])
	local metatable = {}

	function metatable.__index(t, key)
		if not realKeyMap[key] then
			local mapKey = key
			local value = episodeMetatable.__index(t, mapKey)
			local keyIsPreEpisode = key == "preEpisode"

			if keyIsPreEpisode and value > 0 or key == "normalEpisodeId" then
				if keyIsPreEpisode then
					local preEpisodeId = episodeMetatable.__index(t, "preEpisodeId")

					if preEpisodeId and preEpisodeId > 0 then
						return preEpisodeId
					end
				end

				return chainEpisodeDict[value] or value
			end

			if tabletool.indexOf(storyKeys, key) then
				local id = episodeMetatable.__index(t, "chainEpisode")

				if id > 0 and lua_episode.configDict[id] then
					return lua_episode.configDict[id][key]
				end
			end

			return value
		end
	end

	metatable.__newindex = episodeMetatable.__newindex

	for _, v in ipairs(lua_episode.configList) do
		setmetatable(v, metatable)

		if v.chainEpisode > 0 then
			chainEpisodeDict[v.chainEpisode] = v.id
			backwardChainDict[v.id] = v.chainEpisode
		end
	end

	self._chainEpisodeDict = chainEpisodeDict
	self._backwardChainDict = backwardChainDict
end

function DungeonConfig:getChainEpisodeDict()
	return self._chainEpisodeDict
end

function DungeonConfig:getNormalEpisodeIdBySimple(id)
	return self._chainEpisodeDict[id]
end

function DungeonConfig:_initEpisodeList()
	self._unlockEpisodeList = {}
	self._chapterSpStats = {}
	self._chapterEpisodeDict = {}
	self._chpaterNonSpEpisodeDict = {}
	self._episodeElementListDict = {}
	self._episodeUnlockDict = {}
	self._episodeUnlockImplicitElementDict = {}

	local episodeCOList = self._episodeConfig.configList

	for _, episodeCO in ipairs(episodeCOList) do
		local episodeList = self._chapterEpisodeDict[episodeCO.chapterId]

		if not episodeList then
			episodeList = {}
			self._chapterEpisodeDict[episodeCO.chapterId] = episodeList
		end

		table.insert(episodeList, episodeCO)
		self:_setEpisodeIndex(episodeCO)

		if episodeCO.preEpisode > 0 then
			if not string.nilorempty(episodeCO.elementList) then
				self._episodeElementListDict[episodeCO.preEpisode] = episodeCO.elementList

				local list = string.splitToNumber(episodeCO.elementList, "#")

				for i, id in ipairs(list) do
					local elementConfig = lua_chapter_map_element.configDict[id]

					if elementConfig then
						if DungeonEnum.ImplicitElementType[elementConfig.type] then
							if self._episodeUnlockImplicitElementDict[episodeCO.id] then
								logError(string.format("_initEpisodeList 关卡id：%s，元件id：%s重复", episodeCO.id, id))
							end

							self._episodeUnlockImplicitElementDict[episodeCO.id] = id
						end
					else
						logError(string.format("_initEpisodeList 关卡id：%s，元件id：%s不存在", episodeCO.id, id))
					end
				end
			end

			local chapterConfig = self:getChapterCO(episodeCO.chapterId)

			if chapterConfig and chapterConfig.type ~= DungeonEnum.ChapterType.Hard then
				self._episodeUnlockDict[episodeCO.preEpisode] = episodeCO.id
			end
		end

		if episodeCO.unlockEpisode > 0 then
			if not self._unlockEpisodeList[episodeCO.unlockEpisode] then
				do
					local list = {}

					self._unlockEpisodeList[episodeCO.unlockEpisode] = list

					table.insert(list, episodeCO.id)
				end

				if episodeCO.type == DungeonEnum.EpisodeType.Sp then
					if not self._chapterSpStats[episodeCO.chapterId] then
						local num = 0

						num = num + 1
						self._chapterSpStats[episodeCO.chapterId] = num
					end
				end
			end
		end

		self:_mapConnectEpisode(episodeCO)
	end
end

function DungeonConfig:_initVersionActivityEpisodeList()
	self.versionActivityPreEpisodeDict = {}

	local chapterIdList = {
		VersionActivityEnum.DungeonChapterId.LeiMiTeBei3,
		VersionActivityEnum.DungeonChapterId.LeiMiTeBei4,
		VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal2,
		VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3,
		VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei3,
		VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei4,
		VersionActivity1_5DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_5DungeonEnum.DungeonChapterId.Story3,
		VersionActivity1_6DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_6DungeonEnum.DungeonChapterId.Story3,
		VersionActivity1_8DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_8DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_0DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_0DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_1DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_1DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_3DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_3DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_4DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_4DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_5DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_5DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_7DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_7DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_9DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_9DungeonEnum.DungeonChapterId.Story3,
		VersionActivity3_1DungeonEnum.DungeonChapterId.Story2,
		VersionActivity3_1DungeonEnum.DungeonChapterId.Story3,
		VersionActivity3_2DungeonEnum.DungeonChapterId.Story2,
		VersionActivity3_2DungeonEnum.DungeonChapterId.Story3,
		VersionActivity3_4DungeonEnum.DungeonChapterId.Story2,
		VersionActivity3_4DungeonEnum.DungeonChapterId.Story3,
		VersionActivity3_5DungeonEnum.DungeonChapterId.Story2,
		VersionActivity3_5DungeonEnum.DungeonChapterId.Story3,
		VersionActivity3_6DungeonEnum.DungeonChapterId.Story2,
		VersionActivity3_6DungeonEnum.DungeonChapterId.Story3,
		VersionActivity3_8DungeonEnum.DungeonChapterId.Story2,
		VersionActivity3_8DungeonEnum.DungeonChapterId.Story3,
		VersionActivity3_9DungeonEnum.DungeonChapterId.Story2,
		VersionActivity3_9DungeonEnum.DungeonChapterId.Story3,
		VersionActivity3_10DungeonEnum.DungeonChapterId.Story2,
		VersionActivity3_10DungeonEnum.DungeonChapterId.Story3
	}
	local chapterEpisodeList

	for _, chapterId in ipairs(chapterIdList) do
		if self._chapterEpisodeDict[chapterId] then
			for _, episodeCo in ipairs(self._chapterEpisodeDict[chapterId]) do
				self.versionActivityPreEpisodeDict[episodeCo.preEpisode] = episodeCo
			end
		end
	end
end

function DungeonConfig:getVersionActivityEpisodeCoByPreEpisodeId(preEpisodeId)
	if not self.versionActivityPreEpisodeDict then
		self:_initVersionActivityEpisodeList()
	end

	return self.versionActivityPreEpisodeDict[preEpisodeId]
end

function DungeonConfig:getVersionActivityBrotherEpisodeByEpisodeCo(episodeCo)
	local actId = ActivityConfig.instance:getActIdByChapterId(episodeCo.chapterId)

	if not actId then
		return {
			episodeCo
		}
	end

	local episodeCoList = {}
	local activityCo = ActivityConfig.instance:getActivityDungeonConfig(actId)

	while episodeCo.chapterId ~= activityCo.story1ChapterId do
		episodeCo = self:getEpisodeCO(episodeCo.preEpisode)
	end

	while episodeCo do
		table.insert(episodeCoList, episodeCo)

		episodeCo = self:getVersionActivityEpisodeCoByPreEpisodeId(episodeCo.id)
	end

	return episodeCoList
end

function DungeonConfig:_initVersionActivityEpisodeLevelList(start_chapter_id, end_chapter_id)
	self._versionActivityEpisodeLevelList = self._versionActivityEpisodeLevelList or {}

	local tab = {}

	while end_chapter_id ~= start_chapter_id do
		local temp_list = self:getChapterEpisodeCOList(end_chapter_id)

		for i, v in ipairs(temp_list) do
			tab[v.preEpisode] = v.id

			local episode_config = self:getEpisodeCO(v.preEpisode)

			end_chapter_id = episode_config.chapterId
		end
	end

	local episode_list = self:getChapterEpisodeCOList(start_chapter_id)

	for i, v in ipairs(episode_list) do
		self._versionActivityEpisodeLevelList[v.id] = {
			v.id
		}

		if tab[v.id] then
			local temp_id = v.id

			while tab[temp_id] do
				table.insert(self._versionActivityEpisodeLevelList[v.id], tab[temp_id])

				temp_id = tab[temp_id]
			end
		end
	end

	for k, v in pairs(self._versionActivityEpisodeLevelList) do
		if #v > 0 then
			for index, episodeId in ipairs(v) do
				if episodeId ~= k then
					self._versionActivityEpisodeLevelList[episodeId] = v
				end
			end
		end
	end
end

function DungeonConfig:get1_2VersionActivityEpisodeCoList(episode_id)
	if self._versionActivityEpisodeLevelList and self._versionActivityEpisodeLevelList[episode_id] then
		return self._versionActivityEpisodeLevelList[episode_id]
	end

	local episode_config = self:getEpisodeCO(episode_id)

	if not VersionActivity1_2DungeonEnum.DungeonChapterId2StartChapterId[episode_config.chapterId] then
		if not VersionActivity1_2DungeonEnum.DungeonChapterId2EndChapterId[episode_config.chapterId] then
			local end_chapter_id = episode_config.chapterId

			self:_initVersionActivityEpisodeLevelList(VersionActivity1_2DungeonEnum.DungeonChapterId2StartChapterId[episode_config.chapterId], end_chapter_id)

			return self._versionActivityEpisodeLevelList[episode_id]
		end
	end
end

function DungeonConfig:get1_2VersionActivityFirstLevelEpisodeId(episode_id)
	local episode_config = self:getEpisodeCO(episode_id)
	local chapter_id = episode_config.chapterId

	if VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[chapter_id] then
		while VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[chapter_id] ~= chapter_id do
			episode_config = DungeonConfig.instance:getEpisodeCO(episode_config.preEpisode)
			chapter_id = episode_config.chapterId
		end
	end

	return episode_config.id
end

function DungeonConfig:getElementList(episodeId)
	return self._episodeElementListDict[episodeId] or ""
end

function DungeonConfig:getUnlockEpisodeId(episodeId)
	return self._episodeUnlockDict[episodeId]
end

function DungeonConfig:getChapterSpNum(chapterId)
	return self._chapterSpStats[chapterId] or 0
end

function DungeonConfig:getUnlockEpisodeList(id)
	return self._unlockEpisodeList[id]
end

function DungeonConfig:getChapterEpisodeCOList(chapterId)
	local list = self._chapterEpisodeDict[chapterId]

	if list and not list._sort then
		list._sort = true

		table.sort(list, function(a, b)
			if SLFramework.FrameworkSettings.IsEditor then
				local aMap = {}

				if SLFramework.FrameworkSettings.IsEditor then
					local bMap = {}
					local aIndex = self:_getEpisodeIndex(a, aMap)
					local bIndex = self:_getEpisodeIndex(b, bMap)

					return aIndex < bIndex
				end
			end
		end)
	end

	return list
end

function DungeonConfig:getChapterNonSpEpisodeCOList(chapterId)
	local list = self._chpaterNonSpEpisodeDict[chapterId]

	if not list then
		list = {}
		self._chpaterNonSpEpisodeDict[chapterId] = list

		local episodeList = self:getChapterEpisodeCOList(chapterId)

		for i, v in ipairs(episodeList) do
			if v.type ~= DungeonEnum.EpisodeType.Sp then
				table.insert(list, v)
			end
		end
	end

	return list
end

function DungeonConfig:getChapterLastNonSpEpisode(chapterId)
	local list = self:getChapterNonSpEpisodeCOList(chapterId)

	return list and list[#list]
end

function DungeonConfig:_setEpisodeIndex(episodeCfg)
	if episodeCfg.preEpisode > 0 then
		local preEpisodeIndex = self._episodeIndex[episodeCfg.preEpisode]

		if preEpisodeIndex then
			self._episodeIndex[episodeCfg.id] = preEpisodeIndex + 1
		end
	else
		self._episodeIndex[episodeCfg.id] = 0
	end
end

function DungeonConfig:_getEpisodeIndex(episodeCfg, searchTable)
	if searchTable then
		searchTable[episodeCfg] = true
	end

	local index = self._episodeIndex[episodeCfg.id]

	if index then
		return index
	end

	local preEpisodeCfg = self:getEpisodeCO(episodeCfg.preEpisode)

	if searchTable and searchTable[preEpisodeCfg] then
		logError(string.format("_getEpisodeIndex: %s前置互相依赖了", preEpisodeCfg.id))

		return 0
	end

	if not preEpisodeCfg and searchTable then
		logError(string.format("_getEpisodeIndex: %s前置%s不存在", episodeCfg.id, episodeCfg.preEpisode))
	end

	local index = self:_getEpisodeIndex(preEpisodeCfg, searchTable) + 1

	self._episodeIndex[episodeCfg.id] = index

	return index
end

function DungeonConfig:isPreChapterList(preChapterId, curChapterId)
	if preChapterId == curChapterId then
		return false
	end

	local config = self:getChapterCO(curChapterId)
	local closeChapterIdDict = {}

	while config and config.preChapter ~= 0 do
		if config.preChapter == preChapterId then
			return true
		end

		if closeChapterIdDict[config.preChapter] then
			break
		end

		closeChapterIdDict[config.preChapter] = true
		config = self:getChapterCO(config.preChapter)
	end

	return false
end

function DungeonConfig:isPreEpisodeList(preEpisodeId, curEpisodeId)
	if preEpisodeId == curEpisodeId then
		return false
	end

	if preEpisodeId == 0 or curEpisodeId == 0 then
		return false
	end

	local preConfig = self:getEpisodeCO(preEpisodeId)
	local curConfig = self:getEpisodeCO(curEpisodeId)

	if not preConfig or not curConfig then
		return false
	end

	if self:isPreChapterList(preConfig.chapterId, curConfig.chapterId) then
		return true
	end

	local config = curConfig
	local closeEpisodeIdDict = {}

	while config and config.preEpisode ~= 0 do
		if config.preEpisode == preEpisodeId then
			return true
		end

		if closeEpisodeIdDict[config.preEpisode] then
			break
		end

		closeEpisodeIdDict[config.preEpisode] = true
		config = self:getEpisodeCO(config.preEpisode)
	end

	return false
end

function DungeonConfig:getMonsterListFromGroupID(monsterGroupID)
	local list = {}
	local normalList = {}
	local bossList = {}
	local monsterGroupIds = string.splitToNumber(monsterGroupID, "#")

	for _, monsterGroupId in ipairs(monsterGroupIds) do
		local monsterGroupCO = lua_monster_group.configDict[monsterGroupId]
		local monsterList = string.splitToNumber(monsterGroupCO.monster, "#")
		local bossId = monsterGroupCO.bossId

		for _, monsterID in ipairs(monsterList) do
			if monsterID and lua_monster.configDict[monsterID] then
				local monsterConfig = lua_monster.configDict[monsterID]

				if monsterConfig then
					table.insert(list, monsterConfig)

					if FightHelper.isBossId(bossId, monsterID) then
						table.insert(bossList, monsterConfig)
					else
						table.insert(normalList, monsterConfig)
					end
				end
			end
		end
	end

	return list, normalList, bossList
end

function DungeonConfig:getCareersFromBattle(battleId)
	local careerInfos = {}
	local index = 0
	local battleConfig = lua_battle.configDict[battleId]

	if battleConfig then
		local careerDict = {}
		local _, normalMonsters, bossMonsters = self:getMonsterListFromGroupID(battleConfig.monsterGroupIds)

		table.sort(normalMonsters, function(x, y)
			return x.level < y.level
		end)
		table.sort(bossMonsters, function(x, y)
			return x.level < y.level
		end)

		for i, monsterConfig in ipairs(normalMonsters) do
			index = index + 1
			careerDict[monsterConfig.career] = careerDict[monsterConfig.career] or {}
			careerDict[monsterConfig.career].score = index
			careerDict[monsterConfig.career].isBoss = false
		end

		for i, bossConfig in ipairs(bossMonsters) do
			index = index + 1
			careerDict[bossConfig.career] = careerDict[bossConfig.career] or {}
			careerDict[bossConfig.career].score = index
			careerDict[bossConfig.career].isBoss = true
		end

		for career, info in pairs(careerDict) do
			local careerInfo = {}

			careerInfo.career = career
			careerInfo.score = info.score
			careerInfo.isBoss = info.isBoss

			table.insert(careerInfos, careerInfo)
		end

		table.sort(careerInfos, function(x, y)
			return x.score < y.score
		end)
	end

	return careerInfos
end

function DungeonConfig:getBossMonsterIdDict(battleConfig)
	local bossMonsterIdDict = {}

	if battleConfig then
		local _, _, bossMonsters = self:getMonsterListFromGroupID(battleConfig.monsterGroupIds)

		if bossMonsters then
			for i = 1, #bossMonsters do
				bossMonsterIdDict[bossMonsters[i].id] = true
			end
		end
	end

	return bossMonsterIdDict
end

function DungeonConfig:getBattleDisplayMonsterIds(battleConfig)
	local monsterIdList = {}
	local monsterIdDict = {}
	local monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")

	for i = #monsterGroupIds, 1, -1 do
		local monsterGroupId = monsterGroupIds[i]
		local monsterGroupCO = lua_monster_group.configDict[monsterGroupId]
		local monsterList = string.splitToNumber(monsterGroupCO.monster, "#")
		local bossId = monsterGroupCO.bossId
		local bossIndex = 100
		local currentGroupMonsterMOList = {}

		for j, monsterID in ipairs(monsterList) do
			if FightHelper.isBossId(bossId, monsterID) then
				bossIndex = j
			end
		end

		for j, monsterID in ipairs(monsterList) do
			if monsterID and lua_monster.configDict[monsterID] then
				local monsterMO = {}

				monsterMO.id = monsterID
				monsterMO.distance = math.abs(j - bossIndex)

				table.insert(currentGroupMonsterMOList, monsterMO)
			end
		end

		table.sort(currentGroupMonsterMOList, function(x, y)
			return x.distance < y.distance
		end)

		for j, monsterMO in ipairs(currentGroupMonsterMOList) do
			if not monsterIdDict[monsterMO.id] then
				monsterIdDict[monsterMO.id] = true

				table.insert(monsterIdList, monsterMO.id)
			end
		end
	end

	for _, mosnterGroupId in ipairs(monsterGroupIds) do
		local monsterGroupConfig = lua_monster_group.configDict[mosnterGroupId]
		local spmonsterNilOrEmpty = string.nilorempty(monsterGroupConfig.spMonster)
		local spMonsterIds = spmonsterNilOrEmpty and {} or string.split(monsterGroupConfig.spMonster, "#")

		for _, spMonsterId in ipairs(spMonsterIds) do
			if not monsterIdDict[spMonsterId] then
				monsterIdDict[spMonsterId] = true

				table.insert(monsterIdList, tonumber(spMonsterId))
			end
		end
	end

	return monsterIdList
end

function DungeonConfig:getNormalChapterId(episodeId)
	local episodeConfig = self:getEpisodeCO(episodeId)
	local chapterConfig = self:getChapterCO(episodeConfig.chapterId)

	if chapterConfig.type == DungeonEnum.ChapterType.Hard then
		episodeConfig = self:getEpisodeCO(episodeConfig.preEpisode)
		chapterConfig = self:getChapterCO(episodeConfig.chapterId)
	end

	return chapterConfig.id
end

function DungeonConfig:getChapterTypeByEpisodeId(episodeId)
	local episodeConfig = self:getEpisodeCO(episodeId)
	local chapterConfig = self:getChapterCO(episodeConfig.chapterId)

	return chapterConfig.type
end

function DungeonConfig:getFirstEpisodeWinConditionText(episodeId, battleId)
	local winCondition = self:getEpisodeCondition(episodeId, battleId)

	if string.nilorempty(winCondition) then
		return ""
	end

	local winList = GameUtil.splitString2(winCondition, false, "|", "#")

	return self:getWinConditionText(winList[1]) or "winCondition error:" .. winCondition
end

function DungeonConfig:getEpisodeWinConditionTextList(episodeId)
	local winCondition = self:getEpisodeCondition(episodeId)

	if string.nilorempty(winCondition) then
		return {
			""
		}
	end

	local result = {}
	local winList = GameUtil.splitString2(winCondition, false, "|", "#")

	for i, v in ipairs(winList) do
		table.insert(result, self:getWinConditionText(v) or "winCondition error:" .. winCondition)
	end

	return result
end

function DungeonConfig:getWinConditionText(v)
	if not v then
		return nil
	end

	local type = tonumber(v[1])

	if type == 1 or type == 10 then
		return luaLang("dungeon_beat_all")
	elseif type == 2 then
		local id = tonumber(v[2])
		local cfg = lua_monster.configDict[id]

		if cfg then
			return formatLuaLang("dungeon_win_protect", string.format("<color=#ff0000>%s</color>", cfg.name))
		end
	elseif type == 3 or type == 9 then
		local monList = string.split(v[2], "&")
		local monNameList = {}

		for _, monIdStr in ipairs(monList) do
			local id = tonumber(monIdStr)
			local cfg = lua_monster.configDict[id]

			if cfg then
				if FightConfig.instance:getNewMonsterConfig(cfg) then
					if not cfg.highPriorityName then
						local cfgName = cfg.name

						table.insert(monNameList, string.format("<color=#ff0000>%s</color>", cfgName))
					end
				end
			end
		end

		if #monNameList > 0 then
			return formatLuaLang("dungeon_win_3", table.concat(monNameList, luaLang("else")))
		end
	elseif type == 4 then
		-- block empty
	elseif type == 5 then
		local id = tonumber(v[2])
		local cfg = lua_monster.configDict[id]

		if cfg then
			local tag = {
				string.format("<color=#ff0000>%s</color>", cfg.name),
				tonumber(v[3]) / 10 .. "%"
			}

			return (GameUtil.getSubPlaceholderLuaLang(luaLang("dungeon_win_5"), tag))
		end
	elseif type == 6 then
		return formatLuaLang("dungeon_win_6", v[2])
	elseif type == 7 then
		return luaLang("dungeon_beat_all_without_die")
	elseif type == 8 then
		return formatLuaLang("dungeon_win_8", v[3])
	elseif type == 13 then
		local id = tonumber(v[2])
		local cfg = lua_monster.configDict[id]

		if cfg then
			return formatLuaLang("fight_charge_monster_energy", cfg.name)
		end
	end

	return nil
end

function DungeonConfig:getEpisodeAdvancedConditionText(episodeId, battleId)
	local advancedCondition = self:getEpisodeAdvancedCondition(episodeId, battleId)

	if LuaUtil.isEmptyStr(advancedCondition) == false then
		local conditionList = string.splitToNumber(advancedCondition, "|")
		local conditionId = conditionList[1]
		local condition = lua_condition.configDict[conditionId]

		return condition.desc
	else
		return ""
	end
end

function DungeonConfig:getEpisodeAdvancedCondition2Text(episodeId, battleId)
	local advancedCondition = self:getEpisodeAdvancedCondition(episodeId, battleId)

	if LuaUtil.isEmptyStr(advancedCondition) == false then
		local conditionList = string.splitToNumber(advancedCondition, "|")
		local conditionId = conditionList[2]

		if not conditionId then
			return ""
		end

		local condition = lua_condition.configDict[conditionId]

		return condition.desc
	else
		return ""
	end
end

function DungeonConfig:getEpisodeFailedReturnCost(episodeId, multiplication)
	multiplication = multiplication or 1

	local episodeCo = self:getEpisodeCO(episodeId)

	if not episodeCo then
		return 0
	end

	local costList = string.split(episodeCo.cost, "#")
	local failCostList = string.split(episodeCo.failCost, "#")

	if costList[2] == failCostList[2] and costList[3] and failCostList[3] then
		return multiplication * costList[3] - failCostList[3]
	else
		return 0
	end
end

function DungeonConfig:getEndBattleCost(episodeId, fail)
	local episodeCo = self:getEpisodeCO(episodeId)

	if not episodeCo then
		return 0
	end

	if fail then
		return string.split(episodeCo.failCost, "#")[3]
	else
		return string.split(episodeCo.cost, "#")[3]
	end
end

function DungeonConfig:getDungeonEveryDayCount(type)
	local numStr = CommonConfig.instance:getConstStr(ConstEnum.DungeonMaxCount)
	local numList = GameUtil.splitString2(numStr, true, "|", "#")
	local maxCount = 0

	for i, v in ipairs(numList) do
		local dungeonType = v[1]
		local count = v[2]

		if dungeonType == type then
			maxCount = count

			break
		end
	end

	return maxCount
end

function DungeonConfig:getDungeonEveryDayItem(type)
	local numStr = CommonConfig.instance:getConstStr(ConstEnum.DungeonItem)
	local numList = GameUtil.splitString2(numStr, true, "|", "#")
	local item = 0

	for i, v in ipairs(numList) do
		local dungeonType = v[1]
		local id = v[2]

		if dungeonType == type then
			item = id

			break
		end
	end

	return item
end

function DungeonConfig:getPuzzleQuestionCo(id)
	return lua_chapter_puzzle_question.configDict[id]
end

function DungeonConfig:_initPuzzleSquare(configTable)
	self._puzzle_square_data = {}

	for k, v in pairs(configTable.configDict) do
		self._puzzle_square_data[v.group] = self._puzzle_square_data[v.group] or {}

		table.insert(self._puzzle_square_data[v.group], v)
	end
end

function DungeonConfig:getPuzzleSquareDebrisGroupList(group_id)
	return self._puzzle_square_data[group_id]
end

function DungeonConfig:getPuzzleSquareData(id)
	return lua_chapter_puzzle_square.configDict[id]
end

function DungeonConfig:getDecryptCo(id)
	return self._decryptConfig.configDict[id]
end

function DungeonConfig:getDecryptChangeColorCo(id)
	return self._lvConfig.configDict[id]
end

function DungeonConfig:getDecryptChangeColorInteractCos()
	return self._interactConfig.configDict
end

function DungeonConfig:getDecryptChangeColorInteractCo(id)
	return self._interactConfig.configDict[id]
end

function DungeonConfig:getDecryptChangeColorColorCos()
	return self._colorConfig.configDict
end

function DungeonConfig:getDecryptChangeColorColorCo(id)
	return self._colorConfig.configDict[id]
end

function DungeonConfig:isLeiMiTeBeiChapterType(episodeCo)
	if not episodeCo then
		return false
	end

	return episodeCo.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei or episodeCo.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard or episodeCo.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei3 or episodeCo.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei4 or episodeCo.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight
end

function DungeonConfig:getElementFightEpisodeToNormalEpisodeId(elementFightEpisodeCO)
	for _, mapElementCo in ipairs(lua_chapter_map_element.configList) do
		if mapElementCo.type == 2 and mapElementCo.param == tostring(elementFightEpisodeCO.id) then
			local mapId = mapElementCo.mapId
			local chapterMapList = self._chapterMapList[VersionActivityEnum.DungeonChapterId.LeiMiTeBei]

			for episodeId, mapCo in pairs(chapterMapList) do
				if mapCo.id == mapId then
					local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)

					for _, episodeCo in ipairs(episodeList) do
						if episodeCo.preEpisode == episodeId then
							return episodeCo.id
						end
					end
				end
			end
		end
	end

	return nil
end

function DungeonConfig:getActivityElementFightEpisodeToNormalEpisodeId(elementFightEpisodeCO, activityChapterId)
	for _, mapElementCo in ipairs(lua_chapter_map_element.configList) do
		if mapElementCo.type == 2 and tonumber(mapElementCo.param) == elementFightEpisodeCO.id then
			local mapId = mapElementCo.mapId
			local chapterMapList = self._chapterMapList[activityChapterId]

			for episodeId, mapCo in pairs(chapterMapList) do
				if mapCo.id == mapId then
					local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(activityChapterId)

					for _, episodeCo in ipairs(episodeList) do
						if episodeCo.preEpisode == episodeId then
							return episodeCo.id
						end
					end
				end
			end
		end
	end

	return nil
end

function DungeonConfig:isActivity1_2Map(map_id)
	local episode_config = DungeonConfig.instance:getEpisodeCO(map_id)

	if episode_config then
		local chapterId = episode_config.chapterId
		local chapter_config = lua_chapter.configDict[chapterId]

		if chapter_config and (chapter_config.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or chapter_config.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or chapter_config.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or chapter_config.type == DungeonEnum.ChapterType.Activity1_2DungeonHard) then
			return true
		end
	end
end

function DungeonConfig:getEpisodeLevelIndex(episodeCo)
	if not episodeCo then
		return 0
	end

	return self:getEpisodeLevelIndexByEpisodeId(episodeCo.id)
end

function DungeonConfig:getEpisodeLevelIndexByEpisodeId(episodeId)
	if not episodeId or type(episodeId) ~= "number" then
		return 0
	end

	return episodeId % 100
end

function DungeonConfig:getExtendStory(episodeId)
	if not self._episodeExtendStoryDict then
		self._episodeExtendStoryDict = {}

		local constCo = lua_const.configDict[ConstEnum.EpisodeExtendStory]

		if constCo and not string.nilorempty(constCo.value) then
			local info = GameUtil.splitString2(constCo.value, true)

			for _, arr in ipairs(info) do
				self._episodeExtendStoryDict[arr[1]] = {
					arr[2],
					arr[3]
				}
			end
		end
	end

	if not self._episodeExtendStoryDict[episodeId] then
		return nil
	end

	local elementId, storyId = unpack(self._episodeExtendStoryDict[episodeId])

	if not elementId or not DungeonMapModel.instance:elementIsFinished(elementId) then
		return nil
	end

	return storyId
end

function DungeonConfig:getSimpleEpisode(normalEpisodeConfig)
	local storyEpisodeId = normalEpisodeConfig.chainEpisode

	if storyEpisodeId ~= 0 then
		return self:getEpisodeCO(storyEpisodeId)
	end
end

function DungeonConfig:getVersionActivityDungeonNormalEpisode(episodeId, hardEnum, normalEnum)
	local episodeConfig = self:getEpisodeCO(episodeId)

	if episodeConfig.chapterId == hardEnum then
		episodeId = episodeId - 10000
		episodeConfig = self:getEpisodeCO(episodeId)
	else
		while episodeConfig.chapterId ~= normalEnum do
			episodeConfig = self:getEpisodeCO(episodeConfig.preEpisode)
		end
	end

	return episodeConfig
end

function DungeonConfig:getEpisodeByElement(elementId)
	local config = lua_chapter_map_element.configDict[elementId]

	if not config then
		return
	end

	local mapId = config.mapId
	local mapCfg = lua_chapter_map.configDict[mapId]

	return (self:getEpisodeIdByMapCo(mapCfg))
end

function DungeonConfig:getEpisodeUnlockImplicitElement(episodeId)
	return self._episodeUnlockImplicitElementDict[episodeId]
end

function DungeonConfig:getRewardGroupCOList(group)
	return self._rewardConfigDict[group]
end

function DungeonConfig:calcRewardGroupRateInfoList(group)
	local list = {}

	self:_calcRewardGroupRateInfoList(list, group)

	return list
end

function DungeonConfig:_calcRewardGroupRateInfoList(refList, group)
	local COList = self:getRewardGroupCOList(group)

	if not COList or #COList == 0 then
		return
	end

	local totWeight = 0
	local st = #refList

	for _, CO in ipairs(COList) do
		local weight = tonumber(CO.count) or 0

		totWeight = totWeight + weight

		table.insert(refList, {
			weight = weight,
			materialType = CO.materialType,
			materialId = CO.materialId
		})
	end

	local ed = #refList

	for i = st + 1, ed do
		local rateInfo = refList[i]

		rateInfo.rate = totWeight == 0 and 0 or rateInfo.weight / totWeight
	end
end

DungeonConfig.instance = DungeonConfig.New()

return DungeonConfig
