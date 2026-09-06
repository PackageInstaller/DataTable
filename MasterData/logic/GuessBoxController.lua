-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/controller/GuessBoxController.lua

module("logic.extensions.guessbox.controller.GuessBoxController", package.seeall)

local GuessBoxController = class("GuessBoxController", BaseController)

function GuessBoxController:ctor()
	return
end

function GuessBoxController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self.startEnterGame, self)
	self:onReset()
end

function GuessBoxController:onReset()
	return
end

function GuessBoxController:onSendGuessBoxGameGetInfoReq(activityId)
	GuessBoxAgent.instance:sendPM_GuessBoxGameGetInfoReq(activityId)
end

function GuessBoxController:onHandleGuessBoxGameGetInfoRes(msg)
	GuessBoxModel.instance:onHandleGuessBoxGameGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GuessBoxGameGetInfo)
end

function GuessBoxController:onSendGuessBoxGameStartGameReq(activityId)
	GuessBoxModel.instance:setGameScore(0)

	local clientKey = math.random(1, 100000)

	GuessBoxModel.instance:saveClientKey(clientKey)
	GuessBoxAgent.instance:sendPM_GuessBoxGameStartGameReq(activityId, clientKey)
end

function GuessBoxController:onHandleGuessBoxGameStartGameRes(msg)
	GuessBoxModel.instance:onHandleGuessBoxGameStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GuessBoxGameStartGame)
end

function GuessBoxController:onSendGuessBoxGameEndGameReq(flowerIds, score)
	flowerIds = flowerIds or {}

	GuessBoxModel.instance:saveFlowerIds(flowerIds)

	local getScore = checknumber(score)
	local clientKey = GuessBoxModel.instance:getClientKey()
	local serverKey = bit.bxor(GuessBoxModel.instance:getServerKey(), clientKey)
	local encryptedKey = 0

	for _, id in ipairs(flowerIds) do
		encryptedKey = id % 2 == 0 and encryptedKey + (id + serverKey) * 5381 or encryptedKey + (id + clientKey) * 31
	end

	encryptedKey = getScore % 2 == 0 and encryptedKey + (getScore + serverKey) * 5381 or encryptedKey + (getScore + clientKey) * 31

	GuessBoxModel.instance:setGameScore(score)
	GuessBoxAgent.instance:sendPM_GuessBoxGameEndGameReq(flowerIds, getScore, encryptedKey)
end

function GuessBoxController:onHandleGuessBoxGameEndGameRes(msg)
	GuessBoxModel.instance:onHandleGuessBoxGameEndGameRes(msg)

	local changeSetId = checknumber(msg.changeSetId)
	local matMos = MaterialModel.instance:getMaterialMos(changeSetId)
	local prizeStrList = {}

	for _, mo in ipairs(matMos) do
		local prizeStr = mo:toString()

		table.insert(prizeStrList, prizeStr)
	end

	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.GuessBoxGameEndGame, changeSetId, prizeStrList)
end

function GuessBoxController:onHandleGuessBoxGameGainScorePrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GuessBoxGameGainScorePrize)
end

function GuessBoxController:onHandleGuessBoxGameRankInfoRes(msg)
	GuessBoxModel.instance:onHandleGuessBoxGameEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GuessBoxGameRankInfo)
end

function GuessBoxController:startEnterGame()
	return
end

function GuessBoxController:dailyRefresh()
	return
end

function GuessBoxController:isHaveTimes()
	local dailyPlayTimes, dailyHasPlayeTimes = self:getDatePlayNum()
	local weekPlayTimes, weeklyHasPlayeTimes = self:getWeekPlayNum()
	local isHaveDailyTimes = dailyHasPlayeTimes < dailyPlayTimes
	local isHaveWeekTimes = weeklyHasPlayeTimes < weekPlayTimes

	return isHaveDailyTimes and isHaveWeekTimes
end

function GuessBoxController:getDatePlayNum()
	local activityId = GuessBoxModel.instance:getActivityId()
	local gbCfg = GuessBoxConfig.instance:getGbCfg(activityId)
	local dailyPlayTimes = gbCfg.dailyPlayTimes
	local dailyHasPlayeTimes = GuessBoxModel.instance:getDailyHasPlayeTimes()

	return dailyPlayTimes, dailyHasPlayeTimes
end

function GuessBoxController:getWeekPlayNum()
	local activityId = GuessBoxModel.instance:getActivityId()
	local gbCfg = GuessBoxConfig.instance:getGbCfg(activityId)
	local weekPlayTimes = gbCfg.weekPlayTimes
	local weeklyHasPlayeTimes = GuessBoxModel.instance:getWeeklyHasPlayeTimes()

	return weekPlayTimes, weeklyHasPlayeTimes
end

function GuessBoxController:getCorrectGuestNum()
	local activityId = GuessBoxModel.instance:getActivityId()
	local gbCfg = GuessBoxConfig.instance:getGbCfg(activityId)
	local correctFlowerId = gbCfg.correctFlowerId
	local flowerIds = GuessBoxModel.instance:getFlowerIds()
	local correctNum = 0

	for _, id in ipairs(flowerIds) do
		if id == correctFlowerId then
			correctNum = correctNum + 1
		end
	end

	return correctNum
end

GuessBoxController.instance = GuessBoxController.New()

return GuessBoxController
