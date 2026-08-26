-- chunkname: @modules/configs/excel2json/lua_character_destiny_facets_consume.lua

module("modules.configs.excel2json.lua_character_destiny_facets_consume", package.seeall)

local lua_character_destiny_facets_consume = {}
local fields = {
	facetsSort = 6,
	name = 2,
	facetsId = 1,
	type = 8,
	titleName = 9,
	tend = 4,
	keyword = 7,
	consume = 3,
	tag = 10,
	icon = 5
}
local primaryKey = {
	"facetsId"
}
local mlStringKey = {
	titleName = 2,
	name = 1
}

function lua_character_destiny_facets_consume.onLoad(json)
	lua_character_destiny_facets_consume.configList, lua_character_destiny_facets_consume.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_destiny_facets_consume
