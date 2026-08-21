-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\WebSocket.lua

local WebSocketUtils = Framework.Network.WebSocketUtils
local WebSocket = Class("WebSocket")
local Event = {
	CONNECT_ERROR = 1,
	SEND_ERROR = 3,
	CONNECT_SUCCESS = 4,
	RECV_ERROR = 2
}

WebSocket.Event = Event

function WebSocket:ctor()
	self._slotEvent = Slot(WebSocket._onEvent, self)
	self._slotRecv = Slot(WebSocket._onRecv, self)
	self._slotSend = Slot(WebSocket._onSend, self)
	self._id = WebSocketUtils.Create(self._slotEvent, self._slotRecv, self._slotSend)
	self._sendCallbacks = {}
end

function WebSocket:destroy()
	WebSocketUtils.Destroy(self._id)
end

function WebSocket:setRecvCallback(func)
	self._recvCallback = func
end

function WebSocket:setConnectSuccessCB(func)
	self._connectSuccessCB = func
end

function WebSocket:connect(url)
	if VersionUtils.hasAbilityUrlGroup() then
		WebSocketUtils.Connect(self._id, url)
	else
		WebSocketUtils.Connect(self._id, url:Get())
	end
end

function WebSocket:cancel()
	WebSocketUtils.Cancel(self._id)
end

function WebSocket:resetConnectTime(...)
	WebSocketUtils.ResetConnectTime(self._id)
end

function WebSocket:send(bytes, callback)
	local reqID = WebSocketUtils.Send(self._id, bytes)

	self._sendCallbacks[reqID] = callback
end

function WebSocket:setHeader(name, value)
	WebSocketUtils.SetHeader(self._id, name, value)
end

function WebSocket:isConnected()
	return WebSocketUtils.IsConnected(self._id)
end

function WebSocket:_onRecv(bytes)
	if self._recvCallback then
		self._recvCallback(bytes)
	end
end

function WebSocket:_onEvent(eventID, data)
	if eventID == Event.CONNECT_SUCCESS and self._connectSuccessCB then
		self._connectSuccessCB()
	end
end

function WebSocket:_onSend(reqID, succ)
	local callback = self._sendCallbacks[reqID]

	if callback then
		self._sendCallbacks[reqID] = nil

		callback(succ)
	end
end

return WebSocket
