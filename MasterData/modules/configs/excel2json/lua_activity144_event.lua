-- chunkname: @modules/configs/excel2json/lua_activity144_event.lua

module("modules.configs.excel2json.lua_activity144_event", package.seeall)

local lua_activity144_event = {}
local fields = {
	eventId = 2,
	name = 6,
	eventType = 7,
	optionIds = 3,
	picture = 4,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"eventId"
}
local mlStringKey = {
	name = 2,
	desc = 1
}

function lua_activity144_event.onLoad(json)
	lua_activity144_event.configList, lua_activity144_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_event
