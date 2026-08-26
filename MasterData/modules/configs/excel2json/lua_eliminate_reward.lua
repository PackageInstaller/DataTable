-- chunkname: @modules/configs/excel2json/lua_eliminate_reward.lua

module("modules.configs.excel2json.lua_eliminate_reward", package.seeall)

local lua_eliminate_reward = {}
local fields = {
	jumpId = 5,
	star = 4,
	bonus = 6,
	id = 1,
	activityId = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_eliminate_reward.onLoad(json)
	lua_eliminate_reward.configList, lua_eliminate_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_reward
