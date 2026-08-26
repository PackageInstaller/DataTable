-- chunkname: @modules/configs/excel2json/lua_push_box_task.lua

module("modules.configs.excel2json.lua_push_box_task", package.seeall)

local lua_push_box_task = {}
local fields = {
	desc = 5,
	isOnline = 3,
	listenerType = 6,
	bonus = 10,
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

function lua_push_box_task.onLoad(json)
	lua_push_box_task.configList, lua_push_box_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_push_box_task
