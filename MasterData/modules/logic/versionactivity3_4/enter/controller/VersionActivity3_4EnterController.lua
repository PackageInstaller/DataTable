-- chunkname: @modules/logic/versionactivity3_4/enter/controller/VersionActivity3_4EnterController.lua

module("modules.logic.versionactivity3_4.enter.controller.VersionActivity3_4EnterController", package.seeall)

local VersionActivity3_4EnterController = class("VersionActivity3_4EnterController", VersionActivityFixedEnterController)

function VersionActivity3_4EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = VersionActivity3_4Enum.ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivity3_4Enum.EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = VersionActivity3_4Enum.EnterViewActSetting
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView

		if TimeUtil.getDayFirstLoginRed(VersionActivity3_4Enum.EnterVideoDayKey) then
			viewParams.playVideo = true
		end
	end

	local viewName = ViewName.VersionActivity3_4EnterView

	self._internalOpenView(self, viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
	PartyMatchRpc.instance:sendTriggerPartyResultRequest()
end

VersionActivity3_4EnterController.instance = VersionActivity3_4EnterController.New()

return VersionActivity3_4EnterController
