-- chunkname: @modules/configs/excel2json/lua_assassin_task.lua

module("modules.configs.excel2json.lua_assassin_task", package.seeall)

local lua_assassin_task = {}
local fields = {
	jumpId = 13,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	maxFinishCount = 12,
	listenerType = 9,
	id = 1,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	openLimit = 8,
	maxProgress = 11,
	activityId = 2,
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

function lua_assassin_task.onLoad(json)
	lua_assassin_task.configList, lua_assassin_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_task
