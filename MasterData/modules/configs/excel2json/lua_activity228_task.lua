-- chunkname: @modules/configs/excel2json/lua_activity228_task.lua

module("modules.configs.excel2json.lua_activity228_task", package.seeall)

local lua_activity228_task = {}
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

function lua_activity228_task.onLoad(json)
	lua_activity228_task.configList, lua_activity228_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity228_task
