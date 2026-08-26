-- chunkname: @modules/configs/excel2json/lua_task_type.lua

module("modules.configs.excel2json.lua_task_type", package.seeall)

local lua_task_type = {}
local fields = {
	id = 1,
	name = 2,
	redDotKey = 3,
	functuonId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_task_type.onLoad(json)
	lua_task_type.configList, lua_task_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_type
