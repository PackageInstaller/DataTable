-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/XugoujiController.lua

module("modules.logic.versionactivity2_6.xugouji.controller.XugoujiController", package.seeall)

local XugoujiController = class("XugoujiController", BaseController)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji

function XugoujiController:onInit()
	local isDebugMode = PlayerPrefsHelper.getNumber("XugoujiDebugMode", 0)

	self._debugMode = isDebugMode == 1
end

function XugoujiController:reInit()
	return
end

function XugoujiController:addConstEvents()
	return
end

function XugoujiController:_setGuideMode(isGuide)
	Activity188Model.instance:setGameGuideMode(isGuide)
end

function XugoujiController:openXugoujiLevelView()
	self.registerCallback(self, XugoujiEvent.SetGameGuideMode, self._setGuideMode, self)

	local activityMo = ActivityModel.instance:getActMO(actId)

	if activityMo then
		::label_5_0::

		local var_5_0 = activityMo.config

		if activityMo.config then
			local firstStoryId = activityMo.config.storyId
			local toPlayStory = self:_checkCanPlayStory(firstStoryId)

			if toPlayStory then
				StoryController.instance:playStory(firstStoryId, nil, self._requestActInfo, self)
			else
				self:_requestActInfo()
			end
		end
	end
end

function XugoujiController:_requestActInfo()
	Activity188Rpc.instance:sendGet188InfosRequest(VersionActivity2_6Enum.ActivityId.Xugouji, self._onReceivedActInfo, self)
end

function XugoujiController:_onReceivedActInfo()
	ViewMgr.instance:openView(ViewName.XugoujiLevelView)
end

function XugoujiController:openXugoujiGameView()
	ViewMgr.instance:openView(ViewName.XugoujiGameView)
end

function XugoujiController:openTaskView()
	ViewMgr.instance:openView(ViewName.XugoujiTaskView)
end

function XugoujiController:openCardInfoView(cardId)
	cardId = cardId or Activity188Model.instance:getLastCardId()
	self._lastCardInfoUId = cardId

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardInfo)
	ViewMgr.instance:openView(ViewName.XugoujiCardInfoView, {
		cardId = cardId
	})
end

function XugoujiController:openGameResultView(resultParams)
	if self._isWaitingEventResult then
		self._isWaitingGameResult = true

		return
	end

	self._isWaitingGameResult = false

	self:dispatchEvent(XugoujiEvent.OnOpenGameResultView)
	ViewMgr.instance:openView(ViewName.XugoujiGameResultView, resultParams)

	local act188StatMo = self:getStatMo()
	local completed = resultParams.reason == XugoujiEnum.ResultEnum.Completed
	local result = completed and 1 or 0
	local roundNum = Activity188Model.instance:getRound()
	local playerHp = Activity188Model.instance:getCurHP()
	local enemyHp = Activity188Model.instance:getEnemyHP()
	local playerPair = Activity188Model.instance:getCurPairCount()
	local enemyPair = Activity188Model.instance:getEnemyPairCount()

	act188StatMo:setGameData(result, roundNum, playerHp, enemyHp, playerPair, enemyPair)
	act188StatMo:sendGameFinishStatData()
end

function XugoujiController:enterEpisode(episodeId)
	Activity188Model.instance:setCurActId(VersionActivity2_6Enum.ActivityId.Xugouji)

	self._curEnterEpisode = episodeId

	Activity188Rpc.instance:sendAct188EnterEpisodeRequest(VersionActivity2_6Enum.ActivityId.Xugouji, episodeId, self._onEnterGameReply, self)
	Activity188Rpc.instance:SetEpisodePushCallback(self._onEpisodeUpdate, self)
end

function XugoujiController:_onEnterGameReply()
	local episodeCfg = Activity188Config.instance:getEpisodeCfg(actId, self._curEnterEpisode)
	local curGameId = episodeCfg.gameId
	local gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	local act188StatMo = self:getStatMo()

	act188StatMo:reset()
	act188StatMo:setBaseData(actId, self._curEnterEpisode)

	if gameCfg then
		self._lastCardInfoUId = -1

		XugoujiGameStepController.instance:clear()
		act188StatMo:setBaseData(actId, self._curEnterEpisode, gameCfg.id)
	end

	Activity188Model.instance:setCurEpisodeId(self._curEnterEpisode)
	self:dispatchEvent(XugoujiEvent.EnterEpisode, self._curEnterEpisode)
end

function XugoujiController:restartEpisode()
	Activity188Rpc.instance:sendAct188EnterEpisodeRequest(VersionActivity2_6Enum.ActivityId.Xugouji, self._curEnterEpisode, self._onRestartGameReply, self)
	Activity188Rpc.instance:SetEpisodePushCallback(self._onEpisodeUpdate, self)
end

function XugoujiController:_onRestartGameReply()
	local curGameId = Activity188Model.instance:getCurGameId()
	local gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)

	Activity188Model.instance:setCurEpisodeId(self._curEnterEpisode)
	XugoujiGameStepController.instance:clear()

	local act188StatMo = self:getStatMo()

	act188StatMo:reset()
	act188StatMo:setBaseData(actId, self._curEnterEpisode, gameCfg.id)
	XugoujiGameStepController.instance:insertStepListClient({
		{
			stepType = XugoujiEnum.GameStepType.GameReStart
		},
		{
			stepType = XugoujiEnum.GameStepType.UpdateInitialCard
		}
	})
	self:dispatchEvent(XugoujiEvent.GameRestart)
end

function XugoujiController:finishStoryPlay()
	local curEpisode = Activity188Model.instance:getCurEpisodeId()

	Activity188Rpc.instance:sendAct188StoryRequest(VersionActivity2_6Enum.ActivityId.Xugouji, curEpisode, self._onEpisodeUpdate, self)

	local act188StatMo = XugoujiController.instance:getStatMo()

	act188StatMo:sendDungeonFinishStatData()
end

function XugoujiController:selectCardItem(cardUId)
	local operateTime = Activity188Model.instance:getCurTurnOperateTime()

	if operateTime == 0 then
		return
	end

	if Activity188Model.instance:isHpZero() then
		return
	end

	if cardUId == Activity188Model.instance:getCurCardUid() then
		return
	end

	Activity188Model.instance:setCurTurnOperateTime(operateTime - 1, false)
	self:dispatchEvent(XugoujiEvent.OperateTimeUpdated)
	Activity188Model.instance:setCurCardUid(cardUId)
	Activity188Rpc.instance:sendAct188ReverseCardRequest(actId, self._curEnterEpisode, cardUId, self._onOperateCardReply, self)
end

function XugoujiController:_onOperateCardReply(resultCode, msg)
	local cardUId = Activity188Model.instance:getCurCardUid()

	self:dispatchEvent(XugoujiEvent.OperateCard, cardUId)
end

function XugoujiController:manualExitGame()
	XugoujiGameStepController.instance:disposeAllStep()
	self:dispatchEvent(XugoujiEvent.ManualExitGame)
end

function XugoujiController:sendExitGameStat()
	local act188StatMo = self:getStatMo()
	local roundNum = Activity188Model.instance:getRound()
	local playerHp = Activity188Model.instance:getCurHP()
	local enemyHp = Activity188Model.instance:getEnemyHP()
	local playerPair = Activity188Model.instance:getCurPairCount()
	local enemyPair = Activity188Model.instance:getEnemyPairCount()

	act188StatMo:setGameData(nil, roundNum, playerHp, enemyHp, playerPair, enemyPair)
	act188StatMo:sendGameGiveUpStatData()
	act188StatMo:sendDungeonFinishStatData()
end

function XugoujiController:gameResultOver()
	self:dispatchEvent(XugoujiEvent.ExitGame)
end

function XugoujiController:_onEpisodeUpdate()
	self:dispatchEvent(XugoujiEvent.EpisodeUpdate)
end

function XugoujiController:_checkCanPlayStory(storyId)
	if storyId and storyId ~= 0 and not StoryModel.instance:isStoryHasPlayed(storyId) then
		return true
	end

	return false
end

function XugoujiController:checkOptionChoosed(optionId)
	if not self._optionDescRecord then
		self._optionDescRecord = {}
		self._optionDescRecordStr = ""
		self._optionDescRecordStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, "")

		local optionIds = string.splitToNumber(self._optionDescRecordStr, ",")

		for _, id in pairs(optionIds) do
			self._optionDescRecord[id] = true
		end
	end

	return self._optionDescRecord[optionId]
end

function XugoujiController:saveOptionChoosed(optionId)
	self._optionDescRecord[optionId] = true
	self._optionDescRecordStr = string.nilorempty(self._optionDescRecordStr) and optionId or self._optionDescRecordStr .. "," .. optionId

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, self._optionDescRecordStr)
end

function XugoujiController:getStatMo()
	self.statMo = self.statMo or Activity188StatMo.New()

	return self.statMo
end

function XugoujiController:setDebugMode(isDebug)
	self._debugMode = isDebug
end

function XugoujiController:isDebugMode()
	return self._debugMode
end

XugoujiController.instance = XugoujiController.New()

return XugoujiController
