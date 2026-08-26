-- chunkname: @modules/configs/excel2json/lua_activity125_task.lua

module("modules.configs.excel2json.lua_activity125_task", package.seeall)

local lua_activity125_task = {}
local fields = {
	jumpId = 15,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	listenerType = 9,
	tag = 12,
	maxProgress = 14,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	id = 1,
	clientlistenerParam = 11,
	openLimit = 8,
	sorting = 13,
	activityId = 2,
	bonus = 16
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity125_task.onLoad(json)
	lua_activity125_task.configList, lua_activity125_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity125_task
