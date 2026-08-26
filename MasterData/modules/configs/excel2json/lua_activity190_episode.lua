-- chunkname: @modules/configs/excel2json/lua_activity190_episode.lua

module("modules.configs.excel2json.lua_activity190_episode", package.seeall)

local lua_activity190_episode = {}
local fields = {
	eliminateLevelId = 9,
	name = 5,
	preEpisodeBranchId = 4,
	type = 10,
	storyBefore = 6,
	storyClear = 8,
	maxRound = 12,
	episodeId = 2,
	masterId = 13,
	preEpisodeId = 3,
	enemyId = 11,
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

function lua_activity190_episode.onLoad(json)
	lua_activity190_episode.configList, lua_activity190_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity190_episode
