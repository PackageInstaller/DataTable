-- chunkname: @modules/logic/matchgame/model/MatchGameModel.lua

module("modules.logic.matchgame.model.MatchGameModel", package.seeall)

local MatchGameModel = class("MatchGameModel", BaseModel)

function MatchGameModel:onInit()
	self:reInit()
end

function MatchGameModel:reInit()
	self._activityId = nil
	self.heroMap = nil
	self.itemMap = nil
	self.talentMap = {}
	self.receivedBonusId = 0
	self.episodeMap = nil
	self.challengeMo = nil
	self.newCharacterList = {}
end

function MatchGameModel:onUpdateInfo(msg)
	self._activityId = msg.activityId
	self.talentMap = GameUtil.rpcInfosToMap(msg.talents, MatchGameTalentMo, "talentId", self.talentMap)
	self.heroMap = GameUtil.rpcInfosToMap(msg.heros, MatchGameCharacterMo, "heroId", self.heroMap)
	self.itemMap = GameUtil.rpcInfosToMap(msg.items, MatchGameItemMo, "itemId", self.itemMap)
	self.receivedBonusId = msg.receivedBonusId
	self.episodeMap = GameUtil.rpcInfosToMap(msg.episodes, MatchGameEpisodeMo, "episodeId", self.episodeMap)
	self.challengeMo = GameUtil.rpcInfoToMo(msg.challenge, MatchGameChallengeMo, self.challengeMo)
	self.teamMap = GameUtil.rpcInfosToMap(msg.teams, MatchGameTeamMo, "index", self.teamMap)
	self.teamIndex = msg.teamIndex

	self:updateNormalScore()
	self:updateTalentAttrChangeMap()
	MatchGameController.instance:initTalentRedDot()
end

function MatchGameModel:updateNormalScore()
	self.normalScore = 0

	for _, episodeMo in pairs(self.episodeMap) do
		self.normalScore = self.normalScore + episodeMo.starNum
	end
end

function MatchGameModel:onUpdateCharacterInfo(characterInfo)
	local heroId = characterInfo.heroId
	local characterMo = self.heroMap[heroId]

	characterMo = GameUtil.rpcInfoToMo(characterInfo, MatchGameCharacterMo, characterMo)
	self.heroMap[heroId] = characterMo

	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnUpdateCharacter, heroId)
end

function MatchGameModel:onUpdateTalentInfo(talentInfo)
	local talentId = talentInfo.talentId
	local talentMo = self.talentMap[talentId]

	talentMo = GameUtil.rpcInfoToMo(talentInfo, MatchGameTalentMo, talentMo)
	self.talentMap[talentId] = talentMo

	MatchGameController.instance:initTalentRedDot()
	self:updateTalentAttrChangeMap()
	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnUpdateTalentInfo, talentId)
end

function MatchGameModel:onResetTalent(branchId)
	local nodeList = MatchGameConfig.instance:getTalentNodeListByBranchType(branchId)

	if not nodeList then
		return
	end

	for _, nodeCo in ipairs(nodeList) do
		local nodeId = nodeCo.nodeId

		self.talentMap[nodeId] = nil
	end

	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnUpdateTalentInfo)
	self:updateTalentAttrChangeMap()
	MatchGameController.instance:initTalentRedDot()
end

function MatchGameModel:onUpdateItemInfoList(itemInfoList)
	local updateItemIdMap = {}

	for _, itemInfo in ipairs(itemInfoList) do
		local itemId = itemInfo.itemId
		local itemMo = self.itemMap[itemId]

		itemMo = GameUtil.rpcInfoToMo(itemInfo, MatchGameItemMo, itemMo)
		self.itemMap[itemId] = itemMo
		updateItemIdMap[itemId] = true
	end

	MatchGameController.instance:initTalentRedDot()
	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnUpdateItemInfo, updateItemIdMap)
end

function MatchGameModel:onUpdateEpisodeInfo(msg)
	local hasUpdateEpisode = false

	for _, episodeInfo in ipairs(msg.updateEpisodes) do
		self.episodeMap = self.episodeMap or {}

		local episodeId = episodeInfo.episodeId
		local episodeMo = self.episodeMap[episodeId]

		episodeMo = GameUtil.rpcInfoToMo(episodeInfo, MatchGameEpisodeMo, episodeMo)
		self.episodeMap[episodeId] = episodeMo
		hasUpdateEpisode = true
	end

	for _, characterInfo in ipairs(msg.updateHeros) do
		local heroId = characterInfo.heroId
		local characterMo = self.heroMap[heroId]

		if not characterMo then
			table.insert(self.newCharacterList, heroId)
		end

		characterMo = GameUtil.rpcInfoToMo(characterInfo, MatchGameCharacterMo, characterMo)
		self.heroMap[heroId] = characterMo
	end

	if hasUpdateEpisode then
		self:updateNormalScore()
	end

	if msg and msg:HasField("updateChallenge") then
		self.challengeMo = GameUtil.rpcInfoToMo(msg.updateChallenge, MatchGameChallengeMo, self.challengeMo)
	end

	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnUpdateCharacter)
	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnUpdateEpisodeInfo)
end

function MatchGameModel:getItemCount(itemId)
	if self.itemMap then
		return (self.itemMap or nil) and (self.itemMap.num or 0)
	end
end

function MatchGameModel:isItemEnough(allItemList)
	if not allItemList then
		return true
	end

	for _, itemList in ipairs(allItemList) do
		local itemId = itemList[1]
		local itemNum = itemList[2]

		if itemNum > self:getItemCount(itemId) then
			return false
		end
	end

	return true
end

function MatchGameModel:getTalentNode(nodeId)
	return self.talentMap and self.talentMap[nodeId]
end

function MatchGameModel:getTalentNodeStatus(nodeId)
	local status = MatchGameEnum.TalentNodeStatus.Lock

	if self.talentMap[nodeId] then
		status = MatchGameEnum.TalentNodeStatus.Active
	else
		local talentCo = lua_activity244_talent.configDict[nodeId]
		local preNodeStatus = talentCo and self:getTalentNodeStatus(talentCo.prevNodeId)

		if not preNodeStatus or talentCo.prevNodeId == 0 or preNodeStatus == MatchGameEnum.TalentNodeStatus.Active then
			status = MatchGameEnum.TalentNodeStatus.Unlock
		end
	end

	return status
end

function MatchGameModel:getCharacterMo(characterId)
	return self.heroMap and self.heroMap[characterId]
end

function MatchGameModel:getAllCharacterMo()
	return self.heroMap
end

function MatchGameModel:getCharacterStatus(characterId)
	local characterMo = self:getCharacterMo(characterId)

	return (characterMo or nil) and (MatchGameEnum.CharacterStatus.Unlock or MatchGameEnum.CharacterStatus.Lock)
end

function MatchGameModel:getEpisodeInfoById(episodeId)
	local levelType = MatchGameConfig.instance:getEpisodeLevelType(episodeId)

	if levelType == MatchGameEnum.LevelType.Challenge then
		return self.challengeMo and self.challengeMo:getEpisodeMo(episodeId)
	end

	return self.episodeMap and self.episodeMap[episodeId]
end

function MatchGameModel:getEpisodeStatus(episodeId)
	local status = MatchGameEnum.EpisodeStatus.Lock
	local episodeCo = lua_activity244_episode.configDict[episodeId]

	if not episodeCo then
		return status
	end

	local levelType = MatchGameConfig.instance:getEpisodeLevelType(episodeId)

	if levelType == MatchGameEnum.LevelType.Challenge then
		if self.challengeMo and self.challengeMo:isEpisodeOpen(episodeId) then
			status = MatchGameEnum.EpisodeStatus.Unlock
		end
	else
		local episodeInfo = self:getEpisodeInfoById(episodeId)

		if episodeInfo then
			status = episodeInfo.isPass and MatchGameEnum.EpisodeStatus.Finish or MatchGameEnum.EpisodeStatus.Unlock
		end
	end

	return status
end

function MatchGameModel:checkEpisodeOpen(episodeId, showToast)
	local status = self:getEpisodeStatus(episodeId)

	if status >= MatchGameEnum.EpisodeStatus.Unlock then
		return true
	end

	local episodeType = MatchGameConfig.instance:getEpisodeLevelType(episodeId)

	if episodeType == MatchGameEnum.LevelType.Challenge and showToast then
		local episodeMo = self:getEpisodeInfoById(episodeId)

		if episodeMo then
			if not episodeMo.nextRoundTime then
				local nextRoundTime = 0

				if nextRoundTime > 0 then
					local remainTime = TimeUtil.SecondToActivityTimeFormat(nextRoundTime / 1000 - ServerTime.now())

					GameFacade.showToast(ToastEnum.MatchGameChallengeEpisodeTime, remainTime)
				else
					GameFacade.showToastString(luaLang("matchgamebossitem_end"))
				end
			end
		end
	end
end

function MatchGameModel:getCurRewardScore(rewardType)
	if rewardType == MatchGameEnum.RewardType.Normal then
		return self.normalScore
	elseif rewardType == MatchGameEnum.RewardType.Challenge then
		return (self.challengeMo or nil) and (self.challengeMo.totalScore or 0)
	else
		logError(string.format("三消奖励分数获取错误，奖励类型不存在 rewardType = %s", rewardType))
	end
end

function MatchGameModel:getCurActId()
	return self._activityId or MatchGameFightEnum.activityId
end

function MatchGameModel:getReceivedBonusId(rewardType)
	if rewardType == MatchGameEnum.RewardType.Normal then
		return self.receivedBonusId
	elseif rewardType == MatchGameEnum.RewardType.Challenge then
		return self.challengeMo and self.challengeMo.receivedBonusId
	end
end

function MatchGameModel:getRewardStatus(rewardType, rewardCo)
	local curScore = self:getCurRewardScore(rewardType)
	local rewardScore = MatchGameConfig.instance:getRewardScore(rewardType, rewardCo.activityId, rewardCo.id)

	if rewardScore <= curScore then
		local receiveBonusId = self:getReceivedBonusId(rewardType)
		local receiveBonusScore = MatchGameConfig.instance:getRewardScore(rewardType, rewardCo.activityId, receiveBonusId) or 0

		if rewardScore <= receiveBonusScore then
			return MatchGameEnum.RewardItemStatus.Gained
		end

		return MatchGameEnum.RewardItemStatus.CanGet
	end

	return MatchGameEnum.RewardItemStatus.Normal
end

function MatchGameModel:isChallengeUnlock()
	local chapterList = MatchGameConfig.instance:getChapterListByLevelType(MatchGameEnum.LevelType.Challenge)

	if chapterList then
		for _, chapterMo in ipairs(chapterList or {}) do
			local unlock, toastId, toastParam = MatchGameHelper.isChapterUnlock(chapterMo.chapterId)

			if not unlock then
				return unlock, toastId, toastParam
			end
		end
	end

	if self.challengeMo then
		local unlock = self.challengeMo:isUnlock()

		if not unlock then
			return unlock, ToastEnum.MatchGameLockChallenge
		end

		return true
	end
end

function MatchGameModel:getTeamMo(teamIndex)
	return self.teamMap and self.teamMap[teamIndex]
end

function MatchGameModel:getCurTeamIndex()
	return self.teamIndex
end

function MatchGameModel:updateTeamInfo(teamIndex, teamInfo)
	self:updateTeamIndex(teamIndex)

	local teamMo = self:getTeamMo(teamInfo.index)

	teamMo = GameUtil.rpcInfoToMo(teamInfo, MatchGameTeamMo, teamMo)
	self.teamMap[teamMo.index] = teamMo
end

function MatchGameModel:updateTeamIndex(teamIndex)
	self.teamIndex = teamIndex
end

function MatchGameModel:getMaxUnlockEpisodeId()
	local maxEpisodeId = 0
	local chapterList = MatchGameConfig.instance:getChapterListByLevelType(MatchGameEnum.LevelType.Normal)

	if chapterList then
		for _, chapterMo in ipairs(chapterList) do
			local isUnlock = MatchGameHelper.isChapterUnlock(chapterMo.chapterId)

			if not isUnlock then
				break
			end

			local episodeList = chapterMo and chapterMo.episodeList

			for _, episodeCo in ipairs(episodeList or {}) do
				local status = self:getEpisodeStatus(episodeCo.id)

				if status and status < MatchGameEnum.EpisodeStatus.Unlock then
					return maxEpisodeId
				end

				maxEpisodeId = episodeCo.id
			end
		end
	end

	return maxEpisodeId
end

function MatchGameModel:getChapterStatus(chapterId)
	local isUnlock = MatchGameHelper.isChapterUnlock(chapterId)

	return (isUnlock or nil) and (MatchGameEnum.MapStatus.Unlock or MatchGameEnum.MapStatus.Lock)
end

function MatchGameModel:getMaxHeroGroupSnapshotCount()
	return MatchGameConfig.instance:getConstValue(self._activityId, MatchGameEnum.ConstId.TeamNum, true)
end

function MatchGameModel:getTalentSkillAttrChangeMap(talentSkillId)
	local attrChangeMap = {}
	local skillConfig = MatchGameConfig.instance:getHeroSkillConfig(talentSkillId)

	for index = 1, 4 do
		if not string.nilorempty(skillConfig["effect" .. index]) and skillConfig.skillType == MatchGameFightEnum.SkillActiveType.Passive then
			local effectData = string.splitToNumber(skillConfig["effect" .. index], "#")

			if effectData[1] == MatchGameFightEnum.SkillEffectType.Attr then
				local effectType, changeValue = effectData[2], effectData[3]

				attrChangeMap[effectType] = changeValue
			end
		end
	end

	return attrChangeMap
end

function MatchGameModel:updateTalentAttrChangeMap()
	self._talentAttrChangeMap = {}

	for _, nodeMo in pairs(self.talentMap) do
		local skillId = nodeMo.skillId
		local changeMap = self:getTalentSkillAttrChangeMap(skillId)

		for attrType, changeValue in pairs(changeMap) do
			self._talentAttrChangeMap[attrType] = (self._talentAttrChangeMap[attrType] or 0) + changeValue
		end
	end
end

function MatchGameModel:getTalentAttrChangeValue(attrType)
	if self._talentAttrChangeMap then
		return self._talentAttrChangeMap or 0
	end
end

function MatchGameModel:getCharacterAttrValue(characterId, level, attrType)
	local baseValue = MatchGameConfig.instance:getCharacterAttrValue(characterId, level, attrType)
	local talentValue = self:getTalentAttrChangeValue(attrType)

	return baseValue + talentValue, baseValue, talentValue
end

MatchGameModel.instance = MatchGameModel.New()

return MatchGameModel
