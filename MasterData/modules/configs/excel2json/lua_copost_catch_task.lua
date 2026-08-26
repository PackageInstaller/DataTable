-- chunkname: @modules/configs/excel2json/lua_copost_catch_task.lua

module("modules.configs.excel2json.lua_copost_catch_task", package.seeall)

local lua_copost_catch_task = {}
local fields = {
	jumpId = 10,
	isOnline = 4,
	listenerType = 5,
	desc = 8,
	finishNum = 3,
	taskType = 2,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	bonus = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_copost_catch_task.onLoad(json)
	lua_copost_catch_task.configList, lua_copost_catch_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_catch_task
