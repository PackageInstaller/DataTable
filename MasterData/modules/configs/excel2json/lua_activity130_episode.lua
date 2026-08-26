-- chunkname: @modules/configs/excel2json/lua_activity130_episode.lua

module("modules.configs.excel2json.lua_activity130_episode", package.seeall)

local lua_activity130_episode = {}
local fields = {
	lvscene = 11,
	name = 6,
	desc = 7,
	mapId = 5,
	afterStoryId = 9,
	elements = 10,
	beforeStoryId = 8,
	episodeId = 2,
	scenes = 12,
	preEpisodeId = 4,
	winCondition = 13,
	conditionStr = 14,
	episodetag = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	conditionStr = 3,
	name = 1,
	desc = 2
}

function lua_activity130_episode.onLoad(json)
	lua_activity130_episode.configList, lua_activity130_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity130_episode
