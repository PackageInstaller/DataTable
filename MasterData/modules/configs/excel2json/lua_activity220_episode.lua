-- chunkname: @modules/configs/excel2json/lua_activity220_episode.lua

module("modules.configs.excel2json.lua_activity220_episode", package.seeall)

local lua_activity220_episode = {}
local fields = {
	storyBefore = 6,
	name = 5,
	preEpisodeBranchId = 4,
	type = 11,
	storyClear = 9,
	episodeId = 2,
	disactiveEpisodeIds = 10,
	preEpisodeId = 3,
	fightEpisodeId = 7,
	activityId = 1,
	gameId = 8
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}

function lua_activity220_episode.onLoad(json)
	lua_activity220_episode.configList, lua_activity220_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_episode
