-- chunkname: @modules/configs/excel2json/lua_activity194_event.lua

module("modules.configs.excel2json.lua_activity194_event", package.seeall)

local lua_activity194_event = {}
local fields = {
	desc = 7,
	name = 5,
	picture = 4,
	eventGroup = 2,
	eventType = 9,
	eventId = 1,
	trigger = 3,
	number = 6,
	optionIds = 8,
	position = 10
}
local primaryKey = {
	"eventId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity194_event.onLoad(json)
	lua_activity194_event.configList, lua_activity194_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_event
