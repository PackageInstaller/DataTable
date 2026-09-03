-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpvp/service/RTPVPAgent.lua

require("dm.base.net.network_errno")

RTPVPAgent = class("RTPVPAgent", legs.Actor, _M)

RTPVPAgent:has("_client", {
	is = "r"
})
RTPVPAgent:has("_view", {
	is = "r"
})
RTPVPAgent:has("_encrypt", {
	is = "r"
})
RTPVPAgent:has("_netVersion", {
	is = "r"
})
RTPVPAgent:has("_config", {
	is = "r"
})
RTPVPAgent:has("_waitingHandler", {
	is = "rw"
})
RTPVPAgent:has("_waitingManager", {
	is = "rw"
}):injectWith("WaitingManager")

EVT_RTPVP_CONN_FAIL = "EVT_RTPVP_CONN_FAIL"
EVT_RTPVP_CONN_ERROR = "EVT_RTPVP_CONN_ERROR"
EVT_RTPVP_CONN_SUCC = "EVT_RTPVP_CONN_SUCC"
EVT_RTPVP_REQ_ERROR = "EVT_RTPVP_REQ_ERROR"

local libCjson = require("cjson.safe")
local MAX_REPAIR_COUNT = 4

function RTPVPAgent:_assertConfig(config)
	assert(type(config.heartbeat) == "number", "heartbeat must be number, but: " .. tostring(config.heartbeat))
	assert(type(config.hbTimeout) == "number", "hbTimeout must be number, but: " .. tostring(config.hbTimeout))
	assert(type(config.rtoFloor) == "number", "rto floor must be number, but: " .. tostring(config.rtoFloor))
	assert(type(config.rtoCeil) == "number", "rto ceil be number, but: " .. tostring(config.rtoCeil))
	assert(type(config.reqTimeout) == "number", "reqTimeout must be number, but: " .. tostring(config.reqTimeout))
	assert(type(config.encrypt) == "number", "encrypt must be number, but: " .. tostring(config.encrypt))
end

function RTPVPAgent:_assertRequest(request)
	assert(type(config.opType) == "number", "opType must be number")
	assert(type(config.compressionType) == "number", "compressionType must be number")
	assert(type(config.params) == "number", "params must be table")
end

function RTPVPAgent:_sendEvent(evt, data)
	self:dispatch(Event:new(evt, data))
end

function RTPVPAgent:initialize()
	super.initialize(self)

	self._client = self:createClient()

	self:initClient()
end

function RTPVPAgent:createClient()
	local client = rrcp.createClient()

	client.listener = self

	return client
end

function RTPVPAgent:initClient()
	local config = {
		rtoCeil = 5000,
		rtoFloor = 2000,
		hbTimeout = 1600000,
		encrypt = 0,
		netVersion = 0,
		heartbeat = 15000,
		reqTimeout = 10000
	}

	self:_assertConfig(config)

	self._config = config
	self._encrypt = config.encrypt
	self._netVersion = config.netVersion
	self._pushHandlers = {}
	self._isConnected = false
	self._tryRepairCount = 0
end

function RTPVPAgent:registerPushHandler(opType, func)
	self._pushHandlers[opType] = func
end

function RTPVPAgent:dispose()
	if self._waitingHandler then
		self._waitingManager:dispose()

		self._waitingManager = nil
	end

	super.dispose(self)
end

function RTPVPAgent:closeConnect()
	if self._client then
		self._client:close()

		self._isConnected = false
	end
end

function RTPVPAgent:disconnect()
	if self._waitingHandler then
		self._waitingManager:unregister(self._waitingHandler)
	end

	self:closeConnect()
end

function RTPVPAgent:connect(ip, port)
	assert(type(ip) == "string", "ip must be string, but: " .. tostring(ip))
	assert(type(port) == "number", "port must be number, but: " .. tostring(port))
	self:closeConnect()

	if self._waitingHandler == nil then
		self._waitingHandler = self:getInjector():instantiate("RTPVPServerWaitingHandler")
	end

	self._waitingManager:register(self._waitingHandler, WaitingHandlerPriority.kRTPVPServer)

	if self._client.connect(ip, port, 5000) then
		self._waitingHandler:handleWaitingEvent(WaitingEvent.kConnect)

		return true
	else
		return false
	end
end

function RTPVPAgent:onConnected(client, firstConnect)
	self._tryRepairCount = 0
	self._isConnected = true

	self._waitingHandler:handleWaitingEvent(WaitingEvent.kConnectSucc)
	client.setHeartbeatInterval(self._config.heartbeat)
	client.setHeartbeatTimeout(self._config.hbTimeout)
	client.setReqRTOBounds(self._config.rtoFloor, self._config.rtoCeil)
	client.setReqTimeout(self._config.reqTimeout)

	if firstConnect then
		self:_sendEvent(EVT_RTPVP_CONN_SUCC)
	end
end

function RTPVPAgent:sendNetErrorLog(data)
	data = data or {}
	data.type = "rtpvpneterror"

	StatisticSystem:record(LogType.kClient, data)
end

function RTPVPAgent:onError(client, errCode, detail)
	cclog("rtpvpagent_onerror:" .. errCode)

	if not self._isConnected then
		self:onConnectFailed(client, errCode, detail)
		self:sendNetErrorLog({
			errCode = errCode,
			detail = detail
		})

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
			self:_sendEvent(EVT_RTPVP_CONN_ERROR)
		end, {
			errCode = errCode,
			detail = detail
		})
	end
end

function RTPVPAgent:onConnectFailed(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kConnectErr, nil, {
		errCode = errCode,
		detail = detail
	})
	self:_sendEvent(EVT_RTPVP_CONN_FAIL)
end

function RTPVPAgent:onServerClosed(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kUnrepairableErr, function()
		self:_sendEvent(EVT_RTPVP_CONN_ERROR)
	end, {
		errCode = errCode,
		detail = detail
	})
end

function RTPVPAgent:onConnectReset(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kUnrepairableErr, function()
		self:_sendEvent(EVT_RTPVP_CONN_ERROR)
	end, {
		errCode = errCode,
		detail = detail
	})
end

function RTPVPAgent:onInactive(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kRepairableErr, function()
		self:tryRepairConnect(client)
	end, {
		errCode = errCode,
		detail = detail
	})
end

function RTPVPAgent:onConnectBroken(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kRepairableErr, function()
		self:tryRepairConnect(client)
	end, {
		errCode = errCode,
		detail = detail
	})
end

function RTPVPAgent:onRepairFailed(client, errCode, detail)
	if detail == neterrno.ETIMEDOUT or detail == neterrno.ENETUNREACH then
		self._waitingHandler:handleWaitingEvent(WaitingEvent.kRepairableErr, function()
			self:tryRepairConnect(client)
		end, {
			errCode = errCode,
			detail = detail
		})
	else
		self._waitingHandler:handleWaitingEvent(WaitingEvent.kUnrepairableErr, function()
			self:_sendEvent(EVT_RTPVP_CONN_ERROR)
		end, {
			errCode = errCode,
			detail = detail
		})
	end
end

function RTPVPAgent:onRequestTimeout(client, errCode, detail)
	self._waitingHandler:handleWaitingEvent(WaitingEvent.kRepairableErr, function()
		self:tryRepairConnect(client)
	end, {
		errCode = errCode,
		detail = detail
	})
end

function RTPVPAgent:tryRepairConnect(client)
	self._tryRepairCount = self._tryRepairCount + 1

	if self._tryRepairCount > MAX_REPAIR_COUNT then
		self:_sendEvent(EVT_RTPVP_CONN_ERROR)
	else
		client.repair(false)
	end
end

function RTPVPAgent:sendRequest(rid, opType, params, callback)
	local reqParams = string.char(self._netVersion, string.len(rid)) .. rid .. libCjson.encode(params)

	local function requestCallback(req, err, resp)
		if err == rrcp.ERR_NO_ERROR then
			local response, info = libCjson.decode(resp)

			if response == nil then
				dump(resp, "respnil")

				return
			end

			if callback then
				callback(response)
			end
		else
			self:_sendEvent(EVT_RTPVP_REQ_ERROR, {
				err = err,
				resp = resp
			})
		end
	end

	self._client.request(opType, self._encrypt, reqParams, requestCallback)
end

function RTPVPAgent:onRequested(client, reqid, method, params)
	local data = libCjson.decode(params)

	self._pushHandlers[method](data)
	client.respond(reqid, 0, 0, "{}")
end

function RTPVPAgent:onNotified(client, opType, rawdata)
	local data = libCjson.decode(rawdata)

	self._pushHandlers[opType](data)
end

function RTPVPAgent:getNetDelay()
	return self._client:getAvgReqDelay()
end
