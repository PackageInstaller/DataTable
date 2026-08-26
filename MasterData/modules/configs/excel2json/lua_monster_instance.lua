-- chunkname: @modules/configs/excel2json/lua_monster_instance.lua

module("modules.configs.excel2json.lua_monster_instance", package.seeall)

local lua_monster_instance = {}
local fields = {
	defense = 4,
	id = 1,
	technic = 6,
	mdefense = 5,
	sub = 8,
	multiHp = 9,
	life = 2,
	attack = 3,
	level = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_monster_instance.onLoad(json)
	lua_monster_instance.configList, lua_monster_instance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_instance
