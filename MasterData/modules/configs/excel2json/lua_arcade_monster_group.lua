-- chunkname: @modules/configs/excel2json/lua_arcade_monster_group.lua

module("modules.configs.excel2json.lua_arcade_monster_group", package.seeall)

local lua_arcade_monster_group = {}
local fields = {
	column1 = 3,
	column4 = 6,
	column7 = 9,
	column2 = 4,
	row = 2,
	column5 = 7,
	column8 = 10,
	id = 1,
	column3 = 5,
	column6 = 8
}
local primaryKey = {
	"id",
	"row"
}
local mlStringKey = {}

function lua_arcade_monster_group.onLoad(json)
	lua_arcade_monster_group.configList, lua_arcade_monster_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_arcade_monster_group
