-- chunkname: @modules/configs/excel2json/lua_task_weekwalk.lua

module("modules.configs.excel2json.lua_task_weekwalk", package.seeall)

local lua_task_weekwalk = {}
local fields = {
	sortId = 10,
	listenerType = 6,
	periods = 13,
	bonusMail = 12,
	maxFinishCount = 9,
	layerId = 5,
	desc = 4,
	listenerParam = 7,
	minType = 3,
	minTypeId = 2,
	id = 1,
	maxProgress = 8,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	minType = 1
}

function lua_task_weekwalk.onLoad(json)
	lua_task_weekwalk.configList, lua_task_weekwalk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_weekwalk
