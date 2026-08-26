-- chunkname: @modules/configs/excel2json/lua_activity128_task.lua

module("modules.configs.excel2json.lua_activity128_task", package.seeall)

local lua_activity128_task = {}
local fields = {
	achievementRes = 4,
	name = 8,
	stage = 3,
	bonusMail = 11,
	maxFinishCount = 17,
	activity = 18,
	desc = 9,
	listenerParam = 15,
	needAccept = 10,
	params = 12,
	openLimit = 13,
	maxProgress = 16,
	activityId = 2,
	jumpId = 19,
	isOnline = 5,
	totalTaskType = 6,
	listenerType = 14,
	minType = 7,
	id = 1,
	bonus = 20
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity128_task.onLoad(json)
	lua_activity128_task.configList, lua_activity128_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_task
