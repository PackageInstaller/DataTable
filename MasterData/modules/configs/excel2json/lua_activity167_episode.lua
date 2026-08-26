-- chunkname: @modules/configs/excel2json/lua_activity167_episode.lua

module("modules.configs.excel2json.lua_activity167_episode", package.seeall)

local lua_activity167_episode = {}
local fields = {
	name = 4,
	winCondition = 7,
	id = 2,
	subConditionStr = 9,
	exStarCondition = 10,
	subCondition = 8,
	conditionStr = 11,
	storyBefore = 12,
	storyClear = 13,
	mapId = 6,
	preEpisode = 14,
	cubeList = 15,
	episodeType = 3,
	activityId = 1,
	nameEn = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	conditionStr = 3,
	name = 1,
	subConditionStr = 2
}

function lua_activity167_episode.onLoad(json)
	lua_activity167_episode.configList, lua_activity167_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity167_episode
