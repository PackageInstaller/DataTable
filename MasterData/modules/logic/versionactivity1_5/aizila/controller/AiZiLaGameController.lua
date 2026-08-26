-- chunkname: @modules/logic/versionactivity1_5/aizila/controller/AiZiLaGameController.lua

module("modules.logic.versionactivity1_5.aizila.controller.AiZiLaGameController", package.seeall)

local AiZiLaGameController = class("AiZiLaGameController", BaseController)

function AiZiLaGameController:onInit()
	self:reInit()
end

function AiZiLaGameController:onInitFinish()
	return
end

function AiZiLaGameController:addConstEvents()
	return
end

function AiZiLaGameController:reInit()
	return
end

function AiZiLaGameController:exitGame()
	if ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventResult) then
		AiZiLaGameController.instance:leaveEventResult()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventView) then
		ViewMgr.instance:closeView(ViewName.AiZiLaGameEventView)

		return
	end

	local episodeMO = AiZiLaGameModel.instance:getEpisodeMO()
	local lostRate = 0
	local roundCfg = episodeMO:getRoundCfg()

	if roundCfg then
		lostRate = 1000 - roundCfg.keepMaterialRate
	end

	if episodeMO:isCanSafe() or lostRate == 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5AiZiLaSafeExitGame, MsgBoxEnum.BoxType.Yes_No, AiZiLaGameController._onExitGameYes)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5AiZiLaNotSafeExitGame, MsgBoxEnum.BoxType.Yes_No, AiZiLaGameController._onExitGameYes, nil, nil, self, nil, nil, lostRate * 0.1)
	end
end

function AiZiLaGameController._onExitGameYes()
	AiZiLaGameController.instance:settleEpisode()
end

function AiZiLaGameController:enterGame(episodeId)
	AiZiLaGameModel.instance:reInit()
	AiZiLaGameModel.instance:setEpisodeId(episodeId)

	local actId = AiZiLaGameModel.instance:getActivityID()
	local episodeCfg = AiZiLaConfig.instance:getEpisodeCo(actId, episodeId)

	self._enterStoryFinish = true
	self._enterRpcFinish = false

	if self:_checkCanPlayStory(episodeCfg.storyBefore) then
		self._enterStoryFinish = false

		self._playStory(self, episodeCfg.storyBefore, self._afterPlayEnterStory, self)
	end

	Activity144Rpc.instance:sendAct144EnterEpisodeRequest(actId, episodeId, self._onEnterGameRequest, self)
end

function AiZiLaGameController:_checkCanPlayStory(storyId)
	if storyId and storyId ~= 0 and not StoryModel.instance:isStoryHasPlayed(storyId) then
		return true
	end

	return false
end

function AiZiLaGameController:playStory(storyId, callback, callbackObj)
	self:_playStory(storyId)
end

function AiZiLaGameController:_playStory(storyId, callback, callbackObj)
	local param = {}

	param.blur = true
	param.hideStartAndEndDark = true
	param.mark = true
	param.isReplay = false

	StoryController.instance:playStory(storyId, param, callback, callbackObj)
end

function AiZiLaGameController:_afterPlayEnterStory()
	self._enterStoryFinish = true

	self:dispatchEvent(AiZiLaEvent.GameStoryPlayFinish)
	self:_checkEnterGame()
end

function AiZiLaGameController:_onEnterGameRequest(cmd, resultCode, msg)
	if resultCode == 0 then
		self._enterRpcFinish = true

		AiZiLaGameModel.instance:updateEpisode(msg.act144Episode)
		self:_checkEnterGame()
	end
end

function AiZiLaGameController:_checkEnterGame()
	if self._enterRpcFinish and self._enterStoryFinish then
		self:_startGame()
		ViewMgr.instance:openView(ViewName.AiZiLaGameOpenEffectView, {
			callback = self._afterOpenEffect,
			callbackObj = self
		})
	end
end

function AiZiLaGameController:_afterOpenEffect()
	ViewMgr.instance:openView(ViewName.AiZiLaGameView)
	ViewMgr.instance:closeView(ViewName.AiZiLaEpsiodeDetailView)
	ViewMgr.instance:closeView(ViewName.AiZiLaTaskView)
end

function AiZiLaGameController:gameResult()
	self:_delayGameResult(0.05)
end

function AiZiLaGameController:_delayGameResult(delay)
	TaskDispatcher.cancelTask(self._onGameResult, self)
	TaskDispatcher.runDelay(self._onGameResult, self, delay)
end

function AiZiLaGameController:_onGameResult()
	if self._storyClearPlayIng then
		return
	end

	if self._isWaitingEventResult then
		self._isWaitingGameResult = true

		return
	end

	self._isWaitingGameResult = false

	ViewMgr.instance:openView(ViewName.AiZiLaGameResultView)
	self:_endGame()
end

function AiZiLaGameController:gameResultOver()
	if ViewMgr.instance:isOpenFinish(ViewName.AiZiLaGameResultView) then
		local actId = AiZiLaGameModel.instance:getActivityID()
		local episodeId = AiZiLaGameModel.instance:getEpisodeId()
		local episodeCfg = AiZiLaConfig.instance:getEpisodeCo(actId, episodeId)

		self._storyClearPlayIng = false

		if self:_checkCanPlayStory(episodeCfg.storyClear) and AiZiLaGameModel.instance:isPass() then
			self._storyClearPlayIng = true

			self._playStory(self, episodeCfg.storyClear, self._afterPlayStoryClear, self)
			ViewMgr.instance:closeView(ViewName.AiZiLaGameResultView)
		else
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.ExitGame)
		end
	end
end

function AiZiLaGameController:_startGame()
	if self._statGameTime then
		return
	end

	self._statGameTime = ServerTime.now()
end

function AiZiLaGameController:_endGame()
	if not self._statGameTime then
		return
	end

	local useTime = ServerTime.now() - self._statGameTime
	local episodeMO = AiZiLaGameModel.instance:getEpisodeMO()

	if not episodeMO then
		return
	end

	local episodeCfg = episodeMO:getConfig()
	local isSafe = AiZiLaGameModel.instance:getIsSafe()
	local rewardMOList = {}

	if AiZiLaGameModel.instance:getIsFirstPass() and episodeCfg then
		AiZiLaHelper.getItemMOListByBonusStr(episodeCfg.bonus, rewardMOList)
	end

	tabletool.addValues(rewardMOList, AiZiLaGameModel.instance:getResultItemList())

	local rewardList = {}

	for i, rewardMO in ipairs(rewardMOList) do
		local itemCfg = rewardMO:getConfig()

		if itemCfg then
			table.insert(rewardList, {
				materialtype = 1,
				materialname = itemCfg.name,
				materialnum = rewardMO:getQuantity()
			})
		end
	end

	local equipList = {}
	local equipMOList = AiZiLaModel.instance:getEquipMOList()

	for i, equipMO in ipairs(equipMOList) do
		local equipCfg = equipMO:getConfig()

		if equipCfg then
			table.insert(equipList, {
				Ezra_equipname = equipCfg.name,
				Ezra_equip_level = equipCfg.level
			})
		end
	end

	self._statGameTime = nil

	StatController.instance:track(StatEnum.EventName.ExitEzraActivity, {
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.EpisodeId] = string.format("%s", episodeMO.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = episodeMO.enterTimes,
		[StatEnum.EventProperties.RoundNum] = episodeMO.round,
		[StatEnum.EventProperties.RemainingMobility] = episodeMO.actionPoint,
		[StatEnum.EventProperties.CurrentAltitude] = episodeMO.altitude,
		[StatEnum.EventProperties.Result] = isSafe and "安全撤离" or "紧急撤离",
		[StatEnum.EventProperties.EquipInformation] = equipList,
		[StatEnum.EventProperties.Reward] = rewardList
	})
end

function AiZiLaGameController:_afterPlayStoryClear()
	self._storyClearPlayIng = false

	self:dispatchEvent(AiZiLaEvent.GameStoryPlayFinish)
	AiZiLaController.instance:dispatchEvent(AiZiLaEvent.ExitGame)
end

AiZiLaGameController.GAME_FORWARD_GAME_BLOCK_KEY = "AiZiLaGameController.GAME_FORWARD_GAME_BLOCK_KEY"

function AiZiLaGameController:forwardGame()
	AiZiLaHelper.startBlock(AiZiLaGameController.GAME_FORWARD_GAME_BLOCK_KEY)

	local actId = AiZiLaGameModel.instance:getActivityID()

	Activity144Rpc.instance:sendAct144NextDayRequest(actId, self._onForwardGameRequest, self)
end

function AiZiLaGameController:_onForwardGameRequest(cmd, resultCode, msg)
	if resultCode == 0 then
		AiZiLaGameModel.instance:updateEpisode(msg.act144Episode)
		ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
		self:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
	end

	AiZiLaHelper.endBlock(AiZiLaGameController.GAME_FORWARD_GAME_BLOCK_KEY)
end

AiZiLaGameController.GAME_SELECT_OPTION_BLOCK_KEY = "AiZiLaGameController.GAME_SELECT_OPTION_BLOCK_KEY"

function AiZiLaGameController:selectOption(option)
	AiZiLaHelper.startBlock(AiZiLaGameController.GAME_SELECT_OPTION_BLOCK_KEY)

	local actId = AiZiLaGameModel.instance:getActivityID()

	self._isWaitingEventResult = true

	Activity144Rpc.instance:sendAct144SelectOptionRequest(actId, option, self._onSelectOptionRequest, self)
end

function AiZiLaGameController:_onSelectOptionRequest(cmd, resultCode, msg)
	if resultCode == 0 then
		local act144Episode = msg.act144Episode
		local viewParams = {
			eventId = act144Episode.eventId,
			actId = msg.activityId,
			optionId = act144Episode.option,
			optionResultId = act144Episode.optionResultId,
			itemMOList = {}
		}

		self._eventResultViewParams = viewParams

		local tAiZiLaGameModel = AiZiLaGameModel.instance

		if act144Episode then
			if not act144Episode.tempAct144Items then
				local tempAct144Items = {}

				tAiZiLaGameModel:updateEpisode(act144Episode)
				tAiZiLaGameModel:setAct144Items(tempAct144Items)

				local optionResultCfg = AiZiLaConfig.instance:getOptionResultCo(msg.activityId, act144Episode.optionResultId)

				if optionResultCfg and not string.nilorempty(optionResultCfg.bonus) then
					AiZiLaHelper.getItemMOListByBonusStr(optionResultCfg.bonus, viewParams.itemMOList)
				end

				AiZiLaHelper.playViewAnimator(ViewName.AiZiLaGameEventView, UIAnimationName.Switch)
				TaskDispatcher.runDelay(self._onOpenGameEventResult, self, AiZiLaEnum.AnimatorTime.GameEventViewClose)
				self:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
			end
		end
	else
		self._eventResultViewParams = nil
		self._isWaitingEventResult = false

		TaskDispatcher.cancelTask(self._onOpenGameEventResult, self)
		AiZiLaHelper.endBlock(AiZiLaGameController.GAME_SELECT_OPTION_BLOCK_KEY)
	end
end

function AiZiLaGameController:_onOpenGameEventResult()
	AiZiLaHelper.endBlock(AiZiLaGameController.GAME_SELECT_OPTION_BLOCK_KEY)

	self._isWaitingEventResult = false

	if self._eventResultViewParams then
		local viewParams = self._eventResultViewParams

		self._eventResultViewParams = nil

		ViewMgr.instance:openView(ViewName.AiZiLaGameEventResult, viewParams)
		ViewMgr.instance:closeView(ViewName.AiZiLaGameEventView, true)
	end
end

function AiZiLaGameController:settleEpisode()
	Activity144Rpc.instance:sendAct144SettleEpisodeRequest(VersionActivity1_5Enum.ActivityId.AiZiLa)
end

function AiZiLaGameController:leaveEventResult()
	if self._isWaitingGameResult then
		local viewContainer = ViewMgr.instance:getContainer(ViewName.AiZiLaGameView)

		if viewContainer and viewContainer:needPlayRiseAnim() then
			self:_delayGameResult(AiZiLaEnum.AnimatorTime.MapViewRise)
		else
			self:gameResult()
		end
	end

	ViewMgr.instance:closeView(ViewName.AiZiLaGameEventResult)
end

AiZiLaGameController.instance = AiZiLaGameController.New()

return AiZiLaGameController
