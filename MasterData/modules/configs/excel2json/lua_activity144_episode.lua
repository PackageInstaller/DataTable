-- chunkname: @modules/configs/excel2json/lua_activity144_episode.lua

module("modules.configs.excel2json.lua_activity144_episode", package.seeall)

local lua_activity144_episode = {}
local fields = {
	bgPath = 7,
	name = 4,
	picture = 6,
	nameen = 10,
	taskId = 8,
	preEpisode = 3,
	unlockDesc = 9,
	episodeId = 2,
	desc = 5,
	storyBefore = 11,
	storyClear = 12,
	showTargets = 13,
	bonus = 15,
	activityId = 1,
	showBonus = 14
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	unlockDesc = 3,
	name = 1,
	desc = 2
}

function lua_activity144_episode.onLoad(json)
	lua_activity144_episode.configList, lua_activity144_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_episode
