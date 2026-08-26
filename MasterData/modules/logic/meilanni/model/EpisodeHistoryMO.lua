-- chunkname: @modules/logic/meilanni/model/EpisodeHistoryMO.lua

module("modules.logic.meilanni.model.EpisodeHistoryMO", package.seeall)

local EpisodeHistoryMO = pureTable("EpisodeHistoryMO")

function EpisodeHistoryMO:init(info)
	self.eventId = info.eventId
	self.index = info.index
end

return EpisodeHistoryMO
