-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueEventMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueEventMO", package.seeall)

local RogueEventMO = pureTable("RogueEventMO")

function RogueEventMO:init(info)
	self.eventId = info.eventId
	self.status = info.status
	self.eventData = info.eventData
	self.option = info.option
	self._eventJsonData = nil
end

function RogueEventMO:getEventCo()
	self.co = self.co or lua_rogue_event.configDict[self.eventId]

	return self.co
end

function RogueEventMO:getBattleData()
	local eventCo = self:getEventCo()

	if not eventCo or eventCo.type ~= V1a6_CachotEnum.EventType.Battle then
		return
	end

	return self:_getJsonData()
end

function RogueEventMO:_getJsonData()
	self._eventJsonData = self._eventJsonData or string.nilorempty(self.eventData) and {} or cjson.decode(self.eventData)

	return self._eventJsonData
end

function RogueEventMO:isBattleSuccess()
	local battleData = self:getBattleData()

	if not battleData then
		return false
	end

	return battleData.status == 1
end

function RogueEventMO:getRetries()
	local battleData = self:getBattleData()

	if not battleData then
		return 0
	end

	return battleData.retries or 0
end

function RogueEventMO:getDropList()
	if self.status == V1a6_CachotEnum.EventStatus.Finish then
		return
	end

	local jsonData = self:_getJsonData()

	if not jsonData then
		return
	end

	if jsonData.status == 1 then
		if string.nilorempty(jsonData.drop) then
			return {}
		end

		local noGetDrops = {}
		local drops = cjson.decode(jsonData.drop)

		for _, v in ipairs(drops) do
			if v.status == 0 then
				local isSelectEvent = false

				if v.type == "EVENT" then
					local eventCo = lua_rogue_event.configDict[v.value]

					if eventCo and eventCo.type == V1a6_CachotEnum.EventType.ChoiceSelect then
						isSelectEvent = true
					end
				end

				if not isSelectEvent then
					table.insert(noGetDrops, v)
				end
			end
		end

		return noGetDrops
	end
end

return RogueEventMO
