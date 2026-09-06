-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaGameMo.lua

module("logic.extensions.tourarena.view.TourArenaGameMo", package.seeall)

local TourArenaGameMo = class("TourArenaGameMo")

function TourArenaGameMo:ctor(activityId)
	self._activityId = checknumber(activityId)
	self._prizeCfg = TourArenaGameConfig.instance:getTagPrizeCfg(self._activityId)
	self._gameCfg = TourArenaGameConfig.instance:getTagGameCfg(self._activityId)
	self._gainPrizeIdPool = {}
	self._gameInfoPool = {}
	self._stageInfoPool = {}
	self._zoneRankFirstInfoPool = {}
	self._rankResMsgPool = {}
	self._totalRankResMsgPool = {}
	self._clientKey = ""
	self._serverKey = ""
end

function TourArenaGameMo:getActivityId()
	return self._activityId
end

function TourArenaGameMo:deepcopy()
	return TableUtil.deepcopy(self)
end

function TourArenaGameMo:getTryGainPrizeOfProResultAndTips(prizeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isHasGainPrize(prizeId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "您已领奖"
	elseif not self:isEnoughGainPrize(prizeId) then
		result = GameEnum.ResultCode.NotEnoughProgress
		tips = "未满足领奖要求"
	end

	return result, tips
end

function TourArenaGameMo:isCanGetPrize(prizeId)
	local result, tips = self:getTryGainPrizeOfProResultAndTips(prizeId)

	return result == GameEnum.ResultCode.Success
end

function TourArenaGameMo:isEnoughGainPrize(prizeId)
	local curProgress = self:getCurProgress()
	local data = TourArenaGameConfig.instance:getTagPrizeData(self._activityId, prizeId)
	local needProgress = data.score

	return needProgress <= curProgress
end

function TourArenaGameMo:isHasGainPrize(prizeId)
	return self._gainPrizeIdPool[prizeId]
end

function TourArenaGameMo:getCurProgress()
	return self:getTotalScoreOfGame()
end

function TourArenaGameMo:getMaxProgress()
	return self._prizeCfg[#self._prizeCfg].score
end

function TourArenaGameMo:getGainPrizeIdList()
	local prizeIdList = {}

	for prizeId, isHasGain in pairs(self._gainPrizeIdPool) do
		if isHasGain then
			table.insert(prizeIdList, prizeId)
		end
	end
end

function TourArenaGameMo:clearPrizeIdOfGain()
	for prizeId, isHasGain in pairs(self._gainPrizeIdPool) do
		if isHasGain then
			self._gainPrizeIdPool[prizeId] = false
		end
	end
end

function TourArenaGameMo:setPrizeIdOfGain(prizeId, isGain)
	self._gainPrizeIdPool[prizeId] = checkbool(isGain)
end

function TourArenaGameMo:isEnoughTimesOfGame(gameId)
	local isEnough = true

	if not self:isIgnoreTimesOfGame(gameId) then
		local curTimes = self:getTimesOfGame(gameId)
		local maxTimes = self:getMaxTimesOfGame(gameId)

		isEnough = curTimes < maxTimes
	end

	return isEnough
end

function TourArenaGameMo:isIgnoreTimesOfGame(gameId)
	return self:getMaxTimesOfGame(gameId) <= 0
end

function TourArenaGameMo:getLeftTimesOfGame(gameId)
	local curTimes = self:getTimesOfGame(gameId)
	local maxTimes = self:getMaxTimesOfGame(gameId)

	return Mathf.Max(maxTimes - curTimes, 0)
end

function TourArenaGameMo:getMaxTimesOfGame(gameId)
	local data = TourArenaGameConfig.instance:getTagGameData(self._activityId, gameId)

	return (data or nil) and data.dailyTimes
end

function TourArenaGameMo:getTotalScoreOfGame()
	local totalScore = 0

	for _, data in ipairs(self._gameCfg) do
		totalScore = totalScore + self:getScoreOfGame(data.gameId)
	end

	return totalScore
end

function TourArenaGameMo:getTimesOfGame(gameId)
	local info = self:getGameInfo(gameId)

	return (info or nil) and info.times
end

function TourArenaGameMo:getScoreOfGame(gameId)
	local info = self:getGameInfo(gameId)

	return (info or nil) and info.score
end

function TourArenaGameMo:getGameInfo(gameId)
	return self._gameInfoPool[gameId]
end

function TourArenaGameMo:setGameInfo(gameId, info)
	self._gameInfoPool[gameId] = info
end

function TourArenaGameMo:clearAllGameInfo()
	table.clear(self._gameInfoPool)
end

function TourArenaGameMo:isInTimePeriodOfGame(gameId)
	local isInTime = false
	local stageCfg = TourArenaGameConfig.instance:getTagStageCfg(self._activityId, gameId)

	for _, stageData in ipairs(stageCfg) do
		if self:isInTimePeriodOfStage(gameId, stageData.stageId) then
			isInTime = true

			break
		end
	end

	return isInTime
end

function TourArenaGameMo:getFirstStageOpenTime(gameId)
	local data = TourArenaGameConfig.instance:getTagStageData(self._activityId, gameId, 1)

	return data.openDateTime
end

function TourArenaGameMo:getLastStageEndTime(gameId)
	local stageCfg = TourArenaGameConfig.instance:getTagStageCfg(self._activityId, gameId)
	local data = TourArenaGameConfig.instance:getTagStageData(self._activityId, gameId, #stageCfg)

	return data.endDateTime
end

function TourArenaGameMo:isInTimePeriodOfStage(gameId, stageId)
	return self:getTimePeriodOfStage(gameId, stageId) == GameUtil.inTimePeriod
end

function TourArenaGameMo:getTimePeriodOfStage(gameId, stageId)
	local data = TourArenaGameConfig.instance:getTagStageData(self._activityId, gameId, stageId)

	return (data or nil) and GameUtil.getTimePeriod(data.openDateTime, data.endDateTime)
end

function TourArenaGameMo:getEncryptedKey(isPass, progressIdx)
	return (GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		isPass and 1 or 0,
		progressIdx
	}))
end

function TourArenaGameMo:getClientKey()
	return self._clientKey
end

function TourArenaGameMo:setClientKey(clientKey)
	self._clientKey = clientKey
end

function TourArenaGameMo:getServerKey()
	return self._serverKey
end

function TourArenaGameMo:setServerKey(serverKey)
	self._serverKey = serverKey
end

function TourArenaGameMo:getMaxProgressIdxOfStage(gameId, stageId)
	local maxProgressIdx = 0
	local list = self:getProgressIdxOfStage(gameId, stageId)

	for _, v in ipairs(list) do
		if maxProgressIdx < v then
			maxProgressIdx = v
		end
	end

	return maxProgressIdx
end

function TourArenaGameMo:getProgressIdxOfStage(gameId, stageId)
	local info = self:getStageInfo(gameId, stageId)

	return (info or nil) and info.gainedIds
end

function TourArenaGameMo:getBestScoreOfStage(gameId, stageId)
	local info = self:getStageInfo(gameId, stageId)

	return (info or nil) and info.bestScore
end

function TourArenaGameMo:getStageInfo(gameId, stageId)
	if self._stageInfoPool[gameId] then
		return self._stageInfoPool[gameId][stageId]
	end
end

function TourArenaGameMo:setStageInfo(gameId, stageId, info)
	if self._stageInfoPool[gameId] == nil then
		self._stageInfoPool[gameId] = {}
	end

	self._stageInfoPool[gameId][stageId] = info
end

function TourArenaGameMo:clearAllStageInfo()
	table.clear(self._stageInfoPool)
end

function TourArenaGameMo:getZoneIdListOfRankFirstInfo()
	local list = {}

	for zoneId, info in pairs(self._zoneRankFirstInfoPool) do
		table.insert(list, zoneId)
	end

	table.sort(list, function(a, b)
		if a == b then
			return false
		end

		return b < a
	end)

	return list
end

function TourArenaGameMo:getCommonRankInfoOfZoneRankFirst(zoneId)
	local info = self:getZoneRankFirstInfo(zoneId)

	return (info or nil) and info.first
end

function TourArenaGameMo:getZoneRankFirstInfo(zoneId)
	return self._zoneRankFirstInfoPool[zoneId]
end

function TourArenaGameMo:setZoneRankFirstInfo(zoneId, info)
	self._zoneRankFirstInfoPool[zoneId] = info
end

function TourArenaGameMo:clearAllZoneRankFirstInfo()
	table.clear(self._zoneRankFirstInfoPool)
end

function TourArenaGameMo:_getTotalRankResMsg(zoneId)
	return self._totalRankResMsgPool[zoneId]
end

function TourArenaGameMo:_handleTotalRankRes(msg)
	self._totalRankResMsgPool[msg.zoneId] = msg
end

function TourArenaGameMo:_getRankResMsg(gameId)
	return self._rankResMsgPool[gameId]
end

function TourArenaGameMo:_handleTourArenaGameRankRes(msg)
	self._rankResMsgPool[msg.gameId] = msg
end

return TourArenaGameMo
