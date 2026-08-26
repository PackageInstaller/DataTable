-- chunkname: @modules/configs/excel2json/lua_task_activity_show.lua

module("modules.configs.excel2json.lua_task_activity_show", package.seeall)

local lua_task_activity_show = {}
local fields = {
	activity = 10,
	name = 4,
	isOnline = 2,
	bonusMail = 14,
	maxFinishCount = 9,
	jumpId = 19,
	desc = 5,
	listenerParam = 7,
	needAccept = 17,
	params = 15,
	openLimit = 13,
	maxProgress = 8,
	activityId = 20,
	sortId = 11,
	priority = 16,
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

function lua_task_activity_show.onLoad(json)
	lua_task_activity_show.configList, lua_task_activity_show.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_activity_show
