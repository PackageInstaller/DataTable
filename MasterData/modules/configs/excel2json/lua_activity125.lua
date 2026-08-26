-- chunkname: @modules/configs/excel2json/lua_activity125.lua

module("modules.configs.excel2json.lua_activity125", package.seeall)

local lua_activity125 = {}
local fields = {
	clientbonus = 12,
	key = 15,
	taskId = 5,
	musictime = 13,
	groupId = 17,
	name = 9,
	targetFrequency = 8,
	sourceid = 16,
	text = 10,
	preId = 3,
	initFrequency = 7,
	activityId = 1,
	openDay = 4,
	time = 14,
	id = 2,
	frequency = 6,
	bonus = 11
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	text = 2,
	name = 1
}

function lua_activity125.onLoad(json)
	lua_activity125.configList, lua_activity125.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity125
