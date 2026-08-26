-- chunkname: @modules/logic/weekwalk/controller/WeekWalkController.lua

module("modules.logic.weekwalk.controller.WeekWalkController", package.seeall)

local WeekWalkController = class("WeekWalkController", BaseController)

function WeekWalkController:onInit()
	self:clear()
end

function WeekWalkController:onInitFinish()
	return
end

function WeekWalkController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refreshTaskData, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._refreshTaskData, self)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnGetInfo, self.startCheckTime, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self, LuaEventSystem.Low)
end

function WeekWalkController:_onDailyRefresh()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk
	})
	WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()
end

function WeekWalkController:startCheckTime()
	TaskDispatcher.runRepeat(self._checkTime, self, 1)
end

function WeekWalkController:stopCheckTime()
	TaskDispatcher.cancelTask(self._checkTime, self)
end

function WeekWalkController:_checkTime()
	local info = WeekWalkModel.instance:getInfo()

	if not info or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		self:stopCheckTime()

		return
	end

	local endTime = info.endTime
	local curTime = ServerTime.now()

	if endTime - curTime <= 0 then
		self:stopCheckTime()

		if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
			WeekWalkModel.instance:addOldInfo()
		end

		self:_recordRequestTimes()

		if self._requestTimes > self._maxRequestTimes then
			logError("sendGetWeekwalkInfoRequest too many times")

			return
		end

		self:requestTask(true)
		WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()

		return
	end

	self:_clearRequestTimes()
end

function WeekWalkController:_recordRequestTimes()
	self._requestTimes = self._requestTimes or 0
	self._requestTimes = self._requestTimes + 1
end

function WeekWalkController:_clearRequestTimes()
	self._requestTimes = 0
end

function WeekWalkController:reInit()
	self:clear()
end

function WeekWalkController:clear()
	self._requestTask = false
	self._requestTimes = 0
	self._maxRequestTimes = 3
end

function WeekWalkController:_refreshTaskData()
	WeekWalkTaskListModel.instance:updateTaskList()
	self:dispatchEvent(WeekWalkEvent.OnWeekwalkTaskUpdate)
end

function WeekWalkController.getTaskEndTime(type)
	local list = TaskConfig.instance:getWeekWalkTaskList(type)

	for i, v in ipairs(list) do
		local taskMo = WeekWalkTaskListModel.instance:getTaskMo(v.id)

		return taskMo and taskMo.expiryTime
	end
end

function WeekWalkController:requestTask(force)
	if self._requestTask and not force then
		return
	end

	self._requestTask = true

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk
	})
end

function WeekWalkController:openWeekWalkCharacterView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkCharacterView, param, isImmediate)
end

function WeekWalkController:openWeekWalkTarotView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkTarotView, param, isImmediate)
end

function WeekWalkController:openWeekWalkReviveView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkReviveView, param, isImmediate)
end

function WeekWalkController:openWeekWalkRuleView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkRuleView, param, isImmediate)
end

function WeekWalkController:openWeekWalkShallowSettlementView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkShallowSettlementView, param, isImmediate)
end

function WeekWalkController:openWeekWalkDeepLayerNoticeView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkDeepLayerNoticeView, param, isImmediate)
end

function WeekWalkController:checkOpenWeekWalkDeepLayerNoticeView(param, isImmediate)
	if WeekWalkModel.instance:getMaxLayerId() >= WeekWalkEnum.FirstDeepLayer or GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		self:openWeekWalkDeepLayerNoticeView()
	end
end

function WeekWalkController:openWeekWalkView(param, isImmediate)
	param = param or {}

	if not param.mapId then
		local battleId = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		param.mapId = WeekWalkModel.instance:getCurMapId()
	end

	if param.mapId then
		WeekWalkModel.instance:setCurMapId(param.mapId)
	end

	ViewMgr.instance:openView(ViewName.WeekWalkView, param, isImmediate)
end

function WeekWalkController:openWeekWalkDegradeView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkDegradeView, param, isImmediate)
end

function WeekWalkController:openWeekWalkDialogView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkDialogView, param, isImmediate)
end

function WeekWalkController:openWeekWalkQuestionView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkQuestionView, param, isImmediate)
end

function WeekWalkController:openWeekWalkResetView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkResetView, param, isImmediate)
end

function WeekWalkController:openWeekWalkLayerView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkLayerView, param, isImmediate)
end

function WeekWalkController:openWeekWalkRewardView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkRewardView, param, isImmediate)
end

function WeekWalkController:openWeekWalkLayerRewardView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkLayerRewardView, param, isImmediate)
end

function WeekWalkController:openWeekWalkEnemyInfoView(param, isImmediate)
	logError("废弃 view")
end

function WeekWalkController:openWeekWalkBuffBindingView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalkBuffBindingView, param, isImmediate)
end

function WeekWalkController:openWeekWalkRespawnView(param, isImmediate)
	local info = WeekWalkModel.instance:getInfo()

	if info:haveDeathHero() then
		ViewMgr.instance:openView(ViewName.WeekWalkRespawnView, param, isImmediate)
	else
		GameFacade.showToast(ToastEnum.AdventureRespawn)
	end
end

function WeekWalkController:enterWeekwalkFight(elementId)
	local mapId = WeekWalkModel.instance:getCurMapId()
	local elementInfo = WeekWalkModel.instance:getElementInfo(mapId, elementId)
	local battleId = elementInfo:getBattleId()
	local episodeId = WeekWalkEnum.episodeId

	DungeonModel.instance.curLookEpisodeId = episodeId

	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterWeekwalkFight(config.chapterId, episodeId, battleId)
end

function WeekWalkController:jumpWeekWalkDeepLayerView(callback, callbackTarget)
	self._jumpCallback = callback
	self._jumpCallbackTarget = callbackTarget

	module_views_preloader.preloadMultiView(self._preloadCallback, self, {
		ViewName.DungeonView,
		ViewName.WeekWalkLayerView
	}, {
		DungeonEnum.dungeonweekwalkviewPath
	})
end

function WeekWalkController:_preloadCallback()
	WeekWalkModel.instance:setSkipShowSettlementView(true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.WeekWalk)
	DungeonController.instance:enterDungeonView()
	TaskDispatcher.runDelay(self._delayOpenLayerView, self, 0)

	local callback = self._jumpCallback
	local callbackTarget = self._jumpCallbackTarget

	self._jumpCallback = nil
	self._jumpCallbackTarget = nil

	if callback then
		self._jumpCallback(callbackTarget)
	end
end

function WeekWalkController:_delayOpenLayerView()
	WeekWalkController.instance:openWeekWalkLayerView({
		layerId = 11
	})
end

WeekWalkController.instance = WeekWalkController.New()

return WeekWalkController
