-- chunkname: @modules/logic/meilanni/model/EpisodeInfoMO.lua

module("modules.logic.meilanni.model.EpisodeInfoMO", package.seeall)

local EpisodeInfoMO = pureTable("EpisodeInfoMO")

function EpisodeInfoMO:init(info)
	self.episodeId = info.episodeId
	self.mapId = info.mapId
	self.isFinish = info.isFinish
	self.leftActPoint = info.leftActPoint
	self.confirm = info.confirm

	self:_initEvents(info)
	self:_initHistorylist(info)

	self.episodeConfig = lua_activity108_episode.configDict[self.episodeId]
end

function EpisodeInfoMO:_initEvents(info)
	self.events = {}
	self.eventMap = {}
	self.specialEventNum = 0

	for i, v in ipairs(info.events) do
		local e = EpisodeEventMO.New()

		e:init(v)
		table.insert(self.events, e)

		self.eventMap[e.eventId] = e

		if not e.isFinish and e.config.type == 1 then
			self.specialEventNum = self.specialEventNum + 1
		end
	end
end

function EpisodeInfoMO:_initHistorylist(info)
	self.historylist = {}

	local prevEventId
	local historyLen = 0

	for i, v in ipairs(info.historylist) do
		local data = EpisodeHistoryMO.New()

		data:init(v)
		table.insert(self.historylist, data)

		if v.eventId ~= prevEventId then
			prevEventId = v.eventId
			historyLen = historyLen + 1
		end
	end

	self.historyLen = historyLen
end

function EpisodeInfoMO:getEventInfo(id)
	return self.eventMap[id]
end

function EpisodeInfoMO:getEventByBattleId(id)
	for i, v in ipairs(self.events) do
		if v:getConfigBattleId() == id then
			return v
		end
	end
end

return EpisodeInfoMO
