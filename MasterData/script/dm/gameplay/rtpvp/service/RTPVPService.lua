-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpvp/service/RTPVPService.lua

RTPVPService = class("RTPVPService", legs.Actor)

RTPVPService:has("_agent", {
	is = "rw"
}):injectWith("RTPVPAgent")

local OPTYPE_FUNC = {
	[2003] = "frameEvent",
	[2001] = "matchSucc",
	[2004] = "battleFinish",
	[2005] = "displayEmoji"
}

function RTPVPService:initialize()
	super.initialize(self)
end

function RTPVPService:userInject(injector)
	return
end

function RTPVPService:setAgent(agent)
	self._agent = agent

	self:registerHandlers()
end

function RTPVPService:registerHandlers()
	for opType, func in pairs(OPTYPE_FUNC) do
		self._agent:registerPushHandler(opType, bind1(self[OPTYPE_FUNC[opType]], self))
	end
end

function RTPVPService:_sendEvent(evt, data)
	self:dispatch(Event:new(evt, data))
end

function RTPVPService:_request(opType, params, callback)
	DpsLogger:info("rtpvp", "opType: {}", opType)
	DpsLogger:info("rtpvp", "params: {}", params)

	local function reqCallback(resp)
		DpsLogger:info("rtpvp", "resp: {}", resp)

		if resp.resCode == 1 then
			self:battleFinish({
				resultData = {
					reason = "disconnect"
				}
			})
		end

		if callback then
			callback(resp)
		end
	end

	self._agent:sendRequest(self:fetchRid(), opType, params, reqCallback)
end

function RTPVPService:fetchRid()
	local developSystem = self:getInjector():getInstance(DevelopSystem)

	self._rid = developSystem:getPlayer():getRid()

	return self._rid
end

function RTPVPService:confirm(frame, info)
	self:_request(1000, {
		frame = frame,
		info = info
	})
end

function RTPVPService:join(battleData, roomId, type, seasonId)
	self:_request(1001, {
		team = battleData,
		roomId = roomId,
		type = type,
		seasonId = seasonId
	})
end

function RTPVPService:leave()
	self:_request(1002, {})
end

function RTPVPService:ready()
	self:_request(1004, {})
end

function RTPVPService:operate(data, callback)
	data.player = self:fetchRid()

	self:_request(1005, data, callback)
end

function RTPVPService:finish(data)
	self:_request(1006, data)
end

function RTPVPService:emoji(data)
	self:_request(1007, data)
end

function RTPVPService:matchSucc(data)
	self:_sendEvent(EVT_RTPVP_BATTLE_MATCH, data)
end

function RTPVPService:frameEvent(data)
	self:_sendEvent(EVT_RTPVP_BATTLE_FRAME, data)
end

function RTPVPService:battleFinish(data)
	self:disconnect()
	self:_sendEvent(EVT_RTPVP_BATTLE_RESULT, data)
end

function RTPVPService:displayEmoji(data)
	self:_sendEvent(EVT_RTPVP_BATTLE_EMOJI, data)
end

function RTPVPService:connect(battleServerIP, battleServerPort)
	self._agent:connect(battleServerIP, battleServerPort)
end

function RTPVPService:disconnect()
	self._agent:disconnect()
end

function RTPVPService:speedUp(newScale)
	self:_sendEvent(EVT_RTPVP_BATTLE_SPEEDUP, newScale)
end

function RTPVPService:stopTick()
	self:_sendEvent(EVT_RTPVP_BATTLE_STOPTICK)
end
