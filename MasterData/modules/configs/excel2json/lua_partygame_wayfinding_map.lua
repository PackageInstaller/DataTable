-- chunkname: @modules/configs/excel2json/lua_partygame_wayfinding_map.lua

module("modules.configs.excel2json.lua_partygame_wayfinding_map", package.seeall)

local lua_partygame_wayfinding_map = {}
local fields = {
	id = 1,
	mapData = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_wayfinding_map.onLoad(json)
	lua_partygame_wayfinding_map.configList, lua_partygame_wayfinding_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_wayfinding_map
