-- chunkname: @modules/logic/matchgame/config/MatchGameConfig.lua

module("modules.logic.matchgame.config.MatchGameConfig", package.seeall)

local MatchGameConfig = class("MatchGameConfig", BaseConfig)

function MatchGameConfig:reqConfigNames()
	return {
		"activity244_const",
		"activity244_item",
		"activity244_character",
		"activity244_character_skill",
		"activity244_character_attr",
		"activity244_star_reward",
		"activity244_challenge_reward",
		"activity244_character_level",
		"activity244_talent",
		"activity244_talent_branch",
		"activity244_chapter",
		"activity244_episode",
		"activity244_episode_level"
	}
end

function MatchGameConfig:onConfigLoaded(configName, configTable)
	local func = self["process_" .. configName]

	if func then
		func(self, configTable)
	end
end

function MatchGameConfig:process_activity244_talent(configTable)
	self._branchList = {}
	self._teamTalentList = {}
	self._talentNodeCostMap = {}

	for _, v in ipairs(configTable.configList) do
		local branch = v.branch

		self._branchList[branch] = self._branchList[branch] or {}

		table.insert(self._branchList[branch], v)

		self._talentNodeCostMap[v.nodeId] = GameUtil.splitString2(v.costItemId, true)

		if not string.nilorempty(v.teamCondition) then
			table.insert(self._teamTalentList, v)
		end
	end

	for _, nodeList in pairs(self._branchList) do
		table.sort(nodeList, self._sortTalentNode)
	end

	self:buildTalentTeamCondition(configTable)
end

function MatchGameConfig._sortTalentNode(aNodeCo, bNodeCo)
	if aNodeCo.nodeIndex ~= bNodeCo.nodeIndex then
		return aNodeCo.nodeIndex < bNodeCo.nodeIndex
	else
		return aNodeCo.nodeId < bNodeCo.nodeId
	end
end

function MatchGameConfig:process_activity244_character(configTable)
	self._trialHeroList = {}
	self._notTrialHeroList = {}

	for _, characterCo in ipairs(configTable.configList) do
		local isTrial = characterCo.isTrial ~= 0

		if isTrial then
			table.insert(self._trialHeroList, characterCo)
		else
			table.insert(self._notTrialHeroList, characterCo)
		end
	end
end

function MatchGameConfig:process_activity244_character_level(configTable)
	self._levelTplMap = {}
	self._characterMaxLvMap = {}

	for _, levelCo in ipairs(configTable.configList) do
		local level = levelCo.level
		local tplId = levelCo.levelTplId

		self._levelTplMap[tplId] = self._levelTplMap[tplId] or {}
		self._levelTplMap[tplId][level] = levelCo

		if not self._characterMaxLvMap[tplId] then
			if self._characterMaxLvMap[tplId] < level then
				self._characterMaxLvMap[tplId] = level
			end
		end
	end
end

function MatchGameConfig:process_activity244_episode(configTable)
	self._chapterMap = {}
	self._chapterList = {}
	self._lastEpisodeMap = {}

	for _, episodeCo in ipairs(configTable.configList) do
		local levelType = self:getEpisodeLevelType(episodeCo.id)
		local chapterId = episodeCo.chapterId

		if levelType == MatchGameEnum.LevelType.Normal then
			local preEpisode = episodeCo.preEpisode

			self._lastEpisodeMap[chapterId] = self._lastEpisodeMap[chapterId] or {}
			self._lastEpisodeMap[chapterId][preEpisode] = episodeCo
		else
			local chapterMo = self:_getOrCreateChapterMo(chapterId)

			table.insert(chapterMo.episodeList, episodeCo)
		end
	end

	for chapterId, relationMap in pairs(self._lastEpisodeMap) do
		local lastEpisodeCo = relationMap[0]

		if lastEpisodeCo then
			local maxRunTime = 100

			while lastEpisodeCo do
				local chapterMo = self:_getOrCreateChapterMo(lastEpisodeCo.chapterId)

				table.insert(chapterMo.episodeList, lastEpisodeCo)

				lastEpisodeCo = relationMap[lastEpisodeCo.id]
				maxRunTime = maxRunTime - 1

				if maxRunTime <= 0 then
					logError("三消关卡解析死循环了!!!")

					break
				end
			end
		else
			logError(string.format("三消关卡配置没有起点 chapterId = %s", chapterId))
		end
	end

	local sortKeyTab = {
		"sortIndex",
		"id"
	}

	for _, chapterList in pairs(self._chapterList) do
		table.sort(chapterList, self._chapterMoSortFunc)
		SortUtil.tableKeyLower(chapterList, sortKeyTab)
	end
end

function MatchGameConfig._chapterMoSortFunc(aChapterMo, bChapterMo)
	if aChapterMo.chapterCo then
		if bChapterMo.chapterCo then
			local bSortIndex = bChapterMo.chapterCo.sortIndex

			if aChapterMo.chapterCo ~= bSortIndex then
				return aChapterMo.chapterCo < bSortIndex
			end

			return aChapterMo.chapterId < bChapterMo.chapterId
		end
	end
end

function MatchGameConfig:_getOrCreateChapterMo(chapterId)
	local chapterMo = self._chapterMap[chapterId]

	if not chapterMo then
		local chapterCo = lua_activity244_chapter.configDict[chapterId]
		local levelType = chapterCo and chapterCo.levelType

		chapterMo = {
			chapterId = chapterId,
			episodeList = {},
			chapterCo = chapterCo
		}
		self._chapterMap[chapterId] = chapterMo
		self._chapterList[levelType] = self._chapterList[levelType] or {}

		table.insert(self._chapterList[levelType], chapterMo)
	end

	return chapterMo
end

function MatchGameConfig:process_activity244_episode_level(configTable)
	self._levelConditionMap = {}
	self._levelConfig = configTable

	for _, levelCo in ipairs(configTable.configList) do
		self:_initLevelCondition(self._levelConditionMap, levelCo)
	end
end

function MatchGameConfig:_initLevelCondition(levelConditionMap, levelCo)
	levelConditionMap[levelCo.matchLevelId] = {}

	for i = 1, math.huge do
		local conditionStr = levelCo["levelGoal" .. i]

		if string.nilorempty(conditionStr) then
			break
		end

		local condition = string.splitToNumber(conditionStr, "#")

		table.insert(levelConditionMap[levelCo.matchLevelId], condition)
	end
end

function MatchGameConfig:getLevelConfig(matchLevelId)
	return self._levelConfig.configDict[matchLevelId]
end

function MatchGameConfig:process_activity244_star_reward(configTable)
	for _, rewardList in pairs(configTable.configDict) do
		table.sort(rewardList, self._starRewardSortFunc)
	end
end

function MatchGameConfig._starRewardSortFunc(aRewardCo, bRewardCo)
	return aRewardCo.star < bRewardCo.star
end

function MatchGameConfig:process_activity244_challenge_reward(configTable)
	for _, rewardList in pairs(configTable.configDict) do
		table.sort(rewardList, self._challengeRewardSortFunc)
	end
end

function MatchGameConfig._challengeRewardSortFunc(aRewardCo, bRewardCo)
	return aRewardCo.score < bRewardCo.score
end

function MatchGameConfig:getChapterListByLevelType(levelType)
	return self._chapterList and self._chapterList[levelType]
end

function MatchGameConfig:getChapterMo(chapterId)
	return self._chapterMap and self._chapterMap[chapterId]
end

function MatchGameConfig:getTalentNodeListByBranchType(branchId)
	if self._branchList then
		return self._branchList
	end
end

function MatchGameConfig:getAllTalentNodeList()
	return self._branchList
end

function MatchGameConfig:getTalentNodeCost(nodeId)
	return self._talentNodeCostMap and self._talentNodeCostMap[nodeId]
end

function MatchGameConfig:process_activity244_const(configTable)
	self._constConfig = configTable
	self.chainRateDataList = {}
end

function MatchGameConfig:getCharacterLevelTpl(characterId, characterLv)
	local characterCo = lua_activity244_character.configDict[characterId]
	local levelTplId = characterCo and characterCo.levelTplId

	return self._levelTplMap[levelTplId] and self._levelTplMap[levelTplId][characterLv]
end

function MatchGameConfig:getCharacterMaxLevel(characterId)
	local characterCo = lua_activity244_character.configDict[characterId]
	local levelTplId = characterCo and characterCo.levelTplId

	return (self._characterMaxLvMap or nil) and (self._characterMaxLvMap[levelTplId] or 0)
end

function MatchGameConfig:getCharacterAttrValue(characterId, characterLv, attrType)
	local cacheAttrValue = self:_getCacheCharacterAttrValue(characterId, characterLv, attrType)

	if cacheAttrValue then
		return cacheAttrValue
	end

	if characterLv <= 0 then
		local baseValue = self:getCharacterBaseAttrValue(characterId, attrType)

		self:_cacheCharacterAttrValue(characterId, characterLv, attrType, baseValue)

		return baseValue
	end

	local levelTpl = self:getCharacterLevelTpl(characterId, characterLv)
	local attrCo = lua_activity244_character_attr.configDict[attrType]
	local attrFieldName = attrCo and attrCo.addFieldName
	local attrValue = levelTpl and levelTpl[attrFieldName]

	attrValue = attrValue or 0

	local totalValue = attrValue + self:getCharacterAttrValue(characterId, characterLv - 1, attrType) or 0

	self:_cacheCharacterAttrValue(characterId, characterLv, attrType, totalValue)

	return totalValue
end

function MatchGameConfig:_getCacheCharacterAttrValue(characterId, characterLv, attrType)
	if self._cacheCharacterAttrMap then
		local cacheLevelList = self._cacheCharacterAttrMap[characterId]
		local cacheAttrMap = cacheLevelList and cacheLevelList[characterLv]

		return cacheAttrMap and cacheAttrMap[attrType]
	end
end

function MatchGameConfig:_cacheCharacterAttrValue(characterId, characterLv, attrType, attrValue)
	self._cacheCharacterAttrMap = self._cacheCharacterAttrMap or {}
	self._cacheCharacterAttrMap[characterId] = self._cacheCharacterAttrMap[characterId] or {}
	self._cacheCharacterAttrMap[characterId][characterLv] = self._cacheCharacterAttrMap[characterId][characterLv] or {}
	self._cacheCharacterAttrMap[characterId][characterLv][attrType] = attrValue
end

function MatchGameConfig:getCharacterBaseAttrValue(characterId, attrType)
	local characterCo = lua_activity244_character.configDict[characterId]
	local attrCo = lua_activity244_character_attr.configDict[attrType]
	local attrFieldName = attrCo and attrCo.baseFieldName
	local baseAttrValue = characterCo and characterCo[attrFieldName]

	return baseAttrValue or 0
end

function MatchGameConfig:getLevelConditionList(levelId)
	return self._levelConditionMap and self._levelConditionMap[levelId]
end

function MatchGameConfig:getNextEpisodeConfig(episodeId)
	local episodeCo = lua_activity244_episode.configDict[episodeId]
	local levelType = self:getEpisodeLevelType(episodeId)

	if not episodeCo or levelType ~= MatchGameEnum.LevelType.Normal then
		return
	end

	if self._chapterList then
		local chapterList = self._chapterList[levelType]

		if not chapterList then
			return
		end

		for i, chapterMo in ipairs(chapterList) do
			if chapterMo.chapterId == episodeCo.chapterId then
				for j, config in ipairs(chapterMo.episodeList) do
					if config.id == episodeId and chapterMo.episodeList[j + 1] then
						return chapterMo.episodeList[j + 1]
					end
				end

				local nextChapterMo = chapterList[i + 1]
				local nextEpisodeList = nextChapterMo and nextChapterMo.episodeList

				return nextEpisodeList and nextEpisodeList[1]
			end
		end
	end
end

function MatchGameConfig:getChallengeNextScoreReward(actId, score)
	local rewardList = lua_activity244_challenge_reward.configDict[actId]

	if rewardList then
		local preRewardCo = rewardList[1]

		for _, rewardCo in ipairs(rewardList) do
			preRewardCo = rewardCo

			if score < rewardCo.score then
				break
			end
		end

		return preRewardCo
	end
end

function MatchGameConfig:getRewardTotalScore(actId, rewardType)
	if rewardType == MatchGameEnum.RewardType.Normal then
		local rewardList = lua_activity244_star_reward.configDict[actId]
		local lastRewardCo = rewardList and rewardList[#rewardList]

		return (lastRewardCo or nil) and (lastRewardCo.star or 0), lastRewardCo
	elseif rewardType == MatchGameEnum.RewardType.Challenge then
		local rewardList = lua_activity244_challenge_reward.configDict[actId]
		local lastRewardCo = rewardList and rewardList[#rewardList]

		return (lastRewardCo or nil) and (lastRewardCo.score or 0), lastRewardCo
	end
end

function MatchGameConfig:getRewardScore(rewardType, actId, rewardId)
	if rewardType == MatchGameEnum.RewardType.Normal then
		local rewardCo = lua_activity244_star_reward.configDict[actId][rewardId]

		return (rewardCo or nil) and (rewardCo.star or 0)
	elseif rewardType == MatchGameEnum.RewardType.Challenge then
		local rewardCo = lua_activity244_challenge_reward.configDict[actId][rewardId]

		return (rewardCo or nil) and (rewardCo.score or 0)
	end
end

function MatchGameConfig:getHeroSkillConfig(skillId)
	return lua_activity244_character_skill.configDict[skillId]
end

function MatchGameConfig:getCharacterConfig(characterId)
	return lua_activity244_character.configDict[characterId]
end

function MatchGameConfig:getCharacterLevelUpCost(characterId, level)
	if self._cacheCharacterLvUpCost then
		local costItemMap = self._cacheCharacterLvUpCost[characterId]
		local costItemList = costItemMap and costItemMap[level]

		if not costItemList then
			costItemMap = costItemMap or {}
			self._cacheCharacterLvUpCost = self._cacheCharacterLvUpCost or {}
			self._cacheCharacterLvUpCost[characterId] = costItemMap

			local levelUpTpl = self:getCharacterLevelTpl(characterId, level)

			costItemList = levelUpTpl and GameUtil.splitString2(levelUpTpl.needItem, true)
			costItemMap[level] = costItemList
		end

		return costItemList
	end
end

function MatchGameConfig:getEpisodeLevelType(episodeId)
	local episodeCo = lua_activity244_episode.configDict[episodeId]
	local chapterId = episodeCo and episodeCo.chapterId
	local chapterCo = lua_activity244_chapter.configDict[chapterId]

	return chapterCo and chapterCo.levelType
end

function MatchGameConfig:getConstValue(activityId, constId, isNumber)
	local constDict = self._constConfig.configDict[activityId]
	local constCo = constDict and constDict[constId]
	local value = constCo and constCo.value

	if isNumber then
		value = tonumber(value)
	end

	return value
end

function MatchGameConfig:getLevelConfigByEpisodeId(episodeId)
	local episodeCo = lua_activity244_episode.configDict[episodeId]

	return lua_activity244_episode_level.configDict[episodeCo.matchLevelId]
end

function MatchGameConfig:isTeachEpisode(episodeId)
	local levelCo = self:getLevelConfigByEpisodeId(episodeId)

	return levelCo and levelCo.useTemp == 1
end

function MatchGameConfig:getEpisodeRoleNum(episodeId)
	local levelCo = self:getLevelConfigByEpisodeId(episodeId)

	return (levelCo or nil) and (levelCo.roleNum or 0)
end

function MatchGameConfig:getTrialHeroInfoList(episodeId)
	self._trialHeroInfoMap = self._trialHeroInfoMap or {}

	local trialHeroList = self._trialHeroInfoMap[episodeId]

	if not trialHeroList then
		local levelCo = self:getLevelConfigByEpisodeId(episodeId)

		if levelCo then
			if not levelCo.trialHeros then
				local trialHeros = ""

				trialHeroList = GameUtil.splitString2(trialHeros, true)
				self._trialHeroInfoMap[episodeId] = trialHeroList
			end
		end
	end

	return trialHeroList
end

function MatchGameConfig:getNotTrialCharacterList()
	return self._notTrialHeroList
end

function MatchGameConfig:buildTalentTeamCondition(configTable)
	self.talentTeamConditionMap = {}

	for index, config in ipairs(configTable.configList) do
		if not string.nilorempty(config.teamCondition) then
			self.talentTeamConditionMap[config.skillId] = GameUtil.splitString2(config.teamCondition, true)
		end
	end
end

function MatchGameConfig:getTeamConditionData(skillId)
	return self.talentTeamConditionMap[skillId]
end

function MatchGameConfig:getAllTeamTalentList()
	return self._teamTalentList
end

MatchGameConfig.instance = MatchGameConfig.New()

return MatchGameConfig
