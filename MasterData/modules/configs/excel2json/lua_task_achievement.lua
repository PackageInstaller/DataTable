-- chunkname: @modules/configs/excel2json/lua_task_achievement.lua

module("modules.configs.excel2json.lua_task_achievement", package.seeall)

local lua_task_achievement = {}
local fields = {
	name = 4,
	isOnline = 2,
	openLimit = 9,
	bonusMail = 7,
	maxFinishCount = 13,
	listenerType = 10,
	desc = 5,
	listenerParam = 11,
	minType = 3,
	needAccept = 6,
	params = 8,
	id = 1,
	maxProgress = 12,
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

function lua_task_achievement.onLoad(json)
	lua_task_achievement.configList, lua_task_achievement.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_achievement
