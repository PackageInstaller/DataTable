-- chunkname: @modules/configs/excel2json/lua_tower_task.lua

module("modules.configs.excel2json.lua_tower_task", package.seeall)

local lua_tower_task = {}
local fields = {
	jumpId = 13,
	name = 6,
	openLimit = 9,
	bonusMail = 8,
	listenerType = 10,
	maxProgress = 12,
	isOnline = 4,
	desc = 7,
	listenerParam = 11,
	minType = 5,
	isKeyReward = 15,
	id = 1,
	taskGroupId = 2,
	activityId = 3,
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

function lua_tower_task.onLoad(json)
	lua_tower_task.configList, lua_tower_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_task
