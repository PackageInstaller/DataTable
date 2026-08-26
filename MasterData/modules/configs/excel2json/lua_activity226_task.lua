-- chunkname: @modules/configs/excel2json/lua_activity226_task.lua

module("modules.configs.excel2json.lua_activity226_task", package.seeall)

local lua_activity226_task = {}
local fields = {
	unlockDay = 16,
	name = 6,
	sortId = 11,
	showDay = 17,
	desc = 7,
	listenerParam = 9,
	openLimit = 13,
	maxProgress = 10,
	activityId = 2,
	jumpId = 14,
	isOnline = 3,
	prepose = 12,
	loopType = 4,
	listenerType = 8,
	minType = 5,
	id = 1,
	bonus = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity226_task.onLoad(json)
	lua_activity226_task.configList, lua_activity226_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity226_task
