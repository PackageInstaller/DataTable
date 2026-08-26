-- chunkname: @modules/configs/excel2json/lua_odyssey_map_task.lua

module("modules.configs.excel2json.lua_odyssey_map_task", package.seeall)

local lua_odyssey_map_task = {}
local fields = {
	elementList = 2,
	taskDesc = 4,
	taskTitle = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	taskTitle = 1,
	taskDesc = 2
}

function lua_odyssey_map_task.onLoad(json)
	lua_odyssey_map_task.configList, lua_odyssey_map_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_map_task
