-- chunkname: @modules/logic/weekwalk_2/controller/WeekWalk_2Controller.lua

module("modules.logic.weekwalk_2.controller.WeekWalk_2Controller", package.seeall)

local WeekWalk_2Controller = class("WeekWalk_2Controller", BaseController)

function WeekWalk_2Controller:onInit()
	self:clear()
end

function WeekWalk_2Controller:reInit()
	self:clear()
end

function WeekWalk_2Controller:onInitFinish()
	return
end

function WeekWalk_2Controller:clear()
	self._requestTask = false
	self._requestTimes = 0
	self._maxRequestTimes = 3
end

function WeekWalk_2Controller:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refreshTaskData, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._refreshTaskData, self)
	WeekWalk_2Controller.instance:registerCallback(WeekWalk_2Event.OnGetInfo, self.startCheckTime, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self, LuaEventSystem.Low)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	FightController.instance:registerCallback(FightEvent.OnBreakResultViewClose, self._onBreakResultViewClose, self)
end

function WeekWalk_2Controller:_onBreakResultViewClose(param)
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if episodeId then
		::label_6_0::

		local episode_config = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episode_config and episode_config.type == DungeonEnum.EpisodeType.WeekWalk_2 and WeekWalk_2Model.instance:getSettleInfo() then
			param.isBreak = true
		end
	end
end

function WeekWalk_2Controller:_onCloseView(viewName)
	if viewName ~= ViewName.FightSuccView then
		return
	end

	local episodeId = DungeonModel.instance.curSendEpisodeId

	if episodeId then
		::label_7_0::

		local episode_config = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episode_config and episode_config.type == DungeonEnum.EpisodeType.WeekWalk_2 and WeekWalk_2Model.instance:getSettleInfo() then
			WeekWalk_2Controller.instance:openWeekWalk_2HeartResultView()
		end
	end
end

function WeekWalk_2Controller:_onDailyRefresh()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk_2
	})
	Weekwalk_2Rpc.instance:sendWeekwalkVer2GetInfoRequest()
end

function WeekWalk_2Controller:startCheckTime()
	TaskDispatcher.runRepeat(self._checkTime, self, 1)
end

function WeekWalk_2Controller:stopCheckTime()
	TaskDispatcher.cancelTask(self._checkTime, self)
end

function WeekWalk_2Controller:_checkTime()
	local info = WeekWalk_2Model.instance:getInfo()

	if not info or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		self:stopCheckTime()

		return
	end

	local endTime = info.endTime
	local curTime = ServerTime.now()

	if endTime > 0 and endTime - curTime <= 0 then
		self:stopCheckTime()
		self:_recordRequestTimes()

		if self._requestTimes > self._maxRequestTimes then
			logError("sendWeekwalkVer2GetInfoRequest too many times")

			return
		end

		self:requestTask(true)
		Weekwalk_2Rpc.instance:sendWeekwalkVer2GetInfoRequest()

		return
	end

	self:_clearRequestTimes()
end

function WeekWalk_2Controller:_recordRequestTimes()
	self._requestTimes = self._requestTimes or 0
	self._requestTimes = self._requestTimes + 1
end

function WeekWalk_2Controller:_clearRequestTimes()
	self._requestTimes = 0
end

function WeekWalk_2Controller:requestTask(force)
	if self._requestTask and not force then
		return
	end

	self._requestTask = true

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk_2
	})
end

function WeekWalk_2Controller:_refreshTaskData()
	WeekWalk_2TaskListModel.instance:updateTaskList()
	self:dispatchEvent(WeekWalk_2Event.OnWeekwalkTaskUpdate)
end

function WeekWalk_2Controller:enterWeekwalk_2Fight(elementId, battleId)
	if not elementId then
		logError("enterWeekwalk_2Fight elementId nil")
	end

	WeekWalk_2Model.instance:setBattleElementId(elementId)

	local episodeId = WeekWalk_2Enum.episodeId

	DungeonModel.instance.curLookEpisodeId = episodeId

	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, battleId)
end

function WeekWalk_2Controller:openWeekWalk_2HeartLayerView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartLayerView, param, isImmediate)
end

function WeekWalk_2Controller:openWeekWalk_2HeartView(param, isImmediate)
	param = param or {}

	if not param.mapId then
		local battleId = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		param.mapId = WeekWalk_2Model.instance:getCurMapId()
	end

	if param.mapId then
		WeekWalk_2Model.instance:setCurMapId(param.mapId)
	end

	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartView, param, isImmediate)
end

function WeekWalk_2Controller:openWeekWalk_2HeartBuffView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartBuffView, param, isImmediate)
end

function WeekWalk_2Controller:openWeekWalk_2HeartResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartResultView, param, isImmediate)
end

function WeekWalk_2Controller:openWeekWalk_2ResetView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalk_2ResetView, param, isImmediate)
end

function WeekWalk_2Controller:openWeekWalk_2LayerRewardView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalk_2LayerRewardView, param, isImmediate)
end

function WeekWalk_2Controller:openWeekWalk_2RuleView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalk_2RuleView, param, isImmediate)
end

function WeekWalk_2Controller:openWeekWalk_2DeepLayerNoticeView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.WeekWalk_2DeepLayerNoticeView, param, isImmediate)
end

function WeekWalk_2Controller:checkOpenWeekWalk_2DeepLayerNoticeView(param, isImmediate)
	local info = WeekWalk_2Model.instance:getInfo()

	if not info or not info.isPopSettle then
		return
	end

	if WeekWalkModel.instance:getMaxLayerId() >= WeekWalkEnum.FirstDeepLayer or GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		self:openWeekWalk_2DeepLayerNoticeView()
	end
end

function WeekWalk_2Controller:jumpWeekWalkHeartLayerView(callback, callbackTarget)
	self._jumpCallback = callback
	self._jumpCallbackTarget = callbackTarget

	module_views_preloader.preloadMultiView(self._preloadCallback, self, {
		ViewName.DungeonView,
		ViewName.WeekWalk_2HeartLayerView
	}, {
		DungeonEnum.dungeonweekwalk_2viewPath
	})
end

function WeekWalk_2Controller:_preloadCallback()
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

function WeekWalk_2Controller:_delayOpenLayerView()
	WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView()
end

function WeekWalk_2Controller.hasOnceActionKey(type, id)
	local key = WeekWalk_2Controller._getKey(type, id)

	return PlayerPrefsHelper.hasKey(key)
end

function WeekWalk_2Controller.setOnceActionKey(type, id)
	local key = WeekWalk_2Controller._getKey(type, id)

	PlayerPrefsHelper.setNumber(key, 1)
end

function WeekWalk_2Controller._getKey(type, id)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.WeekWalk_2OnceAnim, PlayerModel.instance:getPlayinfo().userId, type, id))
end

WeekWalk_2Controller.instance = WeekWalk_2Controller.New()

return WeekWalk_2Controller
