-- chunkname: @modules/configs/excel2json/lua_activity164_episode.lua

module("modules.configs.excel2json.lua_activity164_episode", package.seeall)

local lua_activity164_episode = {}
local fields = {
	activityId = 1,
	name = 3,
	preEpisode = 9,
	mapIds = 4,
	mainConditionStr = 5,
	storyClear = 8,
	storyRepeat = 10,
	mapName = 6,
	id = 2,
	storyBefore = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	mainConditionStr = 2,
	name = 1,
	mapName = 3
}

function lua_activity164_episode.onLoad(json)
	lua_activity164_episode.configList, lua_activity164_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity164_episode
