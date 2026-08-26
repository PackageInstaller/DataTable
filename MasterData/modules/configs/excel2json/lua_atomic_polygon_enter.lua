-- chunkname: @modules/configs/excel2json/lua_atomic_polygon_enter.lua

module("modules.configs.excel2json.lua_atomic_polygon_enter", package.seeall)

local lua_atomic_polygon_enter = {}
local fields = {
	mapId = 5,
	name = 2,
	id = 1,
	icon = 4,
	pos = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_atomic_polygon_enter.onLoad(json)
	lua_atomic_polygon_enter.configList, lua_atomic_polygon_enter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_polygon_enter
