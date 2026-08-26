-- chunkname: @modules/configs/excel2json/lua_activity133_task.lua

module("modules.configs.excel2json.lua_activity133_task", package.seeall)

local lua_activity133_task = {}
local fields = {
	sortId = 11,
	name = 6,
	isOnline = 3,
	listenerType = 8,
	prepose = 12,
	openLimit = 13,
	loopType = 4,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	jumpId = 15,
	params = 14,
	id = 1,
	maxProgress = 10,
	activityId = 2,
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

function lua_activity133_task.onLoad(json)
	lua_activity133_task.configList, lua_activity133_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity133_task
