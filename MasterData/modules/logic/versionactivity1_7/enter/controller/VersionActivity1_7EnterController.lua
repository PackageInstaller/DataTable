-- chunkname: @modules/logic/versionactivity1_7/enter/controller/VersionActivity1_7EnterController.lua

module("modules.logic.versionactivity1_7.enter.controller.VersionActivity1_7EnterController", package.seeall)

local VersionActivity1_7EnterController = class("VersionActivity1_7EnterController", BaseController)

function VersionActivity1_7EnterController:onInit()
	return
end

function VersionActivity1_7EnterController:reInit()
	return
end

function VersionActivity1_7EnterController:openVersionActivityEnterViewIfNotOpened(openedCallback, openedCallbackObj, jumpActId)
	if ViewMgr.instance:isOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		if openedCallback then
			openedCallback(openedCallbackObj)
		end

		return
	end

	self:openVersionActivityEnterView(openedCallback, openedCallbackObj, jumpActId)
end

function VersionActivity1_7EnterController:openVersionActivityEnterView(openedCallback, openedCallbackObj, jumpActId)
	if not self:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	self:_openVersionActivityEnterView(openedCallback, openedCallbackObj, jumpActId)
end

function VersionActivity1_7EnterController:_onFinishStory()
	if not self:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	self:_openVersionActivityEnterView(self.openCallback, self.openedCallbackObj, self.jumpActId)
end

function VersionActivity1_7EnterController:_openVersionActivityEnterView(openedCallback, openedCallbackObj, jumpActId)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_7Enum.ActivityId.EnterView) then
		local activityMo = ActivityModel.instance:getActMO(VersionActivity1_7Enum.ActivityId.EnterView)

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
				self.openCallback = openedCallback
				self.openedCallbackObj = openedCallbackObj
				self.jumpActId = jumpActId

				StoryController.instance:playStory(storyId, param, self._onFinishStory, self)

				return
			end
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_7EnterView, {
		actId = VersionActivity1_7Enum.ActivityId.EnterView,
		activityIdList = VersionActivity1_7Enum.EnterViewActIdList,
		jumpActId = jumpActId
	})

	if openedCallback then
		openedCallback(openedCallbackObj)
	end
end

function VersionActivity1_7EnterController:directOpenVersionActivityEnterView(jumpActId)
	if not self:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_7EnterView, {
		skipOpenAnim = true,
		actId = VersionActivity1_7Enum.ActivityId.EnterView,
		activityIdList = VersionActivity1_7Enum.EnterViewActIdList,
		jumpActId = jumpActId
	})
end

function VersionActivity1_7EnterController:checkCanOpen(actId)
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return false
	end

	return true
end

function VersionActivity1_7EnterController.GetActivityPrefsKey(key)
	return VersionActivity1_7Enum.ActivityId.EnterView .. key
end

function VersionActivity1_7EnterController.GetActivityPrefsKeyWithUser(key)
	return PlayerModel.instance:getPlayerPrefsKey(VersionActivity1_7EnterController.GetActivityPrefsKey(key))
end

VersionActivity1_7EnterController.instance = VersionActivity1_7EnterController.New()

return VersionActivity1_7EnterController
