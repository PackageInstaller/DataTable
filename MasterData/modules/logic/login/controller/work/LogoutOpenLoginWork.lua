-- chunkname: @modules/logic/login/controller/work/LogoutOpenLoginWork.lua

module("modules.logic.login.controller.work.LogoutOpenLoginWork", package.seeall)

local LogoutOpenLoginWork = class("LogoutOpenLoginWork", BaseWork)

function LogoutOpenLoginWork:ctor()
	return
end

function LogoutOpenLoginWork:onStart(context)
	LoginController.instance:login({
		userManualLogout = true,
		isModuleLogout = true,
		isSdkLogout = context.isSdkLogout
	})
	self:onDone(true)
end

return LogoutOpenLoginWork
