-- chunkname: @modules/logic/versionactivity3_2/enter/controller/VersionActivity3_2EnterController.lua

module("modules.logic.versionactivity3_2.enter.controller.VersionActivity3_2EnterController", package.seeall)

local VersionActivity3_2EnterController = class("VersionActivity3_2EnterController", VersionActivityFixedEnterController)

function VersionActivity3_2EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = VersionActivity3_2Enum.ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivity3_2Enum.EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = VersionActivity3_2Enum.EnterViewActSetting
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView

		if TimeUtil.getDayFirstLoginRed(VersionActivity3_2Enum.EnterVideoDayKey) then
			viewParams.playVideo = true
		end
	end

	local viewName = ViewName.VersionActivity3_2EnterView

	self._internalOpenView(self, viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
end

VersionActivity3_2EnterController.instance = VersionActivity3_2EnterController.New()

return VersionActivity3_2EnterController
