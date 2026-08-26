-- chunkname: @modules/configs/excel2json/lua_partygame_snatch_area_map.lua

module("modules.configs.excel2json.lua_partygame_snatch_area_map", package.seeall)

local lua_partygame_snatch_area_map = {}
local fields = {
	row = 2,
	column = 3,
	mapdata = 4,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_snatch_area_map.onLoad(json)
	lua_partygame_snatch_area_map.configList, lua_partygame_snatch_area_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_snatch_area_map
