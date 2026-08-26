-- chunkname: @modules/configs/excel2json/lua_rouge_last_reward.lua

module("modules.configs.excel2json.lua_rouge_last_reward", package.seeall)

local lua_rouge_last_reward = {}
local fields = {
	id = 2,
	title = 5,
	iconName = 7,
	type = 4,
	season = 1,
	version = 3,
	desc = 6
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rouge_last_reward.onLoad(json)
	lua_rouge_last_reward.configList, lua_rouge_last_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_last_reward
