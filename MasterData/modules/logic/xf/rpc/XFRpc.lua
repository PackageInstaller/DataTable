-- chunkname: @modules/logic/xf/rpc/XFRpc.lua

module("modules.logic.xf.rpc.XFRpc", package.seeall)

local XFRpc = class("XFRpc", BaseRpc)

function XFRpc:onReceiveGuestTimeOutPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SDKMgr.instance:showVistorPlayTimeOutDialog()
end

function XFRpc:onReceiveMinorPlayTimeOutPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local timeOutHour = msg.timeOutHour / 60
	local str = string.format("%.1f", timeOutHour)

	SDKMgr.instance:showMinorPlayTimeOutDialog(str)
end

function XFRpc:onReceiveMinorLimitLoginTimePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local isLogin = msg.isLogin

	if isLogin then
		SDKMgr.instance:showMinorLimitLoginTimeDialog()
	else
		SDKMgr.instance:showMinorPlayTimeOutDialog()
	end
end

XFRpc.instance = XFRpc.New()

return XFRpc
