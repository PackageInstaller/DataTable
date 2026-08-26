-- chunkname: @modules/logic/versionactivity2_8/molideer/controller/MoLiDeErGameController.lua

module("modules.logic.versionactivity2_8.molideer.controller.MoLiDeErGameController", package.seeall)

local MoLiDeErGameController = class("MoLiDeErGameController", BaseController)

function MoLiDeErGameController:onInit()
	self._finishIndex = nil
end

function MoLiDeErGameController:onInitFinish()
	return
end

function MoLiDeErGameController:addConstEvents()
	return
end

function MoLiDeErGameController:reInit()
	self._finishIndex = nil
end

function MoLiDeErGameController:enterGame(actId, episodeId)
	local episodeConfig = MoLiDeErConfig.instance:getEpisodeConfig(actId, episodeId)
	local gameId = episodeConfig.gameId
	local gameConfig = MoLiDeErConfig.instance:getGameConfig(gameId)

	if gameConfig == nil then
		logError("找不到对应的游戏关卡 id:" .. gameId)

		return
	end

	if ViewMgr.instance:isOpen(ViewName.MoLiDeErGameView) then
		-- block empty
	end

	MoLiDeErGameModel.instance:setCurGameData(gameId, gameConfig)
	ViewMgr.instance:openView(ViewName.MoLiDeErInterludeView, {
		isNextRound = false,
		callback = self.onInterludeAnimFinish,
		callbackObj = self
	})
end

function MoLiDeErGameController:onInterludeAnimFinish()
	ViewMgr.instance:openView(ViewName.MoLiDeErGameView)
end

function MoLiDeErGameController:startGame(actId, episodeId)
	MoLiDeErRpc.instance:sendAct194EnterEpisodeRequest(actId, episodeId, self.onReceiveStartGame, self)
end

function MoLiDeErGameController:resumeGame(actId, episodeId)
	MoLiDeErRpc.instance:sendAct194GetEpisodeInfoRequest(actId, episodeId, self.onReceiveResumeGame, self)
end

function MoLiDeErGameController:onReceiveStartGame(cmd, resultCode, msg)
	if resultCode == 0 then
		local actId = msg.activityId
		local episodeId = msg.episodeInfo.episodeId

		self:enterGame(actId, episodeId)
	end
end

function MoLiDeErGameController:onReceiveResumeGame(cmd, resultCode, msg)
	if resultCode == 0 then
		local actId = msg.activityId
		local episodeId = msg.episodeInfo.episodeId

		self:enterGame(actId, episodeId)
	end
end

function MoLiDeErGameController:useItem(actId, episodeId, itemId)
	MoLiDeErRpc.instance:sendAct194UseItemRequest(actId, episodeId, itemId)
end

function MoLiDeErGameController:onUseItem(msg)
	self:dispatchEvent(MoLiDeErEvent.GameUseItem, msg.itemId)
end

function MoLiDeErGameController:dispatchTeam(actId, episodeId, eventId, teamId, optionId)
	MoLiDeErRpc.instance:sendAct194SendTeamExploreRequest(actId, episodeId, eventId, teamId, optionId)
end

function MoLiDeErGameController:withDrawTeam(drawTeamId)
	local msgId = MessageBoxIdDefine.MoLiDeErWithdrawTeamTip

	self._withdrawTeamId = drawTeamId

	GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realWithdrawTeam, nil, nil, self)
end

function MoLiDeErGameController:onWithdrawReply(teamId)
	self:dispatchEvent(MoLiDeErEvent.GameWithdrawTeam, teamId)
end

function MoLiDeErGameController:realWithdrawTeam()
	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErRpc.instance:sendAct194WithdrawTeamRequest(actId, episodeId, self._withdrawTeamId)

	self._withdrawTeamId = nil
end

function MoLiDeErGameController:onDispatchTeam(msg)
	self:dispatchEvent(MoLiDeErEvent.GameDispatchTeam)
end

function MoLiDeErGameController:nextRound(actId, episodeId)
	MoLiDeErRpc.instance:sendAct194NextRoundRequest(actId, episodeId)
end

function MoLiDeErGameController:onEpisodeInfoPush(msg)
	local activityId = msg.activityId
	local gameInfo = msg.episodeInfo
	local curGameInfo = MoLiDeErGameModel.instance:getCurGameInfo()

	if curGameInfo then
		local currentRound = curGameInfo.currentRound
		local newRound = gameInfo.currentRound

		MoLiDeErGameModel.instance:setEpisodeInfo(activityId, gameInfo, msg.isEpisodeFinish, msg.passStar)

		if currentRound < newRound then
			logNormal("莫莉德尔 角色活动 下一回合")
			ViewMgr.instance:openView(ViewName.MoLiDeErInterludeView, {
				isNextRound = true,
				callback = self.sendUIRefreshEvent,
				callbackObj = self
			})
		elseif currentRound == newRound then
			self:sendUIRefreshEvent()
		else
			logNormal("莫莉德尔 角色活动 重置")
			ViewMgr.instance:openView(ViewName.MoLiDeErInterludeView)
			self:dispatchEvent(MoLiDeErEvent.GameReset)
		end
	else
		MoLiDeErGameModel.instance:setEpisodeInfo(activityId, gameInfo, msg.isEpisodeFinish, msg.passStar)
	end
end

function MoLiDeErGameController:sendUIRefreshEvent()
	self:dispatchEvent(MoLiDeErEvent.GameUIRefresh)
end

function MoLiDeErGameController:showFinishEvent(closeViewName)
	if closeViewName ~= nil and closeViewName ~= ViewName.MoLiDeErEventView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.showFinishEvent, self)

	local currentGameInfo = MoLiDeErGameModel.instance:getCurGameInfo()
	local finishList = currentGameInfo.newFinishEventList

	if finishList and #finishList > 0 then
		if self._finishIndex == nil then
			logNormal("莫莉德尔 角色活动 存在完成的事件")

			self._finishIndex = 1
		else
			if self._finishIndex >= #finishList then
				self._finishIndex = nil

				self:dispatchEvent(MoLiDeErEvent.GameFinishEventShowEnd)

				return
			end

			self._finishIndex = self._finishIndex + 1
		end

		if ViewMgr.instance:isOpen(ViewName.MoLiDeErEventView) then
			ViewMgr.instance:closeView(ViewName.MoLiDeErEventView)
		end

		local info = finishList[self._finishIndex]
		local param = {
			eventId = info.eventId,
			optionId = info.optionId,
			state = MoLiDeErEnum.DispatchState.Finish
		}

		ViewMgr.instance:openView(ViewName.MoLiDeErEventView, param)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.showFinishEvent, self)
	else
		self:dispatchEvent(MoLiDeErEvent.GameFinishEventShowEnd)
	end
end

function MoLiDeErGameController:skipGame()
	local msgId = MessageBoxIdDefine.MoLiDeErSkipGameTip

	GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realSendSkip, nil, nil, self)
end

function MoLiDeErGameController:realSendSkip()
	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErRpc.instance:sendAct194SkipEpisodeRequest(actId, episodeId)
end

function MoLiDeErGameController:onReceiveSkipGame(activityId, episodeId)
	local curActId = MoLiDeErModel.instance:getCurActId()
	local curEpisodeId = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameModel.instance:setSkipGameTrigger(activityId, episodeId, true)

	if curActId == activityId and curEpisodeId == episodeId then
		self:onSuccessExit()
	end
end

function MoLiDeErGameController:resetGame()
	local msgId = MessageBoxIdDefine.MoLiDeErResetGameTip

	GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realResetGame, nil, nil, self)
end

function MoLiDeErGameController:realResetGame()
	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErRpc.instance:sendAct194ResetEpisodeRequest(actId, episodeId)
end

function MoLiDeErGameController:onResetGame(actId, episodeId)
	MoLiDeErGameModel.instance:resetGame(actId, episodeId)
end

function MoLiDeErGameController:onSuccessExit()
	self:dispatchEvent(MoLiDeErEvent.GameExit)
	MoLiDeErController.instance:gameFinish()

	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameModel.instance:resetGame(actId, episodeId)
end

function MoLiDeErGameController:onFailRestart()
	self:restartGame()
end

function MoLiDeErGameController:restartGame()
	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	self:startGame(actId, episodeId)
end

function MoLiDeErGameController:onFailExit()
	self:dispatchEvent(MoLiDeErEvent.GameExit)

	local actId = MoLiDeErModel.instance:getCurActId()
	local episodeId = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameModel.instance:resetGame(actId, episodeId)
end

MoLiDeErGameController.instance = MoLiDeErGameController.New()

return MoLiDeErGameController
