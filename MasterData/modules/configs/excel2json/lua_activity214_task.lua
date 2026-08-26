-- chunkname: @modules/configs/excel2json/lua_activity214_task.lua

module("modules.configs.excel2json.lua_activity214_task", package.seeall)

local lua_activity214_task = {}
local fields = {
	bonusScore = 17,
	name = 7,
	jumpId = 18,
	bonusMail = 15,
	endTime = 20,
	desc = 8,
	listenerParam = 10,
	bpId = 3,
	params = 16,
	openLimit = 14,
	maxProgress = 11,
	activityId = 4,
	sortId = 12,
	isOnline = 2,
	prepose = 13,
	loopType = 5,
	listenerType = 9,
	minType = 6,
	id = 1,
	startTime = 19
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity214_task.onLoad(json)
	lua_activity214_task.configList, lua_activity214_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity214_task
