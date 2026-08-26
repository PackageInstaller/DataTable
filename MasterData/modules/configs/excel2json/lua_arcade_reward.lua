-- chunkname: @modules/configs/excel2json/lua_arcade_reward.lua

module("modules.configs.excel2json.lua_arcade_reward", package.seeall)

local lua_arcade_reward = {}
local fields = {
	reward = 3,
	score = 2,
	special = 4,
	id = 1,
	activityId = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_arcade_reward.onLoad(json)
	lua_arcade_reward.configList, lua_arcade_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_reward
