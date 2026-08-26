-- chunkname: @modules/configs/excel2json/lua_activity168_episode.lua

module("modules.configs.excel2json.lua_activity168_episode", package.seeall)

local lua_activity168_episode = {}
local fields = {
	activityId = 1,
	name = 6,
	orderId = 5,
	id = 2,
	preEpisode = 3,
	episodeId = 9,
	mapId = 7,
	episodeType = 4,
	storyBefore = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity168_episode.onLoad(json)
	lua_activity168_episode.configList, lua_activity168_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity168_episode
