-- chunkname: @modules/configs/excel2json/lua_challenge_episode.lua

module("modules.configs.excel2json.lua_challenge_episode", package.seeall)

local lua_challenge_episode = {}
local fields = {
	hiddenRule2 = 11,
	ruleIcon = 13,
	ruleDesc1 = 9,
	type = 3,
	groupId = 4,
	title = 15,
	preEpisodeIds = 5,
	desc = 16,
	episodeId = 1,
	skillDesc = 21,
	leaderBaseStress = 23,
	leaderMaxStress = 24,
	reportIcon = 18,
	icon = 17,
	activityId = 2,
	order = 6,
	hiddenRule1 = 8,
	leaderIdentity = 25,
	resultIcon = 19,
	leaderPosition = 22,
	rule1 = 7,
	condition = 14,
	leaderSkill = 20,
	ruleDesc2 = 12,
	rule2 = 10
}
local primaryKey = {
	"episodeId"
}
local mlStringKey = {
	ruleDesc2 = 2,
	ruleDesc1 = 1,
	title = 3,
	skillDesc = 5,
	desc = 4
}

function lua_challenge_episode.onLoad(json)
	lua_challenge_episode.configList, lua_challenge_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_challenge_episode
