-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingCarModel.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingCarModel", package.seeall)

local V3a9RacingCarModel = class("V3a9RacingCarModel", BaseModel)

function V3a9RacingCarModel:onInit()
	self:reInit()
end

function V3a9RacingCarModel:reInit()
	self._gameState = V3a9RacingCarEnum.RacingGameState.Countdown
	self._raceFinished = false
	self._raceTime = 0
	self._playerFinished = false
	self._playerFinishTime = 0
	self._finishedCount = 0
	self._totalRacers = 0
	self._racerFinishTimes = {}
	self._guideParams = {}
end

function V3a9RacingCarModel:setGameState(state)
	self._gameState = state
end

function V3a9RacingCarModel:getGameState()
	return self._gameState
end

function V3a9RacingCarModel:setPauseChangeLane(value)
	self._pauseChangeLane = value
end

function V3a9RacingCarModel:getPauseChangeLane()
	return self._pauseChangeLane
end

function V3a9RacingCarModel:setEpisodeConfig(config)
	self._episodeConfig = config
end

function V3a9RacingCarModel:getEpisodeConfig()
	return self._episodeConfig
end

function V3a9RacingCarModel:getEpisodeId()
	return (self._episodeConfig or nil) and (self._episodeConfig.episodeId or 0)
end

function V3a9RacingCarModel:getTrackId()
	local episodeConfig = self:getEpisodeConfig()
	local levelConfig = lua_racing_game_level.configDict[episodeConfig.gameId]

	return levelConfig.traceId
end

function V3a9RacingCarModel:getAiRacers()
	local episodeConfig = self:getEpisodeConfig()
	local levelConfig = lua_racing_game_level.configDict[episodeConfig.gameId]

	return levelConfig.aiRacer
end

function V3a9RacingCarModel:setMainPlayerRacer(config)
	self._mainPlayerRacerConfig = config
end

function V3a9RacingCarModel:getMainPlayerRacer()
	return self._mainPlayerRacerConfig
end

function V3a9RacingCarModel:isRacing()
	return self._gameState == V3a9RacingCarEnum.RacingGameState.Racing
end

function V3a9RacingCarModel:isGuidePause()
	return self._gameState == V3a9RacingCarEnum.RacingGameState.GuidePaused
end

function V3a9RacingCarModel:setRaceFinished(finished)
	self._raceFinished = finished
end

function V3a9RacingCarModel:isRaceFinished()
	return self._raceFinished or false
end

function V3a9RacingCarModel:checkRaceCompletion(distance, isPlayer, racerId)
	local trackConfig = self:getTrackConfig()

	if not trackConfig or not trackConfig.level then
		return false
	end

	local finishDistance = trackConfig.level.finishDistance

	if not finishDistance or finishDistance <= 0 then
		return false
	end

	if finishDistance <= distance then
		if not self._raceTime then
			if racerId then
				self._racerFinishTimes = self._racerFinishTimes or {}

				if not self._racerFinishTimes[racerId] then
					self._racerFinishTimes[racerId] = self._raceTime
					self._finishedCount = (self._finishedCount or 0) + 1

					if isPlayer then
						self._playerFinishTime = self._raceTime
						self._playerFinished = true
					end
				end
			end

			if isPlayer and not self._playerFinished then
				self._playerFinished = true
			end

			return true
		end
	end

	return false
end

function V3a9RacingCarModel:getRacerFinishTime(racerId)
	if not self._racerFinishTimes then
		return 0
	end

	return self._racerFinishTimes[racerId] or 0
end

function V3a9RacingCarModel:getPlayerFinishTime()
	return self._playerFinishTime or 0
end

function V3a9RacingCarModel:getCurrentLap(playerDistance)
	local trackConfig = self:getTrackConfig()

	if not trackConfig or not trackConfig.level then
		return 0, 1
	end

	if not trackConfig.level.lapCount then
		local lapCount = 1
		local trackLength = 0

		if trackConfig.trackData and trackConfig.trackData.settings then
			trackLength = trackConfig.trackData.settings.trackLength or 0
		end

		if trackLength <= 0 then
			trackLength = (trackConfig.level.finishDistance or 0) / lapCount
		end

		if trackLength <= 0 then
			return 0, lapCount
		end

		local currentLap = math.floor(playerDistance / trackLength)

		currentLap = math.min(lapCount, math.max(0, currentLap))

		return currentLap, lapCount
	end
end

function V3a9RacingCarModel:resetRaceFinished()
	self._raceFinished = false
	self._playerFinished = false
	self._finishedCount = 0
	self._totalRacers = 0
end

function V3a9RacingCarModel:getActId()
	return VersionActivity3_9Enum.ActivityId.Racing
end

function V3a9RacingCarModel:setPlayerVehicleController(playerVehicleController)
	self._playerVehicleController = playerVehicleController
end

function V3a9RacingCarModel:getPlayerVehicleController()
	return self._playerVehicleController
end

function V3a9RacingCarModel:initTrack()
	local trackId = self:getTrackId()
	local path = string.format("racing39_config_%03d", trackId)

	self._trackConfig = V3a9RacingCarConfig.instance:getTrackConfig(path)
end

function V3a9RacingCarModel:getTrackConfig()
	return self._trackConfig
end

function V3a9RacingCarModel:setElementSpawner(spawner)
	self._elementSpawner = spawner
end

function V3a9RacingCarModel:getElementSpawner()
	return self._elementSpawner
end

function V3a9RacingCarModel:setGeneratedElements(elements)
	self._generatedElements = elements
end

function V3a9RacingCarModel:getGeneratedElements()
	return self._generatedElements or {}
end

function V3a9RacingCarModel:setElementPickupManager(manager)
	self._elementPickupManager = manager
end

function V3a9RacingCarModel:getElementPickupManager()
	return self._elementPickupManager
end

function V3a9RacingCarModel:setAIRacers(aiRacers)
	self._aiRacers = aiRacers
end

function V3a9RacingCarModel:getAIRacers()
	return self._aiRacers or {}
end

function V3a9RacingCarModel:setGuideParams(key, value)
	self._guideParams[key] = value
end

function V3a9RacingCarModel:getGuideParams(key)
	return self._guideParams[key]
end

function V3a9RacingCarModel:clearAll()
	self._trackConfig = nil
	self._playerVehicleController = nil
	self._elementSpawner = nil
	self._generatedElements = nil
	self._elementPickupManager = nil
	self._aiRacers = nil
	self._gameState = V3a9RacingCarEnum.RacingGameState.Countdown
	self._raceFinished = false
	self._raceTime = 0
	self._guideParams = {}
	self._pauseChangeLane = false
end

function V3a9RacingCarModel:setRaceTime(time)
	self._raceTime = time or 0
end

function V3a9RacingCarModel:getRaceTime()
	return self._raceTime or 0
end

function V3a9RacingCarModel:resetGameState()
	self._gameState = V3a9RacingCarEnum.RacingGameState.Countdown
	self._raceFinished = false
	self._raceTime = 0
	self._playerFinished = false
	self._playerFinishTime = 0
	self._finishedCount = 0
	self._totalRacers = 0
	self._racerFinishTimes = {}

	if self._playerVehicleController then
		self._playerVehicleController:resetForRestart()
	end

	if self._aiRacers then
		for _, ai in ipairs(self._aiRacers) do
			if ai and ai.resetForRestart then
				ai:resetForRestart()
			end
		end
	end

	if self._elementPickupManager then
		self._elementPickupManager:resetForRestart()
	end
end

function V3a9RacingCarModel:isShowGameEnter()
	local actId = self:getActId()

	if not ActivityHelper.isOpen(actId) then
		return false
	end

	self._unlockStoryId = self._unlockStoryId or V3a9RacingCarConfig.instance:getAct243ConstValue(actId, V3a9RacingCarEnum.Act243Const.UnlockEnterBtnStoryId, false, true, 203912)

	if StoryModel.instance:isStoryFinished(self._unlockStoryId) then
		return true
	end

	self._unlockEpisodeId = self:getUnlockEpisodeId()

	if self._unlockEpisodeId and DungeonModel.instance:hasPassLevel(self._unlockEpisodeId) then
		return true
	end
end

function V3a9RacingCarModel:getUnlockEpisodeId()
	if not self._unlockEpisodeId then
		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity3_9DungeonEnum.DungeonChapterId.Story)

		if episodeList then
			for _, epCo in ipairs(episodeList) do
				if epCo.beforeStory == self._unlockStoryId then
					self._unlockEpisodeId = epCo.id
				end
			end
		end
	end

	return self._unlockEpisodeId
end

V3a9RacingCarModel.instance = V3a9RacingCarModel.New()

return V3a9RacingCarModel
