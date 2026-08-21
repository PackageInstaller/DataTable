-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/starter/reconnection/INetReconnectionListener.lua

module("logic.starter.reconnection.INetReconnectionListener", package.seeall)

local M = class("INetReconnectionListener")

function M:onLoginFinished(isSuccess, isReconnecting, status)
	return
end

function M:onNetConnected(isSuccess, isReconnecting)
	return
end

function M:onNetDisconnected(isReconnecting)
	return
end

function M:onBlockCountChanged(blockCount)
	return
end

function M:onReconnectStarted()
	return
end

function M:onReconnectSucceeded()
	return
end

function M:onReconnectTimeout()
	return
end

function M:onReconnectCanceled(status)
	return
end

return M
