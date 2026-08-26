-- chunkname: @modules/configs/excel2json/lua_activity206_reward_group.lua

module("modules.configs.excel2json.lua_activity206_reward_group", package.seeall)

local lua_activity206_reward_group = {}
local fields = {
	groupId = 1,
	rewardId2Prob = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}

function lua_activity206_reward_group.onLoad(json)
	lua_activity206_reward_group.configList, lua_activity206_reward_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity206_reward_group
