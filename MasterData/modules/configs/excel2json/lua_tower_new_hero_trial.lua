-- chunkname: @modules/configs/excel2json/lua_tower_new_hero_trial.lua

module("modules.configs.excel2json.lua_tower_new_hero_trial", package.seeall)

local lua_tower_new_hero_trial = {}
local fields = {
	stageId = 1,
	heroIds = 2
}
local primaryKey = {
	"stageId"
}
local mlStringKey = {}

function lua_tower_new_hero_trial.onLoad(json)
	lua_tower_new_hero_trial.configList, lua_tower_new_hero_trial.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_new_hero_trial
