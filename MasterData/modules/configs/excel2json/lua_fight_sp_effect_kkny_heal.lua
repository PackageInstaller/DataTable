-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_kkny_heal.lua

module("modules.configs.excel2json.lua_fight_sp_effect_kkny_heal", package.seeall)

local lua_fight_sp_effect_kkny_heal = {}
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

function lua_fight_sp_effect_kkny_heal.onLoad(json)
	lua_fight_sp_effect_kkny_heal.configList, lua_fight_sp_effect_kkny_heal.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_sp_effect_kkny_heal
