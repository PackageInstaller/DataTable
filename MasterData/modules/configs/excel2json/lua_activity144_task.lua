-- chunkname: @modules/configs/excel2json/lua_activity144_task.lua

module("modules.configs.excel2json.lua_activity144_task", package.seeall)

local lua_activity144_task = {}
local fields = {
	jumpId = 10,
	name = 6,
	isOnline = 3,
	desc = 12,
	showType = 13,
	episodeId = 14,
	loopType = 4,
	listenerType = 7,
	listenerParam = 8,
	minType = 5,
	id = 1,
	maxProgress = 9,
	activityId = 2,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 3,
	minType = 2,
	loopType = 1,
	desc = 4
}

function lua_activity144_task.onLoad(json)
	lua_activity144_task.configList, lua_activity144_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_task
