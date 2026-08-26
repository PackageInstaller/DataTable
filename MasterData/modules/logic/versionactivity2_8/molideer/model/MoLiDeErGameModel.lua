-- chunkname: @modules/logic/versionactivity2_8/molideer/model/MoLiDeErGameModel.lua

module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErGameModel", package.seeall)

local MoLiDeErGameModel = class("MoLiDeErGameModel", BaseModel)

function MoLiDeErGameModel:onInit()
	self:init()
end

function MoLiDeErGameModel:reInit()
	self:init()
end

function MoLiDeErGameModel:init()
	self._episodeInfoDic = {}
	self._curGameConfig = nil
	self._curGameId = nil
	self._skipGameTriggerDic = {}
end

function MoLiDeErGameModel:setEpisodeInfo(activityId, episodeInfo, isEpisodeFinish, passStar)
	local episodeId = episodeInfo.episodeId

	self._episodeInfoDic[activityId] = self._episodeInfoDic[activityId] or {}

	local infoMo

	if not self._episodeInfoDic[activityId][episodeId] then
		infoMo = MoLiDeErGameMo.New()

		infoMo:init(activityId, episodeInfo, isEpisodeFinish, passStar)

		self._episodeInfoDic[activityId][episodeId] = infoMo
	else
		infoMo = self._episodeInfoDic[activityId][episodeId]

		local finishEventList = {}
		local newDispatchTeam = {}
		local newDispatchEventDic = {}
		local newBackTeam = {}
		local newBackTeamEventDic = {}

		if episodeInfo.finishedEventInfos ~= nil then
			for _, eventInfo in ipairs(episodeInfo.finishedEventInfos) do
				local eventId = eventInfo.finishedEventId

				if infoMo:isNewFinishEvent(eventId) then
					table.insert(finishEventList, eventInfo)

					local teamId = infoMo:getEventDispatchTeam(eventId)

					if teamId then
						newBackTeam[teamId] = eventId
						newBackTeamEventDic[eventId] = teamId
					end
				end
			end
		end

		if finishEventList[2] ~= nil then
			table.sort(finishEventList, self.finishSort)
		end

		local newEventList = {}
		local existEventList = {}

		if episodeInfo.eventInfos ~= nil then
			for _, eventInfo in ipairs(episodeInfo.eventInfos) do
				if infoMo:isNewEvent(eventInfo.eventId) then
					table.insert(newEventList, eventInfo)
				else
					table.insert(existEventList, eventInfo)

					local teamId = eventInfo.teamId
					local eventId = eventInfo.eventId

					if teamId == nil or teamId == 0 then
						local dispatchTeamId = infoMo:getEventDispatchTeam(eventId)

						if dispatchTeamId then
							newBackTeam[teamId] = eventId
							newBackTeamEventDic[eventId] = dispatchTeamId
						end
					elseif infoMo:isDispatchTeam(teamId) == false then
						newDispatchTeam[teamId] = eventId
						newDispatchEventDic[eventId] = teamId
					end
				end
			end
		end

		infoMo:init(activityId, episodeInfo, isEpisodeFinish, passStar)

		infoMo.newFinishEventList = finishEventList
		infoMo.newEventList = newEventList
		infoMo.existEventList = existEventList
		infoMo.newDispatchTeam = newDispatchTeam
		infoMo.newDispatchEventDic = newDispatchEventDic
		infoMo.newBackTeam = newBackTeam
		infoMo.newBackTeamEventDic = newBackTeamEventDic
	end

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameInfoUpdate, activityId, episodeId)
end

function MoLiDeErGameModel:getGameInfo(actId, episodeId)
	if not self._episodeInfoDic[actId] then
		return nil
	end

	return self._episodeInfoDic[actId][episodeId]
end

function MoLiDeErGameModel:setCurGameData(gameId, gameConfig)
	if gameConfig == nil then
		gameConfig = MoLiDeErConfig.instance:getGameConfig(gameId)
	end

	self._curGameId = gameId
	self._curGameConfig = gameConfig
end

function MoLiDeErGameModel:getCurGameConfig()
	return self._curGameConfig
end

function MoLiDeErGameModel:getCurGameId()
	return self._curGameId
end

function MoLiDeErGameModel.finishSort(eventInfoA, eventInfoB)
	local configA = MoLiDeErConfig.instance:getEventConfig(eventInfoA.finishedEventId)
	local configB = MoLiDeErConfig.instance:getEventConfig(eventInfoB.finishedEventId)

	if configA.eventType == configB.eventType then
		return configA.eventId >= configB.eventId
	end

	return configA.eventType >= configB.eventType
end

function MoLiDeErGameModel:isMainConditionComplete()
	return true
end

function MoLiDeErGameModel:isExtraConditionComplete()
	return true
end

function MoLiDeErGameModel:getCurExecution()
	local info = self:getCurGameInfo()

	return info.leftRoundEnergy, info.previousRoundEnergy
end

function MoLiDeErGameModel:getCurExecutionCost()
	local eventId = self:getSelectEventId()
	local optionId = self:getSelectOptionId()
	local teamId = self:getSelectTeamId()

	return self:getExecutionCostById(eventId, optionId, teamId)
end

function MoLiDeErGameModel:getExecutionCostById(eventId, optionId, teamId)
	if eventId == nil or optionId == nil then
		return 0
	end

	local baseCost = MoLiDeErConfig.instance:getOptionCost(optionId, MoLiDeErEnum.OptionCostType.Execution)

	if baseCost == 0 then
		return 0
	end

	return self:getExecutionCost(baseCost, teamId)
end

function MoLiDeErGameModel:getExecutionCost(baseCost, teamId)
	local gameInfo = self:getCurGameInfo()
	local percentBuff = {}
	local buffIdDic = {}

	if gameInfo.itemBuffIds then
		for _, buffId in ipairs(gameInfo.itemBuffIds) do
			baseCost = MoLiDeErHelper.calculateExecutionCost(buffId, baseCost, percentBuff, teamId)
			buffIdDic[buffId] = true
		end
	end

	if teamId then
		local teamInfo = gameInfo:getTeamInfo(teamId)

		if teamInfo then
			for _, buffId in ipairs(teamInfo.buffIds) do
				baseCost = MoLiDeErHelper.calculateExecutionCost(buffId, baseCost, percentBuff, teamId)
				buffIdDic[buffId] = true
			end
		end

		for _, buffId in ipairs(gameInfo.buffIds) do
			if not buffIdDic[buffId] then
				baseCost = MoLiDeErHelper.calculateExecutionCost(buffId, baseCost, percentBuff, teamId, MoLiDeErEnum.ExecutionBuffType.FixedOther)
			end
		end
	end

	for _, percentValue in ipairs(percentBuff) do
		baseCost = baseCost * (1 + percentValue * 0.01)
	end

	baseCost = math.ceil(baseCost)

	return baseCost
end

function MoLiDeErGameModel:getRoundCostById(eventId, optionId, teamId)
	if eventId == nil or optionId == nil then
		return 0
	end

	local baseCost = MoLiDeErConfig.instance:getOptionCost(optionId, MoLiDeErEnum.OptionCostType.Round)

	if baseCost == 0 then
		return 0
	end

	return self:getRoundCost(baseCost, teamId)
end

function MoLiDeErGameModel:getRoundCost(baseCost, teamId)
	local gameInfo = self:getCurGameInfo()
	local percentBuff = {}
	local buffIdDic = {}

	if gameInfo.itemBuffIds then
		for _, buffId in ipairs(gameInfo.itemBuffIds) do
			baseCost = MoLiDeErHelper.calculateRoundCost(buffId, baseCost, percentBuff, teamId)
			buffIdDic[buffId] = true
		end
	end

	if teamId then
		local teamInfo = gameInfo:getTeamInfo(teamId)

		if teamInfo then
			for _, buffId in ipairs(teamInfo.buffIds) do
				baseCost = MoLiDeErHelper.calculateRoundCost(buffId, baseCost, percentBuff, teamId)
				buffIdDic[buffId] = true
			end
		end
	end

	for _, buffId in ipairs(gameInfo.buffIds) do
		if not buffIdDic[buffId] then
			baseCost = MoLiDeErHelper.calculateRoundCost(buffId, baseCost, percentBuff, teamId, MoLiDeErEnum.RoundBuffType.FixedOther)
		end
	end

	for _, percentValue in ipairs(percentBuff) do
		baseCost = baseCost * (1 + percentValue * 0.01)
	end

	baseCost = math.ceil(baseCost)

	return baseCost
end

function MoLiDeErGameModel:getCurGameInfo()
	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	return self:getGameInfo(actId, episodeId)
end

function MoLiDeErGameModel:getCurRound()
	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	return self:getRound(actId, episodeId)
end

function MoLiDeErGameModel:getRound(actId, episodeId)
	local info = self:getGameInfo(actId, episodeId)

	if info == nil then
		return 0
	end

	return info.currentRound or 0
end

function MoLiDeErGameModel:setSelectTeamId(teamId)
	self._teamId = teamId

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameTeamSelect, teamId)
end

function MoLiDeErGameModel:getSelectTeamId()
	return self._teamId
end

function MoLiDeErGameModel:setSelectItemId(itemId)
	self._itemId = itemId

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameItemSelect, itemId)
end

function MoLiDeErGameModel:getSelectItemId()
	return self._itemId
end

function MoLiDeErGameModel:setSelectEventId(eventId)
	self._eventId = eventId

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameEventSelect, eventId)
end

function MoLiDeErGameModel:getSelectEventId()
	return self._eventId
end

function MoLiDeErGameModel:setSelectOptionId(optionId)
	self._optionId = optionId

	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameOptionSelect, optionId)

	local gameInfo = self:getCurGameInfo()
	local recommendId

	if optionId and self._eventId then
		local teamInfos = self:getCurTeamData()

		for _, teamInfo in ipairs(teamInfos) do
			local teamId = teamInfo.teamId

			if MoLiDeErHelper.isTeamEnable(optionId, teamId) and gameInfo:canDispatchTeam(teamId) and teamInfo.roundActionTime > 0 and teamInfo.roundActedTime < teamInfo.roundActionTime then
				if recommendId == nil then
					recommendId = teamId
				end

				if MoLiDeErHelper.isTeamBuffed(optionId, teamId) then
					recommendId = teamId

					break
				end
			end
		end
	end

	self:setSelectTeamId(recommendId)
end

function MoLiDeErGameModel:getSelectOptionId()
	return self._optionId
end

function MoLiDeErGameModel:isTeamDispatched(teamId)
	return false
end

function MoLiDeErGameModel:getCurTeamData()
	local gameInfo = self:getCurGameInfo()

	return gameInfo.teamInfos
end

function MoLiDeErGameModel:enterGame()
	self:resetSelect()
end

function MoLiDeErGameModel:resetGame(actId, episodeId)
	self:resetSelect()
	self:removeInfoMo(actId, episodeId)
end

function MoLiDeErGameModel:resetSelect()
	self:setSelectEventId(nil)
	self:setSelectItemId(nil)
	self:setSelectOptionId(nil)
	self:setSelectTeamId(nil)
end

function MoLiDeErGameModel:removeInfoMo(actId, episodeId)
	if self._episodeInfoDic[actId] then
		self._episodeInfoDic[actId][episodeId] = nil
	end
end

function MoLiDeErGameModel:setSkipGameTrigger(actId, episodeId, value)
	local singleSkipDic

	if not self._skipGameTriggerDic[actId] then
		singleSkipDic = {}
		self._skipGameTriggerDic[actId] = singleSkipDic
	else
		singleSkipDic = self._skipGameTriggerDic[actId]
	end

	singleSkipDic[episodeId] = value
end

function MoLiDeErGameModel:getSkipGameTrigger(actId, episodeId)
	if not self._skipGameTriggerDic[actId] then
		return false
	end

	return self._skipGameTriggerDic[actId][episodeId]
end

MoLiDeErGameModel.instance = MoLiDeErGameModel.New()

return MoLiDeErGameModel
