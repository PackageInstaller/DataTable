-- chunkname: @modules/configs/excel2json/lua_activity131_episode.lua

module("modules.configs.excel2json.lua_activity131_episode", package.seeall)

local lua_activity131_episode = {}
local fields = {
	beforeStoryId = 8,
	name = 6,
	desc = 7,
	mapId = 5,
	afterStoryId = 9,
	elements = 10,
	scenes = 11,
	episodeId = 2,
	preEpisodeId = 4,
	episodetag = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity131_episode.onLoad(json)
	lua_activity131_episode.configList, lua_activity131_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity131_episode
