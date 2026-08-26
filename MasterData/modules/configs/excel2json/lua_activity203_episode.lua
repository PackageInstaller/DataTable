-- chunkname: @modules/configs/excel2json/lua_activity203_episode.lua

module("modules.configs.excel2json.lua_activity203_episode", package.seeall)

local lua_activity203_episode = {}
local fields = {
	storyBefore = 6,
	name = 5,
	preEpisodeBranchId = 4,
	type = 9,
	storyClear = 8,
	episodeId = 2,
	preEpisodeId = 3,
	activityId = 1,
	gameId = 7
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}

function lua_activity203_episode.onLoad(json)
	lua_activity203_episode.configList, lua_activity203_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity203_episode
