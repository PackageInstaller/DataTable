-- chunkname: @modules/configs/excel2json/lua_activity172_task.lua

module("modules.configs.excel2json.lua_activity172_task", package.seeall)

local lua_activity172_task = {}
local fields = {
	itemId = 11,
	name = 5,
	openLimit = 7,
	isOnline = 3,
	listenerType = 8,
	jumpId = 12,
	desc = 6,
	listenerParam = 9,
	minType = 4,
	id = 1,
	maxProgress = 10,
	activityId = 2,
	bonus = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity172_task.onLoad(json)
	lua_activity172_task.configList, lua_activity172_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity172_task
