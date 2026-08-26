-- chunkname: @modules/logic/versionactivity1_3/va3chess/controller/Va3ChessController.lua

module("modules.logic.versionactivity1_3.va3chess.controller.Va3ChessController", package.seeall)

local Va3ChessController = class("Va3ChessController", BaseController)

function Va3ChessController:onInit()
	self._activityId = nil
	self._chessMapId = nil
	self._statViewTime = nil
end

function Va3ChessController:reInit()
	self._statViewTime = nil
end

function Va3ChessController:initMapData(actId, mapData)
	if mapData and mapData.id ~= 0 then
		Va3ChessModel.instance:setActId(actId)
		Va3ChessModel.instance:setEpisodeId(mapData.id)
		Va3ChessGameController.instance:initServerMap(actId, mapData)
	else
		Va3ChessModel.instance:setActId(nil)
		Va3ChessModel.instance:setEpisodeId(nil)
		Va3ChessGameModel.instance:setRound(nil)
		Va3ChessGameModel.instance:setResult(nil)
		Va3ChessGameModel.instance:setFireBallCount(nil)
		Va3ChessGameModel.instance:updateFinishInteracts(nil)
		Va3ChessGameController.instance:release()
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameMapDataUpdate)
end

function Va3ChessController:startNewEpisode(episodeId, callback, callbackObj, viewName, storyEpisodeEndCb, storyEpisodeEndCbObj)
	self._startEpisodeCallback = callback
	self._startEpisodeCallbackObj = callbackObj

	local actId = Va3ChessModel.instance:getActId()
	local isStoryEpisode = Va3ChessConfig.instance:isStoryEpisode(actId, episodeId)

	if isStoryEpisode then
		self:storyEpisodePlayStory(actId, episodeId, storyEpisodeEndCb, storyEpisodeEndCbObj)
	else
		Va3ChessGameController.instance:setViewName(viewName)
		Va3ChessRpcController.instance:sendActStartEpisodeRequest(actId, episodeId, self.handleReceiveStartEpisode, self)
	end
end

function Va3ChessController:storyEpisodePlayStory(actId, episodeId, storyEndCb, storyEndCbObj)
	self.tmpPlayStoryFinishCb = storyEndCb
	self.tmpPlayStoryFinishCbObj = storyEndCbObj

	local storyPlayOverParam = {
		actId = actId,
		episodeId = episodeId
	}
	local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)

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

function Va3ChessController:onStoryEpisodePlayOver(storyOverParam)
	if not storyOverParam then
		return
	end

	Va3ChessRpcController.instance:sendActStartEpisodeRequest(storyOverParam.actId, storyOverParam.episodeId, self.onSendPlayOverCb, self)
end

function Va3ChessController:onSendPlayOverCb(cmd, resultCode, msg)
	self:reGetActInfo(self.tmpPlayStoryFinishCb, self.tmpPlayStoryFinishCbObj)

	self.tmpPlayStoryFinishCb = nil
	self.tmpPlayStoryFinishCbObj = nil
end

function Va3ChessController:reGetActInfo(cb, cbObj)
	local actId = Va3ChessModel.instance:getActId()

	Va3ChessRpcController.instance:sendGetActInfoRequest(actId, cb, cbObj)
end

function Va3ChessController:startResetEpisode(episodeId, callback, callbackObj, viewName)
	local actId = Va3ChessModel.instance:getActId()

	self._startEpisodeCallback = callback
	self._startEpisodeCallbackObj = callbackObj

	Va3ChessGameController.instance:setViewName(viewName)
	Va3ChessRpcController.instance:sendActStartEpisodeRequest(actId, episodeId, self.handleReceiveResetEpisode, self)
end

function Va3ChessController:handleReceiveStartEpisode(cmd, resultCode)
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

function Va3ChessController:handleReceiveResetEpisode(cmd, resultCode)
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

function Va3ChessController:openGameView(cmd, resultCode, reset)
	if resultCode ~= 0 then
		return
	end

	local actId = Va3ChessModel.instance:getActId()
	local mapId = Va3ChessModel.instance:getMapId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)

		if episodeCfg and episodeCfg.storyBefore == 0 then
			Va3ChessController.onOpenGameStoryPlayOver()

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
			}, param, Va3ChessController.onOpenGameStoryPlayOver)
		else
			Va3ChessController.onOpenGameStoryPlayOver()
		end
	end
end

function Va3ChessController.onOpenGameStoryPlayOver()
	local actId = Va3ChessModel.instance:getActId()
	local mapId = Va3ChessModel.instance:getMapId()

	if Va3ChessGameController.instance:existGame() and mapId then
		Va3ChessGameController.instance:enterChessGame(actId, mapId, Va3ChessGameController.instance:getViewName())
	end
end

function Va3ChessController:openGameAfterFight(refuseBattle)
	local reconnectFightReason = FightModel.instance:getFightReason()

	if reconnectFightReason and reconnectFightReason.fromChessGame then
		Va3ChessModel.instance:setActId(reconnectFightReason.actId)
		Va3ChessModel.instance:setEpisodeId(reconnectFightReason.actEpisodeId)
	end

	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	self._isRefuseBattle = nil

	if actId and episodeId then
		self._isRefuseBattle = refuseBattle

		Va3ChessRpcController.instance:sendGetActInfoRequest(actId, self.onReceiveInfoAfterFight, self)
	end
end

function Va3ChessController:onReceiveInfoAfterFight(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()
	local mapId = Va3ChessModel.instance:getMapId()

	if episodeId and mapId then
		Va3ChessGameController.instance:enterChessGame(actId, mapId, Va3ChessGameController.instance:getViewName())

		if actId == VersionActivity1_3Enum.ActivityId.Act306 and msg.map.brokenTilebases then
			Va3ChessGameModel.instance:updateBrokenTilebases(actId, msg.map.brokenTilebases)
		end
	else
		logNormal("no map return entry")
	end

	self._isRefuseBattle = nil
end

function Va3ChessController:getFromRefuseBattle()
	return self._isRefuseBattle
end

function Va3ChessController:getFightSourceEpisode()
	local actId, episodeId = Va3ChessModel.instance:getActId(), Va3ChessModel.instance:getEpisodeId()

	if actId and episodeId then
		return actId, episodeId
	else
		local reason = FightModel.instance:getFightReason()

		if reason ~= nil then
			return reason.actId, reason.actEpisodeId
		end
	end
end

function Va3ChessController:enterActivityFight(battleId)
	local actId = Va3ChessModel.instance:getActId()
	local chapterId, episodeId = Va3ChessConfig.instance:getChapterEpisodeId(actId)

	chapterId = chapterId or DungeonConfig.instance:getEpisodeCO(battleId).chapterId

	if chapterId and episodeId then
		DungeonFightController.instance:enterFightByBattleId(chapterId, episodeId, battleId)
	end
end

Va3ChessController.instance = Va3ChessController.New()

return Va3ChessController
