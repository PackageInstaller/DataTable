-- chunkname: @modules/configs/excel2json/lua_monster_sub.lua

module("modules.configs.excel2json.lua_monster_sub", package.seeall)

local lua_monster_sub = {}
local fields = {
	score = 3,
	life = 4,
	technic = 8,
	job = 2,
	id = 1,
	defense = 6,
	mdefense = 7,
	attack = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_monster_sub.onLoad(json)
	lua_monster_sub.configList, lua_monster_sub.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_monster_sub
