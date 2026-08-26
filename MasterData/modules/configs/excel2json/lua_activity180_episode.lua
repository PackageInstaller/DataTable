-- chunkname: @modules/configs/excel2json/lua_activity180_episode.lua

module("modules.configs.excel2json.lua_activity180_episode", package.seeall)

local lua_activity180_episode = {}
local fields = {
	beforeStory = 5,
	name = 4,
	mapId = 7,
	afterStory = 6,
	preEpisode = 3,
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

function lua_activity180_episode.onLoad(json)
	lua_activity180_episode.configList, lua_activity180_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity180_episode
