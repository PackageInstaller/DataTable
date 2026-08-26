-- chunkname: @modules/logic/meilanni/model/EventHistoryMO.lua

module("modules.logic.meilanni.model.EventHistoryMO", package.seeall)

local EventHistoryMO = pureTable("EventHistoryMO")

function EventHistoryMO:init(info)
	self.index = info.index
	self.history = info.history
end

return EventHistoryMO
