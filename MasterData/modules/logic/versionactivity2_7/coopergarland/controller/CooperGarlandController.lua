-- chunkname: @modules/logic/versionactivity2_7/coopergarland/controller/CooperGarlandController.lua

module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandController", package.seeall)

local CooperGarlandController = class("CooperGarlandController", BaseController)

function CooperGarlandController:onInit()
	return
end

function CooperGarlandController:onInitFinish()
	return
end

function CooperGarlandController:addConstEvents()
	return
end

function CooperGarlandController:reInit()
	return
end

function CooperGarlandController:getAct192Info(cb, cbObj, isToast)
	local isOpen = CooperGarlandModel.instance:isAct192Open(isToast)

	if not isOpen then
		return
	end

	local actId = CooperGarlandModel.instance:getAct192Id()

	Activity192Rpc.instance:sendGetAct192InfoRequest(actId, cb, cbObj)
end

function CooperGarlandController:onGetAct192Info(info)
	CooperGarlandModel.instance:updateAct192Info(info)
	self:dispatchEvent(CooperGarlandEvent.OnAct192InfoUpdate)
end

function CooperGarlandController:saveGameProgress(episodeId, curRound, isToast)
	local isOpen = CooperGarlandModel.instance:isAct192Open(isToast)

	if not isOpen then
		return
	end

	local actId = CooperGarlandModel.instance:getAct192Id()
	local isUnlock = CooperGarlandModel.instance:isUnlockEpisode(actId, episodeId)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	Activity192Rpc.instance:sendAct192FinishEpisodeRequest(actId, episodeId, tostring(curRound), self._onSaveGameProgress, self)
end

function CooperGarlandController:_onSaveGameProgress(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = msg.activityId
	local episodeId = msg.episodeId
	local progress = msg.progress
	local isFinished = CooperGarlandModel.instance:isFinishedEpisode(actId, episodeId)

	CooperGarlandModel.instance:updateAct192Episode(actId, episodeId, isFinished, progress)
end

function CooperGarlandController:finishEpisode(episodeId, isToast)
	local isOpen = CooperGarlandModel.instance:isAct192Open(isToast)

	if not isOpen then
		return
	end

	local actId = CooperGarlandModel.instance:getAct192Id()
	local isUnlock = CooperGarlandModel.instance:isUnlockEpisode(actId, episodeId)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	local isFinished = CooperGarlandModel.instance:isFinishedEpisode(actId, episodeId)

	if isFinished then
		self:_playStoryClear(episodeId)

		local isExtra = CooperGarlandConfig.instance:isExtraEpisode(actId, episodeId)

		if isExtra then
			self:saveGameProgress(episodeId, CooperGarlandEnum.Const.DefaultGameProgress, true)
		end
	else
		Activity192Rpc.instance:sendAct192FinishEpisodeRequest(actId, episodeId, nil, self.onFinishEpisode, self)
	end
end

function CooperGarlandController:onFinishEpisode(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = msg.activityId
	local episodeId = msg.episodeId
	local progress = msg.progress

	CooperGarlandModel.instance:updateAct192Episode(actId, episodeId, true, progress)

	local curActId = CooperGarlandModel.instance:getAct192Id()

	if actId == curActId then
		self:_playStoryClear(episodeId)
	end

	self:dispatchEvent(CooperGarlandEvent.FirstFinishEpisode, actId, episodeId)
end

function CooperGarlandController:_playStoryClear(episodeId)
	local actId = CooperGarlandModel.instance:getAct192Id()
	local isFinished = CooperGarlandModel.instance:isFinishedEpisode(actId, episodeId)

	if not isFinished then
		return
	end

	local storyClear = CooperGarlandConfig.instance:getStoryClear(actId, episodeId)

	if storyClear and storyClear ~= 0 then
		StoryController.instance:playStory(storyClear, nil, self.openResultView, self, {
			isWin = true,
			episodeId = episodeId
		})
	else
		self:openResultView({
			isWin = true,
			episodeId = episodeId
		})
	end
end

function CooperGarlandController:clickEpisode(actId, episodeId)
	local isOpen = CooperGarlandModel.instance:isAct192Open(true)

	if not isOpen then
		return
	end

	local isUnlock = CooperGarlandModel.instance:isUnlockEpisode(actId, episodeId)

	if not isUnlock then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	self:dispatchEvent(CooperGarlandEvent.OnClickEpisode, actId, episodeId)
end

function CooperGarlandController:afterClickEpisode(actId, episodeId)
	local curActId = CooperGarlandModel.instance:getAct192Id()

	if not actId or not episodeId or actId ~= curActId then
		return
	end

	CooperGarlandStatHelper.instance:enterEpisode(episodeId)

	local isExtra = CooperGarlandConfig.instance:isExtraEpisode(actId, episodeId)

	if isExtra then
		local saveRound = CooperGarlandModel.instance:getEpisodeProgress(actId, episodeId)

		Activity192Rpc.instance:sendAct192FinishEpisodeRequest(actId, episodeId, tostring(saveRound))
	end

	local storyBefore = CooperGarlandConfig.instance:getStoryBefore(actId, episodeId)

	if storyBefore and storyBefore ~= 0 then
		StoryController.instance:playStory(storyBefore, nil, self._enterGame, self, {
			episodeId = episodeId
		})

		return
	end

	self:_enterGame({
		episodeId = episodeId
	})
end

function CooperGarlandController:openLevelView()
	self.getAct192Info(self, self._realOpenLevelView, self, true)
end

function CooperGarlandController:_realOpenLevelView(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.CooperGarlandLevelView)
end

function CooperGarlandController:openTaskView()
	CooperGarlandTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity192
	}, self._realOpenTaskView, self)
end

function CooperGarlandController:_realOpenTaskView(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CooperGarlandTaskListModel.instance:init()
	ViewMgr.instance:openView(ViewName.CooperGarlandTaskView)
end

function CooperGarlandController:openResultView(param)
	if param and param.isWin then
		CooperGarlandStatHelper.instance:sendEpisodeFinish()
	end

	local actId = CooperGarlandModel.instance:getAct192Id()
	local episodeId = param and param.episodeId

	if not actId or not episodeId then
		return
	end

	local hasGame = CooperGarlandConfig.instance:isGameEpisode(actId, episodeId)

	if not hasGame then
		return
	end

	ViewMgr.instance:openView(ViewName.CooperGarlandResultView, {
		episodeId = episodeId,
		isWin = param.isWin
	})
end

function CooperGarlandController:_enterGame(param)
	local actId = CooperGarlandModel.instance:getAct192Id()
	local episodeId = param and param.episodeId
	local hasGame = CooperGarlandConfig.instance:isGameEpisode(actId, episodeId)

	if hasGame then
		CooperGarlandStatHelper.instance:enterGame()
		CooperGarlandGameModel.instance:enterGameInitData(episodeId)
		CooperGarlandGameEntityMgr.instance:enterMap()
		ViewMgr.instance:openView(ViewName.CooperGarlandGameView)
	else
		self:finishEpisode(episodeId, true)
	end
end

function CooperGarlandController:resetJoystick()
	self:dispatchEvent(CooperGarlandEvent.ResetJoystick)
end

function CooperGarlandController:resetPanelBalance(lerpTimeScale, isForceSet)
	self:changePanelBalance(0, 0, lerpTimeScale, isForceSet)
end

function CooperGarlandController:changePanelBalance(x, y, lerpTimeScale, isForceSet)
	self:dispatchEvent(CooperGarlandEvent.ChangePanelAngle, x, y, lerpTimeScale or 0, isForceSet)
end

function CooperGarlandController:changeRemoveMode()
	local curIsRemoveMode = CooperGarlandGameModel.instance:getIsRemoveMode()
	local newIsRemoveMode = not curIsRemoveMode

	if newIsRemoveMode then
		local removeCount = CooperGarlandGameModel.instance:getRemoveCount()

		if not removeCount or removeCount <= 0 then
			GameFacade.showToast(ToastEnum.CooperGarlandRemoveCountNotEnough)

			return
		end
	end

	self:setStopGame(newIsRemoveMode)
	CooperGarlandGameModel.instance:setRemoveMode(newIsRemoveMode)
	self:dispatchEvent(CooperGarlandEvent.OnRemoveModeChange)
end

function CooperGarlandController:changeControlMode()
	self:resetJoystick()
	self:resetPanelBalance(0, true)

	local controlMode = CooperGarlandGameModel.instance:getControlMode()
	local newControlMode = controlMode % CooperGarlandEnum.Const.JoystickModeLeft + 1

	CooperGarlandGameModel.instance:setControlMode(newControlMode)
	self:dispatchEvent(CooperGarlandEvent.OnChangeControlMode)
end

function CooperGarlandController:removeComponent(mapId, componentId)
	local isRemoveMode = CooperGarlandGameModel.instance:getIsRemoveMode()

	if not isRemoveMode then
		return
	end

	local removeCount = CooperGarlandGameModel.instance:getRemoveCount()

	if not removeCount or removeCount <= 0 then
		return
	end

	local componentType = CooperGarlandConfig.instance:getMapComponentType(mapId, componentId)

	if componentType == CooperGarlandEnum.ComponentType.Hole or componentType == CooperGarlandEnum.ComponentType.Spike then
		CooperGarlandGameEntityMgr.instance:removeComp(componentId)
		CooperGarlandGameModel.instance:setRemoveCount(removeCount - 1)
		self:dispatchEvent(CooperGarlandEvent.OnRemoveComponent, componentId)
	end
end

function CooperGarlandController:enterNextRound()
	local curRound = CooperGarlandGameModel.instance:getGameRound()
	local nextRound = curRound + 1
	local actId = CooperGarlandModel.instance:getAct192Id()
	local episodeId = CooperGarlandGameModel.instance:getEpisodeId()
	local isExtra = CooperGarlandConfig.instance:isExtraEpisode(actId, episodeId)

	if isExtra then
		self:saveGameProgress(episodeId, nextRound, true)
	end

	CooperGarlandGameModel.instance:changeRound(nextRound)
	CooperGarlandGameEntityMgr.instance:changeMap()
	self:dispatchEvent(CooperGarlandEvent.OnEnterNextRound)
end

function CooperGarlandController:resetGame()
	CooperGarlandGameModel.instance:resetGameData()
	CooperGarlandGameEntityMgr.instance:resetMap()
	self:dispatchEvent(CooperGarlandEvent.OnResetGame)
end

function CooperGarlandController:exitGame()
	CooperGarlandGameEntityMgr.instance:clearAllMap()
	CooperGarlandGameModel.instance:clearAllData()
	ViewMgr.instance:closeView(ViewName.CooperGarlandGameView)
end

function CooperGarlandController:setStopGame(isStop)
	local curIsStop = CooperGarlandGameModel.instance:getIsStopGame()

	if curIsStop == isStop then
		return
	end

	CooperGarlandGameModel.instance:setIsStopGame(isStop)
	self:resetJoystick()
	self:resetPanelBalance(0, true)
	CooperGarlandGameEntityMgr.instance:checkBallFreeze(true)
	self:dispatchEvent(CooperGarlandEvent.OnGameStopChange)
end

function CooperGarlandController:triggerEnterComponent(mapId, componentId)
	local isCanTrigger = CooperGarlandGameEntityMgr.instance:isBallCanTriggerComp()

	if not isCanTrigger then
		return
	end

	local audioId
	local cooperAudioEnum = AudioEnum2_7.CooperGarland
	local componentType = CooperGarlandConfig.instance:getMapComponentType(mapId, componentId)

	if componentType == CooperGarlandEnum.ComponentType.End then
		audioId = cooperAudioEnum.play_ui_yuzhou_ball_fall

		self:_ballArrivesEnd()
	elseif componentType == CooperGarlandEnum.ComponentType.Hole or componentType == CooperGarlandEnum.ComponentType.Spike then
		audioId = componentType == CooperGarlandEnum.ComponentType.Hole and cooperAudioEnum.play_ui_yuzhou_ball_trap or cooperAudioEnum.play_ui_yuzhou_ball_spikes

		CooperGarlandGameEntityMgr.instance:playBallDieVx()
		self:_gameFail(componentId)
	elseif componentType == CooperGarlandEnum.ComponentType.Key then
		self:_ballKeyChange(true)

		audioId = cooperAudioEnum.play_ui_yuzhou_ball_star

		CooperGarlandGameEntityMgr.instance:removeComp(componentId)
	elseif componentType == CooperGarlandEnum.ComponentType.Story then
		local extraParam = CooperGarlandConfig.instance:getMapComponentExtraParams(mapId, componentId)

		self:_triggerStory(extraParam)
	end

	if audioId then
		AudioMgr.instance:trigger(audioId)
	end
end

function CooperGarlandController:triggerExitComponent(mapId, componentId)
	local componentType = CooperGarlandConfig.instance:getMapComponentType(mapId, componentId)
end

function CooperGarlandController:_ballArrivesEnd()
	self:setStopGame(true)
	CooperGarlandStatHelper.instance:sendMapArrive()

	local curRound = CooperGarlandGameModel.instance:getGameRound()
	local gameId = CooperGarlandGameModel.instance:getGameId()
	local maxRound = CooperGarlandConfig.instance:getMaxRound(gameId)

	if maxRound <= curRound then
		CooperGarlandStatHelper.instance:sendGameFinish()
		self:dispatchEvent(CooperGarlandEvent.PlayFinishEpisodeStarVX)
	else
		CooperGarlandGameModel.instance:setSceneOpenAnimShowBall(false)
		self:dispatchEvent(CooperGarlandEvent.PlayEnterNextRoundAnim)
	end
end

function CooperGarlandController:_gameFail(componentId)
	self:setStopGame(true)
	CooperGarlandStatHelper.instance:sendMapFail(componentId)

	local episodeId = CooperGarlandGameModel.instance:getEpisodeId()

	self:openResultView({
		isWin = false,
		episodeId = episodeId
	})
end

function CooperGarlandController:_ballKeyChange(isGet)
	CooperGarlandGameModel.instance:setBallHasKey(isGet)
	self:dispatchEvent(CooperGarlandEvent.OnBallKeyChange)
end

function CooperGarlandController:_triggerStory(params)
	local guideId = params and tonumber(params)

	if not guideId then
		return
	end

	local isForbid = GuideController.instance:isForbidGuides()
	local isRunning = GuideModel.instance:isGuideRunning(guideId)

	if not isRunning or isForbid then
		return
	end

	self:setStopGame(true)
	self:dispatchEvent(CooperGarlandEvent.triggerGuideDialogue, guideId)
end

CooperGarlandController.instance = CooperGarlandController.New()

return CooperGarlandController
