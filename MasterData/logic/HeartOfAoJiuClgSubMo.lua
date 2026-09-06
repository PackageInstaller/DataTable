-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/data/HeartOfAoJiuClgSubMo.lua

module("logic.extensions.heartofaojiuclg.data.HeartOfAoJiuClgSubMo", package.seeall)

local HeartOfAoJiuClgSubMo = class("HeartOfAoJiuClgSubMo")

function HeartOfAoJiuClgSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function HeartOfAoJiuClgSubMo:_resetData()
	self._bestScore = 0
	self._scoresInStage = {}
	self._lastStageScores = {}
	self._petHps = {}
	self._hasGainDailyPrize = false
	self._myDailyRank = -1
	self._clgResultMsg = nil

	local actData = HeartOfAoJiuClgConfig.instance:getActivityData(self._activityId)

	self._closeTimeArray = {}

	local closeTime = actData and actData.challengeClosedTimeRange

	if not string.nilorempty(closeTime) then
		self._closeTimeArray = string.split(closeTime, "-")
	end
end

function HeartOfAoJiuClgSubMo:dispose()
	self:_resetData()
end

function HeartOfAoJiuClgSubMo:handlePM_HeartOfAoJiuClgGetInfoRes(msg)
	self._bestScore = msg.bestScore

	table.clear(self._scoresInStage)

	for stageId, score in ipairs(msg.curStageScores) do
		self._scoresInStage[stageId] = score
	end

	table.clear(self._lastStageScores)

	for stageId, score in ipairs(msg.lastStageScores) do
		self._lastStageScores[stageId] = score
	end

	table.clear(self._petHps)

	for _, v in ipairs(msg.raceIdAndLeftHp) do
		self._petHps[v.left] = v.right
	end

	self._hasGainDailyPrize = checkbool(msg.hasGainDailyPrize)
	self._myDailyRank = -1

	if msg:HasField("myDailyRank") then
		self._myDailyRank = msg.myDailyRank
	end
end

function HeartOfAoJiuClgSubMo:handlePM_HeartOfAoJiuClgConfirmRes(msg)
	if msg.confirm then
		if msg:HasField("score") then
			self._scoresInStage[msg.stageId] = msg.score
		end

		for _, v in ipairs(msg.raceIdAndLeftHp) do
			self._petHps[v.left] = v.right
		end

		if msg:HasField("myDailyRank") then
			self._myDailyRank = msg.myDailyRank
		end
	end
end

function HeartOfAoJiuClgSubMo:handlePM_HeartOfAoJiuClgResetRes(msg)
	return
end

function HeartOfAoJiuClgSubMo:handlePM_HeartOfAoJiuClgGetRankInfoRes(msg)
	return
end

function HeartOfAoJiuClgSubMo:handlePM_Notify_HeartOfAoJiuClgChallengeResult(msg)
	self._clgResultMsg = msg
end

function HeartOfAoJiuClgSubMo:getBestScore()
	return self._bestScore
end

function HeartOfAoJiuClgSubMo:getCurBestScore()
	local bestScore = self._bestScore
	local totalScore = 0

	for _, score in pairs(self._scoresInStage) do
		totalScore = totalScore + score
	end

	bestScore = Mathf.Max(self._bestScore, totalScore)

	local oldToTalScore = 0

	for _, score in pairs(self._lastStageScores) do
		oldToTalScore = oldToTalScore + score
	end

	bestScore = Mathf.Max(bestScore, oldToTalScore)

	return bestScore
end

function HeartOfAoJiuClgSubMo:isHasGainDailyPrize()
	return self._hasGainDailyPrize
end

function HeartOfAoJiuClgSubMo:getMyDailyRank()
	return self._myDailyRank
end

function HeartOfAoJiuClgSubMo:getClgResultMsg()
	return self._clgResultMsg
end

function HeartOfAoJiuClgSubMo:isPassAllStage()
	local stageDatas = HeartOfAoJiuClgConfig.instance:getStageDatas(self._activityId)

	for _, data in ipairs(stageDatas) do
		if not self:isPassStage(data.stageId) then
			return false
		end
	end

	return true
end

function HeartOfAoJiuClgSubMo:getPassStageCount()
	local count = 0

	for stageId, score in pairs(self._scoresInStage) do
		if self:isPassStage(stageId) then
			count = count + 1
		end
	end

	return count
end

function HeartOfAoJiuClgSubMo:isPassStage(stageId)
	local score = self:getScoreInStage(stageId)

	return score > 0
end

function HeartOfAoJiuClgSubMo:getScoreInStage(stageId)
	return self._scoresInStage[stageId] or -1
end

function HeartOfAoJiuClgSubMo:getLastStageScore(stageId)
	return self._lastStageScores[stageId] or -1
end

function HeartOfAoJiuClgSubMo:getPetHp(raceId)
	return self._petHps[raceId] or 10000
end

function HeartOfAoJiuClgSubMo:isInOpenTime()
	return not GameUtil.checkIsInTimePeriod(self._closeTimeArray[1], self._closeTimeArray[2], true)
end

return HeartOfAoJiuClgSubMo
