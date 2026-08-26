-- chunkname: @modules/configs/excel2json/lua_actvity204_task.lua

module("modules.configs.excel2json.lua_actvity204_task", package.seeall)

local lua_actvity204_task = {}
local fields = {
	missionorder = 17,
	name = 7,
	realPrepose = 18,
	bonusMail = 9,
	durationHour = 19,
	durationLimitActivityId = 21,
	secretornot = 20,
	desc = 8,
	listenerParam = 11,
	openLimit = 14,
	maxProgress = 12,
	activityId = 2,
	jumpId = 15,
	isOnline = 3,
	prepose = 13,
	loopType = 4,
	listenerType = 10,
	minType = 6,
	id = 1,
	acceptStage = 5,
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

function lua_actvity204_task.onLoad(json)
	lua_actvity204_task.configList, lua_actvity204_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity204_task
