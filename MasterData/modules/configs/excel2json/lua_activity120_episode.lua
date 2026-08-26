-- chunkname: @modules/configs/excel2json/lua_activity120_episode.lua

module("modules.configs.excel2json.lua_activity120_episode", package.seeall)

local lua_activity120_episode = {}
local fields = {
	orderId = 4,
	name = 6,
	chapterId = 5,
	inactPaths = 16,
	conditionStr = 11,
	preEpisode = 3,
	storyBefore = 13,
	maxRound = 10,
	activityId = 1,
	openDay = 15,
	storyRepeat = 17,
	mapIds = 12,
	mainConditionStr = 8,
	storyClear = 14,
	extStarCondition = 9,
	mainConfition = 7,
	id = 2
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	mainConditionStr = 2,
	name = 1,
	conditionStr = 3
}

function lua_activity120_episode.onLoad(json)
	lua_activity120_episode.configList, lua_activity120_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity120_episode
