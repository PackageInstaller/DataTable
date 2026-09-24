-- chunkname: @modules/configs/excel2json/lua_activity244_episode_level.lua

module("modules.configs.excel2json.lua_activity244_episode_level", package.seeall)

local lua_activity244_episode_level = {}
local fields = {
	feverTime = 11,
	levelGoal1 = 7,
	feverCost = 10,
	matchTime = 12,
	trialHeros = 16,
	levelGoal3 = 9,
	matchLevelId = 1,
	levelGoal2 = 8,
	gemTemplateId = 14,
	maxRound = 6,
	sceneUrl = 4,
	useTemp = 15,
	gemTypeNum = 13,
	monsterId = 3,
	boardLayoutId = 2,
	roleNum = 5
}
local primaryKey = {
	"matchLevelId"
}
local mlStringKey = {}

function lua_activity244_episode_level.onLoad(json)
	lua_activity244_episode_level.configList, lua_activity244_episode_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_episode_level
