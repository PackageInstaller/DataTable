-- chunkname: @modules/configs/excel2json/lua_activity231_task.lua

module("modules.configs.excel2json.lua_activity231_task", package.seeall)

local lua_activity231_task = {}
local fields = {
	jumpId = 11,
	isOnline = 3,
	name = 5,
	bonusMail = 12,
	listenerType = 7,
	desc = 6,
	listenerParam = 8,
	minType = 4,
	id = 1,
	maxProgress = 9,
	activityId = 2,
	bonus = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity231_task.onLoad(json)
	lua_activity231_task.configList, lua_activity231_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_task
