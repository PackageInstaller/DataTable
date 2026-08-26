-- chunkname: @modules/configs/excel2json/lua_activity113_task.lua

module("modules.configs.excel2json.lua_activity113_task", package.seeall)

local lua_activity113_task = {}
local fields = {
	isOnline = 3,
	name = 5,
	isKeyReward = 20,
	bonusMail = 8,
	maxFinishCount = 15,
	desc = 6,
	listenerParam = 13,
	needAccept = 7,
	params = 9,
	openLimit = 11,
	maxProgress = 14,
	activityId = 2,
	page = 19,
	jumpId = 17,
	activity = 16,
	prepose = 10,
	listenerType = 12,
	minType = 4,
	id = 1,
	bonus = 18
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity113_task.onLoad(json)
	lua_activity113_task.configList, lua_activity113_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity113_task
