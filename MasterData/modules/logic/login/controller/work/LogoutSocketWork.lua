-- chunkname: @modules/logic/login/controller/work/LogoutSocketWork.lua

module("modules.logic.login.controller.work.LogoutSocketWork", package.seeall)

local LogoutSocketWork = class("LogoutSocketWork", BaseWork)

function LogoutSocketWork:ctor()
	return
end

function LogoutSocketWork:onStart(context)
	if context.isConnected then
		-- block empty
	end

	ConnectAliveMgr.instance:logout()
	self:onDone(true)
end

return LogoutSocketWork
