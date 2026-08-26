-- chunkname: @modules/configs/excel2json/lua_hero_story_score_reward.lua

module("modules.configs.excel2json.lua_hero_story_score_reward", package.seeall)

local lua_hero_story_score_reward = {}
local fields = {
	score = 3,
	storyId = 2,
	id = 1,
	keyReward = 5,
	bonus = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_hero_story_score_reward.onLoad(json)
	lua_hero_story_score_reward.configList, lua_hero_story_score_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_score_reward
