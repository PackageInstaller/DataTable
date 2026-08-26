-- chunkname: @modules/logic/versionactivity3_6/enter/controller/VersionActivity3_6EnterController.lua

module("modules.logic.versionactivity3_6.enter.controller.VersionActivity3_6EnterController", package.seeall)

local VersionActivity3_6EnterController = class("VersionActivity3_6EnterController", VersionActivityFixedEnterController)

function VersionActivity3_6EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen, isExitFight)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = VersionActivity3_6Enum.ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivity3_6Enum.EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = VersionActivity3_6Enum.EnterViewActSetting,
		isExitFight = isExitFight
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView

		if TimeUtil.getDayFirstLoginRed(VersionActivity3_6Enum.EnterVideoDayKey) then
			viewParams.playVideo = true
		end
	end

	local viewName = ViewName.VersionActivity3_6EnterView

	self._internalOpenView(self, viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
end

VersionActivity3_6EnterController.instance = VersionActivity3_6EnterController.New()

return VersionActivity3_6EnterController
