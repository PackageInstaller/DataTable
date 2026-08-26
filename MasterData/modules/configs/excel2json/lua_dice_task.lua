-- chunkname: @modules/configs/excel2json/lua_dice_task.lua

module("modules.configs.excel2json.lua_dice_task", package.seeall)

local lua_dice_task = {}
local fields = {
	jumpId = 11,
	isOnline = 2,
	id = 1,
	bonusMail = 6,
	name = 4,
	listenerType = 8,
	desc = 5,
	listenerParam = 9,
	minType = 3,
	openLimit = 7,
	maxProgress = 10,
	activityId = 13,
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

function lua_dice_task.onLoad(json)
	lua_dice_task.configList, lua_dice_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dice_task
