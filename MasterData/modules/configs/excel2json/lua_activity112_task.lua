-- chunkname: @modules/configs/excel2json/lua_activity112_task.lua

module("modules.configs.excel2json.lua_activity112_task", package.seeall)

local lua_activity112_task = {}
local fields = {
	jumpId = 11,
	isOnline = 3,
	listenerType = 6,
	bonus = 10,
	desc = 5,
	taskId = 2,
	listenerParam = 7,
	minTypeId = 4,
	maxProgress = 8,
	activityId = 1,
	sort = 9
}
local primaryKey = {
	"activityId",
	"taskId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity112_task.onLoad(json)
	lua_activity112_task.configList, lua_activity112_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity112_task
