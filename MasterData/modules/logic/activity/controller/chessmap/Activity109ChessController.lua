-- chunkname: @modules/logic/activity/controller/chessmap/Activity109ChessController.lua

module("modules.logic.activity.controller.chessmap.Activity109ChessController", package.seeall)

local Activity109ChessController = class("Activity109ChessController", BaseController)

function Activity109ChessController:onInit()
	self._activityId = nil
	self._chessMapId = nil
	self._statViewTime = nil
end

function Activity109ChessController:reInit()
	self._statViewTime = nil
end

function Activity109ChessController:openEntry(actId)
	Activity109ChessModel.instance:setActId(actId)
	Activity109Rpc.instance:sendGetAct109InfoRequest(actId, self.onReceiveInfoOpenView, self)
end

function Activity109ChessController:onReceiveInfoOpenView(cmd, resultCode)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.Activity109ChessEntry)
	end
end

function Activity109ChessController:initMapData(actId, mapData)
	if mapData and mapData.id ~= 0 then
		Activity109ChessModel.instance:setEpisodeId(mapData.id)
		ActivityChessGameController.instance:initServerMap(actId, mapData)
	else
		Activity109ChessModel.instance:setEpisodeId(nil)
		ActivityChessGameModel.instance:setRound(nil)
		ActivityChessGameModel.instance:setResult(nil)
		ActivityChessGameModel.instance:updateFinishInteracts(nil)
		ActivityChessGameController.instance:release()
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameMapDataUpdate)
end

function Activity109ChessController:startNewEpisode(episodeId, callback, callbackObj)
	local actId = Activity109ChessModel.instance:getActId()

	self._startEpisodeCallback = callback
	self._startEpisodeCallbackObj = callbackObj

	Activity109Rpc.instance:sendAct109StartEpisodeRequest(actId, episodeId, self.handleReceiveStartEpisode, self)
end

function Activity109ChessController:startEpisode(episodeId)
	if self:checkCanStartEpisode(episodeId) then
		Activity109ChessController.instance:startNewEpisode(episodeId)

		return true
	end

	return false
end

function Activity109ChessController:checkCanStartEpisode(episodeId)
	local episode_data = Activity109Model.instance:getEpisodeData(episodeId)

	if not episode_data then
		GameFacade.showToast(ToastEnum.Chess1)

		return false
	end

	return true
end

function Activity109ChessController:handleReceiveStartEpisode(cmd, resultCode)
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

function Activity109ChessController:openGameView(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	local actId = Activity109ChessModel.instance:getActId()
	local mapId = Activity109ChessModel.instance:getMapId()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		local episodeCfg = Activity109Config.instance:getEpisodeCo(actId, episodeId)

		if episodeCfg and episodeCfg.storyBefore == 0 then
			Activity109ChessController.onOpenGameStoryPlayOver()

			return
		end

		local story = episodeCfg.storyBefore

		if not StoryModel.instance:isStoryHasPlayed(story) then
			StoryController.instance:playStories({
				story
			}, nil, Activity109ChessController.onOpenGameStoryPlayOver)
		else
			Activity109ChessController.onOpenGameStoryPlayOver()
		end
	end
end

function Activity109ChessController.onOpenGameStoryPlayOver()
	local actId = Activity109ChessModel.instance:getActId()
	local mapId = Activity109ChessModel.instance:getMapId()

	if ActivityChessGameController.instance:existGame() and mapId then
		ActivityChessGameController.instance:enterChessGame(actId, mapId)
	end
end

function Activity109ChessController:openGameAfterFight(refuseBattle)
	local reconnectFightReason = FightModel.instance:getFightReason()

	if reconnectFightReason and reconnectFightReason.fromChessGame then
		Activity109ChessModel.instance:setActId(reconnectFightReason.actId)
		Activity109ChessModel.instance:setEpisodeId(reconnectFightReason.actEpisodeId)
	end

	local actId = Activity109ChessModel.instance:getActId()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	self._isRefuseBattle = nil

	if actId and episodeId then
		self._isRefuseBattle = refuseBattle

		Activity109Rpc.instance:sendGetAct109InfoRequest(actId, self.onReceiveInfoAfterFight, self)
	end
end

function Activity109ChessController:onReceiveInfoAfterFight(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	local actId = Activity109ChessModel.instance:getActId()
	local episodeId = Activity109ChessModel.instance:getEpisodeId()
	local mapId = Activity109ChessModel.instance:getMapId()

	ViewMgr.instance:openView(ViewName.Activity109ChessEntry, episodeId)

	if episodeId and mapId then
		ActivityChessGameController.instance:enterChessGame(actId, mapId)
	else
		logNormal("no map return entry")
	end

	self._isRefuseBattle = nil
end

function Activity109ChessController:getFromRefuseBattle()
	return self._isRefuseBattle
end

function Activity109ChessController:getFightSourceEpisode()
	local actId, episodeId = Activity109ChessModel.instance:getActId(), Activity109ChessModel.instance:getEpisodeId()

	if actId and episodeId then
		return actId, episodeId
	else
		local reason = FightModel.instance:getFightReason()

		if reason ~= nil then
			return reason.actId, reason.actEpisodeId
		end
	end
end

function Activity109ChessController:enterActivityFight(battleId)
	local episodeId = ActivityChessEnum.EpisodeId
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, battleId)
end

function Activity109ChessController:statStart()
	if self._statViewTime then
		return
	end

	local mapId = ActivityChessGameModel.instance:getMapId()

	if not mapId then
		return
	end

	self._statViewRound = ActivityChessGameModel.instance:getRound()
	self._statViewTime = ServerTime.now()
end

function Activity109ChessController:statEnd(result)
	if not self._statViewTime then
		return
	end

	local useTime = ServerTime.now() - self._statViewTime
	local mapId = ActivityChessGameModel.instance:getMapId()

	if not mapId then
		return
	end

	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	if not episodeId then
		return
	end

	local roundNum = ActivityChessGameModel.instance:getRound()
	local incrementRoundNum = math.max(0, roundNum - self._statViewRound)
	local goalNum = ActivityChessGameModel.instance:getFinishGoalNum()
	local episodeData = Activity109Model.instance:getEpisodeData(episodeId)
	local challengesNum = episodeData.totalCount

	self._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitPicklesActivity, {
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.MapId] = tostring(mapId),
		[StatEnum.EventProperties.ChallengesNum] = challengesNum,
		[StatEnum.EventProperties.RoundNum] = roundNum,
		[StatEnum.EventProperties.IncrementRoundNum] = incrementRoundNum,
		[StatEnum.EventProperties.GoalNum] = goalNum,
		[StatEnum.EventProperties.Result] = result
	})
end

Activity109ChessController.instance = Activity109ChessController.New()

LuaEventSystem.addEventMechanism(Activity109ChessController.instance)

return Activity109ChessController
