-- chunkname: @modules/configs/excel2json/lua_myth_activity_task.lua

module("modules.configs.excel2json.lua_myth_activity_task", package.seeall)

local lua_myth_activity_task = {}
local fields = {
	jumpId = 12,
	name = 5,
	isOnline = 3,
	episodeId = 11,
	prepose = 7,
	listenerType = 8,
	desc = 6,
	listenerParam = 9,
	minType = 4,
	id = 1,
	maxProgress = 10,
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

function lua_myth_activity_task.onLoad(json)
	lua_myth_activity_task.configList, lua_myth_activity_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_myth_activity_task
