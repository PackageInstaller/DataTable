-- chunkname: @modules/configs/excel2json/lua_atomic_polygon_task.lua

module("modules.configs.excel2json.lua_atomic_polygon_task", package.seeall)

local lua_atomic_polygon_task = {}
local fields = {
	score = 2,
	id = 1,
	special = 4,
	reward = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_atomic_polygon_task.onLoad(json)
	lua_atomic_polygon_task.configList, lua_atomic_polygon_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_polygon_task
