-- chunkname: @modules/configs/excel2json/lua_activity145_task.lua

module("modules.configs.excel2json.lua_activity145_task", package.seeall)

local lua_activity145_task = {}
local fields = {
	prepose = 11,
	name = 7,
	activity = 18,
	bonusMail = 17,
	maxFinishCount = 16,
	sort = 21,
	desc = 8,
	listenerParam = 14,
	needAccept = 9,
	params = 10,
	openLimit = 12,
	maxProgress = 15,
	activityId = 2,
	canRemove = 5,
	jumpId = 19,
	isOnline = 4,
	group = 3,
	listenerType = 13,
	minType = 6,
	id = 1,
	bonus = 20
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity145_task.onLoad(json)
	lua_activity145_task.configList, lua_activity145_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity145_task
