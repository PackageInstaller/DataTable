-- chunkname: @modules/configs/excel2json/lua_task_weekly.lua

module("modules.configs.excel2json.lua_task_weekly", package.seeall)

local lua_task_weekly = {}
local fields = {
	activity = 10,
	name = 4,
	isOnline = 2,
	bonusMail = 14,
	maxFinishCount = 9,
	jumpId = 19,
	desc = 5,
	listenerParam = 7,
	needAccept = 16,
	params = 17,
	openLimit = 13,
	maxProgress = 8,
	activityId = 20,
	sortId = 11,
	priority = 15,
	prepose = 12,
	listenerType = 6,
	minType = 3,
	id = 1,
	bonus = 18
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_task_weekly.onLoad(json)
	lua_task_weekly.configList, lua_task_weekly.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_weekly
