-- chunkname: @modules/configs/excel2json/lua_activity128_rewards.lua

module("modules.configs.excel2json.lua_activity128_rewards", package.seeall)

local lua_activity128_rewards = {}
local fields = {
	reward = 5,
	display = 6,
	rewardPointNum = 4,
	id = 2,
	stage = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity128_rewards.onLoad(json)
	lua_activity128_rewards.configList, lua_activity128_rewards.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_rewards
