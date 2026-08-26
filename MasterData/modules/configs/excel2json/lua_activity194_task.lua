-- chunkname: @modules/configs/excel2json/lua_activity194_task.lua

module("modules.configs.excel2json.lua_activity194_task", package.seeall)

local lua_activity194_task = {}
local fields = {
	jumpId = 10,
	isOnline = 3,
	name = 5,
	listenerType = 7,
	desc = 6,
	listenerParam = 8,
	minType = 4,
	id = 1,
	maxProgress = 9,
	activityId = 2,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity194_task.onLoad(json)
	lua_activity194_task.configList, lua_activity194_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_task
