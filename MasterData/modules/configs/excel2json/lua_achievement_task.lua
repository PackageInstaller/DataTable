-- chunkname: @modules/configs/excel2json/lua_achievement_task.lua

module("modules.configs.excel2json.lua_achievement_task", package.seeall)

local lua_achievement_task = {}
local fields = {
	sortId = 8,
	listenerType = 5,
	achievementId = 2,
	extraDesc = 4,
	icon = 10,
	image = 11,
	desc = 3,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	level = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	extraDesc = 2,
	desc = 1
}

function lua_achievement_task.onLoad(json)
	lua_achievement_task.configList, lua_achievement_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_achievement_task
