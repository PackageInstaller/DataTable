-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/model/FirePowerContestModel.lua

module("logic.extensions.firepowercontest.model.FirePowerContestModel", package.seeall)

local FirePowerContestModel = class("FirePowerContestModel", BaseModel)

function FirePowerContestModel:ctor()
	self:onReset()
end

function FirePowerContestModel:onInit()
	self:onReset()
end

function FirePowerContestModel:onReset()
	self._totalScore = 0
	self._gainPrizeMap = {}
	self._gameTimes = 0
	self._matchCD = 0
	self._historyMaxScore = 0
	self._sweepableDifficulty = {}
end

function FirePowerContestModel:handleGetInfo(msg)
	self._gameTimes = msg.gameTimes
	self._totalScore = msg.curScore
	self._historyMaxScore = msg.historyMaxScore
	self._gainPrizeMap = {}
	self._gainPrizeMap = {}

	for _, id in ipairs(msg.gainPrizeIds) do
		self._gainPrizeMap[id] = true
	end
end

function FirePowerContestModel:beforeGainPrize(index)
	self._cachePrizeId = index
end

function FirePowerContestModel:handleGainPrize(status, msg)
	if status == 0 then
		local changeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(changeSetId)
		MaterialController.instance:showChangeSetInTemp(changeSetId)

		if self._cachePrizeId ~= nil then
			self._gainPrizeMap[self._cachePrizeId] = true
		end
	end

	self._cachePrizeId = nil
end

function FirePowerContestModel:handleNofityGameEnd(msg)
	self._gameResult = {
		winTimes = msg.winTimes,
		score = msg.score,
		winUserId = msg.winUserId,
		iconType = self.handler.data:getIconType(self.handler.data.myUserInfo.userId)
	}
end

function FirePowerContestModel:getGameResultAndClear()
	self._gameResult = nil

	return self._gameResult
end

function FirePowerContestModel:isCanGainPrizeByIndex(index)
	if self:isHasGainPrizeByIndex(index) then
		return false
	end

	local configs = FirePowerContestConfig.instance:getGamePrizeConfs()
	local config = configs[index]

	return self._totalScore >= config.progress
end

function FirePowerContestModel:isHasGainPrizeByIndex(index)
	if self._gainPrizeMap then
		return self._gainPrizeMap[index]
	end

	return true
end

function FirePowerContestModel:getRemainGameCount(maxTimes)
	if maxTimes == nil then
		local activityConf = FirePowerContestConfig.instance:getGameActivityConf()

		maxTimes = activityConf.times
	end

	return math.max(maxTimes - self._gameTimes, 0)
end

function FirePowerContestModel:reqStartGame()
	self.handler = FirePowerContestHandler.New()
end

function FirePowerContestModel:reqDisposeGame()
	if self.handler then
		self.handler:dispose()

		self.handler = nil
	end
end

function FirePowerContestModel:setMatchCD()
	local cd = checknumber(FirePowerContestConfig.instance:getCommonValue("MatchCD"))

	self._matchCD = UnityEngine.Time.realtimeSinceStartup + cd
end

function FirePowerContestModel:isInMatchCD()
	if self._matchCD then
		return UnityEngine.Time.realtimeSinceStartup < self._matchCD
	end
end

function FirePowerContestModel:getMatchCDSec()
	if self:isInMatchCD() then
		return math.ceil(self._matchCD - UnityEngine.Time.realtimeSinceStartup)
	end
end

function FirePowerContestModel:getTotalScore()
	return self._totalScore
end

function FirePowerContestModel:getHistoryMaxScore()
	return self._historyMaxScore
end

function FirePowerContestModel:getGameTime()
	return self._gameTimes
end

function FirePowerContestModel:handlePM_FPCSweepRes(msg)
	self._totalScore = msg.curScore
	self._gameTimes = msg.todayGameTimes
end

FirePowerContestModel.instance = FirePowerContestModel.New()

return FirePowerContestModel
