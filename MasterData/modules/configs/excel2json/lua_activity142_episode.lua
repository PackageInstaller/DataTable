-- chunkname: @modules/configs/excel2json/lua_activity142_episode.lua

module("modules.configs.excel2json.lua_activity142_episode", package.seeall)

local lua_activity142_episode = {}
local fields = {
	activityId = 1,
	name = 6,
	id = 2,
	chapterId = 5,
	conditionStr = 12,
	preEpisode = 3,
	normalSprite = 7,
	storyClear = 17,
	maxRound = 13,
	storyBefore = 16,
	openDay = 18,
	storyRepeat = 19,
	mapIds = 14,
	mainConditionStr = 10,
	pickUpObjIds = 15,
	extStarCondition = 11,
	mainConfition = 9,
	orderId = 4,
	lockSprite = 8
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

function lua_activity142_episode.onLoad(json)
	lua_activity142_episode.configList, lua_activity142_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity142_episode
