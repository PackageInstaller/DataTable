-- chunkname: @modules/logic/versionactivity3_9/bird/model/V3a9BirdModel.lua

module("modules.logic.versionactivity3_9.bird.model.V3a9BirdModel", package.seeall)

local V3a9BirdModel = class("V3a9BirdModel", BaseModel)

function V3a9BirdModel:onInit()
	self:reInit()
end

function V3a9BirdModel:reInit()
	self._curGameEpisodeId = nil
	self._birdMo = nil
	self._isGameOver = false
	self._curPassCount = 0
	self._actId = nil
	self._levelInfos = nil
	self._isLoading = false
end

function V3a9BirdModel:getActId()
	self._actId = self._actId or VersionActivity3_9Enum.ActivityId.Bird

	return self._actId
end

function V3a9BirdModel:onGetInfos(actId, info)
	local list = {}

	if info then
		for i = 1, #info do
			if info[i].episodeType == V3a9RacingCarEnum.EpisodeType.Bird then
				local episodeId = info[i].episodeId

				list[episodeId] = info[i]
			end
		end
	end

	if not self._levelInfos then
		self._levelInfos = {}

		for _, co in ipairs(lua_243_episode.configList) do
			if actId == co.activityId then
				local mo = V3a9BirdLevelMO.New()

				mo:init(co)

				self._levelInfos[co.episodeId] = mo
			end
		end
	end

	for episodeId, mo in pairs(self._levelInfos) do
		mo:initInfo(list[episodeId])
	end
end

function V3a9BirdModel:onEnterMainView(actId)
	self._actId = actId
end

function V3a9BirdModel:getLevelMos()
	return self._levelInfos
end

function V3a9BirdModel:getLevelMo(episodeId)
	local mo = self._levelInfos[episodeId]

	if not mo then
		logError("没有该关卡 episodeId" .. episodeId)
	end

	return mo
end

function V3a9BirdModel:onStartGame(episodeId, initCount)
	self._curGameEpisodeId = episodeId
	self._isGameOver = false
	self._curPassCount = initCount or 0
	self._gameParams = {}
	self._birdMo = self._birdMo or V3a9BirdMO.New()

	self._birdMo:initMo()
end

function V3a9BirdModel:getBirdMO()
	return self._birdMo
end

function V3a9BirdModel:getEnterGameEpisodeId()
	return self._curGameEpisodeId
end

function V3a9BirdModel:getGameType(episodeId)
	for type, list in pairs(V3a9BirdEnum.BirdGameTypeEpisodeId) do
		if LuaUtil.tableContains(list, episodeId) then
			return type
		end
	end

	return V3a9BirdEnum.BirdGameType.Infinite
end

function V3a9BirdModel:passPipe()
	self._curPassCount = self._curPassCount + 1

	local birdMo = self:getBirdMO()

	birdMo:refreshParam()
end

function V3a9BirdModel:getPassCount()
	return self._curPassCount or 0
end

function V3a9BirdModel:getGameScore()
	self._scoreMul = self._scoreMul or V3a9RacingCarConfig.instance:getAct243ConstValue(self._actId, V3a9BirdEnum.Act243Const.ScoreMul, false, true, 10)

	return self._curPassCount * self._scoreMul
end

function V3a9BirdModel:gameOver()
	self._isGameOver = true
end

function V3a9BirdModel:isGameOver()
	return self._isGameOver
end

function V3a9BirdModel:getScreenBound()
	return 1080
end

function V3a9BirdModel:getGameParam(constId, count)
	self._initialGameParams = self._initialGameParams or {}
	self._gameParams = self._gameParams or {}

	local initialGameParam = self._initialGameParams[constId]

	if not initialGameParam then
		local actId = self:getActId()

		initialGameParam = V3a9BirdConfig.instance:getBirdConstValue(actId, constId, false, true)
		self._initialGameParams[constId] = initialGameParam
	end

	count = count or self:getPassCount()

	local value = initialGameParam

	if count > 0 then
		local rate = self:getGameDifficultRate(constId, count)

		if rate then
			value = initialGameParam * (1 + rate)
		end
	end

	self._gameParams[constId] = value

	return value
end

function V3a9BirdModel:getGameDifficultRate(constId, count)
	local variation = self:getDifficultVariation()

	if variation then
		for c, list in pairs(variation) do
			local r = math.floor(count / c)

			if r > 0 then
				local v = list[constId]

				if v then
					return v * r
				end
			end
		end
	end
end

function V3a9BirdModel:getDifficultVariation()
	if not self._difficultCoDict then
		self._difficultCoDict = {}

		local actId = self:getActId()
		local constValue = V3a9BirdConfig.instance:getBirdConstValue(actId, V3a9BirdEnum.BirdConst.difficult, true)

		if not string.nilorempty(constValue) then
			local value = GameUtil.splitString2(constValue, false, "|", "#")

			for _, v in ipairs(value) do
				local v1 = string.splitToNumber(v[1], ":")
				local passCount = v1[1]
				local constId = v1[2]

				if passCount and constId then
					self._difficultCoDict[passCount] = self._difficultCoDict[passCount] or {}
					self._difficultCoDict[passCount][constId] = (not string.nilorempty(v[2]) or nil) and tonumber(v[2])
				end
			end
		end
	end

	return self._difficultCoDict
end

function V3a9BirdModel:getBeforeStoryId()
	if not self._beforeStoryId then
		local actId = self:getActId()

		self._beforeStoryId = V3a9RacingCarConfig.instance:getAct243ConstValue(actId, V3a9BirdEnum.Act243Const.GameBeforeStory, false, true, 203911)
	end

	return self._beforeStoryId
end

function V3a9BirdModel:getAfterStoryId()
	if not self._afterStoryId then
		local actId = self:getActId()

		self._afterStoryId = V3a9RacingCarConfig.instance:getAct243ConstValue(actId, V3a9BirdEnum.Act243Const.GameAfterStory, false, true, 203912)
	end

	return self._afterStoryId
end

function V3a9BirdModel:getStoryEpisodeId()
	if not self._storyEpisodeId then
		local actId = self:getActId()
		local gameId = V3a9RacingCarConfig.instance:getAct243ConstValue(actId, V3a9BirdEnum.Act243Const.StoryGameID, false, true, 13912)

		for _, co in ipairs(lua_243_episode.configList) do
			if actId == co.activityId and co.gameId == gameId then
				self._storyEpisodeId = co.episodeId

				break
			end
		end
	end

	return self._storyEpisodeId or 1392102
end

function V3a9BirdModel:getNormalEpisodeId()
	if not self._normalEpisodeId then
		local list = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity3_9DungeonEnum.DungeonChapterId.Story)
		local beforeStoryId = self:getBeforeStoryId()

		for _, episodeCo in ipairs(list) do
			if episodeCo.beforeStory == beforeStoryId then
				self._normalEpisodeId = episodeCo.id

				break
			end
		end
	end

	return self._normalEpisodeId
end

function V3a9BirdModel:getGameNeedPassNum()
	if not self._gameNeedPassNum then
		local actId = self:getActId()

		self._gameNeedPassNum = V3a9RacingCarConfig.instance:getAct243ConstValue(actId, V3a9BirdEnum.Act243Const.StoryGameNeedPassNum, false, true, 10)
	end

	return self._gameNeedPassNum
end

function V3a9BirdModel:isShowGameEnter()
	local actId = self:getActId()

	if not ActivityHelper.isOpen(actId) then
		return false
	end

	local afterStory = self:getAfterStoryId()

	if StoryModel.instance:isStoryFinished(afterStory) then
		return true
	end

	self._unlockEpisodeId = self:getUnlockEpisodeId()

	if self._unlockEpisodeId and DungeonModel.instance:hasPassLevel(self._unlockEpisodeId) then
		return true
	end
end

function V3a9BirdModel:getUnlockEpisodeId()
	if not self._unlockEpisodeId then
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity3_9DungeonEnum.DungeonChapterId.Story)

		if episodeList then
			for _, epCo in ipairs(episodeList) do
				if epCo.beforeStory == self:getBeforeStoryId() then
					self._unlockEpisodeId = epCo.id
				end
			end
		end
	end

	return self._unlockEpisodeId
end

V3a9BirdModel.instance = V3a9BirdModel.New()

return V3a9BirdModel
