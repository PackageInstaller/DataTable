-- chunkname: @modules/logic/common/obj/LuaKcpPingObjV2.lua

module("modules.logic.common.obj.LuaKcpPingObjV2", package.seeall)
require("tolua.reflection")
tolua.loadassembly("SL_AS")
tolua.loadassembly("PartyGame")

local Type_KcpSocketClient = tolua.findtype("System.Net.Sockets.Kcp.KcpSocketClient")
local Type_SocketMgr = tolua.findtype("SLFramework.SocketMgr")
local Type_ISocketClient = tolua.findtype("SLFramework.ISocketClient")
local Prop_SocketMgr_Instance = Type_SocketMgr and tolua.getproperty(Type_SocketMgr, "Instance")
local Method_SocketMgr_GetInstance = Type_SocketMgr and tolua.getmethod(Type_SocketMgr, "get_Instance")
local Method_GetSocketClient = Type_SocketMgr and tolua.getmethod(Type_SocketMgr, "GetSocketClient", typeof("System.Int32"))
local Method_GetOrCreateSocketClient = Type_SocketMgr and Type_ISocketClient and tolua.getmethod(Type_SocketMgr, "GetOrCreateSocketClient", typeof("System.Int32"), Type_ISocketClient)
local Method_SocketMgr_EndConnect = Type_SocketMgr and tolua.getmethod(Type_SocketMgr, "EndConnect", typeof("System.Int32"))
local Type_KcpSocketUtil = tolua.findtype("PartyGame.Runtime.Utils.KcpSocketUtil")
local Method_ConnectSocket = Type_KcpSocketUtil and tolua.getmethod(Type_KcpSocketUtil, "ConnectSocket", typeof("System.String"), typeof("System.Int32"))
local Type_GameObject = tolua.findtype("UnityEngine.GameObject")
local Method_GO_Find = Type_GameObject and tolua.getmethod(Type_GameObject, "Find", typeof("System.String"))
local Method_GO_GetComponent = Type_GameObject and tolua.getmethod(Type_GameObject, "GetComponent", typeof("System.Type"))
local Method_SetSocketId = Type_KcpSocketClient and tolua.getmethod(Type_KcpSocketClient, "SetSocketId", typeof("System.Int32"))
local Method_BeginConnect = Type_KcpSocketClient and tolua.getmethod(Type_KcpSocketClient, "BeginConnect", typeof("System.String"), typeof("System.Int32"))
local Method_EndConnect = Type_KcpSocketClient and tolua.getmethod(Type_KcpSocketClient, "EndConnect")
local Method_GetLatency = Type_KcpSocketClient and tolua.getmethod(Type_KcpSocketClient, "GetLatency")
local Prop_Status = Type_KcpSocketClient and tolua.getproperty(Type_KcpSocketClient, "Status") or Type_ISocketClient and tolua.getproperty(Type_ISocketClient, "Status")
local Method_GetStatus = Type_KcpSocketClient and tolua.getmethod(Type_KcpSocketClient, "get_Status") or Type_ISocketClient and tolua.getmethod(Type_ISocketClient, "get_Status")
local SocketId_PartyGame = 1
local SocketStatus_DisConnect = "Disconnected"
local SocketStatus_Connected = "Connected"
local kTimeoutFrameCount = 3000

local function _getSocketMgr()
	if Prop_SocketMgr_Instance then
		local mgr = Prop_SocketMgr_Instance:Get()

		if mgr then
			return mgr
		end
	end

	if Method_SocketMgr_GetInstance then
		local mgr = Method_SocketMgr_GetInstance:Call()

		if mgr then
			return mgr
		end
	end

	if Method_GO_Find and Method_GO_GetComponent and Type_SocketMgr then
		local ok, result = pcall(function()
			local go = Method_GO_Find:Call("SocketMgr")

			if go then
				return Method_GO_GetComponent:Call(go, Type_SocketMgr)
			end

			return nil
		end)

		if ok and result then
			return result
		end
	end

	return nil
end

local LuaKcpPingObjV2 = class("LuaKcpPingObjV2", UserDataDispose)

function LuaKcpPingObjV2:ctor(timeoutFrames)
	self:__onInit()

	self._timeoutFrameCount = timeoutFrames or kTimeoutFrameCount

	self:reset()
end

function LuaKcpPingObjV2:setCompletedCb(cb, cbObj)
	self._onCompletedCb = cb
	self._onCompletedCbObj = cbObj
end

function LuaKcpPingObjV2:setTimeoutCb(cb, cbObj)
	self._onTimeoutCb = cb
	self._onTimeoutCbObj = cbObj
end

function LuaKcpPingObjV2:setTimeoutFrames(timeoutFrames)
	self._timeoutFrameCount = timeoutFrames or kTimeoutFrameCount
end

function LuaKcpPingObjV2:reset(ip, port)
	self:_release()

	self._isValid = false
	self._ms = -1
	self._frameCount = 0
	self._port = port

	if string.nilorempty(ip) then
		return
	end

	if not port or not Type_KcpSocketClient or not Type_SocketMgr then
		return
	end

	self._ip = string.find(ip, "www") and SLFramework.UnityHelper.ParseDomainToIp(ip) or ip

	self:_startKcpPing()
end

function LuaKcpPingObjV2:_startKcpPing()
	if Method_ConnectSocket then
		Method_ConnectSocket:Call(self._ip, self._port)

		local socketMgr = _getSocketMgr()

		if socketMgr and Method_GetSocketClient then
			self._socketClient = Method_GetSocketClient:Call(socketMgr, SocketId_PartyGame)
		end

		if self._socketClient then
			self:_poll()

			return
		end
	end

	local socketMgr = _getSocketMgr()

	if not socketMgr then
		logError("LuaKcpPingObjV2: 无法获取 SocketMgr 实例")
		self:_onTimeout()

		return
	end

	if Method_GetSocketClient then
		local existingClient = Method_GetSocketClient:Call(socketMgr, SocketId_PartyGame)

		if existingClient then
			pcall(function()
				Method_EndConnect:Call(existingClient)
			end)

			self._socketClient = existingClient
		elseif Type_KcpSocketClient and Method_GetOrCreateSocketClient then
			local newClient = tolua.createinstance(Type_KcpSocketClient)

			self._socketClient = Method_GetOrCreateSocketClient:Call(socketMgr, SocketId_PartyGame, newClient)

			Method_SetSocketId:Call(self._socketClient, SocketId_PartyGame)
		else
			logError("LuaKcpPingObjV2: 无法创建 KcpSocketClient（Type_ISocketClient 不可用）")
			self:_onTimeout()

			return
		end

		local success = Method_BeginConnect:Call(self._socketClient, self._ip, self._port)

		if not success then
			self:_onTimeout()

			return
		end

		self:_poll()
	end
end

function LuaKcpPingObjV2:onDestroy()
	self:onDestroyView()
end

function LuaKcpPingObjV2:onDestroyView()
	self:setCompletedCb(nil, nil)
	self:setTimeoutCb(nil, nil)
	self:reset()
	self:__onDispose()
end

function LuaKcpPingObjV2:_release()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	if self._socketClient then
		local ok = pcall(function()
			Method_EndConnect:Call(self._socketClient)
		end)

		if not ok then
			local socketMgr = _getSocketMgr()

			if socketMgr and Method_SocketMgr_EndConnect then
				pcall(function()
					Method_SocketMgr_EndConnect:Call(socketMgr, SocketId_PartyGame)
				end)
			end
		end
	end

	self._socketClient = nil
end

function LuaKcpPingObjV2:_poll()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	self._fTimer = FrameTimerController.instance:register(self._onTickCheck, self, 1, 199999)

	self._fTimer:Start()
end

function LuaKcpPingObjV2:_onTickCheck()
	if not self._socketClient then
		self:_onTimeout()

		return
	end

	local statusRaw

	if Prop_Status then
		statusRaw = Prop_Status:Get(self._socketClient, nil)
	elseif Method_GetStatus then
		statusRaw = Method_GetStatus:Call(self._socketClient)
	end

	local status = tostring(statusRaw)

	if status == SocketStatus_Connected and self._frameCount > 200 then
		local latency = Method_GetLatency:Call(self._socketClient)

		self._ms = tonumber(tostring(latency))

		if self._ms < 0 then
			self._ms = -1
		end

		logNormal(string.format("KCP Ping %s:%d -> %d ms", self._ip, self._port, self._ms))
		self:_release()

		if self._ms >= 0 then
			self:_onPollDone()
		else
			self:_onTimeout()
		end
	elseif status == SocketStatus_DisConnect then
		self:_onTimeout()
	else
		self._frameCount = self._frameCount + 1

		if self._frameCount >= self._timeoutFrameCount then
			self:_onTimeout()
		end
	end
end

function LuaKcpPingObjV2:_onPollDone()
	if self._isValid then
		return
	end

	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	self._isValid = true

	self:_execCb(self._onCompletedCb, self._onCompletedCbObj)
end

function LuaKcpPingObjV2:_onTimeout()
	self._isValid = false

	self:_release()
	self:_execCb(self._onTimeoutCb, self._onTimeoutCbObj)
end

function LuaKcpPingObjV2:_execCb(cb, cbObj)
	if not cb then
		return
	end

	if cbObj then
		callWithCatch(cb, cbObj, self)
	else
		callWithCatch(cb, self)
	end
end

function LuaKcpPingObjV2:isValid()
	return self._isValid
end

function LuaKcpPingObjV2:ms()
	return (self._isValid or nil) and (self._ms or -1)
end

function LuaKcpPingObjV2:ip()
	return self._ip
end

return LuaKcpPingObjV2
