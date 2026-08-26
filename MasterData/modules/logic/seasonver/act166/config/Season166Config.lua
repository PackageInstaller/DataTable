-- chunkname: @modules/logic/seasonver/act166/config/Season166Config.lua

local Season166Config = class("Season166Config", BaseConfig)

function Season166Config:ctor()
	return
end

function Season166Config:reqConfigNames()
	return {
		"activity166_const_global",
		"activity166_const",
		"activity166_score",
		"activity166_base",
		"activity166_base_level",
		"activity166_base_target",
		"activity166_train",
		"activity166_teach",
		"activity166_info_analy",
		"activity166_info_bonus",
		"activity166_info",
		"activity166_talent",
		"activity166_talent_style",
		"activity166_word_effect",
		"activity166_word_effect_pos"
	}
end

function Season166Config:onConfigLoaded(configName, configTable)
	if configName == "activity166_const" then
		self._constConfig = configTable
	elseif configName == "activity166_const_global" then
		self._constGlobalConfig = configTable
	elseif configName == "activity166_score" then
		self._scoreConfig = configTable
	elseif configName == "activity166_base" then
		self._baseSpotConfig = configTable
		self._actId2BaseSpotCoList = {}
	elseif configName == "activity166_base_level" then
		self._baseSpotLevelConfig = configTable
		self._baseLevelCoList = {}
	elseif configName == "activity166_base_target" then
		self._baseTargetConfig = configTable
		self._baseTargetCoList = {}
	elseif configName == "activity166_train" then
		self._trainConfig = configTable
		self._trainCoList = {}
	elseif configName == "activity166_teach" then
		self._teachConfig = configTable
	elseif configName == "activity166_info_analy" then
		self._infoAnalyConfig = configTable
	elseif configName == "activity166_info_bonus" then
		self._infoBonusConfig = configTable
	elseif configName == "activity166_info" then
		self._infoConfig = configTable
	elseif configName == "activity166_word_effect" then
		self._wordEffectConfig = configTable

		self:buildSeasonWordEffectConfig()
	elseif configName == "activity166_word_effect_pos" then
		self._wordEffectPosConfig = configTable
	end

	self._episodeId2Config = {}
end

function Season166Config:getSeasonConstGlobalCo(constId)
	return self._constGlobalConfig.configDict[constId]
end

function Season166Config:getSeasonConstCo(constId)
	return self._constConfig.configDict[constId]
end

function Season166Config:getSeasonConstNum(actId, constId)
	if not self._constConfig.configDict[actId] or not self._constConfig.configDict[actId][constId] then
		return nil
	end

	return self._constConfig.configDict[actId][constId].value1
end

function Season166Config:getSeasonConstStr(actId, constId)
	if not self._constConfig.configDict[actId] or not self._constConfig.configDict[actId][constId] then
		return nil
	end

	return self._constConfig.configDict[actId][constId].value2
end

function Season166Config:getSeasonBaseSpotCos(actId)
	local baseSpotCoList = self._actId2BaseSpotCoList[actId]

	if not baseSpotCoList then
		baseSpotCoList = {}
		self._actId2BaseSpotCoList[actId] = baseSpotCoList

		local baseSpotDict = self._baseSpotConfig.configDict[actId]

		if baseSpotDict then
			for baseId, cfg in pairs(baseSpotDict) do
				table.insert(baseSpotCoList, cfg)
			end

			table.sort(baseSpotCoList, function(a, b)
				return a.baseId < b.baseId
			end)
		end
	end

	return baseSpotCoList
end

function Season166Config:getSeasonBaseSpotCo(actId, baseId)
	return self._baseSpotConfig.configDict[actId][baseId]
end

function Season166Config:getSeasonBaseLevelCo(actId, baseId, level)
	if self._baseSpotLevelConfig.configDict[actId] and self._baseSpotLevelConfig.configDict[actId][baseId] then
		return self._baseSpotLevelConfig.configDict[actId][baseId][level]
	end
end

function Season166Config:getSeasonBaseLevelCos(actId, baseId)
	local levelCoMap = self._baseLevelCoList[actId]

	if not levelCoMap then
		levelCoMap = {}
		self._baseLevelCoList[actId] = levelCoMap
	end

	if not levelCoMap[baseId] then
		local levelCoList = {}

		levelCoMap[baseId] = levelCoList

		if self._baseSpotLevelConfig.configDict[actId] then
			if not self._baseSpotLevelConfig.configDict[actId][baseId] then
				local levelDict = {}

				for level, levelCo in pairs(levelDict) do
					table.insert(levelCoList, levelCo)
				end

				table.sort(levelCoList, function(a, b)
					return a.level < b.level
				end)
			end
		end
	end

	return self._baseLevelCoList[actId][baseId]
end

function Season166Config:getSeasonBaseTargetCo(actId, baseId, targetId)
	if self._baseTargetConfig.configDict[actId] and self._baseTargetConfig.configDict[actId][baseId] then
		return self._baseTargetConfig.configDict[actId][baseId][targetId]
	end
end

function Season166Config:getSeasonBaseTargetCos(actId, baseId)
	local targetCoList = self._baseTargetCoList[actId]

	if not targetCoList then
		targetCoList = {}
		self._baseTargetCoList[actId] = targetCoList

		if self._baseTargetConfig.configDict[actId] then
			if not self._baseTargetConfig.configDict[actId][baseId] then
				local targetDict = {}

				for level, targetCo in pairs(targetDict) do
					table.insert(targetCoList, targetCo)
				end

				table.sort(targetCoList, function(a, b)
					return a.targetId < b.targetId
				end)
			end
		end
	end

	return targetCoList
end

function Season166Config:getSeasonTrainCos(actId)
	local trainCoList = self._trainCoList[actId]

	if not trainCoList then
		trainCoList = {}
		self._trainCoList[actId] = trainCoList

		local trainDict = self._trainConfig.configDict[actId]

		if trainDict then
			for trainId, cfg in pairs(trainDict) do
				table.insert(trainCoList, cfg)
			end

			table.sort(trainCoList, function(a, b)
				return a.trainId < b.trainId
			end)
		end
	end

	return trainCoList
end

function Season166Config:getSeasonTrainCo(actId, trainId)
	return self._trainConfig.configDict[actId] and self._trainConfig.configDict[actId][trainId]
end

function Season166Config:getSeasonTeachCos(teachId)
	return self._teachConfig.configDict[teachId]
end

function Season166Config:getAllSeasonTeachCos()
	return self._teachConfig.configList
end

function Season166Config:getSeasonScoreCo(actId, level)
	return self._scoreConfig.configDict[actId][level]
end

function Season166Config:getSeasonScoreCos(actId)
	return self._scoreConfig.configDict[actId]
end

function Season166Config:getSeasonInfos(actId)
	return self._infoConfig.configDict[actId]
end

function Season166Config:getSeasonInfoConfig(actId, infoId)
	return self._infoConfig.configDict[actId] and self._infoConfig.configDict[actId][infoId]
end

function Season166Config:getSeasonInfoAnalys(actId, infoId)
	return self._infoAnalyConfig.configDict[actId] and self._infoAnalyConfig.configDict[actId][infoId]
end

function Season166Config:getSeasonInfoBonuss(actId)
	return self._infoBonusConfig.configDict[actId]
end

function Season166Config:buildSeasonWordEffectConfig()
	self.wordEffectConfigMap = self.wordEffectConfigMap or {}

	local allConfigList = self._wordEffectConfig.configList

	for id, config in ipairs(allConfigList) do
		local wordEffectMap = self.wordEffectConfigMap[config.activityId]

		if not wordEffectMap then
			wordEffectMap = {}
			self.wordEffectConfigMap[config.activityId] = wordEffectMap
		end

		wordEffectMap[config.type] = wordEffectMap[config.type] or {}

		table.insert(wordEffectMap[config.type], config)
	end
end

function Season166Config:getSeasonWordEffectConfigList(actId, typeId)
	return self.wordEffectConfigMap[actId] and self.wordEffectConfigMap[actId][typeId]
end

function Season166Config:getSeasonWordEffectPosConfig(actId, id)
	return self._wordEffectPosConfig.configDict[actId] and self._wordEffectPosConfig.configDict[actId][id]
end

function Season166Config:getSeasonConfigByEpisodeId(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episodeCo.type
	local seasonConfig

	if episodeType and episodeType == DungeonEnum.EpisodeType.Season166Base then
		seasonConfig = self._episodeId2Config[episodeId]

		if not self._episodeId2Config[episodeId] then
			for index, config in ipairs(lua_activity166_base.configList) do
				if config.episodeId == episodeId then
					seasonConfig = config
					self._episodeId2Config[episodeId] = config

					return config
				end
			end
		end
	elseif episodeType and episodeType == DungeonEnum.EpisodeType.Season166Train then
		seasonConfig = self._episodeId2Config[episodeId]

		if not self._episodeId2Config[episodeId] then
			for index, config in ipairs(lua_activity166_train.configList) do
				if config.episodeId == episodeId then
					seasonConfig = config
					self._episodeId2Config[episodeId] = config

					return config
				end
			end
		end
	elseif episodeType and episodeType == DungeonEnum.EpisodeType.Season166Teach then
		seasonConfig = self._episodeId2Config[episodeId]

		if not self._episodeId2Config[episodeId] then
			for index, config in ipairs(lua_activity166_teach.configList) do
				if config.episodeId == episodeId then
					seasonConfig = config

					local chapterConfig = DungeonConfig.instance:getChapterCO(episodeCo.chapterId)

					seasonConfig.activityId = chapterConfig.actId
					self._episodeId2Config[episodeId] = seasonConfig

					return config
				end
			end
		end
	end

	return seasonConfig
end

function Season166Config:getBaseSpotByTalentId(activityId, talentId)
	for _, config in pairs(self._baseSpotConfig.configDict[activityId]) do
		if config.talentId == talentId then
			return config
		end
	end

	logError("talentId dont bind base" .. talentId)
end

function Season166Config:getAdditionScoreByParam(targetConfig, param)
	local params = string.splitToNumber(targetConfig.targetParam, "|")
	local scores = string.splitToNumber(targetConfig.score, "|")
	local index = tabletool.indexOf(params, param)

	return scores[index] or 0
end

Season166Config.instance = Season166Config.New()

return Season166Config
