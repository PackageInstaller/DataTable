-- chunkname: @modules/configs/excel2json/lua_activity119_task.lua

module("modules.configs.excel2json.lua_activity119_task", package.seeall)

local lua_activity119_task = {}
local fields = {
	desc = 8,
	isOnline = 6,
	bonusMail = 9,
	tabId = 4,
	openLimit = 10,
	listenerType = 11,
	bonus = 14,
	day = 3,
	listenerParam = 12,
	minType = 7,
	id = 1,
	maxProgress = 13,
	activityId = 2,
	sort = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	minType = 1
}

function lua_activity119_task.onLoad(json)
	lua_activity119_task.configList, lua_activity119_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity119_task
