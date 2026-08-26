-- chunkname: @modules/configs/excel2json/lua_task_explore.lua

module("modules.configs.excel2json.lua_task_explore", package.seeall)

local lua_task_explore = {}
local fields = {
	listenerType = 5,
	isOnline = 2,
	name = 3,
	display = 9,
	desc = 4,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	bonus = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_task_explore.onLoad(json)
	lua_task_explore.configList, lua_task_explore.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_explore
