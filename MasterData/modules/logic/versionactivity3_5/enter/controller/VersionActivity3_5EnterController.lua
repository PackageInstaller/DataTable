-- chunkname: @modules/logic/versionactivity3_5/enter/controller/VersionActivity3_5EnterController.lua

module("modules.logic.versionactivity3_5.enter.controller.VersionActivity3_5EnterController", package.seeall)

local VersionActivity3_5EnterController = class("VersionActivity3_5EnterController", VersionActivityFixedEnterController)

function VersionActivity3_5EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = VersionActivity3_5Enum.ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivity3_5Enum.EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = VersionActivity3_5Enum.EnterViewActSetting
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView

		if TimeUtil.getDayFirstLoginRed(VersionActivity3_5Enum.EnterVideoDayKey) then
			viewParams.playVideo = true
		end
	end

	local viewName = ViewName.VersionActivity3_5EnterView

	self._internalOpenView(self, viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
end

VersionActivity3_5EnterController.instance = VersionActivity3_5EnterController.New()

return VersionActivity3_5EnterController
