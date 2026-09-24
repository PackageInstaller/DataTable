-- chunkname: @modules/configs/excel2json/lua_activity244_star_reward.lua

module("modules.configs.excel2json.lua_activity244_star_reward", package.seeall)

local lua_activity244_star_reward = {}
local fields = {
	id = 2,
	star = 3,
	activityId = 1,
	rewardId = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity244_star_reward.onLoad(json)
	lua_activity244_star_reward.configList, lua_activity244_star_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_star_reward
