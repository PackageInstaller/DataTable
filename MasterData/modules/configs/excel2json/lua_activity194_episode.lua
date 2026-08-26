-- chunkname: @modules/configs/excel2json/lua_activity194_episode.lua

module("modules.configs.excel2json.lua_activity194_episode", package.seeall)

local lua_activity194_episode = {}
local fields = {
	beforeStory = 5,
	preEpisodeId = 3,
	name = 4,
	afterStory = 7,
	gameId = 6,
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

function lua_activity194_episode.onLoad(json)
	lua_activity194_episode.configList, lua_activity194_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_episode
