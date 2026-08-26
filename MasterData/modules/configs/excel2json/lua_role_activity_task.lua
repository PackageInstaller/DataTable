-- chunkname: @modules/configs/excel2json/lua_role_activity_task.lua

module("modules.configs.excel2json.lua_role_activity_task", package.seeall)

local lua_role_activity_task = {}
local fields = {
	taskDesc = 5,
	name = 4,
	jumpid = 10,
	listenerType = 6,
	listenerParam = 7,
	minType = 3,
	id = 2,
	maxProgress = 8,
	activityId = 1,
	bonus = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	taskDesc = 3
}

function lua_role_activity_task.onLoad(json)
	lua_role_activity_task.configList, lua_role_activity_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_role_activity_task
