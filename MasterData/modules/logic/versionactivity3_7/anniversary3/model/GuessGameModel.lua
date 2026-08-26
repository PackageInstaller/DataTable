-- chunkname: @modules/logic/versionactivity3_7/anniversary3/model/GuessGameModel.lua

module("modules.logic.versionactivity3_7.anniversary3.model.GuessGameModel", package.seeall)

local GuessGameModel = class("GuessGameModel", BaseModel)

function GuessGameModel:onInit()
	self:reInit()
end

function GuessGameModel:reInit()
	self._actInfos = {}
end

function GuessGameModel:initData()
	self._round = 0
	self._gameScore = 0
	self._targetGift = 0
	self._giftDistributes = {}
	self._unlockGifts = {}
	self._searchCount = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.GuideTimes)

	self:_initGameRoles()
end

function GuessGameModel:_initGameRoles()
	self._gameRoles = {}

	local dt = ServerTime.nowDateInLocal()
	local weekDay = TimeUtil.getTodayWeedDay(dt)
	local roleCo = Activity234Config.instance:getWeekRoleCo(weekDay)

	if not roleCo then
		return {
			1,
			2,
			3
		}
	end

	local gameRoles = string.splitToNumber(roleCo.gameroles, "#")

	gameRoles = GameUtil.randomTable(gameRoles)

	if #gameRoles < 3 then
		logError("Please check gameroles, it has not match Roles!")

		return {
			1,
			2,
			3
		}
	end

	for i = 1, 3 do
		table.insert(self._gameRoles, gameRoles[i])
	end
end

function GuessGameModel:getGameRoleByIndex(index)
	if not self._gameRoles or not self._gameRoles[index] then
		return 1
	end

	return self._gameRoles[index]
end

function GuessGameModel:addGameScore(score)
	self._gameScore = self._gameScore + score
end

function GuessGameModel:getGameScore()
	return self._gameScore
end

function GuessGameModel:setAct234Info(info)
	self._actInfos[info.activityId] = self._actInfos[info.activityId] or {}
	self._actInfos[info.activityId].finishGameCount = info.finishGameCount
	self._actInfos[info.activityId].totalScore = info.totalScore
	self._actInfos[info.activityId].acceptedRewardId = info.acceptedRewardId
	self._actInfos[info.activityId].gameRecord = info.gameRecord
end

function GuessGameModel:updateFinishCount(count, actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId].finishGameCount = count
end

function GuessGameModel:updateTotalScore(score, actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId].totalScore = score
end

function GuessGameModel:updateAcceptedRewardId(rewardId, actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId].acceptedRewardId = rewardId
end

function GuessGameModel:getFinishGameCount(actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return 0
	end

	return self._actInfos[actId].finishGameCount
end

function GuessGameModel:isFirstShow(actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return false
	end

	return self._actInfos[actId].finishGameCount == 0
end

function GuessGameModel:getTotalScore(actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return 0
	end

	return self._actInfos[actId].totalScore
end

function GuessGameModel:getMaxTotalScore(actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return 0
	end

	local bonusCos = Activity234Config.instance:getBonusCos(actId)

	return bonusCos[#bonusCos].coinNum
end

function GuessGameModel:getAcceptedRewardId(actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return 0
	end

	return self._actInfos[actId].acceptedRewardId
end

function GuessGameModel:isRewardLock(rewardId, actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return true
	end

	local totalScore = self:getTotalScore(actId)
	local cfg = Activity234Config.instance:getBonusCo(rewardId, actId)

	return totalScore < cfg.coinNum
end

function GuessGameModel:isRewardGet(rewardId, actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return false
	end

	local acceptedRewardId = self:getAcceptedRewardId(actId)
	local cfg = Activity234Config.instance:getBonusCo(rewardId, actId)

	return acceptedRewardId >= cfg.rewardId
end

function GuessGameModel:isRewardCanGet(rewardId, actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	if not self._actInfos[actId] then
		return false
	end

	local isLock = self:isRewardLock(rewardId, actId)
	local isGet = self:isRewardGet(rewardId, actId)

	return not isGet and not isLock
end

function GuessGameModel:setRound(round)
	self._round = round
end

function GuessGameModel:getRound()
	return self._round or 1
end

function GuessGameModel:reduceSearchCount()
	self._searchCount = self._searchCount - 1
end

function GuessGameModel:getSearchCount()
	return self._searchCount
end

function GuessGameModel:setGiftDistribution(index, giftList)
	self._giftDistributes = self._giftDistributes or {}
	self._giftDistributes[index] = giftList
end

function GuessGameModel:getGiftDistribution(index)
	if not self._giftDistributes or not self._giftDistributes[index] then
		return {}
	end

	return self._giftDistributes[index]
end

function GuessGameModel:getResultScoreByGameScore()
	local score = self:getGameScore()
	local baseScore = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.GameBaseScore)

	return baseScore + score
end

function GuessGameModel:setUnlockGifts(gifts)
	for _, giftId in pairs(gifts) do
		self._unlockGifts[giftId] = not self._unlockGifts[giftId] and 1 or 1 + self._unlockGifts[giftId]
	end
end

function GuessGameModel:getGiftUnlockCount(giftId)
	return self._unlockGifts[giftId] or 0
end

function GuessGameModel:hasMultiRewardCouldGet(actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	local isFirstShow = self:isFirstShow(actId)

	if not isFirstShow then
		return false
	end

	local firstShowTime = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.GuessGameFirstShowTime), "")

	if not LuaUtil.isEmptyStr(firstShowTime) then
		local nowTime = ServerTime.now()
		local isSameDay = TimeUtil.isSameDay(tonumber(firstShowTime) - TimeDispatcher.DailyRefreshSecond, nowTime - TimeDispatcher.DailyRefreshSecond)

		if isSameDay then
			return false
		end
	end

	local bonusCos = Activity234Config.instance:getBonusCos(actId)

	for _, bonusCo in pairs(bonusCos) do
		local rewardGet = self:isRewardGet(bonusCo.rewardId, actId)

		if not rewardGet then
			return true
		end
	end

	return false
end

GuessGameModel.instance = GuessGameModel.New()

return GuessGameModel
