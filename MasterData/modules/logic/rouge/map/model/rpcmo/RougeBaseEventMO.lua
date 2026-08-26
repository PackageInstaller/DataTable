-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougeBaseEventMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougeBaseEventMO", package.seeall)

local RougeBaseEventMO = pureTable("RougeBaseEventMO")

function RougeBaseEventMO:init(eventCo, data)
	self.eventCo = eventCo
	self.jsonData = cjson.decode(data)
	self.state = self.jsonData.state
	self.eventId = self.jsonData.eventId
	self.type = self.jsonData.type
	self.fightFail = self.jsonData.fightFail
end

function RougeBaseEventMO:update(eventCo, data)
	self.eventCo = eventCo
	self.jsonData = cjson.decode(data)
	self.eventId = self.jsonData.eventId
	self.type = self.jsonData.type
	self.fightFail = self.jsonData.fightFail

	if self.state ~= self.jsonData.state then
		self.state = self.jsonData.state

		RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeEventStatusChange, self.eventId, self.state)
	end
end

function RougeBaseEventMO:__tostring()
	return string.format("eventId : %s, jsonData : %s, state : %s, type : %s, fightFail : %s", self.eventId, cjson.encode(self.jsonData), self.state, self.type, self.fightFail)
end

return RougeBaseEventMO
