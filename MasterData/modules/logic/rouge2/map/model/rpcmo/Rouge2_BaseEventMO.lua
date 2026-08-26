-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_BaseEventMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_BaseEventMO", package.seeall)

local Rouge2_BaseEventMO = pureTable("Rouge2_BaseEventMO")

function Rouge2_BaseEventMO:init(eventCo, data)
	self.eventCo = eventCo
	self.jsonData = cjson.decode(data)
	self.state = self.jsonData.state
	self.eventId = self.jsonData.eventId
	self.type = self.jsonData.type
	self.fightFail = self.jsonData.fightFail
end

function Rouge2_BaseEventMO:update(eventCo, data)
	self.eventCo = eventCo
	self.jsonData = cjson.decode(data)
	self.eventId = self.jsonData.eventId
	self.type = self.jsonData.type
	self.fightFail = self.jsonData.fightFail

	if self.state ~= self.jsonData.state then
		self.state = self.jsonData.state

		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onNodeEventStatusChange, self.eventId, self.state)
	end
end

function Rouge2_BaseEventMO:__tostring()
	return string.format("eventId : %s, jsonData : %s, state : %s, type : %s, fightFail : %s", self.eventId, cjson.encode(self.jsonData), self.state, self.type, self.fightFail)
end

return Rouge2_BaseEventMO
