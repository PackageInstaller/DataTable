-- chunkname: @modules/configs/excel2json/lua_activity115_episode.lua

module("modules.configs.excel2json.lua_activity115_episode", package.seeall)

local lua_activity115_episode = {}
local fields = {
	openDay = 11,
	winCondition = 7,
	conditionStr = 9,
	chapterId = 3,
	index = 4,
	preEpisode = 5,
	name = 6,
	extStarCondition = 8,
	tooth = 12,
	mapId = 10,
	unlockSkill = 13,
	maxRound = 14,
	id = 2,
	aniPos = 16,
	activityId = 1,
	trialTemplate = 15
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	conditionStr = 2,
	name = 1
}

function lua_activity115_episode.onLoad(json)
	lua_activity115_episode.configList, lua_activity115_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity115_episode
