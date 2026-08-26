-- chunkname: @modules/configs/excel2json/lua_task_activity123.lua

module("modules.configs.excel2json.lua_task_activity123", package.seeall)

local lua_task_activity123 = {}
local fields = {
	sortId = 12,
	isOnline = 5,
	listenerType = 8,
	equipBonus = 14,
	maxFinishCount = 11,
	isRewardView = 16,
	jumpId = 15,
	desc = 7,
	listenerParam = 9,
	minType = 4,
	seasonId = 2,
	minTypeId = 3,
	id = 1,
	maxProgress = 10,
	bgType = 6,
	bonus = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	minType = 1
}

function lua_task_activity123.onLoad(json)
	lua_task_activity123.configList, lua_task_activity123.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_activity123
