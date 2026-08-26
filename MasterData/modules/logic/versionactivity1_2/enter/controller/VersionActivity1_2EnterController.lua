-- chunkname: @modules/logic/versionactivity1_2/enter/controller/VersionActivity1_2EnterController.lua

module("modules.logic.versionactivity1_2.enter.controller.VersionActivity1_2EnterController", package.seeall)

local VersionActivity1_2EnterController = class("VersionActivity1_2EnterController", BaseController)

function VersionActivity1_2EnterController:onInit()
	return
end

function VersionActivity1_2EnterController:reInit()
	return
end

function VersionActivity1_2EnterController:_onFinishStory(param)
	for _, actId in ipairs(VersionActivity1_2Enum.EnterViewActIdList) do
		local activityStatus = ActivityHelper.getActivityStatus(actId)

		if activityStatus == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(actId)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivity1_2Enum.EnterViewActIdList, function()
		self:_openVersionActivity1_2EnterView(param and param.skipOpenAnim)
	end, self)
end

function VersionActivity1_2EnterController:_openVersionActivity1_2EnterView(skipOpenAnim)
	local enterViewActId = VersionActivity1_2Enum.ActivityId.EnterView
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(enterViewActId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParamList)
		end

		return
	end

	if not VersionActivityBaseController.instance:isPlayedActivityVideo(enterViewActId) then
		local activityMo = ActivityModel.instance:getActMO(enterViewActId)

		if activityMo then
			::label_5_0::

			local var_5_0 = activityMo.config

			if activityMo.config then
				local storyId = activityMo.config.storyId

				if storyId and storyId ~= 0 then
					StoryController.instance:playStory(storyId, nil, self._onFinishStory, self, {
						skipOpenAnim = skipOpenAnim
					})
				else
					logWarn(string.format("act id %s dot config story id", storyId))
					self:_onFinishStory({
						skipOpenAnim = skipOpenAnim
					})
				end

				return
			end
		end
	end

	local viewParam = {
		actId = enterViewActId,
		skipOpenAnim = skipOpenAnim,
		activityIdList = VersionActivity1_2Enum.EnterViewActIdList
	}

	ViewMgr.instance:openView(ViewName.VersionActivity1_2EnterView, viewParam)

	if self.openedCallback then
		self.openedCallback(self.openedCallbackObj, self.openedCallbackParam)

		self.openedCallback = nil
		self.openedCallbackObj = nil
		self.openedCallbackParam = nil
	end
end

function VersionActivity1_2EnterController:openVersionActivity1_2EnterView(openedCallback, openedCallbackObj, openedCallbackParam)
	self.openedCallback = openedCallback
	self.openedCallbackObj = openedCallbackObj
	self.openedCallbackParam = openedCallbackParam

	self:_openVersionActivity1_2EnterView()
end

function VersionActivity1_2EnterController:directOpenVersionActivity1_2EnterView(openedCallback, openedCallbackObj, openedCallbackParam)
	self.openedCallback = openedCallback
	self.openedCallbackObj = openedCallbackObj
	self.openedCallbackParam = openedCallbackParam

	self:_openVersionActivity1_2EnterView(true)
end

function VersionActivity1_2EnterController:openActivityStoreView()
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity1_2Enum.ActivityId.DungeonStore)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParamList)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_2StoreView)
end

VersionActivity1_2EnterController.instance = VersionActivity1_2EnterController.New()

return VersionActivity1_2EnterController
