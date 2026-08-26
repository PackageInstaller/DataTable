-- chunkname: @modules/logic/versionactivity1_6/enter/controller/VersionActivity1_6EnterController.lua

module("modules.logic.versionactivity1_6.enter.controller.VersionActivity1_6EnterController", package.seeall)

local VersionActivity1_6EnterController = class("VersionActivity1_6EnterController", BaseController)

function VersionActivity1_6EnterController:onInit()
	self.selectActId = nil
end

function VersionActivity1_6EnterController:reInit()
	self.selectActId = nil
end

function VersionActivity1_6EnterController:setSelectActId(actId)
	self.selectActId = actId
end

function VersionActivity1_6EnterController:getSelectActId()
	return self.selectActId
end

function VersionActivity1_6EnterController:openVersionActivityEnterViewIfNotOpened(openedCallback, openedCallbackObj, actId, showEnterVideo)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_5EnterView) then
		if openedCallback then
			openedCallback(openedCallbackObj)
		end

		return
	end

	self:openVersionActivityEnterView(openedCallback, openedCallbackObj, actId, showEnterVideo)
end

function VersionActivity1_6EnterController:openVersionActivityEnterView(openedCallback, openedCallbackObj, actId, showEnterVideo)
	self.openedCallback = openedCallback
	self.openedCallbackObj = openedCallbackObj
	self.actId = actId

	local viewParams = {
		jumpActId = actId,
		enterVideo = showEnterVideo
	}

	self._enterVersionActivityView(self, ViewName.VersionActivity1_6EnterView, VersionActivity1_6Enum.ActivityId.EnterView, self._openVersionActivityEnterView, self, viewParams)
end

function VersionActivity1_6EnterController:_onFinishStory(viewParams)
	local status = ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	self:_openVersionActivityEnterView(nil, nil, viewParams)
end

function VersionActivity1_6EnterController:_openVersionActivityEnterView(viewName, actId, viewParams)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_6Enum.ActivityId.EnterView) then
		local activityMo = ActivityModel.instance:getActMO(VersionActivity1_6Enum.ActivityId.EnterView)

		if activityMo then
			::label_8_0::

			local var_8_0 = activityMo.config

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

	if self.openedCallback then
		self.openedCallback(self.openedCallbackObj)

		self.openedCallback = nil
		self.openedCallbackObj = nil
	end
end

function VersionActivity1_6EnterController:directOpenVersionActivityEnterView()
	self._enterVersionActivityView(self, ViewName.VersionActivity1_6EnterView, VersionActivity1_6Enum.ActivityId.EnterView, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_6EnterView, {
			skipOpenAnim = true,
			actId = VersionActivity1_6Enum.ActivityId.EnterView,
			activityIdList = VersionActivity1_6Enum.EnterViewActIdList
		})
	end, self)
end

function VersionActivity1_6EnterController:openStoreView()
	self._enterVersionActivityView(self, ViewName.VersionActivity1_6StoreView, VersionActivity1_6Enum.ActivityId.DungeonStore, self._openStoreView, self)
end

function VersionActivity1_6EnterController:_openStoreView(viewName, actId)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, function()
		ViewMgr.instance:openView(viewName, {
			actId = actId
		})
	end)
end

function VersionActivity1_6EnterController:openSeasonStoreView()
	local actId = Activity104Model.instance:getCurSeasonId()
	local viewName = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.StoreView)
	local storeActId = Activity104Enum.SeasonStore[actId]

	self._enterVersionActivityView(self, viewName, storeActId, self._openStoreView, self)
end

function VersionActivity1_6EnterController:openTaskView()
	self._enterVersionActivityView(self, ViewName.VersionActivityTaskView, VersionActivity1_6Enum.ActivityId.Act113, self._openTaskView, self)
end

function VersionActivity1_6EnterController:_openTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function VersionActivity1_6EnterController:openCachotEnterView()
	self._enterVersionActivityView(self, ViewName.V1a6_CachotEnterView, VersionActivity1_6Enum.ActivityId.Cachot, self._openCachotEnterView, self)
end

function VersionActivity1_6EnterController:_openCachotEnterView()
	ViewMgr.instance:openView(ViewName.V1a6_CachotEnterView)
end

function VersionActivity1_6EnterController:_enterVersionActivityView(viewName, actId, callback, callbackObj, viewParams)
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	if callback then
		callback(callbackObj, viewName, actId, viewParams)

		return
	end

	ViewMgr.instance:openView(viewName, viewParams)
end

function VersionActivity1_6EnterController.GetActivityPrefsKey(key)
	return VersionActivity1_6Enum.ActivityId.EnterView .. key
end

VersionActivity1_6EnterController.instance = VersionActivity1_6EnterController.New()

return VersionActivity1_6EnterController
