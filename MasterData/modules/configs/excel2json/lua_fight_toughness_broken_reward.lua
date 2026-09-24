-- chunkname: @modules/configs/excel2json/lua_fight_toughness_broken_reward.lua

module("modules.configs.excel2json.lua_fight_toughness_broken_reward", package.seeall)

local lua_fight_toughness_broken_reward = {}
local fields = {
	id = 1,
	effectType = 2,
	timeline = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_toughness_broken_reward.onLoad(json)
	lua_fight_toughness_broken_reward.configList, lua_fight_toughness_broken_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_toughness_broken_reward
