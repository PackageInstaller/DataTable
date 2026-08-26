-- chunkname: @modules/configs/excel2json/lua_task_season.lua

module("modules.configs.excel2json.lua_task_season", package.seeall)

local lua_task_season = {}
local fields = {
	sortId = 12,
	isOnline = 5,
	listenerType = 8,
	activity104EquipBonus = 14,
	maxFinishCount = 11,
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

function lua_task_season.onLoad(json)
	lua_task_season.configList, lua_task_season.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_season
