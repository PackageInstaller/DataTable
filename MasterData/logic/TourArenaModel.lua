-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/model/TourArenaModel.lua

module("logic.extensions.tourarena.model.TourArenaModel", package.seeall)

local TourArenaModel = class("TourArenaModel", BaseModel)

function TourArenaModel:ctor()
	return
end

function TourArenaModel:onInit()
	self:onReset()
end

function TourArenaModel:onReset()
	self._taGameMoPool = self._taGameMoPool or {}

	table.clear(self._taGameMoPool)

	self._taFightMoPool = self._taFightMoPool or {}

	table.clear(self._taFightMoPool)
end

function TourArenaModel:handlePM_TourArenaZoneInfoRes(msg)
	return
end

function TourArenaModel:handlePM_TourArenaZoneBindingRes(msg)
	return
end

function TourArenaModel:handlePM_TourArenaZoneSelectBindingRes(msg)
	return
end

function TourArenaModel:handlePM_TourArenaGameInfoRes(msg)
	local taGameMo = self:getTourArenaGameMo(msg.activityId)

	taGameMo:clearPrizeIdOfGain()

	for _, prizeId in ipairs(msg.gainPrizeIds) do
		taGameMo:setPrizeIdOfGain(prizeId, true)
	end

	taGameMo:clearAllGameInfo()

	for _, info in ipairs(msg.games) do
		taGameMo:setGameInfo(info.gameId, info)
	end

	taGameMo:clearAllZoneRankFirstInfo()

	for _, info in ipairs(msg.zones) do
		taGameMo:setZoneRankFirstInfo(info.zoneId, info)
	end
end

function TourArenaModel:handlePM_TourArenaGameStartGameRes(msg)
	local taGameMo = self:getTourArenaGameMo(msg.activityId)

	taGameMo:setServerKey(msg.serverKey)
end

function TourArenaModel:handlePM_TourArenaGameEndGameRes(msg)
	return
end

function TourArenaModel:handlePM_TourArenaGameGainPrizeRes(msg)
	local taGameMo = self:getTourArenaGameMo(msg.activityId)

	taGameMo:setPrizeIdOfGain(msg.prizeId, true)
end

function TourArenaModel:handlePM_TourArenaGameTotalRankRes(msg)
	local taGameMo = self:getTourArenaGameMo(msg.activityId)

	taGameMo:_handleTotalRankRes(msg)
end

function TourArenaModel:handlePM_TourArenaGameRankRes(msg)
	local taGameMo = self:getTourArenaGameMo(msg.activityId)

	taGameMo:_handleTourArenaGameRankRes(msg)
end

function TourArenaModel:handlePM_TourArenaFightInfoRes(msg)
	local taFightMo = self:getTourArenaFightMo(msg.activityId)

	taFightMo:clearPrizeIdOfGain()

	for _, prizeId in ipairs(msg.gainPrizeIds) do
		taFightMo:setPrizeIdOfGain(prizeId, true)
	end

	taFightMo:clearAllZoneRankFirstInfo()

	for _, info in ipairs(msg.zones) do
		taFightMo:setZoneRankFirstInfo(info.zoneId, info)
	end

	taFightMo:setTotalScore(msg.totalScore)
	taFightMo:setPeriodTotalScore(msg.periodTotalScore)

	for _, prizeId in ipairs(msg.gainPeriodPrizeIds) do
		taFightMo:setPeriodPrizeIdOfGain(prizeId, true)
	end
end

function TourArenaModel:handlePM_TourArenaFightGainPrizeRes(msg)
	local taFightMo = self:getTourArenaFightMo(msg.activityId)

	taFightMo:setPrizeIdOfGain(msg.prizeId, true)
end

function TourArenaModel:handlePM_TourArenaFightTotalRankRes(msg)
	local taFightMo = self:getTourArenaFightMo(msg.activityId)

	taFightMo:_handleTotalRankRes(msg)
end

function TourArenaModel:handlePM_TourArenaPeriodRankRes(msg)
	local taFightMo = self:getTourArenaFightMo(msg.activityId)

	taFightMo:handlePeriodRankRes(msg)
end

function TourArenaModel:handlePM_TourArenaFightGainPeriodPrizeRes(msg)
	local taFightMo = self:getTourArenaFightMo(msg.activityId)

	taFightMo:setPeriodPrizeIdOfGain(msg.prizeId, true)
end

function TourArenaModel:handlePM_TourArenaGameStageInfoRes(msg)
	local taGameMo = self:getTourArenaGameMo(msg.activityId)

	for _, v in ipairs(msg.stage) do
		taGameMo:setStageInfo(msg.gameId, v.stageId, v)
	end
end

function TourArenaModel:getTourArenaGameMo(activityId)
	if self._taGameMoPool[activityId] == nil then
		self._taGameMoPool[activityId] = TourArenaGameMo.New(activityId)
	end

	return self._taGameMoPool[activityId]
end

function TourArenaModel:getTourArenaFightMo(activityId)
	if self._taFightMoPool[activityId] == nil then
		self._taFightMoPool[activityId] = TourArenaFightMo.New(activityId)
	end

	return self._taFightMoPool[activityId]
end

TourArenaModel.instance = TourArenaModel.New()

return TourArenaModel
