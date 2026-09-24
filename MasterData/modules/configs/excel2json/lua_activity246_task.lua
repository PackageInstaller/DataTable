-- chunkname: @modules/configs/excel2json/lua_activity246_task.lua

module("modules.configs.excel2json.lua_activity246_task", package.seeall)

local lua_activity246_task = {}
local fields = {
	activityId = 2,
	name = 7,
	openLimit = 10,
	bonusMail = 9,
	desc = 8,
	listenerParam = 12,
	clientlistenerParam = 14,
	tag = 15,
	maxProgress = 13,
	openLimitActId = 16,
	jumpId = 18,
	isOnline = 3,
	canFinishDays = 5,
	prepose = 20,
	loopType = 4,
	listenerType = 11,
	minType = 6,
	id = 1,
	sorting = 17,
	bonus = 19
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tag = 4,
	minType = 1,
	name = 2,
	desc = 3
}

function lua_activity246_task.onLoad(json)
	lua_activity246_task.configList, lua_activity246_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity246_task
