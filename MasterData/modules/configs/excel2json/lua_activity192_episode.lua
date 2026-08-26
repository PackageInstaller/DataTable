-- chunkname: @modules/configs/excel2json/lua_activity192_episode.lua

module("modules.configs.excel2json.lua_activity192_episode", package.seeall)

local lua_activity192_episode = {}
local fields = {
	storyBefore = 7,
	name = 6,
	preEpisodeBranchId = 4,
	isExtra = 9,
	storyClear = 8,
	episodeId = 2,
	preEpisodeId = 3,
	activityId = 1,
	gameId = 5
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}

function lua_activity192_episode.onLoad(json)
	lua_activity192_episode.configList, lua_activity192_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity192_episode
