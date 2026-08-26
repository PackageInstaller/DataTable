-- chunkname: @modules/logic/login/rpc/LoginRpc.lua

module("modules.logic.login.rpc.LoginRpc", package.seeall)

local LoginRpc = class("LoginRpc", BaseRpc)

function LoginRpc:onInit()
	return
end

function LoginRpc:reInit()
	return
end

LoginRpc.instance = LoginRpc.New()

return LoginRpc
