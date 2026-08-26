-- chunkname: @modules/logic/versionactivity1_3/chess/controller/Activity1_3ChessController.lua

module("modules.logic.versionactivity1_3.chess.controller.Activity1_3ChessController", package.seeall)

local Activity1_3ChessController = class("Activity1_3ChessController", BaseController)

function Activity1_3ChessController:openMapView(chapterId, callback, cbObj, cbparam)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity122
	})
	Activity122Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act304, function()
		ViewMgr.instance:openView(ViewName.Activity1_3ChessMapView, {
			chapterId = chapterId
		}, true)

		if callback then
			callback(cbObj, cbparam)
		end
	end)
end

function Activity1_3ChessController:openStoryView(episodeId)
	if Activity122Model.instance:isEpisodeClear(episodeId) then
		ViewMgr.instance:openView(ViewName.Activity1_3ChessStoryView, {
			actId = VersionActivity1_3Enum.ActivityId.Act304,
			episodeId = episodeId
		})
	end
end

function Activity1_3ChessController:requestEnterChessGame(episodeId, delayTime)
	Va3ChessGameModel.instance:clearLastMapRound()

	self._isEnterPassedEpisode = Activity122Model.instance:isEpisodeClear(episodeId)

	Va3ChessModel.instance:setActId(VersionActivity1_3Enum.ActivityId.Act304)
	Activity122Model.instance:setCurEpisodeId(episodeId)
	self:dispatchEvent(Activity1_3ChessEvent.BeginEnterChessGame, episodeId)
	Stat1_3Controller.instance:bristleStatStart()
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)

	if delayTime then
		self._enterEpisodeId = episodeId

		TaskDispatcher.runDelay(self.delayRequestEnterChessGame, self, delayTime)
	else
		Va3ChessController.instance:startNewEpisode(episodeId, self._afterEnterGame, self, ViewName.Activity1_3ChessGameView)
	end
end

function Activity1_3ChessController:delayRequestEnterChessGame()
	TaskDispatcher.cancelTask(self.delayRequestEnterChessGame, self)
	Va3ChessController.instance:startNewEpisode(self._enterEpisodeId, self._afterEnterGame, self, ViewName.Activity1_3ChessGameView)
end

function Activity1_3ChessController:beginResetChessGame(episodeId, cbFunc, cbObj)
	Va3ChessGameModel.instance:clearLastMapRound()
	Va3ChessModel.instance:setActId(VersionActivity1_3Enum.ActivityId.Act304)

	self._enterChessCallback = cbFunc
	self._enterChessCallbackObj = cbObj
	self._resetChessGame = true

	Va3ChessController.instance:startResetEpisode(episodeId, self._afterEnterGame, self, ViewName.Activity1_3ChessGameView)
end

function Activity1_3ChessController:_afterEnterGame()
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)

	local id = Va3ChessModel.instance:getEpisodeId()

	if self._enterChessCallback then
		self._enterChessCallback(self._enterChessCallbackObj)

		self._enterChessCallback = nil
		self._enterChessCallbackObj = nil
	end

	if self._resetChessGame then
		self:dispatchEvent(Activity1_3ChessEvent.AfterResetChessGame)

		self._resetChessGame = nil
	end
end

function Activity1_3ChessController:requestReadChessGame(actId, cbFunc, cbObj)
	self._readChessCallback = cbFunc
	self._readChessCallbackObj = cbObj

	Activity122Rpc.instance:sendAct122CheckPointRequest(actId, true, self._readCallback, self)
end

function Activity1_3ChessController:requestBackChessGame(actId)
	Activity122Rpc.instance:sendAct122CheckPointRequest(actId, false, self._readCallback, self)
end

function Activity1_3ChessController:_readCallback(_, resultCode, msg)
	if resultCode == 0 then
		local map = msg.map
		local mapId = map.mapId
		local actId = msg.activityId

		Va3ChessController.instance:initMapData(actId, map)
		Va3ChessGameController.instance:enterChessGame(actId, mapId, ViewName.Activity1_3ChessGameView)
	end

	if self._readChessCallback then
		self._readChessCallback(self._readChessCallbackObj)

		self._readChessCallback = nil
		self._readChessCallbackObj = nil
	end

	self:dispatchEvent(Activity1_3ChessEvent.OnReadChessGame)
end

function Activity1_3ChessController:isEpisodeOpen(episodeId)
	local actId = VersionActivity1_3Enum.ActivityId.Act304
	local episodeCfgList = Activity122Config.instance:getEpisodeList(actId)

	for i = 1, #episodeCfgList do
		local episodeCfg = episodeCfgList[i]

		if episodeCfg.id == episodeId and Activity1_3ChessController.isOpenDay(episodeCfg.id) and (episodeCfg.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(episodeCfg.id) or Activity122Model.instance:isEpisodeClear(episodeCfg.preEpisode)) then
			return true
		end
	end

	return false
end

function Activity1_3ChessController:checkEpisodeIsOpenByChapterId(chapterId)
	local actId = VersionActivity1_3Enum.ActivityId.Act304
	local episodeCfgList = Activity122Config.instance:getEpisodeList(actId)

	for i = 1, #episodeCfgList do
		local episodeCfg = episodeCfgList[i]

		if episodeCfg.chapterId == chapterId and Activity1_3ChessController.isOpenDay(episodeCfg.id) and (episodeCfg.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(episodeCfg.id) or Activity122Model.instance:isEpisodeClear(episodeCfg.preEpisode)) then
			return true
		end
	end

	return false
end

function Activity1_3ChessController.isOpenDay(episodeId)
	local actId = VersionActivity1_3Enum.ActivityId.Act304
	local actMO = ActivityModel.instance:getActMO(actId)
	local cfg = Activity122Config.instance:getEpisodeCo(actId, episodeId)

	if actMO and cfg then
		local openTime = actMO:getRealStartTimeStamp() + (cfg.openDay - 1) * 24 * 60 * 60
		local serverTimeStamp = ServerTime.now()

		if serverTimeStamp < openTime then
			return false, openTime - serverTimeStamp
		end
	else
		return false, -1
	end

	return true
end

function Activity1_3ChessController:isChapterOpen(chapterId)
	local episodeCfg = Activity1_3ChessController.getFristEpisodeCoByChapterId(chapterId)

	if not episodeCfg then
		return false, -1
	end

	if Activity122Model.instance:isEpisodeClear(episodeCfg.id) then
		return true
	end

	local deyOpen, cdTime = Activity1_3ChessController.isOpenDay(episodeCfg.id)

	return deyOpen and Activity122Model.instance:isEpisodeClear(episodeCfg.preEpisode), cdTime or 0
end

function Activity1_3ChessController.getFristEpisodeCoByChapterId(chapterId)
	local actId = VersionActivity1_3Enum.ActivityId.Act304
	local episodeCfgList = Activity122Config.instance:getChapterEpisodeList(actId, chapterId)

	return episodeCfgList and episodeCfgList[1]
end

function Activity1_3ChessController:isEnterPassedEpisode()
	return self._isEnterPassedEpisode
end

function Activity1_3ChessController.getLimitTimeStr()
	local actMO = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act304)

	if actMO then
		return string.format(luaLang("activity_warmup_remain_time"), actMO:getRemainTimeStr())
	end

	return string.format(luaLang("activity_warmup_remain_time"), "0")
end

function Activity1_3ChessController:setReviewStory(value)
	self._isReviewStory = value
end

function Activity1_3ChessController:isReviewStory()
	return self._isReviewStory
end

function Activity1_3ChessController.getCurChessMapCfg()
	local actId = Va3ChessGameModel.instance:getActId()
	local mapId = Va3ChessGameModel.instance:getMapId()

	return (Activity122Config.instance:getMapCo(actId, mapId))
end

local TaskMOAllFinishId = -100

function Activity1_3ChessController:delayRequestGetReward(delayTime, taskMO)
	if self._taskMO == nil and taskMO then
		self._taskMO = taskMO

		TaskDispatcher.runDelay(self.requestGetReward, self, delayTime)
	end
end

function Activity1_3ChessController:requestGetReward()
	if self._taskMO == nil then
		return
	end

	if self._taskMO.id == TaskMOAllFinishId then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity122)
	elseif self._taskMO:haveRewardToGet() then
		TaskRpc.instance:sendFinishTaskRequest(self._taskMO.id)
	end

	self._taskMO = nil
end

function Activity1_3ChessController:dispatchAllTaskItemGotReward()
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.OneClickClaimReward)
end

function Activity1_3ChessController:showToastByEpsodeId(episodeId, isChapter)
	local actId = VersionActivity1_3Enum.ActivityId.Act304
	local episodeCfg = Activity122Config.instance:getEpisodeCo(actId, episodeId)

	if not episodeCfg then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_3Enum.ActivityId.Act304, episodeId))

		return
	end

	local isOpen, cdTime = Activity1_3ChessController.isOpenDay(episodeCfg.id)

	if not isOpen then
		GameFacade.showToast((isChapter or nil) and (ToastEnum.Va3Act120ChapterNotOpenTime or ToastEnum.Va3Act120EpisodeNotOpenTime))

		return
	end

	local preEpisodePass = episodeCfg.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(episodeCfg.preEpisode)

	if not preEpisodePass then
		local preCfg = Activity122Config.instance:getEpisodeCo(episodeCfg.activityId, episodeCfg.preEpisode)

		GameFacade.showToast(ToastEnum.Va3Act124PreEpisodeNotOpen, (preCfg or nil) and (preCfg.name or episodeCfg.preEpisode))
	end
end

function Activity1_3ChessController:checkHasReward()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity122)

	if taskDict ~= nil then
		local taskCfgList = Activity122Config.instance:getTaskByActId(Va3ChessEnum.ActivityId.Act122)

		for _, taskCfg in ipairs(taskCfgList) do
			local taskModel = taskDict[taskCfg.id]

			if taskModel then
				::label_25_0::

				local var_25_0 = taskModel.hasFinished

				if taskModel.hasFinished then
					local hasReward = taskModel.finishCount == 0

					if hasReward then
						return true
					end
				end
			end
		end
	end

	return false
end

Activity1_3ChessController.instance = Activity1_3ChessController.New()

return Activity1_3ChessController
