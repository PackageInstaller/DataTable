-- chunkname: @modules/configs/excel2json/lua_activity185_episode.lua

module("modules.configs.excel2json.lua_activity185_episode", package.seeall)

local lua_activity185_episode = {}
local fields = {
	name = 4,
	preEpisodeId = 3,
	mapId = 6,
	storyId = 5,
	stage = 7,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}

function lua_activity185_episode.onLoad(json)
	lua_activity185_episode.configList, lua_activity185_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity185_episode
