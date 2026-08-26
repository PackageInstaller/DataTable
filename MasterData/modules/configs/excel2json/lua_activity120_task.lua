-- chunkname: @modules/configs/excel2json/lua_activity120_task.lua

module("modules.configs.excel2json.lua_activity120_task", package.seeall)

local lua_activity120_task = {}
local fields = {
	jumpId = 12,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	offestProgress = 15,
	id = 1,
	episodeId = 14,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	listenerType = 9,
	openLimit = 8,
	maxProgress = 11,
	activityId = 2,
	bonus = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity120_task.onLoad(json)
	lua_activity120_task.configList, lua_activity120_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity120_task
