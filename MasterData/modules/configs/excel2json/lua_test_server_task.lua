-- chunkname: @modules/configs/excel2json/lua_test_server_task.lua

module("modules.configs.excel2json.lua_test_server_task", package.seeall)

local lua_test_server_task = {}
local fields = {
	sortId = 10,
	name = 5,
	endTime = 17,
	bonusMail = 13,
	bonus = 18,
	desc = 6,
	listenerParam = 8,
	params = 14,
	openLimit = 12,
	maxProgress = 9,
	activityId = 19,
	jumpId = 15,
	isOnline = 2,
	prepose = 11,
	loopType = 3,
	listenerType = 7,
	minType = 4,
	id = 1,
	startTime = 16
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_test_server_task.onLoad(json)
	lua_test_server_task.configList, lua_test_server_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_test_server_task
