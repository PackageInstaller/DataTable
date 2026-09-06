-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/model/GuessPetModel.lua

module("logic.extensions.guesspets.model.GuessPetModel", package.seeall)

local GuessPetModel = class("GuessPetModel", BaseModel)

GuessPetModel.GameStatus_None = 0
GuessPetModel.GameStatus_LoadingQuestion = 1
GuessPetModel.GameStatus_WaitingQuestion = 2
GuessPetModel.GameStatus_PerparingQuestion = 3
GuessPetModel.GameStatus_StartQuestion = 4
GuessPetModel.GameStatus_DoingQuestion = 5
GuessPetModel.GameStatus_FinishQuestion = 6
GuessPetModel.GameStatus_GameOver = 7

function GuessPetModel:onInit()
	self:onReset()
end

function GuessPetModel:onReset()
	self._activityId = 0
	self._activityInfo = nil
	self._matchingPlayers = nil
	self._gameMO = nil
end

function GuessPetModel:setActivityId(activityId)
	self._activityId = activityId
end

function GuessPetModel:getActivityId()
	return self._activityId
end

function GuessPetModel:getActivityEndTimeStamp()
	if self._activityId == 0 then
		return 0
	end

	local activitiCo = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.GuessPets, self._activityId)

	return GameUtil.string2time(activitiCo.endTime)
end

function GuessPetModel:setActivityInfo(activityInfo)
	self._activityInfo = nil

	if not activityInfo then
		return
	end

	self._activityInfo = GuessPetActivityMO.New()
	self._activityInfo.activityId = self._activityId
	self._activityInfo.myScores = activityInfo.personProgress
	self._activityInfo.curPlayTimes = activityInfo.dailyTimes
	self._activityInfo.curWorldScores = activityInfo.globalProgress
	self._activityInfo.gainPersonPrizeIds = activityInfo.gainedPersonPrizeIds
	self._activityInfo.gainWorldPrizeIds = activityInfo.gainedGlobalPrizeIds
end

function GuessPetModel:getCurPlayTimes()
	if self._activityInfo then
		return self._activityInfo.curPlayTimes
	end

	return 0
end

function GuessPetModel:setCurPlayTimes(curPlayTimes)
	if self._activityInfo then
		self._activityInfo.curPlayTimes = curPlayTimes
	end
end

function GuessPetModel:getMyScores()
	if self._activityInfo then
		return self._activityInfo.myScores
	end

	return 0
end

function GuessPetModel:setMyScores(scores)
	if self._activityInfo then
		self._activityInfo.myScores = scores
	end
end

function GuessPetModel:setWorldScores(scores)
	if self._activityInfo then
		self._activityInfo.curWorldScores = scores
	end
end

function GuessPetModel:getWorldScores()
	if self._activityInfo then
		return self._activityInfo.curWorldScores
	end

	return 0
end

function GuessPetModel:hasGainedPersonPrize(id)
	if not self._activityInfo then
		return false
	end

	local gainPersonPrizeIds = self._activityInfo.gainPersonPrizeIds

	return gainPersonPrizeIds and table.indexof(gainPersonPrizeIds, id)
end

function GuessPetModel:onGainPersonPrize(id)
	if not self._activityInfo then
		return
	end

	if not self._activityInfo.gainPersonPrizeIds then
		local gainPersonPrizeIds = {}

		table.insert(gainPersonPrizeIds, id)

		self._activityInfo.gainPersonPrizeIds = gainPersonPrizeIds
	end
end

function GuessPetModel:hasGainedWorldPrize(id)
	if not self._activityInfo then
		return false
	end

	local gainWorldPrizeIds = self._activityInfo.gainWorldPrizeIds

	return gainWorldPrizeIds and table.indexof(gainWorldPrizeIds, id)
end

function GuessPetModel:onGainWorldPrize(id)
	if not self._activityInfo then
		return
	end

	if not self._activityInfo.gainWorldPrizeIds then
		local gainWorldPrizeIds = {}

		table.insert(gainWorldPrizeIds, id)

		self._activityInfo.gainWorldPrizeIds = gainWorldPrizeIds
	end
end

function GuessPetModel:matchOnePlayer(playerInfo)
	self._matchingPlayers = self._matchingPlayers or {}

	for i = 1, self:getMaxPlayerCount() do
		local playerData = self._matchingPlayers[i]

		if playerData and playerData.userId == playerInfo.userId then
			self._matchingPlayers[i] = playerInfo

			return
		end
	end

	for i = 1, self:getMaxPlayerCount() do
		if not self._matchingPlayers[i] then
			self._matchingPlayers[i] = playerInfo

			break
		end
	end
end

function GuessPetModel:playerExitMatching(userId)
	if self._matchingPlayers then
		for i = 1, self:getMaxPlayerCount() do
			if self._matchingPlayers[i] and self._matchingPlayers[i].userId == userId then
				self._matchingPlayers[i] = nil

				break
			end
		end
	end
end

function GuessPetModel:clearMatchingPlayers()
	self._matchingPlayers = nil
end

function GuessPetModel:getMatchingPlayers()
	return self._matchingPlayers
end

function GuessPetModel:startMatchingPlayers()
	self._matchingPlayers = {}
	self._matchingPlayers[1] = RoleModel.instance:GetRole()
end

function GuessPetModel:isMaxMatchingPlayers()
	if not self._matchingPlayers then
		return false
	end

	return table.nums(self._matchingPlayers) >= self:getMaxPlayerCount()
end

function GuessPetModel:getGuessGameMo()
	return self._gameMO
end

function GuessPetModel:setGuessGameInfo(msg)
	self._gameMO = GuessPetActivityGameMO.New()
	self._gameMO.players = {}

	for i = 1, #msg.players do
		local playerMO = GuessPetGamePlayerMO.New()

		playerMO.playerHeadInfo = msg.players[i]

		table.insert(self._gameMO.players, playerMO)
	end

	self:pushQuestion(msg.problem, msg.seq, msg.problemCount)
end

function GuessPetModel:pushQuestion(problem, seq, problemCount)
	self._gameMO.problemCount = problemCount
	self._gameMO.currProblemSeq = seq

	local question = GuessPetQuestionMO.New()

	question.raceId = problem.raceId
	question.pictureId = problem.pictureId
	question.answers = problem.options
	self._gameMO.curQuestion = question

	local perQuestion = self:getPerQuestionSec()
	local startTime = math.ceil(checknumber(problem.startTime) / 1000)

	question.questPreparingStamp = startTime + 5
	question.questStartStamp = startTime + 7
	question.questEndStamp = question.questStartStamp + perQuestion - 7
	question.nextQuestionRecvTime = startTime + perQuestion
end

function GuessPetModel:getPersonPrizePlanId()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.personPrizePlanId
end

function GuessPetModel:getGlobalPrizePlanId()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.globalPrizePlanId
end

function GuessPetModel:getActivityName()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.activityName
end

function GuessPetModel:getActivityMainBgImage()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return GameUrl.getBigbgFolderUrl("guesspets", activityCo.bgImage)
end

function GuessPetModel:getTipsKey()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.activityTipsKey
end

function GuessPetModel:getMainImage()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return GameUrl.checkSpineUIUrl(activityCo.mainImage)
end

function GuessPetModel:getMainImagePose()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)
	local pose = activityCo.mainImagePose

	return pose[1] or 0, pose[2] or 0, pose[3] or 1
end

function GuessPetModel:getGameImagePose()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)
	local pose = activityCo.gameImagePose

	return pose[1] or 0, pose[2] or 0, pose[3] or 1
end

function GuessPetModel:getMaxPlayTimes()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.gameTimeSec
end

function GuessPetModel:getMainViewBubble()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.viewTip, activityCo.viewTipPos[1] or 0, activityCo.viewTipPos[2] or 0
end

function GuessPetModel:getMaxMatchingSec()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.maxMatchingSec
end

function GuessPetModel:getMaxPlayerCount()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.playerCount
end

function GuessPetModel:getQuestionResPath(raceId)
	local questionCo = GuessPetConfig.instance:getQuestionCo(raceId)

	return (GameUrl.checkSpineUrl(questionCo.res))
end

function GuessPetModel:getPerQuestionSec()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.perQuestionSec
end

function GuessPetModel:getFirstScore()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.firstScore
end

function GuessPetModel:getGameViewTipsPlan()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return checknumber(activityCo.tipsPlan)
end

function GuessPetModel:getGameViewTipsTime()
	local activityId = self:getActivityId()
	local activityCo = GuessPetConfig.instance:getActivityCo(activityId)

	return activityCo.tipTime
end

function GuessPetModel:getAnswerTag(index)
	if index == 1 then
		return "A"
	elseif index == 2 then
		return "B"
	elseif index == 3 then
		return "C"
	elseif index == 4 then
		return "D"
	end

	return "E"
end

GuessPetModel.instance = GuessPetModel.New()

return GuessPetModel
