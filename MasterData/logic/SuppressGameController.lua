-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/controller/SuppressGameController.lua

module("logic.extensions.suppressgame.controller.SuppressGameController", package.seeall)

local SuppressGameController = class("SuppressGameController", BaseController)

function SuppressGameController:ctor()
	return
end

function SuppressGameController:onInit()
	self:onReset()
end

function SuppressGameController:onReset()
	return
end

function SuppressGameController:onSendSuppressGameGetInfoReq(activityId)
	SuppressGameAgent.instance:sendPM_SuppressGameGetInfoReq(activityId)
end

function SuppressGameController:onHandleSuppressGameGetInfoRes(msg)
	SuppressGameModel.instance:onHandleSuppressGameGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameGetInfoRes)
end

function SuppressGameController:onSendSuppressGameStartGameReq(activityId)
	local clientKey = math.random(1, 100000)

	SuppressGameAgent.instance:sendPM_SuppressGameStartGameReq(activityId, clientKey)
end

function SuppressGameController:onHandleSuppressGameStartGameRes(msg)
	SuppressGameModel.instance:onHandleSuppressGameStartGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameStartGameRes)
end

function SuppressGameController:onSendSuppressGameEndGameReq(progress)
	local encryptedKey = SuppressGameModel.instance:getEncryptedKey(progress)

	SuppressGameAgent.instance:sendPM_SuppressGameEndGameReq(progress, encryptedKey)
end

function SuppressGameController:onHandleSuppressGameEndGameRes(msg)
	SuppressGameModel.instance:onHandleSuppressGameEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameEndGameRes)
	self:_handleGameEndThenPushResult(msg.gameId, msg.progress)
end

function SuppressGameController:onSendSuppressGameGetTaskInfoReq(activityId)
	SuppressGameAgent.instance:sendPM_SuppressGameGetTaskInfoReq(activityId)
end

function SuppressGameController:onHandleSuppressGameGetTaskInfoRes(msg)
	SuppressGameModel.instance:onHandleSuppressGameGetTaskInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameGetTaskInfoRes)
end

function SuppressGameController:onSendSuppressGameGainPrizeReq(activityId, gameId, taskId)
	SuppressGameAgent.instance:sendPM_SuppressGameGainPrizeReq(activityId, gameId, taskId)
end

function SuppressGameController:onHandleSuppressGameGainPrizeRes(msg)
	SuppressGameModel.instance:onHandleSuppressGameGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameGainPrizeRes)
end

function SuppressGameController:dailyRefresh()
	return
end

function SuppressGameController:_enterGame()
	local activityId = SuppressGameModel.instance:getCurActivityId()
	local gameId = SuppressGameModel.instance:getCurGameId()
	local tabData = SuppressGameConfig.instance:getSgTabData(activityId, gameId)

	if string.nilorempty(tabData.jumpTo) then
		printError(string.format("跳转为空,这样进不了游戏的( activityId=%d, gameId=%d )", activityId, gameId))

		return
	end

	GotoMgr.gotoByString(tabData.jumpTo)
end

function SuppressGameController:_endGameHandle(gameScore)
	self._curGameScore = gameScore

	local gameId = SuppressGameModel.instance:getCurGameId()
	local activityId = SuppressGameModel.instance:getCurActivityId()

	if gameId == 0 or activityId == 0 then
		return
	end

	local tabData = SuppressGameConfig.instance:getSgTabData(activityId, gameId)
	local progress = self:_getProgressByScore(tabData.progressPlanId, gameScore)

	self:onSendSuppressGameEndGameReq(progress)
end

function SuppressGameController:_isNeedContinueGame()
	local gameId = SuppressGameModel.instance:getCurGameId()

	return gameId ~= 0
end

function SuppressGameController:_isGameHasSuppress(gameId)
	local curGameProgress = SuppressGameModel.instance:getGameProgress(gameId)
	local activityId = SuppressGameModel.instance:getCurActivityId()
	local tabData = SuppressGameConfig.instance:getSgTabData(activityId, gameId)
	local maxProgress = tabData.maxProgress

	return maxProgress <= curGameProgress
end

function SuppressGameController:_isAllGameHasSuppress()
	local activityId = SuppressGameModel.instance:getCurActivityId()
	local tabCfg = SuppressGameConfig.instance:getSgTabCfg(activityId)
	local isAllSuppress = true

	for _, data in ipairs(tabCfg) do
		local isSuppress = self:_isGameHasSuppress(data.gameId)

		if isSuppress == false then
			isAllSuppress = false

			break
		end
	end

	return isAllSuppress
end

function SuppressGameController:_handleGameEndThenPushResult(gameId, progress)
	gameId = checknumber(gameId)
	progress = checknumber(progress)

	local activityId = SuppressGameModel.instance:getCurActivityId()
	local tabData = SuppressGameConfig.instance:getSgTabData(activityId, gameId)
	local scoreValue = self._curGameScore
	local progressValue = progress
	local gameName = tabData.name

	local function callBack()
		UIStateManager.instance:clear()
		UIStateManager.instance:push(ViewName.SuppressGameMainView)
	end

	UIStateManager.instance:push(ViewName.SuppressGameResultView, scoreValue, progressValue, gameName, callBack)
end

function SuppressGameController:_getProgressByScore(progressPlanId, gameScore)
	local proCfg = SuppressGameConfig.instance:getSgProgressCfg(progressPlanId)
	local proData

	for _, data in ipairs(proCfg) do
		if gameScore >= data.gameScore then
			proData = data
		else
			break
		end
	end

	if proData then
		if not proData.progress then
			return 0
		end
	end
end

SuppressGameController.instance = SuppressGameController.New()

return SuppressGameController
