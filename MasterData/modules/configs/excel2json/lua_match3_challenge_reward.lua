-- chunkname: @modules/configs/excel2json/lua_match3_challenge_reward.lua

module("modules.configs.excel2json.lua_match3_challenge_reward", package.seeall)

local lua_match3_challenge_reward = {}
local fields = {
	id = 1,
	score = 3,
	activityId = 2,
	rewardId = 4
}
local primaryKey = {
	"id",
	"activityId"
}
local mlStringKey = {}

function lua_match3_challenge_reward.onLoad(json)
	lua_match3_challenge_reward.configList, lua_match3_challenge_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_challenge_reward
