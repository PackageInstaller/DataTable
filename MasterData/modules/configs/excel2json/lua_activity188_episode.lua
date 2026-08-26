-- chunkname: @modules/configs/excel2json/lua_activity188_episode.lua

module("modules.configs.excel2json.lua_activity188_episode", package.seeall)

local lua_activity188_episode = {}
local fields = {
	name = 4,
	preEpisodeId = 3,
	gameId = 6,
	storyId = 5,
	resource = 7,
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

function lua_activity188_episode.onLoad(json)
	lua_activity188_episode.configList, lua_activity188_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity188_episode
