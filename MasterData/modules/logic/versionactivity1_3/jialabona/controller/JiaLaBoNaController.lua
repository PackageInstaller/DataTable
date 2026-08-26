-- chunkname: @modules/logic/versionactivity1_3/jialabona/controller/JiaLaBoNaController.lua

module("modules.logic.versionactivity1_3.jialabona.controller.JiaLaBoNaController", package.seeall)

local JiaLaBoNaController = class("JiaLaBoNaController", BaseController)

function JiaLaBoNaController:onInit()
	self:reInit()
end

function JiaLaBoNaController:onInitFinish()
	return
end

function JiaLaBoNaController:addConstEvents()
	return
end

function JiaLaBoNaController:reInit()
	self._waitActId = nil
	self._waitEpisodeId = nil
end

function JiaLaBoNaController:delayReward(delayTime, taskMO)
	if self._act120TaskMO == nil and taskMO then
		self._act120TaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function JiaLaBoNaController:_onPreFinish()
	local act120TaskMO = self._act120TaskMO

	self._act120TaskMO = nil

	if act120TaskMO and (act120TaskMO.id == JiaLaBoNaEnum.TaskMOAllFinishId or act120TaskMO:alreadyGotReward()) then
		Activity120TaskListModel.instance:preFinish(act120TaskMO)

		self._act120TaskId = act120TaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, JiaLaBoNaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function JiaLaBoNaController:_onRewardTask()
	local act120TaskId = self._act120TaskId

	self._act120TaskId = nil

	if act120TaskId then
		if act120TaskId == JiaLaBoNaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity120)
		else
			TaskRpc.instance:sendFinishTaskRequest(act120TaskId)
		end
	end
end

function JiaLaBoNaController:oneClaimReward(actId)
	local list = Activity120TaskListModel.instance:getList()

	for _, act120TaskMO in pairs(list) do
		if act120TaskMO:alreadyGotReward() and act120TaskMO.id ~= JiaLaBoNaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(act120TaskMO.id)
		end
	end
end

function JiaLaBoNaController:openMapView(episodeId, rpcCallback, cbObj, cbparam)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity120
	}, function()
		Activity120Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act306)
		Activity120Model.instance:setCurEpisodeId(episodeId)
		ViewMgr.instance:openView(ViewName.JiaLaBoNaMapView, {
			episodeId = episodeId
		})

		if rpcCallback then
			rpcCallback(cbObj, cbparam)
		end
	end)
end

function JiaLaBoNaController:openStoryView(episodeId)
	if Activity120Model.instance:isEpisodeClear(episodeId) then
		ViewMgr.instance:openView(ViewName.JiaLaBoNaStoryView, {
			actId = VersionActivity1_3Enum.ActivityId.Act306,
			episodeId = episodeId
		})
	end
end

function JiaLaBoNaController:isEnterBforeClear()
	return self._isBeforeClear
end

JiaLaBoNaController.ENTER_CHESS_GAME_BLOCK_KEY = "JiaLaBoNaController.ENTER_CHESS_GAME_BLOCK_KEY"

function JiaLaBoNaController:enterChessGame(actId, episodeId, delay)
	UIBlockMgr.instance:startBlock(JiaLaBoNaController.ENTER_CHESS_GAME_BLOCK_KEY)

	self._waitActId = actId
	self._waitEpisodeId = episodeId
	self._isBeforeClear = Activity120Model.instance:isEpisodeClear(episodeId)

	Activity120Model.instance:setCurEpisodeId(episodeId)
	TaskDispatcher.cancelTask(self._onEnterChessGame, self, delay)
	TaskDispatcher.runDelay(self._onEnterChessGame, self, delay or 0.1)
end

function JiaLaBoNaController:_onEnterChessGame()
	UIBlockMgr.instance:endBlock(JiaLaBoNaController.ENTER_CHESS_GAME_BLOCK_KEY)

	if self._waitActId and self._waitEpisodeId then
		Activity120Rpc.instance:sendActStartEpisodeRequest(self._waitActId, self._waitEpisodeId, self._onOpenGame, self)
	end
end

function JiaLaBoNaController:resetStartGame()
	local episodeId = Va3ChessModel.instance:getEpisodeId()
	local actId = Va3ChessModel.instance:getActId()

	if actId and episodeId then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		Activity120Rpc.instance:sendActStartEpisodeRequest(actId, episodeId, self._onRestartCallback, self)
	end
end

JiaLaBoNaController.RETURN_POINT_GAME_BLOCK_KEY = "JiaLaBoNaController.RETURN_POINT_GAME_BLOCK_KEY"

function JiaLaBoNaController:returnPointGame(isLastCheckPoint)
	UIBlockMgr.instance:startBlock(JiaLaBoNaController.RETURN_POINT_GAME_BLOCK_KEY)

	self._isLastCheckPoint = isLastCheckPoint

	local actId = Va3ChessModel.instance:getActId()

	if actId then
		Activity120Rpc.instance:sendActCheckPointRequest(actId, isLastCheckPoint, self._onReurnPiontGame, self)
	end
end

function JiaLaBoNaController:_onRestartCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		Va3ChessController.onOpenGameStoryPlayOver()
		Stat1_3Controller.instance:jiaLaBoNaStatStart()
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameReset)
	else
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	end
end

function JiaLaBoNaController:_onReurnPiontGame(cmd, resultCode, msg)
	UIBlockMgr.instance:endBlock(JiaLaBoNaController.RETURN_POINT_GAME_BLOCK_KEY)

	if resultCode ~= 0 then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	elseif self._isLastCheckPoint then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(self._eventReurnPiontGame, self, JiaLaBoNaEnum.AnimatorTime.SwithSceneOpen)
		ViewMgr.instance:closeView(ViewName.JiaLaBoNaGameResultView)
	else
		self:_eventReurnPiontGame()
	end
end

function JiaLaBoNaController:_eventReurnPiontGame()
	JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.GamePointReturn)
end

function JiaLaBoNaController:_onOpenGame(cmd, resultCode, msg)
	if resultCode == 0 then
		Activity120Model.instance:increaseCount(msg.map.id)
		Va3ChessController.instance:initMapData(msg.activityId, msg.map)
		Va3ChessGameController.instance:setViewName(ViewName.JiaLaBoNaGameView)
		Stat1_3Controller.instance:jiaLaBoNaStatStart()
		Va3ChessController.instance:openGameView(cmd, resultCode)
	end
end

JiaLaBoNaController.instance = JiaLaBoNaController.New()

return JiaLaBoNaController
