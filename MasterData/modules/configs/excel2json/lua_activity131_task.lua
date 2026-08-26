-- chunkname: @modules/configs/excel2json/lua_activity131_task.lua

module("modules.configs.excel2json.lua_activity131_task", package.seeall)

local lua_activity131_task = {}
local fields = {
	jumpId = 9,
	name = 5,
	isOnline = 3,
	loopType = 4,
	listenerType = 6,
	listenerParam = 7,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	loopType = 1,
	name = 2
}

function lua_activity131_task.onLoad(json)
	lua_activity131_task.configList, lua_activity131_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity131_task
