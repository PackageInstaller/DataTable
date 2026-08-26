-- chunkname: @modules/configs/excel2json/lua_activity122_episode.lua

module("modules.configs.excel2json.lua_activity122_episode", package.seeall)

local lua_activity122_episode = {}
local fields = {
	openDay = 15,
	name = 6,
	conditionStr = 9,
	chapterId = 5,
	extStarCondition = 10,
	preEpisode = 3,
	extConditionStr = 11,
	starCondition = 8,
	mapIds = 12,
	storyBefore = 13,
	hp = 7,
	storyClear = 14,
	orderId = 4,
	id = 2,
	activityId = 1,
	storyRepeat = 16
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	conditionStr = 2,
	name = 1,
	extConditionStr = 3
}

function lua_activity122_episode.onLoad(json)
	lua_activity122_episode.configList, lua_activity122_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity122_episode
