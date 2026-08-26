-- chunkname: @modules/configs/excel2json/lua_activity189_task.lua

module("modules.configs.excel2json.lua_activity189_task", package.seeall)

local lua_activity189_task = {}
local fields = {
	openLimitActId = 14,
	name = 6,
	openLimit = 9,
	bonusMail = 8,
	desc = 7,
	listenerParam = 11,
	clientlistenerParam = 12,
	tag = 13,
	maxProgress = 16,
	activityId = 2,
	jumpId = 17,
	isOnline = 3,
	loopType = 4,
	listenerType = 10,
	minType = 5,
	id = 1,
	sorting = 15,
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

function lua_activity189_task.onLoad(json)
	lua_activity189_task.configList, lua_activity189_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity189_task
