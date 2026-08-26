-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_kkny_bear_damage_hit.lua

module("modules.configs.excel2json.lua_fight_sp_effect_kkny_bear_damage_hit", package.seeall)

local lua_fight_sp_effect_kkny_bear_damage_hit = {}
local fields = {
	id = 1,
	hangPoint = 3,
	audio = 4,
	path = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_sp_effect_kkny_bear_damage_hit.onLoad(json)
	lua_fight_sp_effect_kkny_bear_damage_hit.configList, lua_fight_sp_effect_kkny_bear_damage_hit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_kkny_bear_damage_hit
