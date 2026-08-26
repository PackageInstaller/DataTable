-- chunkname: @modules/configs/excel2json/lua_activity228_reward.lua

module("modules.configs.excel2json.lua_activity228_reward", package.seeall)

local lua_activity228_reward = {}
local fields = {
	reward = 2,
	important = 3,
	rewardId = 1
}
local primaryKey = {
	"rewardId"
}
local mlStringKey = {}

function lua_activity228_reward.onLoad(json)
	lua_activity228_reward.configList, lua_activity228_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity228_reward
