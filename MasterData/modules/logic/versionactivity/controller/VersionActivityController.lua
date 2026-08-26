-- chunkname: @modules/logic/versionactivity/controller/VersionActivityController.lua

module("modules.logic.versionactivity.controller.VersionActivityController", package.seeall)

local VersionActivityController = class("VersionActivityController", BaseController)

function VersionActivityController:onInit()
	return
end

function VersionActivityController:reInit()
	return
end

function VersionActivityController:openVersionActivityEnterViewIfNotOpened(openedCallback, openedCallbackObj)
	if ViewMgr.instance:isOpen(ViewName.VersionActivityEnterView) then
		if openedCallback then
			openedCallback(openedCallbackObj)
		end

		return
	end

	self:openVersionActivityEnterView(openedCallback, openedCallbackObj)
end

function VersionActivityController:openVersionActivityEnterView(openedCallback, openedCallbackObj)
	self.openedCallback = openedCallback
	self.openedCallbackObj = openedCallbackObj

	self._enterVersionActivityView(self, ViewName.VersionActivityEnterView, VersionActivityEnum.ActivityId.Act105, self._openVersionActivityEnterView, self)
end

function VersionActivityController:_onFinishStory()
	local status = ActivityHelper.getActivityStatus(VersionActivityEnum.ActivityId.Act105)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	for _, actId in ipairs(VersionActivityEnum.EnterViewActIdList) do
		local activityStatus = ActivityHelper.getActivityStatus(actId)

		if activityStatus == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(actId)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivityEnum.EnterViewActIdList, function()
		self:_openVersionActivityEnterView()
	end, self)
end

function VersionActivityController:_openVersionActivityEnterView()
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivityEnum.ActivityId.Act105) then
		local activityMo = ActivityModel.instance:getActMO(VersionActivityEnum.ActivityId.Act105)

		if activityMo then
			::label_7_0::

			local var_7_0 = activityMo.config

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

	ViewMgr.instance:openView(ViewName.VersionActivityEnterView, {
		actId = VersionActivityEnum.ActivityId.Act105,
		activityIdList = VersionActivityEnum.EnterViewActIdList
	})

	if self.openedCallback then
		self.openedCallback(self.openedCallbackObj)

		self.openedCallback = nil
		self.openedCallbackObj = nil
	end
end

function VersionActivityController:directOpenVersionActivityEnterView()
	self._enterVersionActivityView(self, ViewName.VersionActivityEnterView, VersionActivityEnum.ActivityId.Act105, function()
		ViewMgr.instance:openView(ViewName.VersionActivityEnterView, {
			skipOpenAnim = true,
			actId = VersionActivityEnum.ActivityId.Act105,
			activityIdList = VersionActivityEnum.EnterViewActIdList
		})
	end, self)
end

function VersionActivityController:openLeiMiTeBeiStoreView(actId)
	if ReactivityModel.instance:isReactivity(actId) then
		ReactivityController.instance:openReactivityStoreView(actId)

		return
	end

	self._enterVersionActivityView(self, ViewName.VersionActivityStoreView, VersionActivityEnum.ActivityId.Act107, self._openStoreView, self)
end

function VersionActivityController:_openStoreView(viewName, actId)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, function()
		ViewMgr.instance:openView(viewName, {
			actId = actId
		})
	end)
end

function VersionActivityController:openSeasonStoreView()
	local actId = Activity104Model.instance:getCurSeasonId()
	local viewName = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.StoreView)
	local storeActId = Activity104Enum.SeasonStore[actId]

	self._enterVersionActivityView(self, viewName, storeActId, self._openStoreView, self)
end

function VersionActivityController:openLeiMiTeBeiTaskView()
	local actId = VersionActivityEnum.ActivityId.Act113

	if ReactivityModel.instance:isReactivity(actId) then
		ReactivityController.instance:openReactivityTaskView(actId)

		return
	end

	self._enterVersionActivityView(self, ViewName.VersionActivityTaskView, actId, self._openLeiMiTeBeiTaskView, self)
end

function VersionActivityController:_openLeiMiTeBeiTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function VersionActivityController:_enterVersionActivityView(viewName, actId, callback, callbackObj)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParamList)
		end

		return
	end

	if callback then
		callback(callbackObj, viewName, actId)

		return
	end

	ViewMgr.instance:openView(viewName)
end

VersionActivityController.instance = VersionActivityController.New()

return VersionActivityController
