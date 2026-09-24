-- chunkname: @modules/configs/excel2json/lua_college_reward.lua

module("modules.configs.excel2json.lua_college_reward", package.seeall)

local lua_college_reward = {}
local fields = {
	score = 2,
	id = 1,
	special = 4,
	reward = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_college_reward.onLoad(json)
	lua_college_reward.configList, lua_college_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_reward
