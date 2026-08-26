-- chunkname: @modules/configs/excel2json/lua_rouge2_boss_reward.lua

module("modules.configs.excel2json.lua_rouge2_boss_reward", package.seeall)

local lua_rouge2_boss_reward = {}
local fields = {
	reward = 4,
	score = 3,
	relics = 5,
	id = 1,
	stage = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_boss_reward.onLoad(json)
	lua_rouge2_boss_reward.configList, lua_rouge2_boss_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_boss_reward
