-- chunkname: @modules/logic/login/controller/work/LoginIngoreSomeCmdLog.lua

module("modules.logic.login.controller.work.LoginIngoreSomeCmdLog", package.seeall)

local LoginIngoreSomeCmdLog = class("LoginIngoreSomeCmdLog", BaseWork)

function LoginIngoreSomeCmdLog:onStart(context)
	LuaSocketMgr.instance:setIgnoreSomeCmdLog({
		"BeginRoundReply"
	})
	self:onDone(true)
end

function LoginIngoreSomeCmdLog:clearWork()
	return
end

return LoginIngoreSomeCmdLog
