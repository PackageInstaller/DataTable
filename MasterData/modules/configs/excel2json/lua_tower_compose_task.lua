-- chunkname: @modules/configs/excel2json/lua_tower_compose_task.lua

module("modules.configs.excel2json.lua_tower_compose_task", package.seeall)

local lua_tower_compose_task = {}
local fields = {
	bonus = 16,
	name = 7,
	listenerType = 12,
	bonusMail = 9,
	params = 18,
	pointBonus = 17,
	desc = 8,
	listenerParam = 13,
	endTime = 11,
	maxProgress = 14,
	jumpId = 15,
	isOnline = 5,
	taskType = 3,
	minType = 6,
	minTypeId = 4,
	id = 1,
	taskGroupId = 2,
	startTime = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_tower_compose_task.onLoad(json)
	lua_tower_compose_task.configList, lua_tower_compose_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_task
