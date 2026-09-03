-- chunkname: @/tmp/or_script/lua_compile/dm/base/net/GameServerAgent.lua

require("dm.base.net.network_errno")

EVT_RECONNECTION_SUCC = "EVT_RECONNECTION_SUCC"
GameServerAgent = class("GameServerAgent", legs.Actor, _M)

GameServerAgent:has("_client", {
	is = "r"
})
GameServerAgent:has("_timeOffset", {
	is = "rw"
})
GameServerAgent:has("_waitingHandler", {
	is = "rw"
})
GameServerAgent:has("_waitingManager", {
	is = "rw"
}):injectWith("WaitingManager")

function GameServerAgent:initialize()
	super.initialize(self)

	self._client = self:createClient()
	self.__pushHandlers = {}
	self._timeOffset = 0
	self._isConnected = false
	self._tryRepairCount = 0
	self._alreadyAutoRepairOnce = false
end

function GameServerAgent:dispose()
	if self._waitingHandler then
		self._waitingHandler:dispose()

		self._waitingHandler = nil
	end

	super.dispose(self)
end

function GameServerAgent:createClient()
	local client = rrcp.createClient()

	client.listener = self

	return client
end

function GameServerAgent:closeConnect()
	if self._client then
		self._client:close()

		self._isConnected = false
	end
end

function GameServerAgent:connect(ip, port, callback)
	assert(type(ip) == "string", "ip must be string")
	assert(type(port) == "number", "port must be number")

	if self._waitingHandler == nil then
		self._waitingHandler = self:getInjector():instantiate("GameServerWaitingHandler")

		self._waitingManager:register(self._waitingHandler, WaitingHandlerPriority.kGameServer)
	end

	self._connectedCallback = callback

	if self:getClient().connect(ip, port, 5000) then
		self._waitingHandler:handleWaitingEvent(WaitingEvent.kConnect)

		return true
	else
		return false
	end
end

function GameServerAgent:onConnected(client, firstConnect)
	self._tryRepairCount = 0
	self._isConnected = true
	self._alreadyAutoRepairOnce = false

	self._waitingHandler:handleWaitingEvent(WaitingEvent.kConnectSucc)
	client.setHeartbeatInterval(15000)
	client.setHeartbeatTimeout(1600000)
	client.setReqRTOBounds(2000, 5000)
	client.setReqTimeout(10000)
	self:dispatch(Event:new(EVT_LOGIN_SUCC))

	if firstConnect and self._connectedCallback then
		self:_connectedCallback()
	else
		self:dispatch(Event:new(EVT_RECONNECTION_SUCC))
	end
end

function GameServerAgent:onRequested(client, reqid, method, params)
	return
end

function GameServerAgent:onError(client, errCode, detail)
	cclog("WaitingLog errCode:", errCode, detail)

	if not self._isConnected then
		self:onConnectFailed(client, errCode, detail)

		return
	end

	if (errCode == rrcp.REQ_TIMEDOUT or errCode == rrcp.CONNECT_BROKEN or errCode == rrcp.CONNECT_FAILED) and not self._alreadyAutoRepairOnce then
		self._alreadyAutoRepairOnce = true

		client.repair(false)

		return
	end

	if errCode == rrcp.REQ_TIMEDOUT then
		self:onRequestTimeout(client, errCode, detail)
	elseif errCode == rrcp.INACTIVE then
		self:onInactive(client, errCode, detail)
	elseif errCode == rrcp.CONNECT_BROKEN then
		self:onConnectBroken(client, errCode, detail)
	elseif errCode == rrcp.CONNECT_FAILED then
		self:onRepairFailed(client, errCode, detail)
	elseif errCode == rrcp.SERVER_CLOSED then
		self:onServerClosed(client, errCode, detail)
	elseif errCode == rrcp.CONNECT_RESET then
		self:onConnectReset(client, errCode, detail)
	else
		self._waitingHandler:handleWaitingEvent(WaitingEvent.kUnrepairableErr, function()
			REBOOT()
		end, {
			errCode = errCode,
			detail = detail
		})
		self:sendNetErrorLog({
			errCode = errCode,
			detail = detail
		})
	end
end

function GameServerAgent:tryRepairConnect(client)
	client = client or self._client

	client.repair(false)
end

function GameServerAgent:sendNetErrorLog(data)
	data = data or {}
	data.type = "neterror"

	StatisticSystem:record(LogType.kClient, data)
end

function GameServerAgent:onConnectFailed(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kConnectErr, nil, {
		errCode = errCode,
		detail = detail
	})
end

function GameServerAgent:onServerClosed(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kUnrepairableErr, function()
		self:dispose()
		REBOOT()
	end, {
		errCode = errCode,
		detail = detail
	})
	self:sendNetErrorLog({
		errCode = errCode,
		detail = detail
	})
end

function GameServerAgent:onConnectReset(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kUnrepairableErr, function()
		self:dispose()
		REBOOT()
	end, {
		errCode = errCode,
		detail = detail
	})
	self:sendNetErrorLog({
		errCode = errCode,
		detail = detail
	})
end

function GameServerAgent:onInactive(client, errCode, detail)
	return
end

function GameServerAgent:onConnectBroken(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kRepairableErr, function()
		client.repair(false)
	end, {
		errCode = errCode,
		detail = detail
	})
end

function GameServerAgent:onRepairFailed(client, errCode, detail)
	if detail == neterrno.ETIMEDOUT or detail == neterrno.ENETUNREACH then
		self._waitingHandler:handleWaitingEvent(WaitingEvent.kRepairableErr, function()
			client.repair(false)
		end, {
			errCode = errCode,
			detail = detail
		})
	else
		self._waitingHandler:handleWaitingEvent(WaitingEvent.kUnrepairableErr, function()
			REBOOT()
		end, {
			errCode = errCode,
			detail = detail
		})
		self:sendNetErrorLog({
			errCode = errCode,
			detail = detail
		})
	end
end

function GameServerAgent:onRequestTimeout(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kRepairableErr, function()
		client.repair(false)
	end, {
		errCode = errCode,
		detail = detail
	})
end

function GameServerAgent:onRequested(client, reqid, method, params)
	return
end

function GameServerAgent:onNotified(client, event, rawdata)
	local handler = self.__pushHandlers[event]

	if handler ~= nil then
		handler(event, rawdata)
	end
end

function GameServerAgent:onQueue(client, rawdata)
	local queueData = json.decode(rawdata)

	self:dispatch(Event:new(EVT_LOGIN_ONQUEUE, queueData))
end

function GameServerAgent:doRequest(request, blockUI)
	if blockUI then
		self._waitingHandler:handleWaitingEvent(WaitingEvent.kRequest)
	end

	local callback = request:getCallback()
	local t0 = 0

	if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 then
		t0 = app.getTimeInMilliseconds()
	end

	local function tempCallBack(...)
		if blockUI then
			self._waitingHandler:handleWaitingEvent(WaitingEvent.kRequestSucc)
		end

		if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 then
			local t1 = app.getTimeInMilliseconds()
			local totalTime = t1 - t0
			local optype = request:getOpType()
			local info = string.format("requestType:%s,totalTime:%d", optype, totalTime)
			local color = cc.c3b(0, 255, 0)

			if totalTime > 300 then
				color = cc.c3b(230, 219, 116)
			end

			self:dispatch(ShowStaticTipEvent({
				delay = 5,
				tip = info,
				color = (totalTime > 600 or nil) and cc.c3b(255, 0, 0)
			}))
		end

		callback(...)
	end

	local requestId = self:getClient().request(request:getOpType(), request:getCompressionType(), request:getParams(), tempCallBack)

	assert(requestId >= 0, string.format("a request exception occured (%d)", requestId))
end

function GameServerAgent:addPushHandler(op, handler)
	self.__pushHandlers[op] = handler
end

function GameServerAgent:remoteTimestamp()
	return self:remoteTimeMillis() / 1000
end

function GameServerAgent:remoteTimeMillis()
	return self._client:remoteTimeMillis() + self._timeOffset
end

function GameServerAgent:getNetDelay()
	return self._client:getAvgReqDelay()
end

GameServerRequest = class("GameServerRequest", _G.DisposableObject, _M)

GameServerRequest:has("_opType", {
	is = "rw"
})
GameServerRequest:has("_compressionType", {
	is = "rw"
})
GameServerRequest:has("_callback", {
	is = "rw"
})
GameServerRequest:has("_params", {
	is = "rw"
})

function GameServerRequest:initialize(optype, params, callback)
	super.initialize(self)
	self:setOpType(optype)
	self:setCompressionType(1)
	self:setParams(params)
	self:setCallback(callback)
end

function GameServerRequest:dispose()
	super.dispose(self)
end
