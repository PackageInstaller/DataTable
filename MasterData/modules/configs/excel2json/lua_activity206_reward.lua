-- chunkname: @modules/configs/excel2json/lua_activity206_reward.lua

module("modules.configs.excel2json.lua_activity206_reward", package.seeall)

local lua_activity206_reward = {}
local fields = {
	reward = 2,
	rewardId = 1,
	title = 4,
	pic = 5,
	des = 3
}
local primaryKey = {
	"rewardId"
}
local mlStringKey = {
	title = 2,
	des = 1
}

function lua_activity206_reward.onLoad(json)
	lua_activity206_reward.configList, lua_activity206_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity206_reward
