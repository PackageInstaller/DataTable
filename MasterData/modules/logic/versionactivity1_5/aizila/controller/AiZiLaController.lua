-- chunkname: @modules/logic/versionactivity1_5/aizila/controller/AiZiLaController.lua

module("modules.logic.versionactivity1_5.aizila.controller.AiZiLaController", package.seeall)

local AiZiLaController = class("AiZiLaController", BaseController)

function AiZiLaController:onInit()
	ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, self._onDestroyViewFinish, self)

	self._reShowViewAnim = {
		AiZiLaMapView = UIAnimationName.Open
	}

	self:reInit()
end

function AiZiLaController:onInitFinish()
	return
end

function AiZiLaController:addConstEvents()
	return
end

function AiZiLaController:_onDestroyViewFinish()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	if #openViewNameList > 0 then
		local oneViewName = openViewNameList[#openViewNameList]

		if self._reShowViewAnim[oneViewName] then
			AiZiLaHelper.playViewAnimator(oneViewName, self._reShowViewAnim[oneViewName])
		end
	end
end

function AiZiLaController:reInit()
	self._openStoryIds = nil
end

function AiZiLaController:openStoryView(episodeId)
	local viewParam = {
		episodeId = episodeId,
		actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	}

	ViewMgr.instance:openView(ViewName.AiZiLaStoryView, viewParam)
end

function AiZiLaController:openMapView()
	self._enterStoryFinish = true
	self._openInfosFinish = false

	local storyIds = self:_getOpenStoryIds()

	if not self:_checkStoryIds(storyIds) then
		self._enterStoryFinish = false

		self._playStoryIds(self, storyIds, self._afterPlayEnterStory, self)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleAiZiLa
	}, self._onTaskGet, self)
end

function AiZiLaController:_onTaskGet()
	Activity144Rpc.instance:sendGet144InfosRequest(VersionActivity1_5Enum.ActivityId.AiZiLa, self._onOpenMapViewRequest, self)
end

function AiZiLaController:playOpenStory()
	local storyIds = self:_getOpenStoryIds()

	self:_playStoryIds(storyIds)
end

function AiZiLaController:_playStoryIds(storyIds, callback, callbackObj)
	local storyParams = {
		mark = true,
		isReplay = false,
		hideStartAndEndDark = true
	}

	StoryController.instance:playStories(storyIds, storyParams, callback, callbackObj)
end

function AiZiLaController:_afterPlayEnterStory()
	self._enterStoryFinish = true

	self:_checkOpenMapView()
end

function AiZiLaController:_onOpenMapViewRequest(cmd, resultCode, msg)
	if resultCode == 0 then
		self._openInfosFinish = true
		self._isInfoSettle = msg.Act144InfoNO and msg.Act144InfoNO.isSettle

		self:_checkOpenMapView()
	end
end

AiZiLaController.OPEN_MAPVIEW_INFO_SETTLE = "AiZiLaController.OPEN_MAPVIEW_INFO_SETTLE"

function AiZiLaController:_checkOpenMapView()
	if self._enterStoryFinish and self._openInfosFinish then
		PermanentController.instance:jump2Activity(VersionActivity1_5Enum.ActivityId.EnterView)
		self:_onEnterViewIfNotOpened()
	end
end

function AiZiLaController:_onEnterViewIfNotOpened()
	ViewMgr.instance:openView(ViewName.AiZiLaMapView)

	if self._isInfoSettle then
		self._isInfoSettle = false

		AiZiLaHelper.startBlock(AiZiLaController.OPEN_MAPVIEW_INFO_SETTLE)
		TaskDispatcher.runDelay(self._onInfoSettle, self, AiZiLaEnum.AnimatorTime.MapViewOpen)
	end
end

function AiZiLaController:_onInfoSettle()
	AiZiLaGameModel.instance:reInit()
	Activity144Rpc.instance:sendAct144SettleEpisodeRequest(VersionActivity1_5Enum.ActivityId.AiZiLa, self._onInfoSettleRequest, self)
end

function AiZiLaController:_onInfoSettleRequest(cmd, resultCode, msg)
	AiZiLaHelper.endBlock(AiZiLaController.OPEN_MAPVIEW_INFO_SETTLE)

	if resultCode == 0 then
		AiZiLaGameModel.instance:setEpisodeId(msg.act144Episode.episodeId)
		AiZiLaGameModel.instance:settleEpisodeReply(msg)

		if self._lastSettlePushMsg and self._lastSettlePushMsg.episodeId == msg.act144Episode.episodeId then
			AiZiLaGameModel.instance:settlePush(self._lastSettlePushMsg)
		end

		AiZiLaGameController.instance:gameResult()
	end
end

function AiZiLaController:_getOpenStoryIds()
	if not self._openStoryIds then
		self._openStoryIds = {}

		local storyCos = AiZiLaConfig.instance:getStoryList(VersionActivity1_5Enum.ActivityId.AiZiLa)

		if storyCos then
			for index, storyCo in ipairs(storyCos) do
				if storyCo.episodeId == AiZiLaEnum.OpenStoryEpisodeId then
					table.insert(self._openStoryIds, storyCo.id)
				end
			end
		end
	end

	return self._openStoryIds
end

function AiZiLaController:_checkStoryIds(ids)
	if ids then
		for _, storyId in ipairs(ids) do
			if not StoryModel.instance:isStoryHasPlayed(storyId) then
				return false
			end
		end
	end

	return true
end

function AiZiLaController:openEpsiodeDetailView(episodeId)
	ViewMgr.instance:openView(ViewName.AiZiLaEpsiodeDetailView, {
		episodeId = episodeId,
		actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	})
end

function AiZiLaController:delayReward(delayTime, taskMO)
	if self._actTaskMO == nil and taskMO then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function AiZiLaController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == AiZiLaEnum.TaskMOAllFinishId or actTaskMO:alreadyGotReward()) then
		AiZiLaTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, AiZiLaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function AiZiLaController:_onRewardTask()
	local actTaskId = self._actTaskId

	self._actTaskId = nil

	if actTaskId then
		if actTaskId == AiZiLaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleAiZiLa)
		else
			TaskRpc.instance:sendFinishTaskRequest(actTaskId)
		end
	end
end

function AiZiLaController:getInfosReply(msg)
	AiZiLaModel.instance:getInfosReply(msg)
end

function AiZiLaController:enterEpisodeReply(msg)
	AiZiLaModel.instance:enterEpisodeReply(msg)
end

function AiZiLaController:selectOptionReply(msg)
	AiZiLaModel.instance:selectOptionReply(msg)
end

function AiZiLaController:nextDayReply(msg)
	AiZiLaModel.instance:nextDayReply(msg)
end

function AiZiLaController:settleEpisodeReply(msg)
	local curEpsiodeId = AiZiLaGameModel.instance:getEpisodeId()
	local tempEpsiodeId = msg.act144Episode.episodeId

	if curEpsiodeId ~= 0 and curEpsiodeId == tempEpsiodeId then
		AiZiLaGameModel.instance:settleEpisodeReply(msg)
		AiZiLaGameController.instance:gameResult()
	end
end

function AiZiLaController:settlePush(msg)
	AiZiLaModel.instance:settlePush(msg)

	local curEpsiodeId = AiZiLaGameModel.instance:getEpisodeId()
	local tempEpsiodeId = msg.episodeId

	self._lastSettlePushMsg = nil

	if curEpsiodeId ~= 0 and curEpsiodeId == tempEpsiodeId then
		AiZiLaGameModel.instance:settlePush(msg)
		AiZiLaGameController.instance:gameResult()
	else
		self._lastSettlePushMsg = msg
	end
end

function AiZiLaController:upgradeEquipReply(msg)
	AiZiLaModel.instance:upgradeEquipReply(msg)
	self:dispatchEvent(AiZiLaEvent.OnEquipUpLevel, msg.newEquipId)
end

function AiZiLaController:episodePush(msg)
	AiZiLaModel.instance:episodePush(msg)

	local curEpsiodeId = AiZiLaGameModel.instance:getEpisodeId()

	if curEpsiodeId ~= 0 and curEpsiodeId == msg.act144Episode.episodeId then
		AiZiLaGameModel.instance:updateEpisode(msg.act144Episode)
		AiZiLaGameController.instance:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
	end

	self:dispatchEvent(AiZiLaEvent.EpisodePush)
end

function AiZiLaController:itemChangePush(msg)
	AiZiLaModel.instance:itemChangePush(msg)
end

AiZiLaController.instance = AiZiLaController.New()

return AiZiLaController
