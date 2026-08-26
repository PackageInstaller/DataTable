-- chunkname: @modules/configs/excel2json/lua_activity129_reward.lua

module("modules.configs.excel2json.lua_activity129_reward", package.seeall)

local lua_activity129_reward = {}
local fields = {
	initWeight = 3,
	changeWeight = 4,
	activityId = 1,
	poolId = 2
}
local primaryKey = {
	"activityId",
	"poolId"
}
local mlStringKey = {}

function lua_activity129_reward.onLoad(json)
	lua_activity129_reward.configList, lua_activity129_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity129_reward
