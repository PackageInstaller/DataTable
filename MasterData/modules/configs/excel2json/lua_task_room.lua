-- chunkname: @modules/configs/excel2json/lua_task_room.lua

module("modules.configs.excel2json.lua_task_room", package.seeall)

local lua_task_room = {}
local fields = {
	bonusIcon = 20,
	name = 4,
	bonusMail = 9,
	maxFinishCount = 16,
	desc = 5,
	listenerParam = 14,
	needAccept = 8,
	params = 10,
	openLimit = 12,
	maxProgress = 15,
	order = 7,
	tips = 6,
	isOnline = 2,
	prepose = 11,
	listenerType = 13,
	onceBonus = 19,
	minType = 3,
	id = 1,
	needReset = 18,
	bonus = 17
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 4,
	minType = 1,
	name = 2,
	desc = 3
}

function lua_task_room.onLoad(json)
	lua_task_room.configList, lua_task_room.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_room
