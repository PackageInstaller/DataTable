-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_kkny_bear_damage.lua

module("modules.configs.excel2json.lua_fight_sp_effect_kkny_bear_damage", package.seeall)

local lua_fight_sp_effect_kkny_bear_damage = {}
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

function lua_fight_sp_effect_kkny_bear_damage.onLoad(json)
	lua_fight_sp_effect_kkny_bear_damage.configList, lua_fight_sp_effect_kkny_bear_damage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_kkny_bear_damage
