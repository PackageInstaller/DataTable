-- chunkname: @modules/configs/excel2json/lua_activity149_rewards.lua

module("modules.configs.excel2json.lua_activity149_rewards", package.seeall)

local lua_activity149_rewards = {}
local fields = {
	id = 1,
	reward = 4,
	activityId = 2,
	rewardPointNum = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity149_rewards.onLoad(json)
	lua_activity149_rewards.configList, lua_activity149_rewards.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity149_rewards
