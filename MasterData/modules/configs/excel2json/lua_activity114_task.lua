-- chunkname: @modules/configs/excel2json/lua_activity114_task.lua

module("modules.configs.excel2json.lua_activity114_task", package.seeall)

local lua_activity114_task = {}
local fields = {
	listenerParam = 6,
	listenerType = 5,
	desc = 4,
	minTypeId = 3,
	bonus = 8,
	maxProgress = 7,
	activityId = 1,
	taskId = 2
}
local primaryKey = {
	"activityId",
	"taskId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity114_task.onLoad(json)
	lua_activity114_task.configList, lua_activity114_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_task
