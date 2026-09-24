-- chunkname: @modules/configs/excel2json/lua_activity244_monster.lua

module("modules.configs.excel2json.lua_activity244_monster", package.seeall)

local lua_activity244_monster = {}
local fields = {
	mesh = 7,
	name = 2,
	skillTemplate = 4,
	image = 6,
	career = 8,
	template = 3,
	id = 1,
	icon = 5,
	level = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity244_monster.onLoad(json)
	lua_activity244_monster.configList, lua_activity244_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_monster
