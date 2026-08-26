-- chunkname: @modules/versionactivitybase/mainfixed/VersionActivityMainFixedEnterController.lua

module("modules.versionactivitybase.mainfixed.VersionActivityMainFixedEnterController", package.seeall)

local VersionActivityMainFixedEnterController = class("VersionActivityMainFixedEnterController", BaseController)

function VersionActivityMainFixedEnterController:_internalOpenView(viewName, actId, customerOpenFunc, customerOpenFuncObj, viewParams, openCb, openCbObj)
	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	if customerOpenFunc then
		customerOpenFunc(customerOpenFuncObj, viewName, actId, viewParams)
	else
		ViewMgr.instance:openView(viewName, viewParams)

		if openCb then
			openCb(openCbObj)
		end
	end
end

function VersionActivityMainFixedEnterController:_internalOpenEnterView(viewName, actId, viewParams)
	local hasPlayedVideo = VersionActivityBaseController.instance:isPlayedActivityVideo(actId)

	if hasPlayedVideo then
		ViewMgr.instance:openView(viewName, viewParams)

		if self.openEnterViewCb then
			self.openEnterViewCb(self.openEnterViewCbObj)

			self.openEnterViewCb = nil
			self.openEnterViewCbObj = nil
		end
	else
		local activityMo = ActivityModel.instance:getActMO(actId)

		if activityMo then
			::label_2_0::

			local var_2_0 = activityMo.config

			if activityMo.config then
				local storyId = activityMo.config.storyId

				if not storyId then
					storyId = 100010

					logError(string.format("act id %s dot config story id", 100010))
				end

				local storyParam = {
					isVersionActivityPV = true
				}
				local storyFinishParams = {
					actId = actId,
					viewName = viewName,
					viewParams = viewParams
				}

				StoryController.instance:playStory(storyId, storyParam, self._onFinishEnterStory, self, storyFinishParams)
			end
		end
	end
end

function VersionActivityMainFixedEnterController:_onFinishEnterStory(storyFinishParams)
	local enterViewActId = storyFinishParams.actId

	if not VersionActivityEnterHelper.checkCanOpen(enterViewActId) then
		return
	end

	self:_internalOpenEnterView(storyFinishParams.viewName, enterViewActId, storyFinishParams.viewParams)
end

function VersionActivityMainFixedEnterController:openVersionActivityEnterViewIfNotOpened(openCb, openCbObj, jumpActId, isDirectOpen)
	if ViewMgr.instance:isOpen(ViewName[VersionActivityMainFixedHelper.getVersionActivityEnterViewName()]) then
		if openCb then
			openCb(openCbObj)
		end
	else
		self:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen)
	end
end

function VersionActivityMainFixedEnterController:directOpenVersionActivityEnterView(jumpActId)
	self:openVersionActivityEnterView(nil, nil, jumpActId, true)
end

function VersionActivityMainFixedEnterController:exitFightEnterView(jumpActId)
	self:openVersionActivityEnterView(nil, nil, jumpActId, true, true)
end

function VersionActivityMainFixedEnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen, isExitFight)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local versionActivityEnum = VersionActivityMainFixedHelper.getVersionActivityEnum()
	local actId = versionActivityEnum.ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(versionActivityEnum.EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = versionActivityEnum.EnterViewActSetting
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView

		if (not jumpActId or jumpActId == versionActivityEnum.ActivityId.Dungeon) and TimeUtil.getDayFirstLoginRed(versionActivityEnum.EnterVideoDayKey) then
			viewParams.playVideo = true
		end
	end

	local viewName = ViewName[VersionActivityMainFixedHelper.getVersionActivityEnterViewName()]

	self._internalOpenView(self, viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
end

VersionActivityMainFixedEnterController.instance = VersionActivityMainFixedEnterController.New()

return VersionActivityMainFixedEnterController
