-- chunkname: @modules/configs/excel2json/lua_turnback_task.lua

module("modules.configs.excel2json.lua_turnback_task", package.seeall)

local lua_turnback_task = {}
local fields = {
	sortId = 11,
	name = 6,
	unlockDay = 17,
	type = 18,
	isOnlineTimeTask = 19,
	acceptNeedOnlineSeconds = 20,
	showDay = 21,
	desc = 7,
	listenerParam = 9,
	randomPriority = 23,
	params = 14,
	openLimit = 13,
	maxProgress = 10,
	jumpId = 15,
	isOnline = 3,
	turnbackTaskType = 22,
	jumpUi = 24,
	prepose = 12,
	loopType = 4,
	listenerType = 8,
	minType = 5,
	id = 1,
	turnbackId = 2,
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

function lua_turnback_task.onLoad(json)
	lua_turnback_task.configList, lua_turnback_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_task
