-- chunkname: @modules/configs/excel2json/lua_activity191_event.lua

module("modules.configs.excel2json.lua_activity191_event", package.seeall)

local lua_activity191_event = {}
local fields = {
	skinId = 10,
	outDesc = 6,
	type = 3,
	title = 5,
	offset = 11,
	desc = 7,
	rewardView = 9,
	task = 8,
	id = 1,
	stage = 4,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	outDesc = 2,
	title = 1,
	task = 4,
	desc = 3
}

function lua_activity191_event.onLoad(json)
	lua_activity191_event.configList, lua_activity191_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_event
