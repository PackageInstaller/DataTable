-- chunkname: @modules/configs/excel2json/lua_fight_spell_show_type.lua

module("modules.configs.excel2json.lua_fight_spell_show_type", package.seeall)

local lua_fight_spell_show_type = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_spell_show_type.onLoad(json)
	lua_fight_spell_show_type.configList, lua_fight_spell_show_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_spell_show_type
