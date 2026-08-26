-- chunkname: @modules/configs/excel2json/lua_activity211_episode.lua

module("modules.configs.excel2json.lua_activity211_episode", package.seeall)

local lua_activity211_episode = {}
local fields = {
	name = 5,
	preEpisodeId = 3,
	preEpisodeBranchId = 4,
	storyBefore = 6,
	gameId = 7,
	storyClear = 8,
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

function lua_activity211_episode.onLoad(json)
	lua_activity211_episode.configList, lua_activity211_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity211_episode
