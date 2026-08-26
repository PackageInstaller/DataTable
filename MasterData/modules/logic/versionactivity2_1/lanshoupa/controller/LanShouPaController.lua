-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/controller/LanShouPaController.lua

module("modules.logic.versionactivity2_1.lanshoupa.controller.LanShouPaController", package.seeall)

local LanShouPaController = class("LanShouPaController", BaseController)

function LanShouPaController:onInit()
	self:reInit()
end

function LanShouPaController:onInitFinish()
	return
end

function LanShouPaController:addConstEvents()
	ChessGameController.instance:registerCallback(ChessGameEvent.OnVictory, self._onVictory, self)
	ChessGameController.instance:registerCallback(ChessGameEvent.OnFail, self._onFail, self)
end

function LanShouPaController:reInit()
	self._waitActId = nil
	self._waitEpisodeId = nil
end

function LanShouPaController:openStoryView(episodeId)
	if Activity164Model.instance:isEpisodeClear(episodeId) then
		ViewMgr.instance:openView(ViewName.LanShouPaStoryView, {
			actId = VersionActivity2_1Enum.ActivityId.LanShouPa,
			episodeId = episodeId
		})
	end
end

LanShouPaController.ENTER_CHESS_GAME_BLOCK_KEY = "LanShouPaController.ENTER_CHESS_GAME_BLOCK_KEY"

function LanShouPaController:enterChessGame(actId, episodeId, delay)
	UIBlockMgr.instance:startBlock(LanShouPaController.ENTER_CHESS_GAME_BLOCK_KEY)

	self._waitActId = actId
	self._waitEpisodeId = episodeId

	Activity164Model.instance:setCurEpisodeId(episodeId)
	TaskDispatcher.cancelTask(self._onEnterChessGame, self, delay)
	TaskDispatcher.runDelay(self._onEnterChessGame, self, delay or 0.1)
end

function LanShouPaController:_onEnterChessGame()
	UIBlockMgr.instance:endBlock(LanShouPaController.ENTER_CHESS_GAME_BLOCK_KEY)

	if self._waitActId and self._waitEpisodeId then
		Activity164Rpc.instance:sendActStartEpisodeRequest(self._waitActId, self._waitEpisodeId, self._onOpenGame, self)
	end
end

function LanShouPaController:resetStartGame()
	local episodeId = ChessModel.instance:getEpisodeId()
	local actId = ChessModel.instance:getActId()

	if actId and episodeId then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
		Activity164Rpc.instance:sendActReStartEpisodeRequest(actId, episodeId, self._onRestartCallback, self)
	end
end

LanShouPaController.RETURN_POINT_GAME_BLOCK_KEY = "LanShouPaController.RETURN_POINT_GAME_BLOCK_KEY"

function LanShouPaController:returnPointGame(rollBackType)
	UIBlockMgr.instance:startBlock(LanShouPaController.RETURN_POINT_GAME_BLOCK_KEY)

	local actId = ChessModel.instance:getActId()

	self._isLastCheckPoint = rollBackType == ChessGameEnum.RollBack.CheckPoint

	local episodeId = ChessModel.instance:getEpisodeId()

	if actId then
		Activity164Rpc.instance:sendActRollBackRequest(actId, episodeId, rollBackType, self._onReurnPiontGame, self)
	end
end

function LanShouPaController:_onRestartCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		ChessController.onOpenGameStoryPlayOver()
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameReset)
	else
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	end
end

function LanShouPaController:_onReurnPiontGame(cmd, resultCode, msg)
	UIBlockMgr.instance:endBlock(LanShouPaController.RETURN_POINT_GAME_BLOCK_KEY)

	if resultCode ~= 0 then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	else
		if msg.dead then
			return
		end

		if self._isLastCheckPoint then
			ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
			TaskDispatcher.runDelay(self._eventReurnPiontGame, self, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
			ViewMgr.instance:closeView(ViewName.LanShouPaGameResultView)
			ChessStatController.instance:startStat()
		else
			self:_eventReurnPiontGame()
		end
	end
end

function LanShouPaController:_eventReurnPiontGame()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GamePointReturn)
end

function LanShouPaController:_onOpenGame(cmd, resultCode, msg)
	if resultCode == 0 then
		if msg.scene and msg.scene.dead then
			local function callback()
				Activity164Rpc.instance:sendActStartEpisodeRequest(msg.activityId, msg.episodeId, self._onOpenGame, self)
			end

			Activity164Rpc.instance:sendActAbortRequest(msg.activityId, msg.episodeId, callback, self)

			return
		end

		ChessController.instance:initMapData(msg.activityId, msg.episodeId, msg.scene)
		ChessGameController.instance:setViewName(ViewName.LanShouPaGameView)
		ChessController.instance:openGameView(cmd, resultCode)
	end
end

function LanShouPaController:openActivity164GameView(param)
	local episodeId = param.episodeId
	local co = Activity164Config.instance:getEpisodeCo(VersionActivity2_1Enum.ActivityId.LanShouPa, episodeId)
	local mapGroupId = co.mapIds

	ChessGameController.instance:enterGame(mapGroupId, ViewName.LanShouPaGameView)
end

function LanShouPaController:openTaskView()
	ViewMgr.instance:openView(ViewName.LanShouPaTaskView)
end

function LanShouPaController:_onVictory()
	ViewMgr.instance:openView(ViewName.LanShouPaGameResultView, true)
end

function LanShouPaController:_onFail()
	ViewMgr.instance:openView(ViewName.LanShouPaGameResultView, false)
end

function LanShouPaController:openLanShouPaMapView(actId, isReqInfo)
	actId = actId or VersionActivity2_1Enum.ActivityId.LanShouPa

	if isReqInfo then
		Activity164Rpc.instance:sendGetActInfoRequest(actId, function(cmd, resultCode, msg)
			if resultCode == 0 then
				ViewMgr.instance:openView(ViewName.LanShouPaMapView)
			end
		end)
	else
		ViewMgr.instance:openView(ViewName.LanShouPaMapView)
	end
end

LanShouPaController.instance = LanShouPaController.New()

LuaEventSystem.addEventMechanism(LanShouPaController.instance)

return LanShouPaController
