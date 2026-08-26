-- chunkname: @modules/logic/versionactivity1_5/enter/controller/VersionActivity1_5EnterController.lua

module("modules.logic.versionactivity1_5.enter.controller.VersionActivity1_5EnterController", package.seeall)

local VersionActivity1_5EnterController = class("VersionActivity1_5EnterController", BaseController)

function VersionActivity1_5EnterController:onInit()
	return
end

function VersionActivity1_5EnterController:reInit()
	return
end

function VersionActivity1_5EnterController:openVersionActivityEnterViewIfNotOpened(openedCallback, openedCallbackObj)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_5EnterView) then
		if openedCallback then
			openedCallback(openedCallbackObj)
		end

		return
	end

	self:openVersionActivityEnterView(openedCallback, openedCallbackObj)
end

function VersionActivity1_5EnterController:openVersionActivityEnterView(openedCallback, openedCallbackObj)
	self.openedCallback = openedCallback
	self.openedCallbackObj = openedCallbackObj

	self._enterVersionActivityView(self, ViewName.VersionActivity1_5EnterView, VersionActivity1_5Enum.ActivityId.EnterView, self._openVersionActivityEnterView, self)
end

function VersionActivity1_5EnterController:_onFinishStory()
	local status = ActivityHelper.getActivityStatus(VersionActivity1_5Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	self:_openVersionActivityEnterView()
end

function VersionActivity1_5EnterController:_openVersionActivityEnterView()
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_5Enum.ActivityId.EnterView) then
		local activityMo = ActivityModel.instance:getActMO(VersionActivity1_5Enum.ActivityId.EnterView)

		if activityMo then
			::label_6_0::

			local var_6_0 = activityMo.config

			if activityMo.config then
				local storyId = activityMo.config.storyId

				if not storyId then
					logError(string.format("act id %s dot config story id", storyId))

					storyId = 100010
				end

				local param = {}

				param.isVersionActivityPV = true

				StoryController.instance:playStory(storyId, param, self._onFinishStory, self)

				return
			end
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5EnterView, {
		actId = VersionActivity1_5Enum.ActivityId.EnterView,
		activityIdListWithGroup = VersionActivity1_5Enum.EnterViewActIdListWithGroup,
		mainActIdList = VersionActivity1_5Enum.EnterViewMainActIdList,
		actId2AmbientDict = VersionActivity1_5Enum.ActId2Ambient,
		actId2OpenAudioDict = VersionActivity1_5Enum.ActId2OpenAudio
	})

	if self.openedCallback then
		self.openedCallback(self.openedCallbackObj)

		self.openedCallback = nil
		self.openedCallbackObj = nil
	end
end

function VersionActivity1_5EnterController:directOpenVersionActivityEnterView()
	self._enterVersionActivityView(self, ViewName.VersionActivity1_5EnterView, VersionActivity1_5Enum.ActivityId.EnterView, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_5EnterView, {
			skipOpenAnim = true,
			actId = VersionActivity1_5Enum.ActivityId.EnterView,
			activityIdListWithGroup = VersionActivity1_5Enum.EnterViewActIdListWithGroup,
			mainActIdList = VersionActivity1_5Enum.EnterViewMainActIdList,
			actId2AmbientDict = VersionActivity1_5Enum.ActId2Ambient,
			actId2OpenAudioDict = VersionActivity1_5Enum.ActId2OpenAudio
		})
	end, self)
end

function VersionActivity1_5EnterController:openStoreView()
	self._enterVersionActivityView(self, ViewName.VersionActivity1_5StoreView, VersionActivity1_5Enum.ActivityId.DungeonStore, self._openStoreView, self)
end

function VersionActivity1_5EnterController:_openStoreView(viewName, actId)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, function()
		ViewMgr.instance:openView(viewName, {
			actId = actId
		})
	end)
end

function VersionActivity1_5EnterController:openSeasonStoreView()
	local actId = Activity104Model.instance:getCurSeasonId()
	local viewName = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.StoreView)
	local storeActId = Activity104Enum.SeasonStore[actId]

	self._enterVersionActivityView(self, viewName, storeActId, self._openStoreView, self)
end

function VersionActivity1_5EnterController:openTaskView()
	self._enterVersionActivityView(self, ViewName.VersionActivityTaskView, VersionActivity1_5Enum.ActivityId.Act113, self._openTaskView, self)
end

function VersionActivity1_5EnterController:_openTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function VersionActivity1_5EnterController:_enterVersionActivityView(viewName, actId, callback, callbackObj)
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	if callback then
		callback(callbackObj, viewName, actId)

		return
	end

	ViewMgr.instance:openView(viewName)
end

function VersionActivity1_5EnterController.GetActivityPrefsKey(key)
	return VersionActivity1_5Enum.ActivityId.EnterView .. key
end

function VersionActivity1_5EnterController.GetActivityPrefsKeyWithUser(key)
	return PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_5EnterController.GetActivityPrefsKey(key))
end

VersionActivity1_5EnterController.instance = VersionActivity1_5EnterController.New()

return VersionActivity1_5EnterController
