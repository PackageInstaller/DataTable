-- chunkname: @modules/logic/versionactivity1_5/act142/controller/Activity142Controller.lua

module("modules.logic.versionactivity1_5.act142.controller.Activity142Controller", package.seeall)

local Activity142Controller = class("Activity142Controller", BaseController)

function Activity142Controller:onInit()
	self:clear()
end

function Activity142Controller:reInit()
	self:clear()
end

function Activity142Controller:clear()
	self:_endBlock()
end

function Activity142Controller:openMapView(cb, cbObj, cbParam)
	self._tmpOpenMapViewCb = cb
	self._tmpOpenMapViewCbObj = cbObj
	self._tmpOpenMapViewCbParam = cbParam

	local actId = Activity142Model.instance:getActivityId()

	Va3ChessRpcController.instance:sendGetActInfoRequest(actId, self._onOpenMapViewGetActInfoCb, self)
end

function Activity142Controller:_onOpenMapViewGetActInfoCb(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = Activity142Model.instance:getActivityId()
	local isOpen = Activity142Model.instance:isEpisodeOpen(actId, Activity142Enum.AUTO_ENTER_EPISODE_ID)
	local isClear = Activity142Model.instance:isEpisodeClear(Activity142Enum.AUTO_ENTER_EPISODE_ID)

	if isOpen and not isClear then
		self.enterChessGame(self, Activity142Enum.AUTO_ENTER_EPISODE_ID, self._realOpenMapView, self)
	else
		self:_realOpenMapView()
	end
end

function Activity142Controller:_realOpenMapView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity142
	})
	ViewMgr.instance:openView(ViewName.Activity142MapView, nil, true)

	if self._tmpOpenMapViewCb then
		self._tmpOpenMapViewCb(self._tmpOpenMapViewCbObj, self._tmpOpenMapViewCbParam)
	end

	self._tmpOpenMapViewCb = nil
	self._tmpOpenMapViewCbObj = nil
	self._tmpOpenMapViewCbParam = nil
end

function Activity142Controller:openStoryView(episodeId)
	if Activity142Model.instance:isEpisodeClear(episodeId) then
		local actId = Activity142Model.instance:getActivityId()

		if actId then
			ViewMgr.instance:openView(ViewName.Activity142StoryView, {
				actId = actId,
				episodeId = episodeId
			})
		end
	end
end

function Activity142Controller:enterChessGame(episodeId, storyEpisodeEndCb, storyEpisodeEndCbObj)
	Va3ChessGameModel.instance:clearLastMapRound()

	local actId = Activity142Model.instance:getActivityId()

	Va3ChessModel.instance:setActId(actId)
	Activity142Model.instance:setCurEpisodeId(episodeId)
	Activity142Helper.setAct142UIBlock(true)
	Va3ChessController.instance:startNewEpisode(episodeId, self._afterEnterChessGame, self, ViewName.Activity142GameView, storyEpisodeEndCb, storyEpisodeEndCbObj)

	local isStoryEpisode = Va3ChessConfig.instance:isStoryEpisode(actId, episodeId)

	if not isStoryEpisode then
		Activity142StatController.instance:statStart()
	end
end

function Activity142Controller:_afterEnterChessGame()
	self:_endBlock()
end

function Activity142Controller:_endBlock()
	Activity142Helper.setAct142UIBlock(false)
end

function Activity142Controller:act142Back2CheckPoint(callback, callbackObj)
	local actId = Activity142Model.instance:getActivityId()

	Activity142Rpc.instance:sendAct142CheckPointRequest(actId, true, callback, callbackObj)
end

function Activity142Controller:act142ResetGame(callback, callbackObj)
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if not episodeId then
		return
	end

	self._tmpResetCallback = callback
	self._tmpResetCallbackObj = callbackObj

	local actId = Activity142Model.instance:getActivityId()

	Va3ChessModel.instance:setActId(actId)
	Va3ChessGameModel.instance:clearLastMapRound()
	Va3ChessController.instance:startResetEpisode(episodeId, self._act142ResetCallback, self, ViewName.Activity142GameView)
end

function Activity142Controller:_act142ResetCallback()
	if self._tmpResetCallback then
		self._tmpResetCallback(self._tmpResetCallbackObj)

		self._tmpResetCallback = nil
		self._tmpResetCallbackObj = nil
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameReset)
end

function Activity142Controller:delayRequestGetReward(delayTime, taskMO)
	if self._tmpTaskMO == nil and taskMO then
		self._tmpTaskMO = taskMO

		TaskDispatcher.runDelay(self.requestGetReward, self, delayTime)
	end
end

function Activity142Controller:requestGetReward()
	if self._tmpTaskMO == nil then
		return
	end

	if self._tmpTaskMO.id == Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity142)
	elseif self._tmpTaskMO:haveRewardToGet() then
		TaskRpc.instance:sendFinishTaskRequest(self._tmpTaskMO.id)
	end

	self._tmpTaskMO = nil
end

function Activity142Controller:dispatchAllTaskItemGotReward()
	self:dispatchEvent(Activity142Event.OneClickClaimReward)
end

function Activity142Controller:setPlayedUnlockAni(key)
	local playerCacheData = Activity142Model.instance:getPlayerCacheData()

	if not playerCacheData then
		return
	end

	playerCacheData[key] = true

	Activity142Model.instance:saveCacheData()
end

function Activity142Controller:havePlayedUnlockAni(key)
	local result = false

	if not key then
		return result
	end

	local playerCacheData = Activity142Model.instance:getPlayerCacheData()

	if not playerCacheData then
		return result
	end

	result = playerCacheData[key] or false

	return result
end

Activity142Controller.instance = Activity142Controller.New()

return Activity142Controller
