-- chunkname: @modules/configs/excel2json/lua_activity244_monster_template.lua

module("modules.configs.excel2json.lua_activity244_monster_template", package.seeall)

local lua_activity244_monster_template = {}
local fields = {
	defense = 4,
	id = 1,
	hp = 2,
	heal = 5,
	attack = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity244_monster_template.onLoad(json)
	lua_activity244_monster_template.configList, lua_activity244_monster_template.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_monster_template
