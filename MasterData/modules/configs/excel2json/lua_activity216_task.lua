-- chunkname: @modules/configs/excel2json/lua_activity216_task.lua

module("modules.configs.excel2json.lua_activity216_task", package.seeall)

local lua_activity216_task = {}
local fields = {
	episodeId = 13,
	name = 5,
	sortId = 17,
	bonusMail = 7,
	desc = 6,
	listenerParam = 10,
	openLimit = 12,
	maxProgress = 11,
	activityId = 2,
	jumpId = 14,
	isOnline = 3,
	prepose = 8,
	source = 16,
	listenerType = 9,
	minType = 4,
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

function lua_activity216_task.onLoad(json)
	lua_activity216_task.configList, lua_activity216_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity216_task
