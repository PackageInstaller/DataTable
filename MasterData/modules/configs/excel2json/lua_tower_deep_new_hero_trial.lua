-- chunkname: @modules/configs/excel2json/lua_tower_deep_new_hero_trial.lua

module("modules.configs.excel2json.lua_tower_deep_new_hero_trial", package.seeall)

local lua_tower_deep_new_hero_trial = {}
local fields = {
	id = 1,
	heroIds = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_tower_deep_new_hero_trial.onLoad(json)
	lua_tower_deep_new_hero_trial.configList, lua_tower_deep_new_hero_trial.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_deep_new_hero_trial
