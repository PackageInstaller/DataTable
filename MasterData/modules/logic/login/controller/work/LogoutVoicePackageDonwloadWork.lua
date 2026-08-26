-- chunkname: @modules/logic/login/controller/work/LogoutVoicePackageDonwloadWork.lua

module("modules.logic.login.controller.work.LogoutVoicePackageDonwloadWork", package.seeall)

local LogoutVoicePackageDonwloadWork = class("LogoutVoicePackageDonwloadWork", BaseWork)

function LogoutVoicePackageDonwloadWork:ctor()
	return
end

function LogoutVoicePackageDonwloadWork:onStart(context)
	if context.isVoicePackageDonwload then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
		SettingsVoicePackageController.instance:initData(self.onVoicePackageLoadDone, self)
	else
		self:onDone(true)
	end
end

function LogoutVoicePackageDonwloadWork:onVoicePackageLoadDone()
	self:onDone(true)
end

return LogoutVoicePackageDonwloadWork
