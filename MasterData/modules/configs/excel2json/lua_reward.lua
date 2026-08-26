-- chunkname: @modules/configs/excel2json/lua_reward.lua

module("modules.configs.excel2json.lua_reward", package.seeall)

local lua_reward = {}
local fields = {
	reward_id = 1,
	rewardGroup1 = 4,
	dailyDrop = 2,
	rewardGroup2 = 5,
	rewardGroup3 = 6,
	rewardGroup4 = 7,
	dailyGainWarning = 3,
	rewardGroup5 = 8,
	rewardGroup6 = 9,
	rewardGroup7 = 10,
	rewardGroup8 = 11
}
local primaryKey = {
	"reward_id"
}
local mlStringKey = {}

function lua_reward.onLoad(json)
	lua_reward.configList, lua_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_reward
