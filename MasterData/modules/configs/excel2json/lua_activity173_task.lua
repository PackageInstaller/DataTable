-- chunkname: @modules/configs/excel2json/lua_activity173_task.lua

module("modules.configs.excel2json.lua_activity173_task", package.seeall)

local lua_activity173_task = {}
local fields = {
	sortId = 9,
	name = 4,
	bonusMail = 12,
	desc = 5,
	listenerParam = 7,
	params = 13,
	openLimit = 11,
	maxProgress = 8,
	activityId = 16,
	showBonus = 18,
	jumpId = 15,
	isOnline = 2,
	prepose = 10,
	source = 17,
	listenerType = 6,
	minType = 3,
	id = 1,
	bonus = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity173_task.onLoad(json)
	lua_activity173_task.configList, lua_activity173_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity173_task
