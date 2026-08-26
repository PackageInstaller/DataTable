-- chunkname: @modules/configs/excel2json/lua_atomic_polygon_element.lua

module("modules.configs.excel2json.lua_atomic_polygon_element", package.seeall)

local lua_atomic_polygon_element = {}
local fields = {
	icon = 6,
	mapId = 2,
	taskDesc = 7,
	type = 4,
	id = 1,
	unlockCondition = 3,
	pos = 5,
	needFollow = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	taskDesc = 1
}

function lua_atomic_polygon_element.onLoad(json)
	lua_atomic_polygon_element.configList, lua_atomic_polygon_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_polygon_element
