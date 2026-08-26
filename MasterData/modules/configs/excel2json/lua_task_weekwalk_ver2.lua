-- chunkname: @modules/configs/excel2json/lua_task_weekwalk_ver2.lua

module("modules.configs.excel2json.lua_task_weekwalk_ver2", package.seeall)

local lua_task_weekwalk_ver2 = {}
local fields = {
	listenerType = 8,
	name = 6,
	isOnline = 3,
	bonusMail = 13,
	maxFinishCount = 11,
	layerId = 2,
	periods = 14,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	minTypeId = 4,
	id = 1,
	maxProgress = 10,
	bonus = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_task_weekwalk_ver2.onLoad(json)
	lua_task_weekwalk_ver2.configList, lua_task_weekwalk_ver2.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_weekwalk_ver2
