-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/controller/GuessPetController.lua

module("logic.extensions.guesspets.controller.GuessPetController", package.seeall)

local GuessPetController = class("GuessPetController", BaseController)

function GuessPetController:onInit()
	self:onReset()
end

function GuessPetController:onReset()
	self._lastGainPersonPrizeId = 0
	self._lastGainPersonPrizeAcId = 0
	self._lastGainGlobalPrizeId = 0
	self._lastGainGlobalPrizeAcId = 0
	self._isPlayedMatchEff = false
	self._receivedEnterGame = false
	self._lastCancelMatchingTime = 0
end

function GuessPetController:getMatchingRemainTime()
	if self._lastCancelMatchingTime == 0 then
		return 0
	end

	return math.max(0, 10 - (UnityEngine.Time.realtimeSinceStartup - self._lastCancelMatchingTime))
end

function GuessPetController:setMatchingRemainTime(time)
	self._lastCancelMatchingTime = time
end

function GuessPetController:openActivityView()
	self:calCurrActivityId()

	local activityId = GuessPetModel.instance:getActivityId()

	if activityId == 0 then
		return
	end

	UIStateManager.instance:push(ViewName.GuessPetsMain)
end

function GuessPetController:hasShowWorldRecordWhileOpening()
	local key = "guess_pets_show_world_" .. RoleModel.instance:getUserId()

	return checknumber(GameUtil.getUserDayData(key)) == 1
end

function GuessPetController:setShowWorldRecordWhileOpening()
	local key = "guess_pets_show_world_" .. RoleModel.instance:getUserId()

	GameUtil.saveUserDayData(key, 1)
end

function GuessPetController:getCurActivityId()
	local activities = GuessPetConfig.instance:getActivities()

	for i = 1, #activities do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GuessPets, activities[i].activityId) then
			return activities[i].activityId
		end
	end

	return 0
end

function GuessPetController:calCurrActivityId()
	local currActivityId = self:getCurActivityId()

	if currActivityId == 0 then
		GuessPetModel.instance:setActivityId(0)
		GuessPetModel.instance:setActivityInfo()

		return
	end

	local activityId = GuessPetModel.instance:getActivityId()

	if activityId == currActivityId then
		return
	end

	GuessPetModel.instance:setActivityId(currActivityId)
end

function GuessPetController:requestActivityInfo()
	local activityId = GuessPetModel.instance:getActivityId()

	GuessPetAgent.instance:sendPM_GetGuessGameInfoReq(activityId)
end

function GuessPetController:onActivityInfo(msg)
	GuessPetModel.instance:setActivityInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsAcInfo)
end

function GuessPetController:requestGainPersonPrize(id)
	if self._lastGainPersonPrizeId ~= 0 then
		return
	end

	self._lastGainPersonPrizeAcId = GuessPetModel.instance:getActivityId()
	self._lastGainPersonPrizeId = id

	GuessPetAgent.instance:sendPM_GainGuessGamePersonPrizeReq(self._lastGainPersonPrizeAcId, id)
end

function GuessPetController:onGainPersonPrize(status, msg)
	if self._lastGainPersonPrizeId == 0 then
		return
	end

	local prizeId = self._lastGainPersonPrizeId
	local activityId = self._lastGainPersonPrizeAcId

	self._lastGainPersonPrizeId = 0
	self._lastGainPersonPrizeAcId = 0

	if status ~= 0 or activityId ~= GuessPetModel.instance:getActivityId() then
		return
	end

	GuessPetModel.instance:onGainPersonPrize(prizeId)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsPersonPrize)
end

function GuessPetController:requestGainGlobalPrize(id)
	if self._lastGainGlobalPrizeId ~= 0 then
		return
	end

	self._lastGainGlobalPrizeAcId = GuessPetModel.instance:getActivityId()
	self._lastGainGlobalPrizeId = id

	GuessPetAgent.instance:sendPM_GainGuessGameGlobalPrizeReq(self._lastGainGlobalPrizeAcId, id)
end

function GuessPetController:onGainGlobalPrize(status, msg)
	if self._lastGainGlobalPrizeId == 0 then
		return
	end

	local prizeId = self._lastGainGlobalPrizeId
	local activityId = self._lastGainGlobalPrizeAcId

	self._lastGainGlobalPrizeAcId = 0
	self._lastGainGlobalPrizeId = 0

	if status ~= 0 or activityId ~= GuessPetModel.instance:getActivityId() then
		return
	end

	GuessPetModel.instance:onGainWorldPrize(prizeId)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsGlobalPrize)
end

function GuessPetController:startMatchingPlayers()
	self._isPlayedMatchEff = false
	self._receivedEnterGame = false

	GuessPetModel.instance:startMatchingPlayers()
	GuessPetAgent.instance:sendPM_GuessGameMatchReq(GuessPetModel.instance:getActivityId())
end

function GuessPetController:onMatchingPlayers(status, msg)
	if status ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsMatchingFailed)
	end
end

function GuessPetController:onNotifyGuessGameQueueChange(players)
	local currPlayers = GuessPetModel.instance:getMatchingPlayers()
	local enterPlayers = {}
	local exitPlayers = {}
	local maxPlayer = GuessPetModel.instance:getMaxPlayerCount()

	for i = 1, maxPlayer do
		local player = currPlayers[i]

		if player then
			local isExited = true

			for j = 1, #players do
				if player.userId == players[j].userId then
					isExited = false

					break
				end
			end

			if isExited then
				table.insert(exitPlayers, player)
			end
		end
	end

	for i = 1, #players do
		local player = players[i]
		local isEnter = true

		for j = 1, maxPlayer do
			local curPlayer = currPlayers[j]

			if curPlayer and player.userId == curPlayer.userId then
				isEnter = false

				break
			end
		end

		if isEnter then
			table.insert(enterPlayers, player)
		end
	end

	for i = 1, #exitPlayers do
		self:onMatchingPlayerExit(exitPlayers[i].userId)
	end

	for i = 1, #enterPlayers do
		self:onMatchingPlayer(enterPlayers[i])
	end
end

function GuessPetController:cancelMatchingPlayers()
	GuessPetAgent.instance:sendPM_GuessGameCancelMatchReq()
end

function GuessPetController:onCancelMatchingPlayers()
	GuessPetModel.instance:clearMatchingPlayers()
	self:setMatchingRemainTime(UnityEngine.Time.realtimeSinceStartup)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsExitMatching)
end

function GuessPetController:onMatchingPlayersSuccess()
	GuessPetModel.instance:clearMatchingPlayers()
	self:setMatchingRemainTime(0)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsMatchingSuccess)
end

function GuessPetController:onMatchingPlayersFailed()
	self:setMatchingRemainTime(0)
	GuessPetModel.instance:clearMatchingPlayers()
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsMatchingFailed)
end

function GuessPetController:onMatchingPlayer(playerInfo)
	GuessPetModel.instance:matchOnePlayer(playerInfo)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsPlayerEnter)
end

function GuessPetController:onMatchingPlayerExit(userId)
	GuessPetModel.instance:playerExitMatching(userId)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsPlayerExit)
end

function GuessPetController:onGuessGameAbort()
	self:setMatchingRemainTime(0)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsGameAbort)
end

function GuessPetController:setPlayedMatchEff(isPlayed)
	self._isPlayedMatchEff = isPlayed or false

	self:enterGuessGameView()
end

function GuessPetController:enterGuessGame(msg)
	GuessPetModel.instance:setGuessGameInfo(msg)

	self._receivedEnterGame = true

	self:onMatchingPlayersSuccess()
	self:enterGuessGameView()
end

function GuessPetController:enterGuessGameView()
	if self._isPlayedMatchEff and self._receivedEnterGame then
		UIStateManager.instance:push(ViewName.GuessPetsGame)

		self._isPlayedMatchEff = false
		self._receivedEnterGame = false
	end
end

function GuessPetController:requestGuessGameGuessPicture(guessId)
	GuessPetAgent.instance:sendPM_GuessGameGuessPictureReq(guessId)
end

function GuessPetController:onNextQuestion(msg)
	GuessPetModel.instance:pushQuestion(msg.problem, msg.seq, msg.problemCount)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsNextQuestion)
end

function GuessPetController:onGuessGamePlayerGuess(msg)
	local gameMO = GuessPetModel.instance:getGuessGameMo()

	if not gameMO.curQuestion or gameMO.currProblemSeq ~= msg.seq then
		return
	end

	local addScores = 0
	local player = gameMO:getPlayer(msg.guessUserId)

	if player then
		addScores = msg.curScore - (player.scores or 0)
		player.scores = msg.curScore
	end

	gameMO.curQuestion:setPlayerAnswer(msg.guessUserId, msg.guessId, msg.isFirstCorrect, addScores)
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsPlayerAnswer, msg.guessUserId, gameMO.curQuestion)
end

function GuessPetController:onGuessGameNotifyLeaveGame(msg)
	local gameMO = GuessPetModel.instance:getGuessGameMo()

	if not gameMO then
		return
	end

	local player = gameMO:getPlayer(msg.leaveUserId)

	if player then
		player.isOffline = true
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsPlayerExitGame, msg.leaveUserId)
end

function GuessPetController:requestGuessGameLeaveGame()
	GuessPetAgent.instance:sendPM_GuessGameLeaveGameReq()
end

function GuessPetController:onGuessGameExit()
	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsExitGameSucces)
end

function GuessPetController:onGuessGameEnd(msg)
	GuessPetModel.instance:setMyScores(msg.personProgress)
	GuessPetModel.instance:setWorldScores(msg.globalProgress)
	GuessPetModel.instance:setCurPlayTimes(msg.dailyTimes)

	local gameMO = GuessPetModel.instance:getGuessGameMo()

	if not gameMO then
		return
	end

	gameMO.guessGameResult = {}

	for i = 1, #msg.userList do
		gameMO.guessGameResult[msg.userList[i].userId] = msg.userList[i].score
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnGuessPetsGameResult)
end

GuessPetController.instance = GuessPetController.New()

return GuessPetController
