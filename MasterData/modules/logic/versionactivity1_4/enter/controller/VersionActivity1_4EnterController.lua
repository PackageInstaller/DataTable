-- chunkname: @modules/logic/versionactivity1_4/enter/controller/VersionActivity1_4EnterController.lua

module("modules.logic.versionactivity1_4.enter.controller.VersionActivity1_4EnterController", package.seeall)

local VersionActivity1_4EnterController = class("VersionActivity1_4EnterController", BaseController)

function VersionActivity1_4EnterController:onInit()
	self.actId = VersionActivity1_4Enum.ActivityId.EnterView
end

function VersionActivity1_4EnterController:reInit()
	return
end

function VersionActivity1_4EnterController:openVersionActivityEnterViewIfNotOpened(openedCallback, openedCallbackObj)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_4EnterView) then
		if openedCallback then
			openedCallback(openedCallbackObj)
		end

		return
	end

	self:openVersionActivityEnterView(openedCallback, openedCallbackObj)
end

function VersionActivity1_4EnterController:openVersionActivityEnterView(openedCallback, openedCallbackObj)
	self.openedCallback = openedCallback
	self.openedCallbackObj = openedCallbackObj

	VersionActivityBaseController.instance:enterVersionActivityView(ViewName.VersionActivity1_4EnterView, self.actId, self._openVersionActivityEnterView, self)
end

function VersionActivity1_4EnterController:_onFinishStory()
	local status = ActivityHelper.getActivityStatus(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	self:_openVersionActivityEnterView()
end

function VersionActivity1_4EnterController:_openVersionActivityEnterView()
	local actCo = ActivityConfig.instance:getActivityCo(self.actId)
	local storyId = actCo and actCo.storyId

	if storyId and storyId > 0 and not StoryModel.instance:isStoryFinished(actCo.storyId) then
		StoryController.instance:playStory(storyId, {
			isVersionActivityPV = true
		}, self._onFinishStory, self)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_4EnterView, {
		actId = self.actId,
		activityIdList = VersionActivity1_4Enum.EnterViewActIdList
	})

	if self.openedCallback then
		self.openedCallback(self.openedCallbackObj)

		self.openedCallback = nil
		self.openedCallbackObj = nil
	end
end

function VersionActivity1_4EnterController:directOpenVersionActivityEnterView()
	VersionActivityBaseController.instance:enterVersionActivityView(ViewName.VersionActivity1_4EnterView, self.actId, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_4EnterView, {
			skipOpenAnim = true,
			actId = self.actId,
			activityIdList = VersionActivity1_4Enum.EnterViewActIdList
		})
	end, self)
end

VersionActivity1_4EnterController.instance = VersionActivity1_4EnterController.New()

return VersionActivity1_4EnterController
