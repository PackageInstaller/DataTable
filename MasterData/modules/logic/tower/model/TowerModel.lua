-- chunkname: @modules/logic/tower/model/TowerModel.lua

module("modules.logic.tower.model.TowerModel", package.seeall)

local TowerModel = class("TowerModel", BaseModel)

function TowerModel:onInit()
	self:reInit()
end

function TowerModel:reInit()
	self:clearTowerData()

	self.fightParam = {}
	self.fightFinishParam = {}
	self.localPrefsDict = {}
end

function TowerModel:clearTowerData()
	self.towerOpenMap = {}
	self.towerOpenList = {}
	self.towerInfoMap = {}
	self.towerInfoList = {}
	self.curTowerType = nil
	self.towerTrialHeroDataMap = {}
end

function TowerModel:onReceiveTowerBattleFinishPush(info)
	self.fightFinishParam.towerType = info.type
	self.fightFinishParam.towerId = info.towerId
	self.fightFinishParam.layerId = info.layerId
	self.fightFinishParam.difficulty = info.difficulty
	self.fightFinishParam.score = info.score
	self.fightFinishParam.bossLevel = info.bossLevel
	self.fightFinishParam.teamLevel = info.teamLevel
	self.fightFinishParam.layer = info.layer
	self.fightFinishParam.historyHighScore = info.historyHighScore
end

function TowerModel:getFightFinishParam()
	return self.fightFinishParam
end

function TowerModel:clearFightFinishParam()
	self.fightFinishParam = {}
end

function TowerModel:onReceiveGetTowerInfoReply(info)
	self:clearTowerData()
	TowerAssistBossModel.instance:clear()
	self:setTowerOpenInfo(info)
	self:setTowerInfo(info)
	self:updateMopUpTimes(info.mopUpTimes)
	self:updateTrialHeroSeason(info.trialHeroSeason)

	for i = 1, #info.assistBosses do
		TowerAssistBossModel.instance:updateAssistBossInfo(info.assistBosses[i])
	end

	TowerPermanentModel.instance:InitData()
end

function TowerModel:setTowerOpenInfo(info)
	if #info.towerOpens == 0 then
		logError("towerOpenInfo not exit")

		return
	end

	for index, OpenData in ipairs(info.towerOpens) do
		local towerType = OpenData.type
		local towerId = OpenData.towerId
		local round = OpenData.round
		local towerOpenMap = self.towerOpenMap[towerType]

		if not towerOpenMap then
			towerOpenMap = {}
			self.towerOpenMap[towerType] = towerOpenMap
		end

		local roundMap = towerOpenMap[towerId]

		if not roundMap then
			roundMap = {}
			towerOpenMap[towerId] = roundMap
		end

		local towerMo = roundMap[round]

		if not towerMo then
			towerMo = TowerOpenMo.New()
			roundMap[round] = towerMo

			self:addTowerOpenList(towerType, towerMo)
		end

		towerMo:updateInfo(OpenData)
	end
end

function TowerModel:addTowerOpenList(towerType, mo)
	self.towerOpenList[towerType] = self.towerOpenList[towerType] or {}

	table.insert(self.towerOpenList[towerType], mo)
end

function TowerModel:getTowerOpenList(towerType)
	return self.towerOpenList[towerType] or {}
end

function TowerModel:getTowerOpenInfoByRound(towerType, towerId, round)
	local towerOpenMap = self.towerOpenMap[towerType]
	local roundMap = towerOpenMap and towerOpenMap[towerId]

	if not roundMap then
		return
	end

	return roundMap[round]
end

function TowerModel:getTowerOpenInfo(towerType, towerId, towerStatus)
	if towerStatus == nil then
		towerStatus = TowerEnum.TowerStatus.Open
	end

	local towerOpenMap = self.towerOpenMap[towerType]
	local roundMap = towerOpenMap and towerOpenMap[towerId]

	if not roundMap then
		return
	end

	for _, mo in pairs(roundMap) do
		if mo.status == towerStatus then
			return mo
		end
	end
end

function TowerModel:setTowerInfo(info)
	if #info.towers == 0 then
		logError("towerInfo not exit")

		return
	end

	for index, towerData in ipairs(info.towers) do
		local towerType = towerData.type
		local towerId = towerData.towerId
		local towerInfoMap = self.towerInfoMap[towerType]

		if not towerInfoMap then
			towerInfoMap = {}
			self.towerInfoMap[towerType] = towerInfoMap
		end

		if not towerInfoMap[towerId] then
			local towerMo = TowerMo.New()

			towerInfoMap[towerId] = towerMo

			self:addTowerInfoList(towerType, towerMo)
		end

		self.towerInfoMap[towerType][towerId]:updateInfo(towerData)
	end
end

function TowerModel:addTowerInfoList(towerType, mo)
	self.towerInfoList[towerType] = self.towerInfoList[towerType] or {}

	table.insert(self.towerInfoList[towerType], mo)
end

function TowerModel:getTowerInfoById(towerType, towerId)
	if not self.towerInfoMap[towerType] then
		return
	end

	return self.towerInfoMap[towerType][towerId]
end

function TowerModel:getTowerListByStatus(towerType, towerStatus)
	if towerStatus == nil then
		towerStatus = TowerEnum.TowerStatus.Open
	end

	local openList = self:getTowerOpenList(towerType)
	local list = {}

	for _, mo in pairs(openList) do
		if mo.status == towerStatus then
			table.insert(list, mo)
		end
	end

	return list
end

function TowerModel:getCurPermanentMo()
	local normalType = TowerEnum.TowerType.Normal

	if self.towerInfoMap[normalType] then
		return self.towerInfoMap[normalType][TowerEnum.PermanentTowerId]
	end
end

function TowerModel:initEpisodes()
	if self.towerEpisodeMap then
		return
	end

	self.towerEpisodeMap = {}

	self:_initEpisode(TowerEnum.TowerType.Boss, TowerConfig.instance.bossTowerEpisodeConfig)
end

function TowerModel:_initEpisode(towerType, config)
	local mo = TowerEpisodeMo.New()

	mo:init(towerType, config)

	self.towerEpisodeMap[towerType] = mo
end

function TowerModel:getEpisodeMoByTowerType(towerType)
	self:initEpisodes()

	return self.towerEpisodeMap[towerType]
end

function TowerModel:setRecordFightParam(towerType, towerId, layerId, difficulty, episodeId)
	self.fightParam.towerType = towerType
	self.fightParam.towerId = towerId
	self.fightParam.layerId = layerId
	self.fightParam.difficulty = difficulty
	self.fightParam.episodeId = episodeId

	self:refreshHeroGroupInfo()
end

function TowerModel:refreshHeroGroupInfo()
	local towerType = self.fightParam.towerType
	local towerId = self.fightParam.towerId
	local layerId = self.fightParam.layerId
	local difficulty = self.fightParam.difficulty
	local episodeId = self.fightParam.episodeId
	local towerInfo = self:getTowerInfoById(towerType, towerId)
	local isHeroGroupLock, heroIds, assistBoss, equipUids, banHeroIds, banAssistBoss, banTrialHeros, trialHeros

	if towerInfo then
		local isLock, subEpisodeInfo = towerInfo:isHeroGroupLock(layerId, episodeId)

		isHeroGroupLock = isLock

		if subEpisodeInfo then
			heroIds = subEpisodeInfo.heroIds
			assistBoss = subEpisodeInfo.assistBossId
			equipUids = subEpisodeInfo.equipUids
			trialHeros = subEpisodeInfo.trialHeroIds
		end

		banHeroIds, banAssistBoss, banTrialHeros = towerInfo:getBanHeroAndBoss(layerId, difficulty, episodeId)
	end

	self.fightParam.isHeroGroupLock = isHeroGroupLock
	self.fightParam.heros = heroIds
	self.fightParam.equipUids = equipUids
	self.fightParam.trialHeros = trialHeros
	self.fightParam.herosDict = {}

	if heroIds then
		for i = 1, #heroIds do
			self.fightParam.herosDict[heroIds[i]] = 1
		end
	end

	self.fightParam.assistBoss = assistBoss
	self.fightParam.banHeroDict = banHeroIds
	self.fightParam.banAssistBossDict = banAssistBoss
	self.fightParam.banTrialDict = banTrialHeros
end

function TowerModel:getRecordFightParam()
	return self.fightParam
end

function TowerModel:clearRecordFightParam()
	self.fightParam = {}
end

function TowerModel:updateMopUpTimes(mopUpTimes)
	self.mopUpTimes = mopUpTimes
end

function TowerModel:getMopUpTimes()
	return self.mopUpTimes
end

function TowerModel:updateTrialHeroSeason(season)
	self.trialHeroSeason = season

	self:buildTrialHeroCoDataList()
end

function TowerModel:getTrialHeroSeason()
	return self.trialHeroSeason or 0
end

function TowerModel:resetTowerSubEpisode(msg)
	local towerType = msg.towerType
	local towerId = msg.towerId
	local layerInfo = msg.layerInfo
	local towerMO = self:getTowerInfoById(towerType, towerId)

	towerMO:resetLayerInfos(layerInfo)
	towerMO:resetLayerScore(layerInfo)
	towerMO:updateHistoryHighScore(msg.historyHighScore)
end

function TowerModel:getTowerInfoList(towerType)
	if not self.towerInfoMap[towerType] then
		logError("towerInfoMap is Empty")

		return {}
	end

	if not self.towerInfoList[towerType] then
		self.towerInfoList[towerType] = {}

		for id, mo in pairs(self.towerInfoMap[towerType]) do
			table.insert(self.towerInfoList[towerType], mo)
		end

		table.sort(self.towerInfoList[towerType], function(a, b)
			return a.towerId < b.towerId
		end)
	end

	return self.towerInfoList[towerType]
end

function TowerModel:getLocalPrefsTab(key, towerOpenInfo)
	local uniqueKey = self:prefabKeyPrefs(key, towerOpenInfo)

	if not self.localPrefsDict[uniqueKey] then
		local tab = {}
		local saveStr = TowerController.instance:getPlayerPrefs(uniqueKey)
		local saveStateList = GameUtil.splitString2(saveStr, true)

		if saveStateList then
			for _, param in ipairs(saveStateList) do
				local id = param[1]

				tab[id] = param[2]
			end
		end

		self.localPrefsDict[uniqueKey] = tab
	end

	return self.localPrefsDict[uniqueKey]
end

function TowerModel:getLocalPrefsState(key, id, towerOpenInfo, defaultState)
	local tab = self:getLocalPrefsTab(key, towerOpenInfo)

	return tab[id] or defaultState
end

function TowerModel:setLocalPrefsState(key, id, towerOpenInfo, state)
	local tab = self:getLocalPrefsTab(key, towerOpenInfo)

	if tab[id] == state then
		return
	end

	tab[id] = state

	local list = {}

	for k, v in pairs(tab) do
		table.insert(list, string.format("%s#%s", k, v))
	end

	local value = table.concat(list, "|")
	local uniqueKey = self:prefabKeyPrefs(key, towerOpenInfo)

	TowerController.instance:setPlayerPrefs(uniqueKey, value)
end

function TowerModel:prefabKeyPrefs(key, towerOpenInfo)
	if string.nilorempty(key) then
		return key
	end

	local towerType = towerOpenInfo.type
	local towerId = towerOpenInfo.towerId

	return (string.format("Tower_%s_%s_%s_%s", key, towerType, towerId, (key == TowerEnum.LocalPrefsKey.NewBossOpen or nil) and 1))
end

function TowerModel:hasNewBossOpen()
	local result = false
	local list = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	for i, v in ipairs(list) do
		local newState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, v.towerId, v, TowerEnum.LockKey)
		local curNewState = TowerEnum.UnlockKey
		local canShowNew = newState == TowerEnum.LockKey and curNewState == TowerEnum.UnlockKey

		if canShowNew then
			result = true

			break
		end
	end

	return result
end

function TowerModel:isHeroLocked(heroId)
	local param = self:getRecordFightParam()
	local dict = param.herosDict

	return dict and dict[heroId] ~= nil
end

function TowerModel:isBossLocked(bossId)
	local param = self:getRecordFightParam()

	return param.assistBoss == bossId
end

function TowerModel:isHeroBan(heroId)
	local param = self:getRecordFightParam()
	local dict = param.banHeroDict
	local isTowerDeep = self:isTowerDeepEpisode(param.episodeId)

	if isTowerDeep then
		return TowerPermanentDeepModel.instance:isHeroBan(heroId)
	else
		return dict and dict[heroId] ~= nil
	end
end

function TowerModel:isBossBan(bossId)
	local param = self:getRecordFightParam()
	local dict = param.banAssistBossDict

	return dict and dict[bossId] ~= nil
end

function TowerModel:isTrialHeroBan(trialHeroId)
	local param = self:getRecordFightParam()
	local dict = param.banTrialDict

	return dict and dict[trialHeroId] ~= nil
end

function TowerModel:isLimitTowerBossBan(towerType, towerId, bossId)
	if towerType == TowerEnum.TowerType.Limited then
		local limitedTimeCo = TowerConfig.instance:getTowerLimitedTimeCo(towerId)

		if limitedTimeCo then
			local bossIdList = string.splitToNumber(limitedTimeCo.bossPool, "#")

			for i, v in ipairs(bossIdList) do
				if v == bossId then
					return false
				end
			end
		end

		return true
	end
end

function TowerModel:isInTowerBattle()
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCO = episodeId and lua_episode.configDict[episodeId]
	local episodeType = episodeCO and episodeCO.type

	return self:isTowerEpisode(episodeType)
end

function TowerModel:isTowerEpisode(episodeType)
	self._towerEpisodeTypeDefine = self._towerEpisodeTypeDefine or {
		[DungeonEnum.EpisodeType.TowerPermanent] = 1,
		[DungeonEnum.EpisodeType.TowerBoss] = 1,
		[DungeonEnum.EpisodeType.TowerLimited] = 1,
		[DungeonEnum.EpisodeType.TowerBossTeach] = 1,
		[DungeonEnum.EpisodeType.TowerDeep] = 1
	}

	return self._towerEpisodeTypeDefine[episodeType] ~= nil
end

function TowerModel:checkHasOpenStateTower(towerType)
	local openList = self:getTowerOpenList(towerType)

	for index, TowerOpenMo in ipairs(openList) do
		if TowerOpenMo.status == TowerEnum.TowerStatus.Open then
			return true
		end
	end

	return false
end

function TowerModel:getFirstUnOpenTowerInfo(towerType)
	if not self:checkHasOpenStateTower(towerType) then
		local minTimeStamp = -1
		local minTimeStampMo
		local openList = self:getTowerOpenList(towerType)

		for index, TowerOpenMo in ipairs(openList) do
			if TowerOpenMo.status == TowerEnum.TowerStatus.Ready then
				local nextTime = TowerOpenMo.nextTime

				if minTimeStamp == -1 or nextTime < minTimeStamp then
					minTimeStamp = nextTime
					minTimeStampMo = TowerOpenMo
				end
			end
		end

		return minTimeStampMo
	end
end

function TowerModel:isBossOpen(bossId)
	local config = TowerConfig.instance:getAssistBossConfig(bossId)

	if not config then
		return false
	end

	local towerId = config.towerId
	local timeConfig = TowerConfig.instance:getBossTimeTowerConfig(towerId, 1)

	if not timeConfig then
		return false
	end

	local startTime = string.format("%s 5:0:0", timeConfig.startTime)
	local timestamp = TimeUtil.stringToTimestamp(startTime)

	return timestamp <= ServerTime.now()
end

function TowerModel:setCurTowerType(towerType)
	self.curTowerType = towerType
end

function TowerModel:getCurTowerType()
	return self.curTowerType
end

function TowerModel:cleanTrialData()
	TowerAssistBossModel.instance:cleanTrialLevel()
	self:setCurTowerType(nil)
end

function TowerModel:isTowerDeepEpisode(episodeId)
	if not episodeId or episodeId == 0 then
		return false
	end

	local episdoeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	return episdoeConfig and episdoeConfig.type == DungeonEnum.EpisodeType.TowerDeep
end

function TowerModel:buildTrialHeroCoDataList()
	local curSeason = self:getTrialHeroSeason()

	if self.towerTrialHeroDataMap[curSeason] then
		return
	end

	self.towerTrialHeroDataMap[curSeason] = {}

	local towerTrialConfig = TowerConfig.instance:getHeroTrialConfig(curSeason)

	if towerTrialConfig then
		local heroIds = string.splitToNumber(towerTrialConfig.heroIds, "|")

		for _, trialHeroId in ipairs(heroIds) do
			local trialCoData = {}

			trialCoData.trialConfig = lua_hero_trial.configDict[trialHeroId][0]
			trialCoData.heroConfig = HeroConfig.instance:getHeroCO(trialCoData.trialConfig.heroId)
			trialCoData.skinConfig = SkinConfig.instance:getSkinCo(trialCoData.trialConfig.skin)

			table.insert(self.towerTrialHeroDataMap[curSeason], trialCoData)
		end
	end
end

function TowerModel:getTrialHeroCoDataList(seasonId)
	return self.towerTrialHeroDataMap[seasonId]
end

TowerModel.instance = TowerModel.New()

return TowerModel
