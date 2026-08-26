-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/WarEpisodeInfo.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.WarEpisodeInfo", package.seeall)

local WarEpisodeInfo = pureTable("WarEpisodeInfo")

function WarEpisodeInfo:init(info)
	self:initFromParam(info.id, info.star)
end

function WarEpisodeInfo:initFromParam(id, star)
	self.id = id
	self.star = star
	self.config = lua_eliminate_episode.configDict[self.id]
end

return WarEpisodeInfo
