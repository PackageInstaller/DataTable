-- chunkname: @modules/logic/versionactivity3_9/enter/controller/VersionActivity3_9EnterController.lua

module("modules.logic.versionactivity3_9.enter.controller.VersionActivity3_9EnterController", package.seeall)

local VersionActivity3_9EnterController = class("VersionActivity3_9EnterController", VersionActivityFixedEnterController)

function VersionActivity3_9EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = VersionActivity3_9Enum.ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivity3_9Enum.EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = VersionActivity3_9Enum.EnterViewActSetting
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView

		if TimeUtil.getDayFirstLoginRed(VersionActivity3_9Enum.EnterVideoDayKey) then
			viewParams.playVideo = true
		end
	end

	local viewName = ViewName.VersionActivity3_9EnterView

	self._internalOpenView(self, viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
	PartyMatchRpc.instance:sendTriggerPartyResultRequest()
end

VersionActivity3_9EnterController.instance = VersionActivity3_9EnterController.New()

return VersionActivity3_9EnterController
