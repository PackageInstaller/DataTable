-- chunkname: @modules/logic/chessgame/controller/ChessController.lua

module("modules.logic.chessgame.controller.ChessController", package.seeall)

local ChessController = class("ChessController", BaseController)

function ChessController:onInit()
	self._activityId = nil
	self._chessMapId = nil
	self._statViewTime = nil
end

function ChessController:reInit()
	self._statViewTime = nil
end

function ChessController:initMapData(actId, episodeId, map)
	local state = ChessGameModel.instance:getGameState()

	if map.dead and state == ChessGameEnum.GameState.Fail then
		ChessRpcController.instance:sendActRollBackRequest(actId, episodeId, ChessGameEnum.RollBack.CheckPoint)

		return
	end

	if map.win and state == ChessGameEnum.GameState.Win then
		ChessRpcController.instance:sendActReStartEpisodeRequest(actId, episodeId)
		ChessGameModel.instance:setGameState(nil)

		return
	end

	if map and map.episodeId ~= 0 then
		ChessModel.instance:setActId(actId)
		ChessModel.instance:setEpisodeId(map.episodeId)
		ChessGameModel.instance:setGameState(nil)
		ChessGameController.instance:initServerMap(actId, map)
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameMapDataUpdate)
end

function ChessController:startNewEpisode(episodeId, callback, callbackObj, viewName, storyEpisodeEndCb, storyEpisodeEndCbObj)
	self._startEpisodeCallback = callback
	self._startEpisodeCallbackObj = callbackObj

	local actId = ChessModel.instance:getActId()
	local isStoryEpisode = ChessConfig.instance:isStoryEpisode(actId, episodeId)

	if isStoryEpisode then
		self:storyEpisodePlayStory(actId, episodeId, storyEpisodeEndCb, storyEpisodeEndCbObj)
	else
		ChessGameController.instance:setViewName(viewName)
		ChessRpcController.instance:sendActStartEpisodeRequest(actId, episodeId, self.handleReceiveStartEpisode, self)
	end
end

function ChessController:storyEpisodePlayStory(actId, episodeId, storyEndCb, storyEndCbObj)
	self.tmpPlayStoryFinishCb = storyEndCb
	self.tmpPlayStoryFinishCbObj = storyEndCbObj

	local storyPlayOverParam = {
		actId = actId,
		episodeId = episodeId
	}
	local episodeCfg = ChessConfig.instance:getEpisodeCo(actId, episodeId)

	if not episodeCfg then
		self:onStoryEpisodePlayOver(storyPlayOverParam)

		return
	end

	local storyId = episodeCfg.storyBefore
	local isValidStoryId = storyId and storyId ~= 0 or false
	local isCanRepeat = episodeCfg.storyRepeat == 1
	local isStoryHasPlayed = StoryModel.instance:isStoryHasPlayed(storyId)

	if isValidStoryId and (isCanRepeat or not isStoryHasPlayed) then
		local storyParam = {}

		storyParam.blur = true
		storyParam.mark = true
		storyParam.hideStartAndEndDark = true

		StoryController.instance:playStories({
			storyId
		}, storyParam, self.onStoryEpisodePlayOver, self, storyPlayOverParam)
	else
		self:onStoryEpisodePlayOver(storyPlayOverParam)
	end

	if self._startEpisodeCallback then
		self._startEpisodeCallback(self._startEpisodeCallbackObj)
	end

	self._startEpisodeCallback = nil
	self._startEpisodeCallbackObj = nil
end

function ChessController:onStoryEpisodePlayOver(storyOverParam)
	if not storyOverParam then
		return
	end

	ChessRpcController.instance:sendActStartEpisodeRequest(storyOverParam.actId, storyOverParam.episodeId, self.onSendPlayOverCb, self)
end

function ChessController:onSendPlayOverCb(cmd, resultCode, msg)
	self:reGetActInfo(self.tmpPlayStoryFinishCb, self.tmpPlayStoryFinishCbObj)

	self.tmpPlayStoryFinishCb = nil
	self.tmpPlayStoryFinishCbObj = nil
end

function ChessController:reGetActInfo(cb, cbObj)
	local actId = ChessModel.instance:getActId()

	ChessRpcController.instance:sendGetActInfoRequest(actId, cb, cbObj)
end

function ChessController:startResetEpisode(episodeId, callback, callbackObj, viewName)
	local actId = ChessModel.instance:getActId()

	self._startEpisodeCallback = callback
	self._startEpisodeCallbackObj = callbackObj

	ChessGameController.instance:setViewName(viewName)
	ChessRpcController.instance:sendActStartEpisodeRequest(actId, episodeId, self.handleReceiveResetEpisode, self)
end

function ChessController:handleReceiveStartEpisode(cmd, resultCode)
	local callback = self._startEpisodeCallback
	local callbackObj = self._startEpisodeCallbackObj

	self._startEpisodeCallback = nil
	self._startEpisodeCallbackObj = nil

	if resultCode ~= 0 then
		return
	end

	self:openGameView(cmd, resultCode)

	if callback then
		self._startEpisodeCallback(callbackObj)
	end
end

function ChessController:handleReceiveResetEpisode(cmd, resultCode)
	local callback = self._startEpisodeCallback
	local callbackObj = self._startEpisodeCallbackObj

	self._startEpisodeCallback = nil
	self._startEpisodeCallbackObj = nil

	if resultCode ~= 0 then
		return
	end

	self:openGameView(cmd, resultCode, true)

	if callback then
		self._startEpisodeCallback(callbackObj)
	end
end

function ChessController:openGameView(cmd, resultCode, reset)
	if resultCode ~= 0 then
		return
	end

	local actId = ChessModel.instance:getActId()
	local episodeId = ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		local episodeCfg = ChessConfig.instance:getEpisodeCo(actId, episodeId)

		if episodeCfg and episodeCfg.storyBefore == 0 then
			ChessController.onOpenGameStoryPlayOver()

			return
		end

		local story = episodeCfg.storyBefore

		if not reset and (episodeCfg.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(story)) then
			local param = {}

			param.blur = true
			param.mark = true
			param.hideStartAndEndDark = true

			StoryController.instance:playStories({
				story
			}, param, ChessController.onOpenGameStoryPlayOver)
		else
			ChessController.onOpenGameStoryPlayOver()
		end
	end
end

function ChessController.onOpenGameStoryPlayOver()
	local actId = ChessModel.instance:getActId()
	local episodeId = ChessModel.instance:getEpisodeId()
	local episodeCfg = ChessConfig.instance:getEpisodeCo(actId, episodeId)
	local mapGroupId = episodeCfg.mapIds

	if ChessGameController.instance:existGame() and mapGroupId then
		ChessGameController.instance:enterChessGame(actId, mapGroupId, ChessGameController.instance:getViewName())
	end
end

function ChessController:openGameAfterFight(refuseBattle)
	local reconnectFightReason = FightModel.instance:getFightReason()

	if reconnectFightReason and reconnectFightReason.fromChessGame then
		ChessModel.instance:setActId(reconnectFightReason.actId)
		ChessModel.instance:setEpisodeId(reconnectFightReason.actEpisodeId)
	end

	local actId = ChessModel.instance:getActId()
	local episodeId = ChessModel.instance:getEpisodeId()

	self._isRefuseBattle = nil

	if actId and episodeId then
		self._isRefuseBattle = refuseBattle

		ChessRpcController.instance:sendGetActInfoRequest(actId, self.onReceiveInfoAfterFight, self)
	end
end

function ChessController:onReceiveInfoAfterFight(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	local actId = ChessModel.instance:getActId()
	local episodeId = ChessModel.instance:getEpisodeId()
	local mapId = ChessModel.instance:getMapId()

	if episodeId and mapId then
		ChessGameController.instance:enterChessGame(actId, mapId, ChessGameController.instance:getViewName())
	else
		logNormal("no map return entry")
	end

	self._isRefuseBattle = nil
end

function ChessController:getFromRefuseBattle()
	return self._isRefuseBattle
end

function ChessController:getFightSourceEpisode()
	local actId, episodeId = ChessModel.instance:getActId(), ChessModel.instance:getEpisodeId()

	if actId and episodeId then
		return actId, episodeId
	else
		local reason = FightModel.instance:getFightReason()

		if reason ~= nil then
			return reason.actId, reason.actEpisodeId
		end
	end
end

function ChessController:enterActivityFight(battleId)
	local actId = ChessModel.instance:getActId()
	local chapterId, episodeId = ChessConfig.instance:getChapterEpisodeId(actId)

	chapterId = chapterId or DungeonConfig.instance:getEpisodeCO(battleId).chapterId

	if chapterId and episodeId then
		DungeonFightController.instance:enterFightByBattleId(chapterId, episodeId, battleId)
	end
end

ChessController.instance = ChessController.New()

return ChessController
