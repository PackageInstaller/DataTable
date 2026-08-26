-- chunkname: @modules/configs/excel2json/lua_activity184_episode.lua

module("modules.configs.excel2json.lua_activity184_episode", package.seeall)

local lua_activity184_episode = {}
local fields = {
	puzzleId = 3,
	preEpisodeId = 4,
	name = 5,
	storyId = 6,
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

function lua_activity184_episode.onLoad(json)
	lua_activity184_episode.configList, lua_activity184_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity184_episode
