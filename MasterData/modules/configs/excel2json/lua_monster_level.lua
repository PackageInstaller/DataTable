-- chunkname: @modules/configs/excel2json/lua_monster_level.lua

module("modules.configs.excel2json.lua_monster_level", package.seeall)

local lua_monster_level = {}
local fields = {
	equip_base = 5,
	equip_super = 6,
	technic = 3,
	base = 2,
	id = 1,
	base_super = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_monster_level.onLoad(json)
	lua_monster_level.configList, lua_monster_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_level
