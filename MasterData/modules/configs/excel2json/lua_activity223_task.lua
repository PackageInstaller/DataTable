-- chunkname: @modules/configs/excel2json/lua_activity223_task.lua

module("modules.configs.excel2json.lua_activity223_task", package.seeall)

local lua_activity223_task = {}
local fields = {
	sortId = 12,
	name = 7,
	teamBonus = 17,
	unlockDay = 18,
	showDay = 19,
	showOfflineTime = 20,
	desc = 8,
	listenerParam = 10,
	openLimit = 14,
	maxProgress = 11,
	activityId = 2,
	jumpId = 15,
	isOnline = 3,
	teamType = 6,
	prepose = 13,
	loopType = 4,
	listenerType = 9,
	minType = 5,
	id = 1,
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

function lua_activity223_task.onLoad(json)
	lua_activity223_task.configList, lua_activity223_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity223_task
