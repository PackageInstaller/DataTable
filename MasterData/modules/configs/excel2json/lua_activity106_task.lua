-- chunkname: @modules/configs/excel2json/lua_activity106_task.lua

module("modules.configs.excel2json.lua_activity106_task", package.seeall)

local lua_activity106_task = {}
local fields = {
	orderid = 17,
	name = 5,
	bonusMail = 8,
	maxFinishCount = 14,
	desc = 6,
	listenerParam = 12,
	needAccept = 7,
	params = 9,
	openLimit = 10,
	maxProgress = 13,
	activityId = 2,
	openDay = 16,
	isOnline = 3,
	listenerType = 11,
	minType = 4,
	id = 1,
	bonus = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_activity106_task.onLoad(json)
	lua_activity106_task.configList, lua_activity106_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity106_task
