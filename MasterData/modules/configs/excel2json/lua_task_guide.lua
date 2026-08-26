-- chunkname: @modules/configs/excel2json/lua_task_guide.lua

module("modules.configs.excel2json.lua_task_guide", package.seeall)

local lua_task_guide = {}
local fields = {
	maxProgress = 9,
	name = 5,
	isOnline = 2,
	bonusMail = 15,
	maxFinishCount = 10,
	part = 17,
	priority = 19,
	desc = 6,
	listenerParam = 8,
	chapter = 18,
	needAccept = 20,
	jumpId = 22,
	openLimit = 14,
	stage = 16,
	sortId = 12,
	activity = 11,
	prepose = 13,
	listenerType = 7,
	minType = 4,
	minTypeId = 3,
	id = 1,
	bonus = 21
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_task_guide.onLoad(json)
	lua_task_guide.configList, lua_task_guide.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_guide
