-- chunkname: @modules/configs/excel2json/lua_activity109_episode.lua

module("modules.configs.excel2json.lua_activity109_episode", package.seeall)

local lua_activity109_episode = {}
local fields = {
	openDay = 14,
	winCondition = 7,
	id = 2,
	chapterId = 5,
	conditionStr = 10,
	preEpisode = 3,
	mapId = 11,
	extStarCondition = 8,
	storyBefore = 12,
	maxRound = 9,
	storyClear = 13,
	name = 6,
	orderId = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	conditionStr = 2,
	name = 1
}

function lua_activity109_episode.onLoad(json)
	lua_activity109_episode.configList, lua_activity109_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity109_episode
