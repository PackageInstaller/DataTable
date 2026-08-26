-- chunkname: @modules/logic/versionactivity3_1/enter/controller/VersionActivity3_1EnterController.lua

module("modules.logic.versionactivity3_1.enter.controller.VersionActivity3_1EnterController", package.seeall)

local VersionActivity3_1EnterController = class("VersionActivity3_1EnterController", VersionActivityFixedEnterController)

function VersionActivity3_1EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen, isExitFight)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = VersionActivity3_1Enum.ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivity3_1Enum.EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = VersionActivity3_1Enum.EnterViewActSetting,
		isExitFight = isExitFight
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView

		if TimeUtil.getDayFirstLoginRed(VersionActivity3_1Enum.EnterVideoDayKey) and (not jumpActId or jumpActId == VersionActivity3_1Enum.ActivityId.Dungeon) then
			viewParams.playVideo = true
		end
	end

	local viewName = ViewName.VersionActivity3_1EnterView

	self._internalOpenView(self, viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
end

VersionActivity3_1EnterController.instance = VersionActivity3_1EnterController.New()

return VersionActivity3_1EnterController
