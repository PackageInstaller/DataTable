-- chunkname: @modules/logic/seasonver/act123/config/Season123Config.lua

local Season123Config = class("Season123Config", BaseConfig)

function Season123Config:ctor()
	return
end

function Season123Config:reqConfigNames()
	return {
		"activity123_const",
		"activity123_stage",
		"activity123_episode",
		"task_activity123",
		"activity123_equip",
		"activity123_equip_attr",
		"activity123_equip_tag",
		"activity123_story",
		"activity123_retail",
		"activity123_trial",
		"activity123_stage_reward"
	}
end

function Season123Config:onConfigLoaded(configName, configTable)
	if configName == "activity123_const" then
		self._constConfig = configTable
	elseif configName == "activity123_stage" then
		self._stageConfig = configTable
		self._actId2StageList = {}
	elseif configName == "activity123_episode" then
		self._episodeConfig = configTable
	elseif configName == "activity123_equip" then
		self._equipConfig = configTable

		self:preprocessEquip()
	elseif configName == "activity123_equip_attr" then
		self._equipAttrConfig = configTable
	elseif configName == "activity123_equip_tag" then
		self._equipTagConfig = configTable
	elseif configName == "activity123_story" then
		self._storyConfig = configTable
	elseif configName == "task_activity123" then
		self._taskConfig = configTable
	elseif configName == "activity123_retail" then
		self._retailConfig = configTable
	elseif configName == "activity123_trial" then
		self._trialConfig = configTable
	elseif configName == "activity123_stage_reward" then
		self._stageRewardConfig = configTable
	end
end

function Season123Config:preprocessEquip()
	self._equipIsOptionalDict = {}

	for _, cfg in pairs(self._equipConfig.configList) do
		if cfg.isOptional == 1 then
			self._equipIsOptionalDict[cfg.equipId] = true
		end
	end
end

function Season123Config:getStageCos(actId)
	local stageList = self._actId2StageList[actId]

	if not stageList then
		stageList = {}
		self._actId2StageList[actId] = stageList

		local stageDict = self._stageConfig.configDict[actId]

		if stageDict then
			for stage, cfg in pairs(stageDict) do
				table.insert(stageList, cfg)
			end

			table.sort(stageList, function(a, b)
				return a.stage < b.stage
			end)
		end
	end

	return stageList
end

function Season123Config:getStageCo(actId, stage)
	return self._stageConfig.configDict[actId] and self._stageConfig.configDict[actId][stage]
end

function Season123Config:getSeasonEpisodeStageCos(actId, stage)
	return self._episodeConfig.configDict[actId] and self._episodeConfig.configDict[actId][stage]
end

function Season123Config:getSeasonEpisodeCo(actId, stage, layer)
	if self._episodeConfig.configDict[actId] and self._episodeConfig.configDict[actId][stage] then
		return self._episodeConfig.configDict[actId][stage][layer]
	end
end

function Season123Config:getAllSeasonEpisodeCO(actId)
	if not self._allEpisodeCOList or not self._allEpisodeCOList[actId] then
		self._allEpisodeCOList = self._allEpisodeCOList or {}

		local allList = {}

		if self._episodeConfig.configDict[actId] then
			for stage, stageDict in pairs(self._episodeConfig.configDict[actId]) do
				for layer, episodeCO in pairs(stageDict) do
					table.insert(allList, episodeCO)
				end
			end

			table.sort(allList, function(a, b)
				if a.stage ~= b.stage then
					return a.stage < b.stage
				else
					return a.layer < b.layer
				end
			end)
		end

		self._allEpisodeCOList[actId] = allList
	end

	return self._allEpisodeCOList[actId]
end

function Season123Config:getSeasonEpisodeByStage(actId, stage)
	local result = {}
	local cfgList = self:getSeasonEpisodeStageCos(actId, stage)

	if cfgList then
		for i, cfg in pairs(cfgList) do
			if stage == cfg.stage then
				table.insert(result, cfg)
			end
		end

		table.sort(result, function(a, b)
			return a.layer < b.layer
		end)
	else
		logNormal(string.format("cfgList is nil, actId = %s, stage = %s", actId, stage))
	end

	return result
end

function Season123Config:getSeasonConstCo(constId)
	return self._constConfig.configDict[constId]
end

function Season123Config:getSeasonEquipCos()
	return self._equipConfig.configDict
end

function Season123Config:getSeasonEquipCo(equipId)
	return self._equipConfig.configDict[equipId]
end

function Season123Config:getSeasonOptionalEquipCos()
	local cos = {}

	for _, v in pairs(self._equipConfig.configDict) do
		if v.isOptional == 1 then
			table.insert(cos, v)
		end
	end

	return cos
end

function Season123Config:getSeasonTagList()
	return self._equipTagConfig.configList
end

function Season123Config:getSeasonTagDesc(id)
	return self._equipTagConfig.configDict[id]
end

function Season123Config:getEquipIsOptional(equipId)
	return self._equipIsOptionalDict[equipId]
end

function Season123Config:getEquipCoByCondition(filterFunc)
	local list = {}

	for _, cfg in ipairs(self._equipConfig.configList) do
		if filterFunc(cfg) then
			table.insert(list, cfg)
		end
	end

	return list
end

function Season123Config:getSeasonEquipAttrCo(attrId)
	return self._equipAttrConfig.configDict[attrId]
end

function Season123Config:getConfigByEpisodeId(episodeId)
	self:_initEpisodeId2Config()

	return self._episodeId2Config and self._episodeId2Config[episodeId]
end

function Season123Config:getRetailCOByEpisodeId(episodeId)
	self:_initEpisodeId2RetailCO()

	return self._episodeId2RetailCO and self._episodeId2RetailCO[episodeId]
end

function Season123Config:getTrailCOByEpisodeId(episodeId)
	self:_initEpisodeId2TrailCO()

	return self._episodeId2TrailCO and self._episodeId2TrailCO[episodeId]
end

function Season123Config:_initEpisodeId2Config()
	if self._episodeId2Config then
		return
	end

	self._episodeId2Config = {}

	for actId, stageDict in pairs(self._episodeConfig.configDict) do
		for stage, layerDict in pairs(stageDict) do
			for layer, co in pairs(layerDict) do
				self._episodeId2Config[co.episodeId] = co
			end
		end
	end
end

function Season123Config:_initEpisodeId2RetailCO()
	if self._episodeId2RetailCO then
		return
	end

	self._episodeId2RetailCO = {}

	for actId, coDict in pairs(self._retailConfig.configDict) do
		for id, co in pairs(coDict) do
			self._episodeId2RetailCO[co.episodeId] = co
		end
	end
end

function Season123Config:_initEpisodeId2TrailCO()
	if self._episodeId2TrailCO then
		return
	end

	self._episodeId2TrailCO = {}

	for actId, coDict in pairs(self._trialConfig.configDict) do
		for id, co in pairs(coDict) do
			self._episodeId2TrailCO[co.episodeId] = co
		end
	end
end

function Season123Config:getEquipItemCoin(actId, constId)
	return self:getSeasonConstNum(actId, constId)
end

function Season123Config:getSeasonConstNum(actId, constId)
	if not self._constConfig.configDict[actId] or not self._constConfig.configDict[actId][constId] then
		return nil
	end

	return self._constConfig.configDict[actId][constId].value1
end

function Season123Config:getSeasonConstStr(actId, constId)
	if not self._constConfig.configDict[actId] or not self._constConfig.configDict[actId][constId] then
		return nil
	end

	return self._constConfig.configDict[actId][constId].value2
end

function Season123Config:getSeasonConstLangStr(actId, constId)
	if not self._constConfig.configDict[actId] or not self._constConfig.configDict[actId][constId] then
		return nil
	end

	return self._constConfig.configDict[actId][constId].value3
end

function Season123Config:getAllStoryCo(actId)
	return self._storyConfig.configDict[actId]
end

function Season123Config:getStoryConfig(actId, storyId)
	return self._storyConfig.configDict[actId][storyId]
end

function Season123Config:getSeason123TaskCo(taskId)
	return self._taskConfig.configDict[taskId]
end

function Season123Config:getSeason123AllTaskList()
	return self._taskConfig.configList
end

function Season123Config:getRetailCO(actId, retailId)
	if self._retailConfig.configDict[actId] then
		return self._retailConfig.configDict[actId][retailId]
	end
end

function Season123Config:getRecommendCareers(actId, stage)
	local stageCO = self:getStageCo(actId, stage)

	if stageCO and not string.nilorempty(stageCO.recommend) then
		return string.split(stageCO.recommend, "#")
	end
end

function Season123Config:getRecommendTagCoList(actId, stage)
	local stageCO = self:getStageCo(actId, stage)
	local tagCoList = {}

	if stageCO and not string.nilorempty(stageCO.recommendSchool) then
		local tagList = string.splitToNumber(stageCO.recommendSchool, "#")
		local tagDescDict = self:getSeasonTagDesc(actId)

		for _, tagId in ipairs(tagList) do
			if tagDescDict[tagId] then
				table.insert(tagCoList, tagDescDict[tagId])
			end
		end
	end

	return tagCoList
end

function Season123Config:filterRule(ruleList, stage)
	local list = {}

	if ruleList then
		local actId = Season123Model.instance:getCurSeasonId()

		if not actId then
			return
		end

		for k, v in pairs(ruleList) do
			if not self:isExistInRuleTips(actId, stage, v[2]) then
				table.insert(list, v)
			end
		end
	end

	return list
end

function Season123Config:isExistInRuleTips(actId, stage, ruleId)
	self.ruleDict = self.ruleDict or {}
	self.ruleDict[actId] = self.ruleDict[actId] or {}

	local stageDict = self.ruleDict[actId][stage]

	if not stageDict then
		stageDict = self:getRuleTips(actId, stage)
		self.ruleDict[actId][stage] = stageDict
	end

	return self.ruleDict[actId][stage][ruleId] ~= nil
end

function Season123Config:getRuleTips(actId, stage)
	local curActStageList = self:getStageCos(actId)
	local stageCo = curActStageList[stage]
	local list = {}

	if stage then
		if not stageCo then
			self.emptyTips = self.emptyTips or {}

			return self.emptyTips
		end

		list = string.splitToNumber(stageCo.stageCondition, "#")
	else
		local stageCondition = self:getSeasonConstStr(actId, Activity123Enum.Const.HideRule)

		list = string.splitToNumber(stageCondition, "#")
	end

	local dict = {}

	for i, ruleId in ipairs(list) do
		dict[ruleId] = true
	end

	return dict
end

function Season123Config:getTrialCO(actId, layer)
	local dict = self._trialConfig.configDict[actId]

	if dict then
		return dict[layer]
	end

	return nil
end

function Season123Config:getTaskListenerParamCache(taskCO)
	self.taskListenerParamCache = self.taskListenerParamCache or {}

	local cacheList = self.taskListenerParamCache[taskCO]

	if not cacheList then
		cacheList = string.split(taskCO.listenerParam, "#")
		self.taskListenerParamCache[taskCO] = cacheList
	end

	return cacheList
end

function Season123Config:getRewardTaskCount(actId, stage)
	self:checkInitRewardTaskCount()

	if self._taskCountDict[actId] then
		return self._taskCountDict[actId][stage] or 0
	end

	return 0
end

function Season123Config:checkInitRewardTaskCount()
	if not self._taskCountDict then
		self._taskCountDict = {}

		local taskCOList = self:getSeason123AllTaskList()

		for _, taskCO in ipairs(taskCOList) do
			if taskCO.isRewardView == 1 then
				self._taskCountDict[taskCO.seasonId] = self._taskCountDict[taskCO.seasonId] or {}

				local paramArr = self:getTaskListenerParamCache(taskCO)

				if #paramArr > 0 then
					local stage = tonumber(paramArr[1])

					if not self._taskCountDict[taskCO.seasonId][stage] then
						local stageCount = 0

						stageCount = stageCount + 1
						self._taskCountDict[taskCO.seasonId][stage] = stageCount
					end
				end
			end
		end
	end
end

function Season123Config:getCardLimitPosDict(itemId)
	local itemCO = self:getSeasonEquipCo(itemId)

	if not itemCO or string.nilorempty(itemCO.indexLimit) then
		return nil
	else
		self._indexLimitDict = self._indexLimitDict or {}
		self._indexLimitStrDict = self._indexLimitStrDict or {}

		local dict = self._indexLimitDict[itemId]
		local rsStr = self._indexLimitStrDict[itemId]

		if not dict then
			dict = {}

			local list = string.splitToNumber(itemCO.indexLimit, "#")

			rsStr = ""

			for i, pos in ipairs(list) do
				dict[pos] = true
				rsStr = not string.nilorempty(rsStr) and rsStr .. "," .. tostring(pos) or tostring(pos)
			end

			self._indexLimitDict[itemId] = dict
			self._indexLimitStrDict[itemId] = rsStr
		end

		return dict, rsStr
	end
end

function Season123Config:isLastStage(actId, stage)
	return stage == tabletool.len(self._stageConfig.configDict[actId])
end

function Season123Config:getCardSpecialEffectCache(equipId)
	self.cardEffectCache = self.cardEffectCache or {}

	local cacheMap = self.cardEffectCache[equipId]

	if not cacheMap then
		cacheMap = {}

		local equipConfig = self:getSeasonEquipCo(equipId)
		local effectList = GameUtil.splitString2(equipConfig.specialEffect, true) or {}
		local effectParam = {}

		for index, effect in ipairs(effectList) do
			local effectId = effect[1]

			for i = 2, #effect do
				table.insert(effectParam, effect[i])
			end

			cacheMap[effectId] = effectParam
		end

		self.cardEffectCache[equipId] = cacheMap
	end

	return cacheMap
end

function Season123Config:getCardSpecialEffectMap(equipId)
	local equipCo = self:getSeasonEquipCo(equipId)

	if equipCo then
		return self:getCardSpecialEffectCache(equipCo.equipId) or {}
	end
end

function Season123Config:getSeasonEpisodeTotalStar(episodeId)
	local advancedCondition = DungeonConfig.instance:getEpisodeAdvancedCondition(episodeId)
	local conditionList = string.splitToNumber(advancedCondition, "|")

	if #conditionList == 0 then
		return 2
	end

	return #conditionList + 1
end

function Season123Config:getStageRewardList(actId, stage)
	if not self._stageRewardDict then
		self._stageRewardDict = {}

		for _, rewardCo in ipairs(self._stageRewardConfig.configList) do
			self._stageRewardDict[rewardCo.activityId] = self._stageRewardDict[rewardCo.activityId] or {}
			self._stageRewardDict[rewardCo.activityId][rewardCo.stageId] = self._stageRewardDict[rewardCo.activityId][rewardCo.stageId] or {}

			table.insert(self._stageRewardDict[rewardCo.activityId][rewardCo.stageId], rewardCo)
		end

		for _, stageDict in pairs(self._stageRewardDict) do
			for _, rewardList in pairs(stageDict) do
				table.sort(rewardList, SortUtil.keyLower("star"))
			end
		end
	end

	local dict = self._stageRewardDict[actId]

	if not dict then
		dict = {}
		self._stageRewardDict[actId] = dict
	end

	return dict[stage] or {}
end

Season123Config.instance = Season123Config.New()

return Season123Config
