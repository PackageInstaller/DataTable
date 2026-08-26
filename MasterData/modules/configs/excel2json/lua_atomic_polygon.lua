-- chunkname: @modules/configs/excel2json/lua_atomic_polygon.lua

module("modules.configs.excel2json.lua_atomic_polygon", package.seeall)

local lua_atomic_polygon = {}
local fields = {
	mapId = 2,
	name = 4,
	icon = 5,
	id = 1,
	unlockCondition = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_atomic_polygon.onLoad(json)
	lua_atomic_polygon.configList, lua_atomic_polygon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_polygon
