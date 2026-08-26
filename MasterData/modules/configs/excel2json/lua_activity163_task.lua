-- chunkname: @modules/configs/excel2json/lua_activity163_task.lua

module("modules.configs.excel2json.lua_activity163_task", package.seeall)

local lua_activity163_task = {}
local fields = {
	jumpId = 10,
	isOnline = 3,
	episodeId = 9,
	name = 5,
	listenerType = 6,
	listenerParam = 7,
	minType = 4,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1
}

function lua_activity163_task.onLoad(json)
	lua_activity163_task.configList, lua_activity163_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity163_task
