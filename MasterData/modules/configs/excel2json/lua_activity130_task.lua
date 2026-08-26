-- chunkname: @modules/configs/excel2json/lua_activity130_task.lua

module("modules.configs.excel2json.lua_activity130_task", package.seeall)

local lua_activity130_task = {}
local fields = {
	jumpId = 10,
	name = 5,
	episodeId = 9,
	isOnline = 3,
	loopType = 4,
	listenerType = 6,
	listenerParam = 7,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	loopType = 1,
	name = 2
}

function lua_activity130_task.onLoad(json)
	lua_activity130_task.configList, lua_activity130_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity130_task
